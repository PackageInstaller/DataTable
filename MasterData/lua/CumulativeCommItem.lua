-- 多个商品
local eventMgr = nil;
local commodity = nil;
local rmbIcon = nil;
local SDKdisplayPrice = nil;
local iconList = {};
local arrow = nil;
local costs = {};
local canBuy = false; -- 是否可以购买
local addBuffs = nil;
local elseData = nil;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefersh)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(_commodity, _elseData)
    commodity = _commodity;
    elseData = _elseData;
    -- 获取上一个商品的购买状态
    if commodity ~= nil then
        local isOver = commodity:IsOver();
        local preCommId = commodity:GetPreLimitID();
        canBuy = commodity:GetBuyLimit();
        -- 判断是否存在条件，否则有条件限制的直接显示可领取和未解锁,无条件限制的显示未解锁和免费
        local isLock, lockDesc = elseData.activityData:GetLockState(commodity:GetID());
        -- LogError(tostring(commodity:GetID()).."\t"..tostring(isLock).."\t"..tostring(lockDesc))
        CSAPI.SetGOActive(overObj, commodity:IsOver());
        CSAPI.SetGOActive(lockObj, not canBuy);
        -- 初始化价格
        rmbIcon = commodity:GetCurrencySymbols();
        SDKdisplayPrice = commodity:GetSDKdisplayPrice()
        local isSP = elseData.activityData:IsOverRewards(commodity:GetID());
        -- local scale=isSP and 1.1 or 0.94
        -- CSAPI.SetScale(gameObject,scale,scale,scale)
        costs = nil;
        if commodity:HasOtherPrice(ShopPriceKey.jCosts1) then
            costs = {commodity:GetRealPrice()[1], commodity:GetRealPrice(ShopPriceKey.jCosts1)[1]};
        else
            costs = commodity:GetRealPrice();
        end
        local goods = commodity:GetCommodityList();
        local good = goods ~= nil and goods[1] or nil;
        local num = commodity:GetNum()
        local type = 1;
        if elseData and isSP then
            type = 3
        elseif (costs == nil or (costs ~= nil and costs[1].num <= 0)) then
            type = 1;
        else
            type = 2;
        end
        SetQuality(type)
        CSAPI.SetText(txtName, commodity:GetName());
        if good ~= nil then
            -- local s=#goods>1 and 1 or 1.1;
            -- CSAPI.SetScale(infos,s,s,s);
            if commodity:GetType() == CommodityItemType.THEME or commodity:GetType() == CommodityItemType.FORNITURE then -- 查询宿舍表中的价格
                costs = {};
                local dyVal1 = good.data:GetDyVal1();
                local isMax = false;
                -- 查询宿舍表
                if dyVal1 then
                    local cfg = Cfgs.CfgFurniture:GetByID(dyVal1);
                    type = 2;
                    -- 判断是否超过持有数，超过持有数不能购买
                    if commodity:GetType() == CommodityItemType.FORNITURE then -- 家具
                        num = cfg.comfort;
                        local buyCount = DormMgr:GetBuyCount(dyVal1);
                        isMax = buyCount >= cfg.buyNumLimit;
                        if cfg.price_1 then
                            table.insert(costs, {
                                id = cfg.price_1[1][1],
                                num = cfg.price_1[1][2]
                            });
                        end
                        if cfg.price_2 then
                            table.insert(costs, {
                                id = cfg.price_2[1][1],
                                num = cfg.price_2[1][2]
                            });
                        end
                    else -- 主题
                        local themeData = DormMgr:GetThemesByID(ThemeType.Sys, dyVal1)
                        local cfg2 = Cfgs.CfgFurnitureTheme:GetByID(dyVal1);
                        num = cfg2.comfort;
                        -- 获取主题价格
                        local price1, price2 = DormMgr:GetThemePrices(dyVal1);
                        isMax = themeData ~= nil;
                        if cfg.price_1 then
                            table.insert(costs, {
                                id = cfg.price_1[1][1],
                                num = price1
                            });
                        end
                        if cfg.price_2 then
                            table.insert(costs, {
                                id = cfg.price_2[1][1],
                                num = price2
                            });
                        end
                    end
                end
            end
            for i = 1, 2 do
                local isShow = false;
                if commodity:GetType() == CommodityItemType.Skin and i > 1 then
                    isShow = false;
                else
                    isShow = goods[i] ~= nil;
                end
                if iconList[i]==nil or (iconList[i] and iconList[i].isLoading ~=true) then
                    iconList[i]={};
                    iconList[i].isLoading = true;
                    ResUtil:CreateUIGOAsync("ShopComm/CommodityIcon", this["iconNode" .. i], function(go)
                        iconList[i].tab=ComUtil.GetLuaTable(go);
                        if goods[i] ~= nil then
                            iconList[i].tab.LoadGoodsIcon(goods[i].data, 1); -- 根据物品数据加载图标
                            -- 设置数量
                            CSAPI.SetText(this["txtNum" .. i], tostring(goods[i].num));
                        end
                    end);
                elseif goods[i] ~= nil and iconList[i]~=nil then
                    iconList[i].tab.LoadGoodsIcon(goods[i].data, 1); -- 根据物品数据加载图标
                    -- 设置数量
                    CSAPI.SetText(this["txtNum" .. i], tostring(goods[i].num));
                end
                CSAPI.SetGOActive(this["iconObj" .. i], isShow);
            end
        end
        if canBuy and isLock ~= true then
            SetCost(costs);
        else -- 设置条件显示描述
            CSAPI.SetGOActive(priceObj, false);
            CSAPI.SetGOActive(freeObj, true);
            if lockDesc ~= "" and lockDesc ~= nil then
                if isLock then
                    CSAPI.SetText(txt_free, lockDesc);
                else
                    if commodity:IsOver() then -- 可购买
                        CSAPI.SetText(txt_free, LanguageMgr:GetByID(170011));
                    else
                        CSAPI.SetText(txt_free, LanguageMgr:GetByID(170010));
                    end
                end
            else
                if commodity:IsOver() then -- 可购买
                    CSAPI.SetText(txt_free, LanguageMgr:GetByID(170012));
                else
                    -- CSAPI.SetText(txt_free,LanguageMgr:GetByID(170005));
                    SetCost(costs);
                end
            end
        end
    end
    OnRedPointRefersh();
