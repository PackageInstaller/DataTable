local isOver = false
local items1 = {}
local items2 = {}
local perCnts = {3, 5}
local qTr = nil -- 翻下
local oldIndexs = {}
local rTs = nil -- 翻上
local inte = nil -- 连射间隔
local curNumbers = {}
local curGolds = {} -- 金色 curNumbers的下标
local perTimer = 5

function Update()
    if (isOver) then
        return
    end

    if (qTr and Time.time >= qTr) then
        qTr = nil
        ToQuit()
    end
    if (rTs and Time.time >= rTs) then
        rTs = nil
        ToShow()
    end
    if (inte and Time.time >= inte) then
        inte = nil
    end
end

function ToQuit()
    local isHad = false
    for k, v in ipairs(curNumbers) do
        if (v ~= 0) then
            isHad = true
            if (v > 6) then
                items2[v - 6].PlayAnim("target_quit")
            else
                items1[v].PlayAnim("target_quit")
            end
        end
    end
    rTs = isHad and (Time.time + 0.4) or Time.time
end

function ToShow()
    curNumbers, curGolds = GetNumbers()
    for k, v in ipairs(curNumbers) do
        if (v > 6) then
            items2[v - 6].PlayAnim("target_entry", k, curGolds[k])
        else
            items1[v].PlayAnim("target_entry", k, curGolds[k])
        end
    end
    qTr = Time.time + perTimer + 0.7
end

function GetNumbers()
    -- 1. 先生成 1~12 的数组
    local numbers = {}
    for i = 1, 12 do
        table.insert(numbers, i)
    end

    -- 2. 随机决定取 3、4、5 个（你要的范围）
    local count = CSAPI.RandomInt(perCnts[1], perCnts[2])

    -- 3. 随机抽取（不重复）
    local result = {}
    local golds = {}
    local isBreak = false
    for i = 1, count do
        -- 随机取一个位置
        local idx = CSAPI.RandomInt(1, #numbers)
        -- 放进结果
        table.insert(result, numbers[idx])
        -- 金色 
        if (not isBreak) then
            local gl = math.ceil(100 * (0.5 ^ (i - 1)))
            local _gl = CSAPI.RandomInt(1, 100)
            if (_gl <= gl) then
                table.insert(golds, i)
            else
                isBreak = true
            end
        end

        -- 删除已选数字，保证不重复
        table.remove(numbers, idx)
    end
    return result, golds
end

function Refresh(_parentLua, _CardLive2DItem, _cb)
    parentLua = _parentLua
    CardLive2DItem = _CardLive2DItem
    cb = _cb
    --
    items1 = items1 or {}
    ItemUtil.AddItems("Spine/30180_skin_Machairodus05a_spine/30180_BackUI_Item", items1, {1, 2, 3, 4, 5, 6}, hlg1,
        ItemClickCB)
    --
    items2 = items2 or {}
    ItemUtil.AddItems("Spine/30180_skin_Machairodus05a_spine/30180_BackUI_Item", items2, {1, 2, 3, 4, 5, 6}, hlg2,
        ItemClickCB)
    -- 
    rTs = Time.time + 0.5
end

function ItemClickCB(item, score)
    if (isOver) then
        return
    end
    if (inte) then
        return
    end
    if (not parentLua.CanShoot()) then
        return
    end
    parentLua.Shoot()
    inte = Time.time + 0.2
    if (item) then
        item.PlayAnim("target_quit")
        curNumbers[item.GetIx()] = 0
    end
    cb(score)
    -- 
    local isHad = false
    for k, v in ipairs(curNumbers) do
        if (v ~= 0) then
            isHad = true
            break
        end
    end
    if (not isHad) then
        local _qTr = Time.time + 0.8
        if (qTr == nil) then
            qTr = _qTr
        else
            qTr = qTr < _qTr and qTr or _qTr
        end
    end
end

function SetOver()
    isOver = true
end

function OnClickMask()
    ItemClickCB(nil, 0)
end
