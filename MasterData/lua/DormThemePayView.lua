-- 主题购买
function Awake()

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Dorm2/DormThemePayItem", LayoutCallBack, true)

    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    cg_pay = ComUtil.GetCom(btn_pay, "CanvasGroup")

    layout2 = ComUtil.GetCom(hpage, "UIInfinite")
    layout2:Init("UIs/Dorm2/DormThemeImg", LayoutCallBack2, true)
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        lua.Refresh(imgDatas[index])
    end
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data, tab.selIndex)
    end
end

function OnOpen()
    if openSetting and openSetting == 2 then -- data={id=cfgId,commId=商品ID}
        cfg = Cfgs.CfgFurnitureTheme:GetByID(data.id)
    else
        cfg = Cfgs.CfgFurnitureTheme:GetByID(data)
    end

    -- name 
    CSAPI.SetText(txt_name, cfg.sName)
    -- comfort
    CSAPI.SetText(txtComfort, cfg.comfort .. "")
    -- icon
    SetImgs()
    -- desc
    CSAPI.SetText(txt_desc, cfg.desc)
    -- tab 
    tab.selIndex = 0
end

function SetImgs()
    imgDatas = {}
    if (cfg.PromoImage) then
        for k, v in ipairs(cfg.PromoImage) do
            local str = cfg.id .. "/" .. v
            table.insert(imgDatas, str)
        end
    end
    layout2:IEShowList(#imgDatas)
end

function OnTabChanged(_index)
    if (_index == 1 and cfg.price_2 == nil) then
        tab.selIndex = 0
        return
    end
    count = 1
    RefreshPanel()
end

function RefreshPanel()
    price = tab.selIndex == 0 and cfg.price_1[1] or cfg.price_2[1]
    -- 内容 
    curDatas = {}
    if (counts == nil) then
        counts = DormMgr:GetCfgFurnitureCount(cfg.id)
    end
    for k, v in pairs(counts) do
        local buyCount = DormMgr:GetBuyCount(k)
        table.insert(curDatas, {k, v, buyCount}) -- {id,需要的数量，已购买的数量}
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            return a[1] < b[1]
        end)
    end
    layout:IEShowList(#curDatas)

    -- 价格
    CheckEnough()
    local _cfg = Cfgs.ItemInfo:GetByID(price[1])
    local iconName = _cfg and _cfg.icon or nil
    if (iconName) then
        ResUtil.IconGoods:Load(nPriceIcon, iconName .. "_1", true)
    end
    CSAPI.SetText(txt_nPrice, need .. "")
    -- btn
    cg_pay.alpha = had >= need and 1 or 0.3

    --
    SetImgTabs()
end

function SetImgTabs()
    if (not isSetTab) then
        local _cfg1 = Cfgs.ItemInfo:GetByID(cfg.price_1[1][1])
        ResUtil.IconGoods:Load(imtTab1, _cfg1.icon .. "_1", true)

        local _cfg2 = Cfgs.ItemInfo:GetByID(cfg.price_2[1][1])
        ResUtil.IconGoods:Load(imtTab2, _cfg2.icon .. "_1", true)
    end
end

function CheckEnough()
    had = BagMgr:GetCount(price[1])
    need = 0
    for k, v in ipairs(curDatas) do
        local num = v[2] > v[3] and (v[2] - v[3]) or 0
        if (num > 0) then
            local _cfg = Cfgs.CfgFurniture:GetByID(v[1])
            if (not _cfg.special) then
                local _prices = tab.selIndex == 0 and _cfg.price_1 or _cfg.price_2
                local _price = _prices and _prices[1] or nil
                if (_price) then
                    need = need + _price[2] * num
                end
            end
        end
    end
end

function OnClickPay()
    if (had >= need) then
        if (need <= 0) then
            -- 特殊家具 
            LanguageMgr:ShowTips(15122)
            return
        end
        local func = nil
        if openSetting == 2 then
            if data == nil or data.commId == nil then
                LogError("传入的数据有误！");
                return
            end
            func = function()
                ShopProto:Buy(data.commId, TimeUtil:GetTime(), 1, tab.selIndex == 0 and "price_1" or "price_2",nil,nil,
                    function(proto)
                        EventMgr.Dispatch(EventType.Shop_View_Refresh);
                        if proto and next(proto.gets) then
                            UIUtil:OpenReward({proto.gets})
                        end
                    end)
            end
        else
            func = function()
                local str = tab.selIndex == 0 and "price_1" or "price_2"
                DormProto:BuyTheme(cfg.id, str)
            end
        end
        if (tab.selIndex == 0) then
            func()
            Close()
        else
            if CSAPI.IsADVRegional(3) then
                CSAPI.ADVJPTitle(need,function()
                    func()
                    view:Close()
                end)
            else
                local _cfg2 = Cfgs.ItemInfo:GetByID(cfg.price_2[1][1])
                local str = LanguageMgr:GetTips(15123, _cfg2.name, need)
                UIUtil:OpenDialog(str, function()
                    func()
                    view:Close()
                end)
            end
        end
    end
end

function OnClickMask()
    Close()
end

function Close()
    CSAPI.SetGOActive(tweenObj2, true);
    FuncUtil:Call(function()
        view:Close();
    end, nil, 180);
end
