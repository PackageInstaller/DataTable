local rtSize = nil
local boxSize = nil
local posX, posY = 0, 0
local boxPosX,boxPosY = 0,0
local resetTime = 0
local curType = 0
local currStateName = "idle"
local leftIndex = 0

function Awake()
    boxPosX,boxPosY = CSAPI.GetAnchor(box)

    CSAPI.SetGOActive(itemAnim, false)
    CSAPI.SetGOActive(walk,false)
    CSAPI.SetGOActive(get,false)
    CSAPI.SetGOActive(trap,false)
end

function UpdateState(isMove)
    if resetTime > 0 then
        resetTime = resetTime - Time.deltaTime
        if resetTime <= 0 then
            ShowStateAnim(curType)
        end
        return
    end

    if (isMove and 1 or 0) == curType then
        return
    end
    curType = isMove and 1 or 0
    ShowStateAnim(curType)
end

function GetWidth()
    if rtSize == nil then
        rtSize = CSAPI.GetRTSize(gameObject)
    end
    return rtSize[0]
end

function GetHeight()
    if rtSize == nil then
        rtSize = CSAPI.GetRTSize(gameObject)
    end
    return rtSize[1]
end

function GetPosX()
    posX, posY = CSAPI.GetAnchor(gameObject)
    return posX
end

function GetPosY()
    -- posX, posY = CSAPI.GetAnchor(gameObject)
    return posY
end

function GetBoxWidth()
    if boxSize == nil then
        boxSize = CSAPI.GetRTSize(box)
    end
    return boxSize[0]
end

function GetBoxHeight()
    if boxSize == nil then
        boxSize = CSAPI.GetRTSize(box)
    end
    return boxSize[1]
end

function GetBoxPosY()
    return GetPosY() + boxPosY
end

function GetBoxPosX()
    return GetPosX() + boxPosX
end

function SetFront(isLeft)
    if leftIndex == (isLeft and 1 or 0) then
        return
    end
    leftIndex = isLeft and 1 or 0
    CSAPI.SetScale(node,isLeft and -1 or 1,1,1)
end

function ShowScoreAnim()
    CSAPI.SetGOActive(itemAnim, false)
    CSAPI.SetGOActive(itemAnim, true)
end

function SetState(goName)
    if currStateName and currStateName ~= goName then
        CSAPI.SetGOActive(this[currStateName].gameObject,false)
        CSAPI.SetGOActive(this[goName].gameObject,true)
        currStateName = goName
    end
end

function ShowStateAnim(index)
    SetState(index == 1 and "walk" or "idle")
end

function ShowTriggerAnim(type)
    if type == HalloweenItemType.Score or type == HalloweenItemType.Time then
        SetState("get")
        resetTime = 0.5
    elseif type == HalloweenItemType.Trap then
        SetState("trap")
        resetTime = 0.5
    end
end