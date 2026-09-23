-- 策划
local winIndex = 10 -- 胜利动画,填下标
local loseIndex = 12 -- 失败动画,填下标
local clickIndex = 9 -- 点击动画,填下标
local startNum = 20 -- 初始值 （100是满了）
local holdTime = 0.1 -- 无动作多长时间（秒）会开始掉进度
local downTime = 0.5 -- 降低百分1需要的秒数
local addNum = 18 -- 每次点击增加多少 （100是满了）
-- local showtime = 1000 -- 事件触发后多长时间显示UI,不能改，要特效改
local hideTime = 0 -- 触发胜利失败动画多长时间后隐藏UI
local lerpNum = 0.01 -- 每帧增加多少

-- 程序
local img_fill
local CardLive2DItem
local isOver = nil
local timer = 0
local slider_min = 0 ---170
local slider_max = 1 -- 200
local height = 0
local _height = 0
local len = 0
local isUp = true
local firstHeight = 0
local isCan = false

function Awake()
    img_fill = ComUtil.GetCom(fill, "Image")
end

function Refresh(_CardLive2DItem)
    CardLive2DItem = _CardLive2DItem
    -- 初始化
    len = slider_max - slider_min
    _height = slider_min + startNum * (len / 100)
    firstHeight = _height
    height = slider_min
    timer = holdTime
    -- 显示ui
    FuncUtil:Call(function()
        CSAPI.SetGOActive(effect, true)
        isOver = false
    end, nil, 1000)
end

function Update()
    if (isOver == nil) then
        return
    end
    if (_height ~= height) then
        SetSoftMaskHeight()
    end
    if (isOver) then
        if (CardLive2DItem.IsIdle()) then
            local index = winIndex
            if (height <= slider_min) then -- 胜利
                index = loseIndex
            end
            CardLive2DItem.PlayByIndex(index)
            isOver = nil
            -- 隐藏ui
            FuncUtil:Call(function()
                if (effect ~= nil) then
                    CSAPI.SetGOActive(effect, false)
                end
            end, nil, hideTime)
        end
    elseif (isCan and not isUp) then
        timer = timer - Time.deltaTime
        if (timer <= 0) then
            local decreaseAmount = Time.deltaTime / downTime
            _height = _height - decreaseAmount * (len / 100)
            isUp = false
        end
    end
end

function SetSoftMaskHeight()
    -- local x, y = CSAPI.GetAnchor(softMask)
    local y = img_fill.fillAmount
    if (isUp) then
        height = (y + lerpNum) >= _height and _height or (y + lerpNum)
        height = height <= slider_max and height or slider_max
        if (not isCan and height >= firstHeight) then
            isCan = true
        end
    else
        --height = (y - lerpNum) <= _height and _height or (y - lerpNum)
        height = _height
        height = height >= slider_min and height or slider_min
    end
    if (height >= slider_max or height <= slider_min) then
        isOver = true
    end
    if (height >= _height) then
        isUp = false
    end
    -- CSAPI.SetAnchor(softMask, -472.3, height, 0)
    img_fill.fillAmount = height
end

function OnClickMask()
    if (isOver == nil or not isCan) then
        return
    end
    if (not isOver) then
        if (clickIndex ~= nil and CardLive2DItem.IsIdle()) then
            CardLive2DItem.PlayByIndex(clickIndex)
        end
        timer = holdTime
        _height = _height + addNum * (len / 100)
        isUp = true
    end
end
