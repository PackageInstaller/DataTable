local sectionData = nil
local currLevel = 1
local turnNum
local currNum = 0
local hardData = nil
local lastOpen = nil

local fadeT = nil
local fade = nil
local numFade = nil
local imgFade = nil
local bgRotate1 = nil
local bgRotate2 = nil

local isAnim = false

function Awake()
    CSAPI.SetGOActive(turnScaleAction1, false)
    CSAPI.SetGOActive(turnScaleAction2, false)
    CSAPI.SetGOActive(enterAction, false)
    CSAPI.SetGOActive(changeAction, false)
    bgRotate1 = ComUtil.GetCom(upAction, "ActionRotate")
    bgRotate2 = ComUtil.GetCom(downAction, "ActionRotate")
    CSAPI.SetGOActive(upAction, false)
    CSAPI.SetGOActive(downAction, false)
    fadeT = ComUtil.GetCom(selImg, "ActionFadeT")
    fade = ComUtil.GetCom(txt_lock, "ActionFade")
    numFade = ComUtil.GetCom(numObj, "ActionFade")
    imgFade = ComUtil.GetCom(rotate2, "ActionFade")
end

function SetNumClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    sectionData = _data
    if sectionData then
        turnNum = sectionData:GetTurnNum()
        SetIcon()
    end
end

function SetIcon()
    local iconName = sectionData:GetTurnImg() or "bg1"
    if iconName ~= nil and iconName ~= "" then
        ResUtil:LoadBigImg(bg, "UIs/DungeonActivity/Role/" .. iconName .. "/bg")
    end
end

-- 区域
function SetRegion(isOpen)
    CSAPI.SetGOActive(lockImg, not isOpen)
    CSAPI.SetGOActive(openImg, isOpen)

    local color = isOpen and {255, 193, 70, 255} or {255, 255, 255, 255}
    CSAPI.SetImgColor(selImg, color[1], color[2], color[3], color[4])
end

function SetLock(isOpen)
    CSAPI.SetGOActive(txt_lock, not isOpen)
end

function SetNum(currTurnNum, openList)
    if currTurnNum == nil or currTurnNum == 0 or currTurnNum > turnNum then
        LogError("区域数有误！！")
        return
    end

    if #openList < turnNum then
        LogError("区域数据和区域数不一致！！")
        return
    end

    local iconName = "btn_20_0"
    for i = 1, turnNum do
        local num = currTurnNum + (i - 1)
        num = num > turnNum and num - turnNum or num
        CSAPI.LoadImg(this["num" .. i].gameObject, "UIs/DungeonRole/" .. iconName .. num .. ".png", true, nil, true)

        local scale = i == 1 and 1 or 0.7
        CSAPI.SetScale(this["num" .. i].gameObject, scale, scale, scale)

        if i == 1 then
            local color = openList[num] == 1 and {255, 193, 70, 255} or {255, 255, 255, 178}
            CSAPI.SetImgColor(this["num" .. i].gameObject, color[1], color[2], color[3], color[4])
        else
            local color = openList[num] == 1 and {255, 193, 70, 255} or {255, 255, 255, 178}
            CSAPI.SetImgColor(this["num" .. i].gameObject, color[1], color[2], color[3], color[4])
        end
    end

    currNum = currTurnNum
end

function SetHard(lv)
    CSAPI.SetGOActive(hardImg, lv == 2)
end

function Rotate(angle)
    CSAPI.SetAngle(bg, 0, 0, angle)
    if not isAnim then
        CSAPI.SetAngle(rotate2, 0, 0, angle)
    end
end

function ScaleTo(callBack)
    AnimReplay(turnScaleAction1.gameObject)
    FuncUtil:Call(function()
        if gameObject then
            AnimReplay(turnScaleAction2.gameObject)
            if callBack then
                callBack()
            end
        end
    end,nil,100)
end

function ScaleIn()
    AnimReplay(turnScaleAction1.gameObject)
end

function ScaleOut(callBack)
    AnimReplay(turnScaleAction2.gameObject)
    if callBack then
        callBack()
    end
end

function OnClickNum(go)
    if isAnim then
        return
    end
    local name= "btnNum"
    for i = 1, turnNum do
        if go.name == name..i then
            if cb then
                local num = currNum + (i - 1)
                num = num > turnNum and num - turnNum or num
                cb(num)
            end
        end
    end
end

-----------------------------------------------动效-----------------------------------------------

function PlayEnterAnim()
    AnimReplay(enterAction.gameObject)
end

function PlayTurnFade()
    FuncUtil:Call(function ()
        if gameObject then
            fadeT:Play()
        end
    end,nil,300)
    -- numFade:Play(1, 0, 300, 0, function()
    --     numFade:Play(0, 1, 500)
    -- end)
end

function PlayRotateAnim(isUp, currAngle)
    currAngle = math.abs(currAngle % 90)
    local isAnim = true
    bgRotate1.scale = currAngle
    bgRotate2.scale = currAngle
    CSAPI.SetGOActive(upAction, false)
    CSAPI.SetGOActive(downAction, false)
    CSAPI.SetGOActive(downAction, not isUp)
    CSAPI.SetGOActive(upAction, isUp)
    FuncUtil:Call(function()
        if gameObject then
            isAnim = false
        end
    end, nil, 800)
end

function PlayUnLockAnim(currTurnNum, turnOpenList)
    fade:Play(0, 1, 200, 0, function()
        FuncUtil:Call(function()
            -- CSAPI.SetUIScaleTo(txt_lock,"action_UIScale_to_front2",1.5,1.5,1.5,nil,0.05)
            AnimReplay(changeAction.gameObject)
            fade:Play(1, 0, 300)
            SetRegion(true)
            SetNum(currTurnNum, turnOpenList)
        end, nil, 100)
        FuncUtil:Call(function()
            if gameObject then
                CSAPI.SetGOActive(changeAction.gameObject,false)
                fade.from = 0
                fade.to = 1
                CSAPI.SetScale(txt_lock, 1, 1, 1)
                SetLock(true)
            end
        end, this, 420)
    end)
end

function AnimReplay(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end
