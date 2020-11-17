defmodule Avatar do
  @moduledoc """
    Creating Avatars icons of 250X250pix trough a any simple string
  """

  def main(input) do
    input
    |> hash_in
    |> createcollor
    |> createtable
    |> removeodd
    |> createpixel
    |> drawimage
    |> saveimage(input)
  end


  def hash_in(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Avatar.Image{hex: hex}
  end

    @doc """
    This create collor in RGB with the 3 firsts positions of values of the hash for the image struct
  """
  def createcollor(image) do
    %Avatar.Image{hex: [r, g, b | _tail]} = image
    %Avatar.Image{image | color: {r,g,b}}
  end
  @doc """
    Here, we separeted the values in `createtable` in other lists of 3 elements and return
    a grid of image!

  """
  def createtable(image) do
    %Avatar.Image{hex: hex} = image
    grid = hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror/1)
    |> List.flatten
    |> Enum.with_index

    %Avatar.Image{image | grid: grid}
  end

  def mirror(line) do
    [fir, sec | _tail] = line
    line ++ [sec, fir]
  end

    @doc """
    Remove all odd value of the grid, and returns a `new grid` only with even values

  """
  def removeodd(image) do
    %Avatar.Image{grid: grid} = image
    newgrid = Enum.filter(grid, fn ({value, _index}) ->
      rem(value, 2) == 0
    end)

    %Avatar.Image{image | grid: newgrid}
  end

    @doc """
    Creating the pixels running all grid of the struct image to seed the Image...
  """
  def createpixel(image) do
    %Avatar.Image{grid: grid} = image
    pixel = Enum.map(grid, fn ({_value, index}) ->
      hori = rem(index, 5) * 50
      vert = div(index, 5) * 50
      topleft = {hori, vert}
      downright = {hori + 50, vert + 50}
      {topleft, downright}
    end)
    %Avatar.Image{image | pixel: pixel}
  end

    @doc """
    Now we can draw the Avatar image chossing if will be in rectangle or ellipse(like small circles)...
  """
  def drawimage(image) do
    %Avatar.Image{color: color, pixel: pixel} = image
    image = :egd.create(250,250)
    fill = :egd.color(color)
    Enum.each(pixel, fn ({start, stop}) ->
      #:egd.filledRectangle(image, start, stop, fill)
      :egd.filledEllipse(image, start, stop, fill)
    end)
    :egd.render(image)
  end

  @doc """
    Just saving the .png with the input name
  """
  def saveimage(image, input) do
    File.write!("#{input}.png", image)
  end











end
