local curIndex = 1
local oldIndex = 1
function Awake()
    UIUtil:AddTop2("RogueTBuffSelect", gameObject, function()
        view:Close()
    end, nil, {})
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RogueT_Buff_Upgrade, SetBtn)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    -- items
    SetItems()
    -- btn
    SetBtn()
end

function SetItems()
    randomBuffs = RogueTMgr:GetFightData().randomBuffs
    items = items or {}
    ItemUtil.AddItems("RogueT/RogueTBuffSelectItem", items, randomBuffs, grids, ItemSelect, 1, curIndex, ItemsAnim)
end

function ItemsAnim()
    local delay = 1
    for k, v in ipairs(items) do
        delay = delay + 40 * (k - 1)
        UIUtil:SetPObjMove(v.clickNode, 350, 0, 0, 0, 0, 0, nil, 400, delay)
        UIUtil:SetObjFade(v.clickNode, 0, 1, nil, 200, delay, 0)
    end
end

function SetBtn()
    CSAPI.SetText(txtShop, BagMgr:GetCount(g_RogueT_Coin) .. "")
    local cfg = Cfgs.ItemInfo:GetByID(g_RogueT_Coin)
    ResUtil.IconGoods:Load(goodsIcon, cfg.icon .. "_1")
end

function ItemSelect(index)
    if (oldIndex == index) then
        return
    end
    curIndex = index
    items[oldIndex].Select(false)
    items[curIndex].Select(true)
    oldIndex = curIndex
end

function OnClickSure()
    FightProto:RogueTSelectBuff(randomBuffs[curIndex], function()
        CSAPI.SetGOActive(mask, true)
        CSAPI.OpenView("RogueTEnemySelect")
        view:Close()
    end)
end

function OnClickShop()
    CSAPI.OpenView("RogueTShopBuff")
end

function OnClickBuff()
    CSAPI.OpenView("RogueTCurBuff")
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
