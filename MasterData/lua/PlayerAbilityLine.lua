local cfg = nil
local nextCfg = nil

local isBeeLine = false -- 直线
local isMain = false
local isRight = false -- 转弯并且从右侧出发
local isDown = false
local direction = 2

local w = 0
local h = 0

local centerPos = {}

-- 点运算
local dotSpeed = 0.26 -- 点移动速度

local intervalTime = 30
local delay = 200 -- 第二个延迟出发时间

local dotItem = nil
local dotColor = nil
local view = nil

local offset = {} -- 距离两个item之间的中心点偏移量

function Awake()
    canvasGroup1 = ComUtil.GetCom(mask, "CanvasGroup")
    canvasGroup2 = ComUtil.GetCom(mask, "CanvasGroup")
end

function Refresh(cfg1, cfg2)
    cfg = cfg1
    nextCfg = cfg2
    -- 是否在躯干上
    isMain = cfg1.pos[1] == 2
    -- 起始点偏离值
    local offset1 = cfg1.type == AbilityType.SkillGroup and 105 or 82
    local offset2 = cfg2.type == AbilityType.SkillGroup and 105 or 82
    -- 获取两点坐标
    local x1, y1 = PlayerAbilityMgr:GetPos(cfg1.pos[1], cfg1.pos[2])
    local x2, y2 = PlayerAbilityMgr:GetPos(cfg2.pos[1], cfg2.pos[2])
    -- item之间的中心点
    centerPos = {
        x = math.abs(x2 - x1) / 2,
        y = math.abs(y2 - y1) / 2
    }
    -- 判断
    local b1 = x1 == x2
    local b2 = y1 == y2
    isBeeLine = (b2 or b1) and true or false

    CSAPI.SetGOActive(line1, isBeeLine)
    CSAPI.SetGOActive(line2, not isBeeLine)

    if (isBeeLine) then -- 同行或同列
        if (b2) then -- 同行
            direction = cfg.pos[1]
            --长度
            w = (x2 - offset2) - (x1 + offset1)
            CSAPI.SetAnchor(line1, offset1 + (w / 2), 0)
            CSAPI.SetAngle(line1, 0, 0, 0)
            -- mask
            CSAPI.SetAnchor(mask, offset1 + (w / 2), 0)
        else -- 同列
            local isDown = y1 > y2 -- 位于下方
            direction = isDown and 3 or 1
            w = isDown and (y2 + offset2) - (y1 - offset1) or (y2 - offset2) - (y1 + offset1)
            offset1 = isDown and -offset1 or offset1
            CSAPI.SetAnchor(line1, 0, offset1 + (w / 2))
            -- 旋转
            local angle = isDown and -90 or 90
            CSAPI.SetAngle(line1, 0, 0, angle)
            -- mask
            CSAPI.SetAnchor(mask, 0, offset1 + (w / 2))
            CSAPI.SetAngle(mask, 0, 0, angle)
        end
        CSAPI.SetRTSize(line1, math.abs(w), 26)
        -- mask
        CSAPI.SetRTSize(mask, math.abs(w) - 49, 26)
    else
        isDown = y1 > y2 -- 位于下方
        -- 偏移修正
        local xOffset = 0
        local yOffset = 0
        local lineX = 0
        local lineY = 0
        local maskOffset = {}
        if (isMain) then -- 主躯干 --从上下出发 -7
            xOffset = -13
            yOffset = 13
            -- line
            w = (x2 - offset2) - (x1 + xOffset)
            h = isDown and (y2 - yOffset) - (y1 - offset1) or (y2 + yOffset) - (y1 + offset1)
            lineX = (w / 2) + xOffset
            lineY = isDown and (h / 2) - offset1 or (h / 2) + offset1
            CSAPI.SetAnchor(line2, lineX, lineY)
            CSAPI.SetScale(line2, 1, isDown and -1 or 1, 1)
            -- mask
            maskOffset.x = -13
            maskOffset.y = isDown and -14 or 14
            CSAPI.SetAnchor(mask, lineX + maskOffset.x, lineY + maskOffset.y)
            -- CSAPI.SetScale(mask, 1, isDown and -1 or 1, 1)
            -- offset
            offset.x = ((x2 + offset2) - (x1 - xOffset)) / 2 - xOffset - centerPos.x - maskOffset.x
            offset.y = isDown and ((y2 + yOffset) - (y1 + offset1)) / 2 + offset1 + centerPos.y - maskOffset.y or
                           ((y2 - yOffset) - (y1 - offset1)) / 2 - offset1 - centerPos.y - maskOffset.y
            -- 位置
            direction = isDown and 3 or 1
        else -- 从右出发
            xOffset = 13
            yOffset = isDown and 13 or -13
            w = (x2 + xOffset) - (x1 + offset1)
            h = isDown and (y2 + offset2) - (y1 + yOffset) or (y2 - offset2) - (y1 + yOffset)
            lineX = (w / 2) + offset1
            lineY = (h / 2) + yOffset
            CSAPI.SetAnchor(line2, lineX, lineY)
            CSAPI.SetScale(line2, -1, isDown and 1 or -1, 1)
            -- mask
            maskOffset.x = 13
            maskOffset.y = isDown and 14 or -14
            CSAPI.SetAnchor(mask, lineX + maskOffset.x, lineY + maskOffset.y)
            -- offset
            offset.x = ((x2 - xOffset) - (x1 - offset1)) / 2 - offset1 - centerPos.x - maskOffset.x
            offset.y = isDown and ((y2 - offset2) - (y1 - yOffset)) / 2 - yOffset + centerPos.y - maskOffset.y or
                           ((y2 + offset2) - (y1 - yOffset)) / 2 - yOffset - centerPos.y - maskOffset.y
            -- 右下
            isRight = true
        end
        CSAPI.SetRTSize(line2, w, math.abs(h))
        -- mask
        CSAPI.SetRTSize(mask, math.abs(w) - 20, math.abs(h) - 20)
    end
