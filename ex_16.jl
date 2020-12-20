#Используем задачи 15, 14, 6 для решения.

function moves!(r::Robot,side::HorizonSide) #Вспомогательная функция.
    s = 0
    while isborder(r, side) == false
        move!(r, side)
        s += 1
    end
    return s
end

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

function markers_is_everywhere!(r::Robot) #Основная функция.
    i = 0
    steps = []
    while ((isborder(r, West) == false) || (isborder(r, Sud) == false))
        push!(steps, moves!(r, West))
        push!(steps, moves!(r, Sud))
        i += 2
    end
    putmarker!(r)
    while !isborder(r, Ost)
        move!(r, Ost)
        putmarker!(r)
    end
    side = West
    while !isborder(r, Nord)
        count = 1
        move!(r, Nord)
        putmarker!(r)
        while count != 0
            count = robot_is_everywhere!(r, side)
            putmarker!(r)
        end
        side = inverse(side)
    end
    moves!(r, West)
    moves!(r, Sud)
    while (i > 0) == true
        side = isodd(i) ? Ost : Nord
        for _ in 1:actions[i]
            move!(r, side)
        end
        i -= 1
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))
next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))