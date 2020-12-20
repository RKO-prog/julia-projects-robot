function robot_is_everywhere!(r::Robot, side::HorizonSide) #Вспомогательная функция.
    s = 0
    while (isborder(r, side) && !isborder(r, next(side)))
        move!(r, next(side))
        s += 1
    end
    count = 0
    if !isborder(r, side)
        move!(r, side)
        count = count + 1
    end
    if s != 0
        while isborder(r, inverse(next(side)))
            move!(r, side)
            count = count + 1
        end
        for _ in 1:s
            move!(r, inverse(next(side)))
        end
    end
    return count
end

function cross!(r::Robot) #Основная функция.
    side = Nord
    for _ in 0:3
        count = 1
        while count != 0
            count = move_to(r, side)
            putmarker!(r)
        end
        while ismarker(r)
            robot_is_everywhere(r, inverse(side))
        end
        side = inverse(next(side))
    end
    putmarker!(r)
end


inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))
next(side::HorizonSide)=HorizonSide(mod(Int(side)+1,4))