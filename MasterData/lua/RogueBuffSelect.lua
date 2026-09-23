function Awake()
    UIUtil:AddTop2("RogueBuffSelect", AdaptiveScreen, function()
        RogueMgr:Back(view)
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, function()
        if (data) then
            SetDown(data, true)
        end
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    SetDown(data, true)
    SetItems1()
    SetItems2()
end

function SetDown(data, isChallenge)
    local limit = data:GetLimitRound()
    local index = data:GetRNum(isChallenge)
    -- item
    posItems = posItems or {}
    local datas = {}
    for k = 1, 7 do
        table.insert(datas, k)
    end
    ItemUtil.AddItems("Rogue/RoguePosItem", posItems, datas, Content, nil, 1, {index, 2})
end

function SetItems1()
    items1 = items1 or {}
    ItemUtil.AddItems("Rogue/RogueBuffSelectItem1", items1, RogueMgr:GetRandomBuffs(), group1, ItemSelectCB1, 1, nil,
        function()
            ItemsAnim()
            ItemSelectCB1(items1[1])
        end)
end

function ItemsAnim()
    local delay = 1
    for k, v in ipairs(items1) do
        delay = delay + 40 * (k - 1)
        UIUtil:SetPObjMove(v.clickNode, 350, 0, 0, 0, 0, 0, nil, 400, delay)
        UIUtil:SetObjFade(v.clickNode, 0, 1, nil, 200, delay, 0)
    end
end

function ItemSelectCB1(item)
    if (oldItem1) then
        oldItem1.Select(false)
    end
    item.Select(true)
    oldItem1 = item
end

function SetItems2()
    items2 = items2 or {}
    ItemUtil.AddItems("Rogue/RogueBuffSelectItem2", items2, RogueMgr:GetSelectBuffs(), group2)

    UIUtil:SetPObjMove(objGroup2, -572.4, -647.4, -362.7, -362.7, 0, 0, nil, 300, 200)
    UIUtil:SetObjFade(objGroup2, 0, 1, nil, 300, 200, 0)
end

function OnClickSure()
    FightProto:RogueSelectBuff(oldItem1.id, function()
        view:Close()
        CSAPI.OpenView("RogueEnemySelect", data)
    end)
end


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    RogueMgr:Back(view)
end