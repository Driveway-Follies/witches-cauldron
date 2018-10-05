function resetColors() 
    blueGreenBuffer:fill(255, 0, 128)
    greenBuffer:fill(255, 0, 0)
    yellowGreenBuffer:fill(255, 128, 0)
    yellowBuffer:fill(128, 128, 0)
    orangeBuffer:fill(128, 255, 0)
    crossmix = 1
end

function crossfade(bufferOut, bufferIn)
        buffer = ws2812.newBuffer(87, 3)
        buffer:mix(256-crossmix, bufferOut, crossmix, bufferIn)
        ws2812.write(buffer) 
        crossmix = crossmix + 1
end

ws2812.init()
local i = 0
forward = 1
interval = 254
crossmix = 1

blueGreenBuffer = ws2812.newBuffer(87, 3)
greenBuffer = ws2812.newBuffer(87, 3)
yellowGreenBuffer = ws2812.newBuffer(87, 3)
yellowBuffer = ws2812.newBuffer(87, 3)
orangeBuffer = ws2812.newBuffer(87, 3)

resetColors()

ws2812.write(blueGreenBuffer)

tmr.create():alarm(100, 1, function()

    i = i + 1
    if forward == 1 then
        if (i < interval) then 
            print("bluegreen to green")
            crossfade(blueGreenBuffer, greenBuffer)
        elseif ( i == interval ) then
            resetColors()
        elseif ( i < interval * 2 ) then
            print("hold green")
            ws2812.write(greenBuffer)
        elseif (i == interval * 2 ) then 
            resetColors()
        elseif ( i < interval * 3 ) then
            print("green to yellowgreen")
            crossfade(greenBuffer, yellowGreenBuffer)
        elseif (i == interval * 3 ) then 
            resetColors()
        elseif ( i < interval * 4 ) then
            print("yellowgreen to yellow")
            crossfade(yellowGreenBuffer, yellowBuffer)
        elseif (i == interval * 4 ) then 
            resetColors()
        elseif ( i < interval * 5 ) then
            print("yellow to orange")
            crossfade(yellowBuffer, orangeBuffer)
        elseif (i == interval * 5 ) then 
            resetColors()
            forward = 0
            i = 0
        end
    else
        if (i < interval) then 
            print("orange to yellow")
            crossfade(orangeBuffer,yellowBuffer)
        elseif ( i == interval ) then
            resetColors()
        elseif ( i < interval * 2 ) then
            print("yellow to yellowgreen")
            crossfade(yellowBuffer, yellowGreenBuffer)
        elseif (i == interval * 2 ) then 
            resetColors()
        elseif ( i < interval * 3 ) then
            print("yellowgreen to green")
            crossfade(yellowGreenBuffer, greenBuffer)
        elseif (i == interval * 3 ) then 
            resetColors()
        elseif ( i < interval * 4 ) then
            print("green to bluegreen")
            crossfade(greenBuffer, blueGreenBuffer)
        elseif (i == interval * 4 ) then 
            resetColors()
            forward = 1
            i = 0
        end
    end

end)
