-- 家具购买
local count = 1 -- 选择几件
local limit=1;--限制选择数量

function Awake()
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    -- cg_pay = ComUtil.GetCom(btn_pay, "CanvasGroup")
end

function OnOpen()
    if openSetting and openSetting == 2 then
        cfg = Cfgs.CfgFurniture:GetByID(data.id)
    else
        cfg = Cfgs.CfgFurniture:GetByID(data)
    end

    -- name 
    CSAPI.SetText(txt_name, cfg.sName)
    -- comfort
    CSAPI.SetText(txtComfort, cfg.comfort .. "")
    -- icon
    ResUtil.Furniture:Load(icon, cfg.icon, true)
    -- desc
    CSAPI.SetText(txt_desc, cfg.desc)
    -- tab 
    tab.selIndex = 0
    -- imgMove
    CSAPI.SetGOActive(imgMove, cfg.inteActionId ~= nil)
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

    -- price 单价
    _cfg = Cfgs.ItemInfo:GetByID(price[1])
    iconName = _cfg and _cfg.icon or nil
    if (iconName) then
        ResUtil.IconGoods:Load(nPriceIcon, iconName .. "_1", true)
    end
    CSAPI.SetText(txt_nPrice, price[2] .. "")
    -- 持有 
    cur = DormMgr:GetBuyCount(cfg.id)
    max = cfg.buyNumLimit
    if openSetting==2 then
        limit=data.comm:GetNum();
        limit=cur+limit>=max and max-cur or limit;
    end
    if limit==nil or limit==-1 then
        limit=max-cur;
    end
    CSAPI.SetText(txt_hasNum, string.format("%s/%s", cur, max))
    -- 内容 
    CSAPI.SetText(txt_contentName, cfg.sName)
    CSAPI.SetText(txt_contentNum, "X1")
    --
    Change()

    --
    SetImgTabs()
end

function Change()
    CSAPI.SetText(txt_num, count .. "")
    -- 合计
    if (iconName) then
        ResUtil.IconGoods:Load(priceIcon, iconName .. "_1", true)
    end
    need = price[2] * count
    CSAPI.SetText(txt_price, need .. "")
    -- btn 
    had = BagMgr:GetCount(price[1])
    -- cg_pay.alpha = had >= need and 1 or 0.3
end

function SetImgTabs()
    if (not isSetTab) then
        -- item1
        CSAPI.SetGOActive(item1, cfg.price_1 ~= nil)
        if (cfg.price_1 ~= nil) then
            local _cfg1 = Cfgs.ItemInfo:GetByID(cfg.price_1[1][1])
            ResUtil.IconGoods:Load(imtTab1, _cfg1.icon .. "_1", true)
            LanguageMgr:SetText(txtItem1, 18111, _cfg1.name) -- 38001
        end
        -- item2
        CSAPI.SetGOActive(item2, cfg.price_2 ~= nil)
        if (cfg.price_2 ~= nil) then
            local _cfg2 = Cfgs.ItemInfo:GetByID(cfg.price_2[1][1])
            ResUtil.IconGoods:Load(imtTab2, _cfg2.icon .. "_1", true)
            LanguageMgr:SetText(txtItem2, 18111, _cfg2.name) -- 38002
        end
        local width = cfg.price_2 ~= nil and 430 or 821
        CSAPI.SetRTSize(item1, width, 100)
    end
end

function OnClickRemove()
    if (count > 1) then
        count = count - 1
        Change()
    else
        LanguageMgr:ShowTips(2309)
    end
end

function OnClickAdd()
    if (count < limit) then
        count = count + 1
        Change()
    else
        LanguageMgr:ShowTips(2308)
    end
end

function OnClickMax()
    if (count ~= limit) then
        count = limit
        Change()
    else
        LanguageMgr:ShowTips(2308)
    end
end

function OnClickMin()
    if (count ~= 1) then
        count = 1
        Change()
    else
        LanguageMgr:ShowTips(2309)
    end
end

function OnClickMask()
    Close()
end

function OnClickPay()
    if (had >= need) then
        if (need <= 0) then
            -- 特殊家具 
            LanguageMgr:ShowTips(15122)
            return
        end
        local func = nil
        if openSetting == 2 then -- 商店中的购买
            if data == nil or data.commId == nil then
                LogError("传入的数据有误！");
                return
            end
            func = function()
                ShopProto:Buy(data.commId, TimeUtil:GetTime(), count, tab.selIndex == 0 and "price_1" or "price_2",nil,nil,
                    function(proto)
                        EventMgr.Dispatch(EventType.Shop_View_Refresh);
                        if proto and next(proto.gets) then
                            UIUtil:OpenReward({proto.gets})
                        end
                    end)
            end
        else
            func = function()
                local infos = {{
                    ["id"] = cfg.id,
                    num = count
                }}
                DormProto:BuyFurniture(infos, tab.selIndex == 0 and "price_1" or "price_2")
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
    else
        Tips.ShowTips(string.format(LanguageMgr:GetTips(15000), _cfg.name))
    end
end

function Close()
    CSAPI.SetGOActive(tweenObj2, true);
    FuncUtil:Call(function()
        view:Close();
    end, nil, 180);
end
