-- 策划
local actions = {3, 5, 4} -- 角色3个动作下标（石头，剪刀，布）
local tyIndex = 10 -- 脱衣动作下标 
local hxIndexs = {6, 7, 8, 9} -- 害羞动作下标(卡牌失败)
local cfIndexs = {12, 13, 14, 15} -- 嘲讽动作下标 （卡牌胜利）
local gcIndex = 2 -- 退场动作下标
local cardAllLose = 11 -- 卡牌4次全败会额外播放一次这个动作
--
local czTimer = 3 -- 出招总时间（镜头头2.1s）
local sfTimer = 2 -- 胜负展示时间（镜头0.6s）
local gl = {6, 9, 10}
-- 程序
local playerHP = 3
local cardHP = 3
local curType = 1 -- 1:玩家选择 2：玩家出招+角色出招 3：胜负判断  4：角色动作 5:全脱额外动作
local playerIndex = nil
local cardIndex = nil
local playerIsWin = nil -- 单次出招胜负
local nextTime = nil
local isOver = false
local animator = nil
local effects = {"effect_win", "effect_draw", "effect_lose"}
local lockTime = nil

function Update()
    if (isOver) then
        if (CardLive2DItem.IsIdle()) then
            CardLive2DItem.PlayByIndex(gcIndex)
            isOver = nil
        end
    elseif (nextTime) then
        if (Time.time > nextTime) then
            nextTime = nil
            RefreshPanel()
        end
    end
end

function Refresh(_CardLive2DItem)
    CardLive2DItem = _CardLive2DItem
    animator = ComUtil.GetCom(CardLive2DItem.GetL2dGo(), "Animator")
    RefreshPanel()
end

function RefreshPanel()
    CSAPI.SetGOActive(btnBack, curType == 1)
    CSAPI.SetGOActive(node1, false)
    CSAPI.SetGOActive(node2, false)
    CSAPI.SetGOActive(node3, false)
    this["SetState" .. curType]()
end

-- 玩家选择
function SetState1()
    if (playerHP == 0 or cardHP == 0) then
        -- 还原脱衣动作
        if (cardHP > 0) then
            CardLive2DItem.ResetByIndex({tyIndex})
        end
        -- 游戏结束
        isOver = true
    else
        lockTime = Time.time + 0.5
        CSAPI.SetGOActive(node1, true)
    end
end

-- 双方出招
function SetState2()
    animator:SetTrigger("in") -- 5.18s
    -- 
    CSAPI.LoadImg(imgNode2, "UIs/Spine/20080_skin_Melody06_spine/img_01_0" .. playerIndex .. ".png", true, nil, true)
    CSAPI.SetGOActive(node2, true)
    -- 卡牌出招
    -- 先判断输赢
    local r = 1 -- 123=赢输平
    local _num = CSAPI.RandomInt(1, 10)
    for k, v in ipairs(gl) do
        if (_num <= v) then
            r = k
            break
        end
    end
    -- 根据输赢固定卡牌的出招
    cardIndex = playerIndex
    if (r == 1) then
        cardIndex = (playerIndex + 1 > 3) and 1 or (playerIndex + 1)
    elseif (r == 2) then
        cardIndex = (playerIndex - 1 < 1) and 3 or (playerIndex - 1)
    end
    -- cardIndex = CSAPI.RandomInt(1, 3)
    CardLive2DItem.PlayByIndex(actions[cardIndex])
    curType = 3
    nextTime = Time.time + czTimer
end

-- 胜负判断
function SetState3()
    animator:SetTrigger("out") -- 0.6s
    --
    playerIsWin = nil
    local effectIndex = 2
    if (playerIndex ~= cardIndex) then
        if (math.abs(playerIndex - cardIndex) > 1) then
            playerIsWin = playerIndex == 3
        else
            playerIsWin = playerIndex < cardIndex
        end
        effectIndex = playerIsWin and 1 or 3
    end
    for k, v in ipairs(effects) do
        CSAPI.SetGOActive(this[v], k == effectIndex)
    end
    CSAPI.SetGOActive(node3, true)
    curType = playerIsWin == nil and 1 or 4 -- nil是和
    nextTime = Time.time + sfTimer
end

-- 动作
function SetState4()
    if (playerIsWin) then
        cardHP = cardHP - 1
        -- 害羞动作(只播2段),最后一段混在cardAllLose下标对于的动作里
        if (cardHP >= 1) then
            CardLive2DItem.PlayByIndex(hxIndexs[3 - cardHP]) -- 1.6s
        end
        -- 卡牌脱衣动作(总2.6s)
        CardLive2DItem.PlayByIndex(tyIndex)
        if (cardHP <= 0) then
            curType = 5
            nextTime = Time.time + 0.1
        else
            curType = 1
            nextTime = Time.time + 2
        end
    else
        playerHP = playerHP - 1
        -- 嘲讽动作 
        CardLive2DItem.PlayByIndex(cfIndexs[3 - playerHP], function()
            curType = 1
            nextTime = Time.time + 0.1
        end)
    end
    -- 
    SetHPs()
end

-- 会直接抛事件退出
function SetState5()
    CardLive2DItem.PlayByIndex(cardAllLose)
end

function SetHPs()
    for k = 1, 4 do
        CSAPI.SetGOActive(this["imgCard" .. k], cardHP >= k)
        CSAPI.SetGOActive(this["imgRole" .. k], playerHP >= k)
    end
end

function ToClick(index)
    if(lockTime and Time.time>lockTime)then 
        curType = 2
        playerIndex = index
        RefreshPanel()
    end 
end

-- 石头
function OnClick1()
    ToClick(1)
end
-- 剪刀
function OnClick2()
    ToClick(2)
end
-- 布
function OnClick3()
    ToClick(3)
end

function OnClickBack()
    if(isOver==nil)then 
        return 
    end
    if (not isOver) then
        playerHP = 0
        curType = 1
        nextTime = Time.time
    end
end