end

-- 设置单种价格
function SetCost(costs, isOver)
    if costs then
        if #costs == 1 then -- 暂只支持单个价格配置
            if costs[1].num > 0 then
                ShopCommFunc.SetPriceIcon(moneyIcon, costs[1]);
                local tips = "";
                local Price = costs[1].num;
                if costs[1].id == -1 then
                    tips = rmbIcon;
                    if CSAPI.IsADV() and SDKdisplayPrice then
                        Price = SDKdisplayPrice;
                    end
                end
                if CSAPI.IsSwapleftandright() then
                    CSAPI.SetText(txt_price, tostring(Price) .. tips);
                else
                    CSAPI.SetText(txt_price, tips .. tostring(Price));
                end
                CSAPI.SetGOActive(priceObj, true);
                CSAPI.SetGOActive(freeObj, false);
            else
                CSAPI.SetText(txt_free, LanguageMgr:GetByID(170003));
                CSAPI.SetGOActive(priceObj, false);
                CSAPI.SetGOActive(freeObj, true);
            end
        end
    else
        CSAPI.SetText(txt_free, LanguageMgr:GetByID(170003));
        CSAPI.SetGOActive(priceObj, false);
        CSAPI.SetGOActive(freeObj, true);
    end
end

function ShowBottomArrow()
    if arrow ~= nil then
        CSAPI.SetGOActive(arrow.gameObject, true);
    else
        -- 加载箭头
        ResUtil:CreateUIGOAsync("CumulativeSpending/CumulativeArrow", gameObject, function(go)
            arrow = ComUtil.GetLuaTable(go);
            arrow.Refresh(4);
            CSAPI.SetScale(arrow.gameObject, 0.8, 0.8)
            CSAPI.SetAnchor(arrow.gameObject, 4, -130);
        end);
    end
