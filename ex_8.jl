#ДАНО: Робот - рядом с горизонтальной перегородкой (под ней), бесконечно продолжающейся в обе стороны, в которой имеется проход шириной в одну клетку.
#РЕЗУЛЬТАТ: Робот - в клетке под проходом

function border_is_empty!(r::Robot, side::HorizonSide, s::Int) #Вспомогательная функция. Если разлом в границе найден - робот останавливается.
    for _ in 1:s
        move!(r, side)
        if isborder(r, Nord) == false
            break
        end
    end
end

function robot_finded_exit!(r::Robot) #Основная функция
    s = 1 #Кол-во шагов.
    side = Ost
    while isborder(r,Nord) == true
        border_is_empty(r, side, i)
        side = inverse(side)
        s += 1
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))