
# usage: gawk -f life.awk
# Then hit and hold the return key.
# For each key press, you get one new generation.

# Each generation, a cell C is alive 1 or dead 0.
# In the next generation each cell C is alive or dead
# depending on a count of its neighbours N
#
#   Now Neighbors           Next
#   --- ---------           --------------
#   1   0,1             ->  0  # Lonely
#   1   4,5,6,7,8       ->  0  # Overcrowded
#   1   2,3             ->  1  # Lives
#   0   3               ->  1  # It takes three to give birth!
#   0   0,1,2,4,5,6,7,8 ->  0  # Barren
#
# Code citation : https://gist.github.com/timm/1f4e45d46e4788ee43f12ebe54409b2f#file-life-awk

def life (rows, cols, randValue, generations)
    size = rows*cols
    game = Array.new(size)
    for i in 0..(size-1)
        game[i] =  rand < randValue ? 1 : 0
    end

    live(game,rows,cols,generations)
end

def homescreen()
    print "ssssssss"
end

def getNeighbors(game, c, rows, cols)
    res = 0
    size = rows*cols

    if cols > 1
        if c%cols != 0
            res = res + game[c-1]
            if c - cols - 1 >= 0
                res = res + game[c - cols - 1]
            end
            if c + cols - 1 < size
                res = res + game[c + cols - 1]
            end
        end

        if c%cols != cols - 1
            res = res + game[c+1]
            if c - cols + 1 >= 0
                res = res + game[c-cols+1]
            end
            if c + cols + 1 < size
                res = res + game[c+cols+1]
            end
        end

    end

    res += cols + c < size ? game[c+cols] : 0

    res += c - cols >= 0 ? game[c-cols] : 0

    return res
end


def live(game,rows,cols,gen)
    if (gen <= 1)
        return
    end

    sleep(0.5)

    homescreen()

    puts "Generation of #{gen}"

    for i in 0..(game.length -  1)
        print game[i] == 1? "o" : " "
        if (i+1) % cols == 0
            puts
        end
    end

    newarr = Array.new(game.length)

    for index in 0..(game.length - 1)
        neighbors = 0

        neighbors = getNeighbors(game, index, rows, cols)

        newarr[index] = (neighbors == 2 or neighbors == 3) ? 1 : 0
    end
    gen -= 1
    live newarr, rows, cols, gen
end

life(50,20,0.619,200)
