#Используем код задачи 6 и преобразуем его для решения задачи.

function moves!(r::Robot,side::HorizonSide) #Вспомогательная функция.
    s = 0
    while isborder(r, side) == false
        move!(r, side)
        s += 1
    end
    return s
end

function perimetrV2!(r::Robot) #Основная функция.
    i = 0
    steps = []
    while ((isborder(r, Nord) == false) || (isborder(r, Ost) == false))
        push!(steps, moves!(r, West))
        push!(steps, moves!(r, Sud))
        i += 2
    end
    side = Nord
    for _ in 0:3
        while !isborder(r, side)
            putmarker!(r)
            move!(r, side)
        end
        side = inverse(next(side))
    end
    while (i > 0) == true
        side = isodd(i) ? Ost : Nord
        for _ in 1:steps[i]
            move!(r, side)
        end
        i -= 1
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))
next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))
