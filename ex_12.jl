#На прямоугольном поле произвольных размеров расставить маркеры в виде "шахматных" клеток, начиная с юго-западного угла поля, когда каждая отдельная "шахматная" клетка имеет размер n x n клеток поля (n - это параметр функции). Начальное положение Робота - произвольное, конечное - совпадает с начальным. Клетки на севере и востоке могут получаться "обрезанными" - зависит от соотношения размеров поля и "шахматных" клеток. (Подсказка: здесь могут быть полезными две глобальных переменных, в которых будут содержаться текущие декартовы координаты Робота относительно начала координат в левом нижнем углу поля, например)

#Используем в качестве фундамента код из задачи 7.

X_CORD = 0
Y_CORD = 0

function robot_back!(r::Robot) #Вспомогательная функция.
    while isborder(r, West) == false
        move!(r, West) 
    end
    while isborder(r, Sud) == false
        move!(r, Sud)
    end        
end

function marker_chess!(r::Robot, side::HorizonSide, n::Int, i::Int) #Вспомогательная функция.
    global X_CORD
    
    while isborder(r, side) == false           
        if mod(div(X_CORD, n), 2) == mod(i, 2)         
            putmarker!(r)
        end
        X_CORD += 1
        move!(r, side)
    end
    if mod(div(X_CORD, n), 2) == mod(i, 2)
        putmarker!(r)
    end

end

function chess!(r::Robot) #Основная функция.
	
	west = robot_go_to!(r, West) #Робот идет до западной границы
	sud = robot_go_to!(r, Sud) #Робот идет до южной границы
	
	global X_CORD = 0
    global Y_CORD = 0
	
    marker = 0
    row_number = 0 #Переменная номера строки, для определения четности строки (четная/нечетная строка)

    while isborder(r, Nord) == false
        if mod(div(Y_CORD, n), 2) == mod(marker, 2)
            marker_chess!(r, Ost, n, row_number)
            moves!(r, West)
            move!(r, Nord)
            X_CORD = 0
			Y_CORD = Y_CORD + 1
        else
            marker += 1
            row_number = mod(row_number + 1, 2)
        end
    end
    if mod(div(Y_CORD, n), 2) == mod(marker, 2)
        marker_chess!(r, Ost, n, row_number)
    else
        marker_chess!(r, Ost, n, mod(row_number + 1, 2))
    end
   
    moves!(r, West)
    moves!(r, Sud)
	robot_back!(r, Ost, west)
    robot_back!(r, Nord, sud)
end