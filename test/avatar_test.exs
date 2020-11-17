defmodule AvatarTest do
  use ExUnit.Case
  doctest Avatar

  test "verify if the main application its running ok" do
    assert Avatar.main("ola") == :ok
  end

  test "create the hexadecimal of the image" do
    [x | _tail] = Avatar.hash_in("ola").hex
    assert x == 47
  end

  test "verify if the color was created" do
    color = Avatar.createcollor(%Avatar.Image{color: nil, grid: nil, hex: [47, 224, 78, 82, 75, 164,
    5, 5, 168, 46, 3, 162, 129, 148, 41, 204], pixel: nil}).color
    assert {47, 224, 78} == color
  end

  test "create the table of the grid" do
    [y | _tail] = Avatar.createtable(%Avatar.Image{color: {47, 224, 78}, grid: nil, hex: [[47, 224, 78], [82, 75, 164],
    [5, 5, 168], [46, 3, 162], [129, 148, 41]], pixel: nil}).grid
    assert y == {47, 0}
  end

  test "verify if the elements of the grid its even" do
    new = Avatar.createtable(%Avatar.Image{color: {47, 224, 78}, grid: nil, hex: [[47, 224, 78], [82, 75, 164],
    [5, 5, 168], [46, 3, 162], [129, 148, 41]], pixel: nil})

    new = Avatar.createtable(new)
    |> Avatar.removeodd

    [index | _tail] = new.grid
    {value, _index} = index
    assert rem(value, 2) == 0
  end

  test "verify if the value of the first pixel it's the expected" do
    new = Avatar.createtable(%Avatar.Image{color: {161, 46, 176}, grid: nil, hex: [[47, 224, 78], [82, 75, 164],
    [5, 5, 168], [46, 3, 162], [129, 148, 41]], pixel: nil})

    new = Avatar.createtable(new)
    |> Avatar.removeodd
    |> Avatar.createpixel

    [pixelx | _tail] = new.pixel
    assert {{50,0}, {100,50}} = pixelx
  end


end
