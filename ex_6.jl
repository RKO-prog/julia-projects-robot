#ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. Робот - в произвольной клетке поля между внешней и внутренней перегородками. 
#РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.

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
    while isborder(r, Ost) == false
        while isborder(r, side) == false
            move!(r, side)
            if isborder(r, Ost) == true
                break
            end           
        end
        if isborder(r, Ost) == false
            move!(r, Ost)
        end
        side = inverse(side)
    end
    while isborder(r, Ost) == true
        move!(r, Sud)
    end
    side = Nord
    for _ in 0:3
        putmarker!(r)
        move!(r, side)
        while isborder(r, next(side)) == true
            putmarker!(r)
            move!(r,side)
        end
        side = next(side)
    end
    moves!(r, Sud)
    moves!(r, West)
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