end

function OnClick()
    -- if commodity:IsOver()  then
    --     Tips.ShowTips(LanguageMgr:GetByID(170013))
    --     do return end
    -- elseif canBuy~=true then
    --     Tips.ShowTips(LanguageMgr:GetByID(170015))
    --     do return end
    -- elseif isLock then
    --     Tips.ShowTips(LanguageMgr:GetByID(170014))
    --     do return end
    -- end
    -- SendBuy();
    ShowGoodsInfo(1)
end

function SendBuy()
    local pageData = ShopMgr:GetPageByID(commodity:GetShopID());
    if (costs == nil or (costs ~= nil and costs[1].num <= 0)) then
        ShopCommFunc.HandlePayLogic(commodity, 1, nil, OnSuccess);
    else
        -- 收费则调起窗口
        CSAPI.OpenView("ShopPayView", {
            commodity = commodity
        })
        -- CSAPI.OpenView("CumulativeSpendingPayView", {
        --     commodity = commodity,
        --     pageData = pageData,
        --     isLock = isLook
        -- });
    end
end

function OnSuccess(proto)
    if proto then
        addBuffs = proto.add_bufs;
        if next(proto.gets) then
            UIUtil:OpenReward({proto.gets})
        else
            ShowBuffTips();
        end
    end
end

function ShowBuffTips()
    if addBuffs and next(addBuffs) then
        for k, v in ipairs(addBuffs) do
            local itemCfg = Cfgs.ItemInfo:GetByID(v.id);
            if itemCfg then
                Tips.ShowTips(itemCfg.describe);
            end
        end
    end
end

function OnRedPointRefersh()
    local _pData1 = RedPointMgr:GetData(RedPointType.CumulativeSpending)
    local isShow = false;
    if _pData1 ~= nil then
        for i, v in pairs(_pData1) do
            if v[commodity:GetID()] ~= nil then
                isShow = true;
                break
            end
        end
    end
    UIUtil:SetRedPoint(redNode, isShow, 0, 0, 0)
end

-- _type:1=免费、2=收费、3=大奖
function SetQuality(_type)
    local quality = _type == nil and 1 or _type;
    local fontColor = "243c30";
    local bgName = "img_23_01";
    local iBgName = "img_24_01";
    local iNumName = "img_25_01";
    if quality == 2 then
        fontColor = "843410";
        bgName = "img_23_02";
        iBgName = "img_24_02";
        iNumName = "img_25_02";
    elseif quality == 3 then
        fontColor = "4d336a";
        bgName = "img_23_03";
        iBgName = "img_24_03";
        iNumName = "img_25_03";
    end
    local pathStr = "UIs/CumulativeSpending/%s.png";
    for i = 1, 2 do
        CSAPI.LoadImg(this["iconObj" .. i], string.format(pathStr, iBgName), true, nil, true);
        CSAPI.LoadImg(this["numObj" .. i], string.format(pathStr, iNumName), true, nil, true);
    end
    CSAPI.LoadImg(gameObject, string.format(pathStr, bgName), true, nil, true);
    CSAPI.SetTextColorByCode(txt_price, fontColor);
    CSAPI.SetTextColorByCode(txt_free, fontColor);
    CSAPI.SetTextColorByCode(txtName, fontColor);
end

function OnClickGoods()
    ShowGoodsInfo(1)
end

function OnClickGoods2()
    ShowGoodsInfo(2)
end

function ShowGoodsInfo(idx)
    if commodity then
        local isLook = false;
        local isLock, lockDesc = elseData.activityData:GetLockState(commodity:GetID());
        if canBuy and commodity:IsOver() ~= true and not isLock then
            SendBuy();
            do
                return
            end
        end
        local goods = commodity:GetCommodityList();
        if idx <= #goods then
            local good = goods ~= nil and goods[idx] or nil;
            local g = BagMgr:GetFakeData(good.cid)
            CSAPI.OpenView("GoodsFullInfo", {
                data = g
            }, 1);
        end
    end
end
