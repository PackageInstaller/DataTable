local curTopIndex = 1
local selectID = nil

function Awake()
    UIUtil:AddTop2("RogueTShopBuff", gameObject, function()
        view:Close()
    end, nil)

    layout1 = ComUtil.GetCom(hsv, "UIInfinite")
    layout1:Init("UIs/RogueT/RogueTCurBuffItem1", LayoutCallBack1, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.RogueT)

    layout2 = ComUtil.GetCom(vsv, "UIInfinite")
    layout2:Init("UIs/RogueT/RogueTShopBuffItem", LayoutCallBack2, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.RogueTM)

    InitTopData()
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = topCfgs[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB1)
        lua.Refresh(_data, curTopIndex)
    end
end
function ItemClickCB1(index)
    curTopIndex = index
    layout1:UpdateList()
    SetVSV()
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetClickCB(ItemClickCB2)
        lua.Refresh(_data, selectID)
    end
end
function ItemClickCB2(id)
    if (btnEffect) then
        CSAPI.SetGOActive(btnEffect, false)
    end
    selectID = id
    layout2:UpdateList()
    SetRight()
end

function InitTopData()
    local _cfgs = Cfgs.CfgRogueBuffType:GetAll()
    topCfgs = {}
    table.insert(topCfgs, {
        id = 0,
        icon = "1000" -- RogueBuff
    })
    for k, v in ipairs(_cfgs) do
        table.insert(topCfgs, v)
    end
end

function OnOpen()
    arr = RogueTMgr:GetSelectBuffs()

    RefreshPanel()
end

function RefreshPanel()
    --
    layout1:IEShowList(#topCfgs)
    --
    SetVSV()
    --
    SetRight()
end

function SetVSV()
    curDatas = {}
    if (curTopIndex == 1) then
        curDatas = arr
    else
        local id = topCfgs[curTopIndex].id
        for k, v in ipairs(arr) do
            local cfg = Cfgs.CfgRogueTBuff:GetByID(v)
            if (cfg.buffType == id) then
                table.insert(curDatas, v)
            end
        end
    end
    layout2:IEShowList(#curDatas)
    CSAPI.SetGOActive(txtEmpty, #curDatas <= 0)
end

function SetRight(isUP)
    CSAPI.SetGOActive(R, selectID ~= nil)
    if (selectID ~= nil) then
        if (not shopItem) then
            ResUtil:CreateUIGOAsync("RogueT/RogueTShopBuffItem", R, function(go)
                shopItem = ComUtil.GetLuaTable(go)
                shopItem.Refresh(selectID)
            end)
        else
            shopItem.Refresh(selectID)
            if (isUP) then
                shopItem:SetUPAnim()
            end
        end
        --
        local cfg = Cfgs.CfgRogueTBuff:GetByID(selectID)
        CSAPI.SetText(txtDesc1, cfg.desc)
        --
        local desc2 = ""
        if (cfg.nextLevel) then
            local cfg2 = Cfgs.CfgRogueTBuff:GetByID(cfg.nextLevel)
            desc2 = cfg2.desc
        end
        CSAPI.SetText(txtDesc2, desc2)
        --
        alpha = 1
        CSAPI.SetGOActive(btnUpgrade, cfg.nextLevel ~= nil)
        local cost = cfg.cost ~= nil and cfg.cost[1] or nil
        if (cfg.nextLevel and cost ~= nil) then
            CSAPI.SetText(txtShop, cost[2] .. "")
            local cfg = Cfgs.ItemInfo:GetByID(cost[1])
            ResUtil.IconGoods:Load(goodsIcon, cfg.icon .. "_1")
            --
            if (cost[2] > BagMgr:GetCount(cost[1])) then
                alpha = 0.5
            end
        end
        CSAPI.SetGOAlpha(btnUpgrade, alpha)
    end
end

function OnClickUpgrade()
    if (alpha == 1) then
        FightProto:RogueTBuffUp(selectID, function(new_id)
            selectID = new_id
            --
            if (btnEffect) then
                CSAPI.SetGOActive(btnEffect, true)
            else
                CSAPI.CreateGOAsync("UIs/RogueT/RogueTShopBuff_Btn", 0, 0, 0, btnUpgrade, function(obj)
                    btnEffect = obj
                end)
            end

            SetVSV()
            SetRight(true)
            CSAPI.SetGOActive(mask, true)
            --
            FuncUtil:Call(function()
                CSAPI.SetGOActive(mask, false)
            end, nil, 320)
        end)
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
