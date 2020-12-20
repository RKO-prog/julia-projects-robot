#ДАНО: Робот - Робот - в произвольной клетке ограниченного прямоугольного поля
#РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.

function putmarkers!(r::Robot, side::HorizonSide) #Вспомогательная функция. Как в задаче 1.
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end
end

function robot_go_to!(r::Robot, side::HorizonSide) #Вспомогательная функция. Подсчитывает количество шагов и возвращает число при вызове.
	s = 0
	while isborder(r, side) == false
		move!(r, side)
		s = s + 1
	end
	return s
end

function robot_go_to!(r::Robot, side::HorizonSide, s::Int) #Вспомогательная функция. Для возвращения в исходную точку.
	for i in (1 : s)
		move!(r, side)
	end
end

function robot_back!(r::Robot) #Вспомогательная функция. Возвращаем робота в левый нижний угол.
    while isborder(r, West) == false
        move!(r, West) 
    end
    while isborder(r, Sud) == false
        move!(r, Sud)
    end        
end

function robot_back_by_markers!(r::Robot, side::HorizonSide) #Вспомогательная функция.
    while isborder(r, Nord) == false
        move!(r, Nord)
        putmarkers!(r, side)
        side = inverse(side)
        while ismarker(r) == true
            move!(r, side)
        end
        side = inverse(side)
        if isborder(r, side) == false
          move!(r, side)
        end
    end
end

function line!(r::Robot) #Основная функция.
	
	west = robot_go_to!(r, West) #Робот идет до западной границы
	sud = robot_go_to!(r, Sud) #Робот идет до южной границы
	
	putmarker!(r)
    side = Ost
    putmarkers!(r, side)
    side = inverse(side)
	
    robot_back_by_markers!(r, side)
    robot_back!(r)
	
	robot_go_to!(r, Nord, sud)
	robot_go_to!(r, Ost, west)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))