end

-- 设置物体颜色
function SetColor(isChange)
    local color = isChange and {97, 74, 30, 255} or {77, 77, 77, 255}
    dotColor = isChange and {255, 214, 70, 255} or {255, 255, 255, 255}
    local line = isBeeLine and line1 or line2
    CSAPI.SetImgColor(line, color[1], color[2], color[3], color[4])
end

-- 显示点移动
function ShowDot(isShow)
    canvasGroup1.alpha = isShow and 1 or 0
    canvasGroup2.alpha = isShow and 1 or 0
end

-- 执行点动画
function PlayDotAction(_view)
    view = _view
    local go = view.GetDot()
    if go == nil then
        return
    end
    dotItem = ComUtil.GetLuaTable(go)
    if dotItem == nil then
        return
    end
    -- size
    dotItem.SetRTSize(w, math.abs(h))
    -- pos
    if (offset.x and offset.y) then
        CSAPI.SetAnchor(go, offset.x, offset.y)
    end
    -- color
    if dotColor then
        dotItem.SetColor(dotColor)
    end
    -- parent
    CSAPI.SetParent(dotItem.gameObject, mask)
    -- scale
    if (isBeeLine) then
        CSAPI.SetScale(dotItem.gameObject, 1, direction == 3 and -1 or 1, 1)
    else
        CSAPI.SetScale(dotItem.gameObject, 1, isDown and -1 or 1, 1)
    end
    -- callback
    local cb = function()
        view.RecycleDot(go)
        if (isRight) then
            return
        end
        view.PlayDotAction(nextCfg.id)
    end
    -- play
    if (isBeeLine) then
        local pos = GetDotPos(1)
        local time = GetTime(pos[1], pos[3])
        PlayAction(dotItem, 1, time, 0, pos[1], pos[3], cb)
        PlayAction(dotItem, 2, time, delay, pos[2], pos[4])
    else
        -- pos
        local pos1 = GetDotPos(1)
        local pos2 = GetDotPos(2)
        local pos3 = GetDotPos(3)
        -- time
        local time1 = {GetTime(pos1[1], pos1[3]), GetTime(pos1[2], pos1[4])}
        -- local time2 = {GetTime(pos2[1], pos2[3]), GetTime(pos2[2], pos2[4])}
        local time2 = {GetTime(pos2[2], pos2[4]), GetTime(pos2[2], pos2[4])}
        local time3 = {GetTime(pos3[1], pos3[3]), GetTime(pos3[2], pos3[4])}
        -- 一阶段
        PlayAction(dotItem, 1, time1[1], 0, pos1[1], pos1[3])
        PlayAction(dotItem, 2, time1[2], delay, pos1[2], pos1[4])
        -- 二阶段
        FuncUtil:Call(function()
            if (gameObject) then
                PlayAction(dotItem, 1, time2[1], 0, pos2[1], pos2[3])
            end
        end, nil, time1[1] + intervalTime)
        FuncUtil:Call(function()
            if (gameObject) then
                PlayAction(dotItem, 2, time2[2], 0, pos2[2], pos2[4])
            end
        end, nil, time1[2] + intervalTime + delay)
        -- 三阶段
        FuncUtil:Call(function()
            if (gameObject) then
                PlayAction(dotItem, 1, time3[1], 0, pos3[1], pos3[3], cb)
            end
        end, nil, time1[1] + intervalTime + time2[1] + intervalTime)
        FuncUtil:Call(function()
            if (gameObject) then
                PlayAction(dotItem, 2, time3[2], 0, pos3[2], pos3[4])
            end
        end, nil, time1[2] + intervalTime + time2[2] + intervalTime + delay)
    end
