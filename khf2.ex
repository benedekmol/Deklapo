defmodule Khf2 do
	@moduledoc """
	Szövegelő
	@author "Egyetemi Hallgató <egy.hallg@dp.vik.bme.hu>"
	@date   "2021-10-01"
	...
	"""

  @spec maxlength(list::List):: i::integer
  def maxlength(list) do
    max = 0
    for elem <- list, max < length(elem) do
      max = length(elem)
    end
    max
  end

  @spec split(string::String):: list::List
  def split(s) do
    withoutnewline = String.replace(s, "\n", "")
    String.split(withoutnewline, ~r/\ \ */)
  end

  @spec readfile(file::String) :: any()
  def readfile(file) do
    read = File.stream!(file)
      # |> Stream.with_index
      # |> Stream.map(fn {line, i} -> IO.puts "#{i+1} #{line}" end)
      # |> Stream.map(fn (line) -> line end)
      # |> Stream.run

    listoflines = for line <- read, line != "\n" do
      line
    end
    listofsplitlines = for line <- listoflines do
      split(line)
    end
    max = maxlength(listofsplitlines)
    IO.puts "max: #{max}"
    # IO.inspect IEx.Info.info(tpye?)
    # IO.inspect listoflines
    IO.inspect listofsplitlines
  end

	# @spec szovegelo(file :: String.t) :: rss:: [[String.t | nil]]
	# A file fájl tartalmából előállítja az rss szövegmátrixot.
	# A beolvasott szöveg és a szövegmátrix sorainak száma azonos.
	# A szövegmátrix oszlopainak száma megegyezik a leghosszabb
	# sor szavainak számával. A mátrix minden egyes cellájában a
	# fájl egy-egy szava vagy a nil atom van. A szavakat egy vagy
	# több szóköz-jellegű karakter választja el. A sorokba balról
	# jobbra haladva kerülnek be a szavak, a sorok végén üresen
	# maradó cellákba pedig a nil atom.
end

# IO.inspect Khf2.readfile("./test.txt")
Khf2.readfile("./test.txt")
# IO.inspect Khf2.split("éalskjfd  asédlfkj jfjfjf\n")
