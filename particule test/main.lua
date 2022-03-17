io.stdout:setvbuf('no')
love.window.setMode(1100,700)
w = 1100
h = 700
j1 = {}
j1.nbPart = 5000
j1.x = 50
j1.y = 50 
j1.vx = 0
j1.vy = 0
j1.listP = {}
  j1.move = function(det)
  j1.speedx = 0 
  j1.speedy = 0 
  
  if love.keyboard.isDown("d") then 
    j1.speedx = j1.speedx + 100 
  end 
  if love.keyboard.isDown("q") then 
    j1.speedx = j1.speedx - 100 
  end 
  if love.keyboard.isDown("s") then 
    j1.speedy = j1.speedy + 100 
  end 
  if love.keyboard.isDown("z") then 
    j1.speedy = j1.speedy - 100 
  end 
  
  if j1.speedx ~= 0 or j1.speedy ~= 0 then 
     j1.vy = j1.speedy/math.sqrt(j1.speedx^2+j1.speedy^2)*100
     j1.vx = j1.speedx/math.sqrt(j1.speedx^2+j1.speedy^2)*100
  end 
  
  j1.x = j1.x +  j1.vx*det*15
  j1.y = j1.y +  j1.vy*det*15
  
  j1.vx = 0 
  j1.vy = 0  
end

function j1.set(e)
  local o = (math.random(1,3600)/1800)*math.pi
  local r = math.random(1,10)
  
  
  j1.listP[e].x  = j1.x + math.cos(o)*r
  j1.listP[e].y  = j1.y + math.sin(o)*r
  
  local vo = (math.random(1,360)/180)*math.pi -- -(math.random(130,230)/360)*math.pi -- 
  local vr = math.random()*2
  j1.listP[e].vx =  math.cos(vo)*vr
  j1.listP[e].vy =  math.sin(vo)*vr
  j1.listP[e].t = 0 
  j1.listP[e].tend = math.random()
  j1.listP[e].color = {math.random(),math.random(),math.random()}
end

function love.update(dt)
  for i = 1,#j1.listP do
    if j1.listP[i].t >= j1.listP[i].tend then 
      j1.set(i)
    else
      j1.listP[i].t = j1.listP[i].t + dt
    end
  end
  
   if j1.x+20 >= w then
    j1.x = w-20
   elseif j1.x-20 <= 0 then
    j1.x = 20
  end
  if j1.y+20 >= h then
    j1.y = h-20
  elseif j1.y <= 0 then
    j1.y = 20
  end
  print(#j1.listP)
  while #j1.listP < j1.nbPart do
  j1.listP[#j1.listP+1] = {}
  j1.set(#j1.listP)
end 

  for i = 1,#j1.listP do
    ------------------------------------------
    if j1.listP[i].x >= w or j1.listP[i].x <= 0 then
      j1.listP[i].vx = -j1.listP[i].vx
    end
    if j1.listP[i].y >= h or j1.listP[i].y <= 0 then
      j1.listP[i].vy = -j1.listP[i].vy
    end
    j1.listP[i].x = j1.listP[i].x  + j1.listP[i].vx
    j1.listP[i].y = j1.listP[i].y  + j1.listP[i].vy
    
  end 
  
  j1.move(dt)
end

function love.draw()
  --love.graphics.setBackgroundColor(1,1,1)
  for i = 1,#j1.listP do
    love.graphics.setColor(j1.listP[i].color)
    love.graphics.circle("fill",j1.listP[i].x,j1.listP[i].y,2)
  end 
end


