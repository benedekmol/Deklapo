defmodule Khf2 do
	@moduledoc """
	Szövegelő
	@author "Molnár Benedek molnar.benedek.mate@gmail.com"
	@date   "2021-09-29"
	...
	"""

  @spec maxlength(list::List):: i::integer
  defp maxlength(list) do
    max = Enum.max_by(list, fn x -> length(x) end)
    length(max)
  end

  @spec addnil(list::List, max::integer):: any()
  defp addnil(list, 0) do
    list
  end
  defp addnil(list, maxminuslength) do
    tmp = list ++ [nil]
    addnil(tmp, maxminuslength - 1 )
  end

  @spec split(string::String):: list::List
  defp split(s) do
    withouttab = String.replace(s, "\t", "")
    withoutnewline = String.replace(withouttab, "\n", "")

    splitted = String.split(withoutnewline, ~r/\ \ */)
    for split <- splitted, split != "" do
      split
    end
  end

	@spec szovegelo(file :: String.t) :: rss:: [[String.t | nil]]
	# A file fájl tartalmából előállítja az rss szövegmátrixot.
	# A beolvasott szöveg és a szövegmátrix sorainak száma azonos.
	# A szövegmátrix oszlopainak száma megegyezik a leghosszabb
	# sor szavainak számával. A mátrix minden egyes cellájában a
	# fájl egy-egy szava vagy a nil atom van. A szavakat egy vagy
	# több szóköz-jellegű karakter választja el. A sorokba balról
	# jobbra haladva kerülnek be a szavak, a sorok végén üresen
	# maradó cellákba pedig a nil atom.
  def szovegelo(file) do
    read = File.stream!(file)
    # listoflines = for line <- read, line != "\n" do
    listoflines = for line <- read, !String.match?(line, ~r/^[\ \t\n]*\n$/) do
      line
    end
    if listoflines == [] do
      []
    else
      listofsplitlines = for line <- listoflines do
        split(line)
      end
      max = maxlength(listofsplitlines)
      ## Add nil to lines
      result = for line <- listofsplitlines do
        if length(line) < max do
          addnil(line, max - length(line))
        else
          line
        end
      end
      result
    end
  end


  @spec matchymatch(file::String):: any()
  def matchymatch(file) do
    read = File.stream!(file)
    # listoflines = for line <- read, line != "\n" do
    listoflines = for line <- read, !String.match?(line, ~r/^[\ \t\n]*\n$/) do
      IO.puts "Line: "
      IO.inspect line
    end
  end
end

# IO.inspect Khf2.matchymatch("./test.txt")


# IO.inspect Khf2.readfile("./test.txt")
# IO.inspect Khf2.szovegelo("./test.txt")
IO.inspect Khf2.szovegelo("./khf2_s0.txt")
# IO.inspect Khf2.split("éalskjfd  asédlfkj jfjfjf\n")
# IO.inspect Khf2.addnil(["a","b","c"],5)
