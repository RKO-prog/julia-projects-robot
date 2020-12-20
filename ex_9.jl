#ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. Робот - в произвольной клетке поля.
#РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.

#Воспользуемся похожим алгоритмом, как в задаче 8

function find_marker!(r::Robot, side::HorizonSide, s::Int) #Вспомогательная функция. Если маркер найден - робот останавливается.
    for _ in 1:s
        move!(r, side)
        if ismarker(r) == true
            break
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

next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))