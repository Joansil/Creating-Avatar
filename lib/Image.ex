defmodule Avatar.Image do
  @moduledoc """
    All the struct of a image
  """

  @doc """
    All structs of a image
    * :hex -> the hexadecimal of image
    * :color -> the color of a image
    * :grid -> the grid of create the image
    * :pixel -> the point where will be filled with the image

  """
  defstruct hex: nil, color: nil, grid: nil, pixel: nil
end
