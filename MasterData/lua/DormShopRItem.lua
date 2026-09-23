local needToCheckMove = false
local timer = nil
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName)
end
function Update()
    if (needToCheckMove and Time.time > timer) then
        luaTextMove:CheckMove(txtName)
        needToCheckMove = false
    end
end
function Refresh(_id)
    id = _id

    cfg = Cfgs.CfgFurniture:GetByID(id)

    -- icon 
    ResUtil.Furniture:Load(icon, cfg.icon, true)
    -- name 
    needToCheckMove = false
    CSAPI.SetText(txtName, cfg.sName)
    timer = Time.time + 0.1
    needToCheckMove = true
    -- time 
    -- todo 
    -- num 
    cur = DormMgr:GetBuyCount(id)
    CSAPI.SetText(txtHad, string.format("%s/%s", cur, cfg.buyNumLimit))
    -- comfort
    CSAPI.SetText(txtComfort, cfg.comfort .. "")
    -- spend
    -- 家具币
    if (cfg.price_1) then
        local cfg1 = Cfgs.ItemInfo:GetByID(cfg.price_1[1][1])
        ResUtil.IconGoods:Load(imgSpend1, cfg1.icon .. "_1")
        CSAPI.SetText(txtSpend1, cfg.price_1[1][2] .. "")
    end
    CSAPI.SetGOActive(imgSpend1, cfg.price_1 ~= nil)
    -- 钻石
    if (cfg.price_2) then
        local cfg2 = Cfgs.ItemInfo:GetByID(cfg.price_2[1][1])
        ResUtil.IconGoods:Load(imgSpend2, cfg2.icon .. "_1")
        CSAPI.SetText(txtSpend2, cfg.price_2[1][2] .. "")
    end
    CSAPI.SetGOActive(imgSpend2, cfg.price_2 ~= nil)
    --
    CSAPI.SetGOActive(bg, cfg.price_1 ~= nil and cfg.price_2 ~= nil and true or false)
    --  
    local canInte = false
    if (cfg.intePoints and #cfg.intePoints > 0) then
        canInte = true
    end
    CSAPI.SetGOActive(imgMove, canInte)
end

function OnClick()
    if (cur < cfg.buyNumLimit) then
        -- CSAPI.OpenView("DormFurniturePayView", id)
        CSAPI.OpenView("ShopPayView",{id=id,spType=1})
    else
        LanguageMgr:ShowTips(21036)
    end
end
