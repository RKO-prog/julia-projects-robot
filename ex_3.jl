#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
#РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы

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

function square!(r::Robot) #Основная функция.
	
	west = robot_go_to!(r, West) #Робот идет до западной границы
	sud = robot_go_to!(r, Sud) #Робот идет до южной границы
	
	side = Nord
    putmarker!(r)
    putmarkers!(r, side)
    while isborder(r, Ost) == false
        move!(r, Ost)
        side = inverse(side)
        putmarker!(r)
		putmarkers!(r, side)
    end
   
    robot_back!(r)
	
	robot_go_to!(r, Nord, sud)
	robot_go_to!(r, Ost, west)
end