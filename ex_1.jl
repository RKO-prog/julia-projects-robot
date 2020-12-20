#ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
#РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.

function putmarkers!(r::Robot, side::HorizonSide) #Вспомогательная функция. Пока нет стены, робот будет идти в заданном направлении и ставить маркеры.
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end
end

function move_by_markers!(r::Robot, side::HorizonSide)  #Вспомогательная функция. Робот двигается по маркерам.
    while ismarker(r) == true 
        move!(r, side) 
    end
end

function cross!(r::Robot) #Основная функция.
    for i in 1:4 #Перебор всех сторон света (всего 4 варианта).
        putmarkers!(r, HorizonSide(i))
        move_by_markers!(r, inverse(HorizonSide(i)))
    end
    putmarker!(r)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

