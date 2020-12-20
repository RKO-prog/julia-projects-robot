#Посчитать число всех горизонтальных прямолинейных перегородок (вертикальных - нет)

function count_of_borders(r::Robot, side::HorizonSide, i::Int) #Вспомогательная функция.
    ok = 1
    while (ok == 1)
        if isborder(r, Sud) == true
            i += 1
        end
        if isborder(r, side) == false
            move!(r, side)
        else
            ok = evade_borders!(r, side)
        end
    end
    return i
end

function counter!(r::Robot) #Основная функция.
    flag1 = 1
    flag2 = 1
    
    while ((flag1 == 1) || ( flag2 == 1))
        moves!(r, Sud)
        if isborder(r, Sud) == true
            flag1 = evade_borders!(r, Sud)
        end

        moves!(r, West)
        if isborder(r, West) == true
            flag2 = evade_borders!(r, West)
        end
    end
    num_of_borders = 0
    side = Ost
    ok = 1
    while (ok == 1)
        num_of_borders += count_of_borders(r, side, 0)
        if (isborder(r, Nord) == false)
            move!(r, Nord)
            side = inverse(side)
        else
            ok = evade_borders!(r, Nord)
            side = inverse(side)
        end    
        num_of_borders += count_of_borders(r, side, 0)
    end
    num_of_borders += count_of_borders(r, side, 0)
    return num_of_borders
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))