local cfgs = nil
local curDatas = nil
local targetTime,timer = 0,0
local time = 0
local items = nil
local curItem = nil
local buyInfo = nil
local isBuy = false

local selItem = nil
local svSize = nil

function Awake()
    CSAPI.SetGOActive(animMask, false)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Regression_Rebate_Refresh, RefreshPanel);
end

function OnDisable()
    
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = targetTime - TimeUtil:GetTime()
        local tab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 55002, tab[1], tab[2], tab[3])
        if time <= 0 then
            CSAPI.SetText(txtTime, "")
        end
    end
end

function Refresh(_data, _elseData)
    targetTime = _elseData
    cfgs = Cfgs.CfgReturningActivityReward:GetAll()
    SetTime()
    RefreshPanel()
end

function SetTime()
    time = targetTime - TimeUtil:GetTime()
end

function RefreshPanel()
    buyInfo = RegressionMgr:GetRebateInfo()
    isBuy = buyInfo ~= nil
    SetDatas()
    CSAPI.SetGOActive(panel1, not isBuy)
    CSAPI.SetGOActive(panel2, isBuy)
    if isBuy then
        SetCurItem()
    else
        SetItems()
    end
end

function SetDatas()
    curDatas = {}
    if cfgs then
        for i, v in ipairs(cfgs) do
            if not isBuy or (v.level == buyInfo.index) then
                table.insert(curDatas, v)
            end
        end
    end
    if #curDatas > 0 then
        table.sort(curDatas, function(a, b)
            return a.level < b.level
        end)
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("RegressionActivity7/RegressionRebateItem1", items, curDatas, itemParent1, OnItemClickCB, 1, nil)
end

function OnItemClickCB(item)
    if selItem and item.index == selItem.index then
        selItem.SetSelect(false)
        selItem = nil
        MoveTo(-(item.index - 1) * (40 + 344))
        SetSelectAnim(item.index, false)
        return
    end
    local hasSel = false
    if selItem then
        selItem.SetSelect(false)
        SetSelectAnim(selItem.index, false, true)
        hasSel = true
    end
    MoveTo(hasSel and -(40 + 344) or -(item.index - 1) * (40 + 344),hasSel)
    local func = function()
        selItem = item
        selItem.SetSelect(true)
        SetSelectAnim(selItem.index, true)
    end
    FuncUtil:Call(func, this, hasSel and 300 or 0)
    PlayAnim(hasSel and 800 or 350)
end

function MoveToLeft(index)
    if svSize == nil then
        svSize = CSAPI.GetRTSize(sv1)
    end
    local itemLen = 80 + (#curDatas * 344) + 606
    local posX = -(40 + (index - 1) * (344 + 40))
    if itemLen < svSize[0] then
        posX = -40
    elseif -posX > itemLen - svSize[0] then
        posX = -(itemLen - svSize[0])
    end
    CSAPI.SetAnchor(itemParent1, posX, 0)
end

function SetCurItem()
    if curItem then
        curItem.Refresh(curDatas[1], isBuy)
        curItem.SetSelect(true)
    else
        ResUtil:CreateUIGOAsync("RegressionActivity7/RegressionRebateItem1", itemParent2, function(go)
            curItem = ComUtil.GetLuaTable(go)
            curItem.Refresh(curDatas[1], isBuy)
            curItem.SetSelect(true)
        end)
    end
end
-------------------------------------------anim-------------------------------------------
function PlayAnim(time)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
    end, this, time)
end

function SetSelectAnim(index, b, isDisable)
    if not isDisable then
        CSAPI.SetScriptEnable(sv1, "ScrollRect", not b)
        CSAPI.SetScriptEnable(itemParent1, "HorizontalLayoutGroup", not b)
    end
    for i, v in ipairs(items) do
        if i == index then
            v.SetRTAnim(b)
        elseif i > index then
            v.SetMoveAnim(b)
        end
    end
end

function MoveTo(num,isAnim)
    if isAnim then
        local x,y = CSAPI.GetLocalPos(itemParent1)
        UIUtil:SetPObjMove(itemParent1,x,x + num,y,y,0,0,nil,450)
    else
        CSAPI.SetAnchor(itemParent1, num, 0)
    end
end