end

-- 设置点位置
function GetDotPos(_type)
    local pos = centerPos
    local pos1 = {
        x = 0,
        y = 0
    }
    local pos2 = {
        x = 0,
        y = 0
    }
    local pos3 = {
        x = 0,
        y = 0
    }
    local pos4 = {
        x = 0,
        y = 0
    }
    if (_type == 1) then -- 阶段一
        if (isBeeLine) then -- 直线
            if (direction == 2) then
                pos1.x = -pos.x
                pos1.y = 4.6
                pos2.x = -pos.x
                pos2.y = -11.1
                pos3.x = pos.x
                pos3.y = 4.6
                pos4.x = pos.x
                pos4.y = -11.1
            else
                pos1.x = -pos.x
                pos1.y = -11.1
                pos2.x = -pos.x
                pos2.y = 4.6
                pos3.x = pos.x
                pos3.y = -11.1
                pos4.x = pos.x
                pos4.y = 4.6
            end
        else
            if isMain then
                pos1.x = -pos.x + 11
                pos1.y = -pos.y
                pos2.x = -pos.x - 4
                pos2.y = -pos.y
                pos3.x = -pos.x + 11
                pos3.y = pos.y - 53
                pos4.x = -pos.x - 4
                pos4.y = pos.y - 46
            else
                pos1.x = -pos.x
                pos1.y = -pos.y + 12.5
                pos2.x = -pos.x
                pos2.y = -pos.y - 3
                pos3.x = pos.x - 31.5
                pos3.y = -pos.y + 12.5
                pos4.x = pos.x - 21.5
                pos4.y = -pos.y - 3
            end
        end
    elseif (_type == 2) then -- 阶段二
        if (isMain) then
            pos1.x = -pos.x + 11
            pos1.y = pos.y - 53
            pos2.x = -pos.x - 4
            pos2.y = pos.y - 46
            pos3.x = -pos.x + 32
            pos3.y = pos.y - 12.5
            pos4.x = -pos.x + 21.5
            pos4.y = pos.y + 3
        else
            pos1.x = pos.x - 31.5
            pos1.y = -pos.y + 12.5
            pos2.x = pos.x - 21.5
            pos2.y = -pos.y - 3
            pos3.x = pos.x - 11
            pos3.y = -pos.y + 53.5
            pos4.x = pos.x + 3.5
            pos4.y = -pos.y + 46
        end
    elseif (_type == 3) then -- 阶段三
        if (isMain) then
            pos1.x = -pos.x + 32
            pos1.y = pos.y - 12.5
            pos2.x = -pos.x + 21.5
            pos2.y = pos.y + 3
            pos3.x = pos.x
            pos3.y = pos.y - 12.5
            pos4.x = pos.x
            pos4.y = pos.y + 3
        else
            pos1.x = pos.x - 11
            pos1.y = -pos.y + 53.5
            pos2.x = pos.x + 3.5
            pos2.y = -pos.y + 46
            pos3.x = pos.x - 11
            pos3.y = pos.y
            pos4.x = pos.x + 3.5
            pos4.y = pos.y
        end
    end

    return {pos1, pos2, pos3, pos4}
end

-- 执行动画
function PlayAction(_item, _type, _time, _delay, _pos1, _pos2, _cb)
    _item.Play(_type, _time, _delay, _pos1, _pos2)
    FuncUtil:Call(function()
        if (gameObject) then
            if (_cb) then
                _cb()
            end
        end
    end, nil, _time + intervalTime or 0)
end

function GetTime(pos1, pos2)
    return math.floor(GetDistance(pos1, pos2) / dotSpeed)
end

function GetDistance(pos1, pos2)
    return math.sqrt(((pos2.x - pos1.x) * (pos2.x - pos1.x)) + ((pos2.y - pos1.y) * (pos2.y - pos1.y)))
end

function GetCfg()
    return cfg
end

function GetPos()
    return direction
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    lineMask = nil;
    line = nil;
    view = nil;
end
----#End#----
