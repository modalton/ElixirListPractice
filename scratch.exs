defmodule Practice do
  def last([]), do: nil
  def last([tail]), do: tail
  def last([_ | tail]), do: last(tail)

  def penultimate([]), do: nil
  def penultimate([_]), do: nil
  def penultimate([_ | tail]) when length(tail) == 2 do
    [head | _] = tail
    head
  end
  def penultimate([_ | tail]), do: penultimate(tail)

  def nth([head], n) when n == 0, do: head
  def nth([_ | tail], n), do: nth(tail, n-1)

  defp count([],num), do: num
  defp count([_ | tail], num), do: count(tail, num + 1)
  def count(list), do: count(list, 0)

  defp reverse([],acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head] ++ acc)
  def reverse(list), do: reverse(list, [])

  defp palindrome(left, right) when length(left)==length(right), do: left==right
  defp palindrome(left, [_|right]) when length(left)==length(right), do: left==right 
  defp palindrome(left, [middle|right]), do: palindrome [middle|left], right
  def palindrome(list), do: palindrome [], list

  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head), do: flatten(head) ++ flatten(tail)
  def flatten([head | tail]), do: [head | flatten(tail)]

  def unique(list), do: list |> MapSet.new() |> MapSet.to_list()

  defp pack([], acc), do: acc # |> Enum.reverse()
  defp pack([head | tail], [[letter | rest] | acc_rest]) when head == letter, do: pack(tail, [[head , letter | rest] | acc_rest]);
  defp pack([head | tail], [[letter | rest] | acc_rest]), do: pack(tail, [[head], [letter | rest] |  acc_rest]);
  defp pack([head | tail], acc), do: pack(tail, [[head], acc]);
  def pack([head | tail]), do: pack(tail, [[head]])

  def encode(list), do: Enum.map(pack(list), fn([letter | rest]) -> {letter, length(rest)+1} end)
  
  def encodeMod(list) do
    list
    |> pack
    |> Enum.map(
      fn([letter|rest]) -> if length(rest) == 0, do: letter, else: {letter, length(rest)+1} end)
  end

  defp decode([], acc), do: acc
  defp decode([{letter, count} | tail], acc), do: decode(tail, List.duplicate(letter, count) ++ acc)
  defp decode([letter | tail], acc), do: decode(tail, [letter | acc])
  def decode(list), do: decode(list, [])

  defp duplicate([], acc), do: acc
  defp duplicate([head | tail], acc), do: duplicate(tail, acc ++ [head, head])
  def duplicate(list), do: duplicate(list, [])

  def duplicateFold(list), do: list |> List.foldl([], fn el, acc -> acc ++ [el, el] end)

  def replicate(list, n), do: list |> List.foldl([], fn el, acc -> acc ++ List.duplicate(el,n) end)

  def drop(list, n), do: list |> Enum.with_index() |> List.foldl([], fn
    {_, i}, acc when rem(i + 1,n) == 0 -> acc
    {el, _}, acc -> acc ++ [el]
  end)

end

