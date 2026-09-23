local sizeActions = nil
function Awake()
    sizeActions = {}
    for i = 1, 3 do
        local sizeAction = ComUtil.GetCom(this["wh" .. i].gameObject,"ActionWH")
        table.insert(sizeActions,sizeAction)
    end
end

function Refresh(pos1, pos2)
    local x1, y1 = pos1[1], pos1[2]
    local x2, y2 = pos2[1], pos2[2]
    local isUp = y1 < y2

    local width = math.abs(x2 - x1)
    local height = math.abs(y2 - y1)
    height = height < 0.0001 and 0 or height

    CSAPI.SetRTSize(gameObject, width, height)
    CSAPI.SetAnchor(gameObject, x1 + width / 2, y1 + (isUp and height / 2 or -height / 2))
    CSAPI.SetScale(gameObject, 1, isUp and -1 or 1, 1)

    CSAPI.SetAnchor(line1,height > 0 and 2 or 0,height > 0 and height/2 - 2 or 0)
    CSAPI.SetAnchor(line2,0,0)
    CSAPI.SetAnchor(line3,height > 0 and -2 or 0,height > 0 and -height/2 +2 or 0)
    
    sizeActions[1].scaleW = width /2
    sizeActions[3].scaleW = width /2
    sizeActions[2].scaleH = height

    CSAPI.SetRTSize(line1, width /2, 4)
    CSAPI.SetRTSize(line2, 4, height)
    CSAPI.SetRTSize(line3, width /2, 4)

    CSAPI.SetGOActive(line2, height > 0)
end

function PlayAnim()
    CSAPI.SetRTSize(line1.gameObject,0,4)
    CSAPI.SetRTSize(line2.gameObject,4,0)
    CSAPI.SetRTSize(line3.gameObject,0,4)

    CSAPI.SetGOActive(w1,false)
    CSAPI.SetGOActive(w2,false)

    for i = 1, #sizeActions do
        sizeActions[i]:Play()
    end
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(w1,true)
        CSAPI.SetGOActive(w2,true)
    end,nil,400)
end

