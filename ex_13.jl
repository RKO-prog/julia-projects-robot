#ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.
#РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.

function robot_move_to!(r::Robot, side::HorizonSide) #Вспомогательная функция.
    while ((isborder(r, side) == false) && (isborder(r, next(side)) == false))
        move!(r, side)
        move!(r, next(side))
        putmarker!(r)    
    end
end

function move_by_markers!(r::Robot, side::HorizonSide) #Вспомогательная функция.
    while ismarker(r) == true
        move!(r, side)
        move!(r, next(side))
    end
end

function cross!(r::Robot) #Основная функция.
    for i in 1:4
        robot_move_to!(r, HorizonSide(i))
        move_by_markers!(r, HorizonSide(mod(i + 1, 4)))
    end
    putmarker!(r)
end