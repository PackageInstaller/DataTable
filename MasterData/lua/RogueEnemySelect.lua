local isOK = false

function Awake()
    UIUtil:AddTop2("RogueEnemySelect", AdaptiveScreen, function()
        RogueMgr:Back(view)
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.InitFinishRet, function()
        if (isOK) then
            if (isOK ~= "ToFight") then
                FightProto:RogueSelectPos(isOK, nil)
            end
            FightProto:EnterRogueFight()
        end
    end) -- 重连成功
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    curData = RogueMgr:GetCurData()
    local isMax = curData.round >= data:GetLimitRound()
    -- x轮 
    if (isMax) then
        LanguageMgr:SetText(txtTop, 50015)
        CSAPI.LoadImg(top, "UIs/Rogue/img9_10_02.png", false, nil, true)
    else
        LanguageMgr:SetText(txtTop, 50014, curData.round)
        CSAPI.LoadImg(top, "UIs/Rogue/img9_10_01.png", false, nil, true)
    end
    -- items 
    SetItems()

    -- 是否有表演
    CheckAnim()
end

function CheckAnim()
    if (curData.selectPos == nil or #curData.selectPos <= 0) then
        CSAPI.SetScale(group, 0, 0, 0)
        CSAPI.SetGOActive(mask, true)
        CSAPI.SetGOActive(group_fake, true)
        FuncUtil:Call(function()
            CSAPI.SetScale(group, 1, 1, 1)
            CSAPI.SetGOActive(mask, false)
            CSAPI.SetGOActive(group_fake, false)
        end, nil, 1600)
    end
end

function SetItems()
    items = items or {}
    datas = datas or {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    ItemUtil.AddItems("Rogue/RogueEnemySelectItem", items, datas, group, ItemClickCB, 1, nil, function()
        if (curData.selectPos) then
            for k, v in pairs(curData.selectPos) do
                items[v.pos].SetMonster(v.duplicateID, true)
            end
        end
    end)
end

function ItemClickCB(item)
    isOK = item.index
    CSAPI.SetGOActive(mask, true)
    item.SetMonster(curData.duplicateID)
    item.Select()
    FightProto:RogueSelectPos(item.index, ToFight)
end

function ToFight()
    isOK = "ToFight"
    FuncUtil:Call(function()
        FightProto:EnterRogueFight()
    end, nil, 3000)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    RogueMgr:Back(view)
end
