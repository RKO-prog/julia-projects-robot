#Эта задача аналогична задаче 9, но дополнительно на неограниченном поле могут находиться изолированные прямолинейные перегородки, в том числе и неограниченно продолжающиеся в одну из своих сторон.

function find_marker!(r::Robot, side::HorizonSide, s::Int) #Вспомогательная функция. Если маркер найден - робот останавливается.
    for _ in 1:s
        move!(r, side)
        if ismarker(r) == true
            break
        end
    end
end

function evade_borders!(r::Robot, side::HorizonSide) #Вспомогательная функция. Обход границ.
    a = 0
    num = 1
    while isborder(r, side) == true
        if isborder(r, next(side)) == true
            num = 0
            break
        end
        move!(r, next(side))
        a += 1
    end
    if (num != 0)
        move!(r, side)
        while isborder(r, prev(side)) == true
            move!(r, side)
        end
        move!(r, prev(side))
        moves!(r, prev(side), a - 1)
    else
        moves!(r, prev(side), a)
    end
    return num
end

import HorizonSideRobots.move! #Вспомогательная функция.
function move!(r, side, s)
    for _ in 1:s 
        if ismarker(r) == false
            if isborder(r, side) == false
                move!(r, side)
            else
                evade_borders!(r, side)
            end 
        end
    end
end

function robot_find_marker!(r::Robot) #Основная функция.
    s = 1 #Кол-во шагов.
    side = Nord #Задаем начальное направление.
    while ismarker(r) == false
        for _ in 1:2
            find_marker!(r, side, s)
            side = next(side)
        end
        s += 1
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))
next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))