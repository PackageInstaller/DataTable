-- 伊根
-- 策划
local len = 15
local maxfaliCount = 3
local winIndex = 12
local failIndex = 13
local gcIndex = 6
local cur = 0.3
local target = 0.3
local add = 0.3
local del = 0.1

-- 程序
local percent = 50
local isOver = nil
local animator = nil -- 震动
local isUp = nil
local height = 1000 -- 660 - 1660 
local result = nil -- true win

function Awake()
    animator = ComUtil.GetCom(gameObject, "Animator")
end

function Update()
    if (isUp ~= nil and result == nil) then
        cur = isUp and (cur + Time.deltaTime * 0.3) or (cur - Time.deltaTime * 0.3)
        if ((isUp and cur >= target) or (not isUp and cur <= target)) then
            isUp = nil
            cur = target
            if (cur == 0 or cur == 1) then
                result = cur
            end
        end
        CSAPI.SetAnchor(Waves, 0, 660 + cur * height, 0)
    end
    if (isOver and result ~= nil) then
        if (CardLive2DItem.IsIdle()) then
            CSAPI.SetGOActive(mask, false)
            CSAPI.SetGOActive(Fullscreen, false)
            CSAPI.SetGOActive(AdaptiveScreen, false)
            -- local cb = nil
            -- if (result ~= -1) then
            --     cb = function()
            --         local index = result == 1 and winIndex or failIndex
            --         CardLive2DItem.PlayByIndex(index)
            --     end
            -- end
            local index = result == 1 and winIndex or failIndex
            CardLive2DItem.PlayByIndex(index)
            isOver = nil
        end
    end
    if (len > 0) then
        len = len - Time.deltaTime
        SetTime()
        if (len <= 0 and not isOver) then
            OnClickBack()
        end
    end
end

function Refresh(_CardLive2DItem)
    CardLive2DItem = _CardLive2DItem
    CSAPI.SetAnchor(Waves, 0, 660 + cur * height, 0)
    SetTime()
end

function SetTime()
    local num = math.ceil(len)
    local a = math.floor(num / 10)
    local b = num % 10
    CSAPI.LoadImg(txtNum1, "UIs/Spine/60350_skin_Ijen03_spine/img_01_0" .. a .. ".png", true, nil, true)
    CSAPI.LoadImg(txtNum2, "UIs/Spine/60350_skin_Ijen03_spine/img_01_0" .. b .. ".png", true, nil, true)
end

function OnClickHit()
    if (isOver or isUp ~= nil) then
        return
    end
    local isSuccess = nil
    local x, y = CSAPI.GetAnchor(arrow)
    if (y > 360) then
        isSuccess = true
        target = target + add
        target = target > 1 and 1 or target
        animator:SetTrigger("shake")
    elseif (y < 240) then
        isSuccess = false
        target = target - del
        target = target < 0 and 0 or target
        maxfaliCount = maxfaliCount - 1
    end
    if (target ~= cur) then
        isUp = target > cur
    end
    if (maxfaliCount <= 0 or target >= 1 or target <= 0) then
        isOver = true
        if (maxfaliCount <= 0) then
            result = 0
        end
    end
end

function OnClickBack()
    if (not isOver) then
        result = -1
        isOver = true
    end
end

