-- 随机商品数据
local this = {}

function this.New()
    this.__index = this.__index or this;
    local tab = {};
    setmetatable(tab, this);
    return tab
end

function this:SetData(data, sortIdx)
    if data then
        self.data = data;
        self:SetCfg(data.reward_id, data.id, data.index);
        self.goods = nil; -- 当前商品的具体配置信息
        self.sortIdx = sortIdx;
        if data.type == RandRewardType.ITEM or data.type == RandRewardType.CARD then -- 道具
            self.goods = GoodsData();
            self.goods:InitCfg(data.id);
        elseif data.type == RandRewardType.EQUIP then -- 商品 
            self.goods = EquipData();
            self.goods:InitCfg(data.id);
        end
    end
end

function this:SetCfg(rewardId, itemId, itemIndex)
    local rewardCfg = Cfgs.RewardInfo:GetByID(rewardId);
    self.cfg = nil;
    if rewardCfg then
        self.icon = rewardCfg.icon;
        self.quality = rewardCfg.quality;
        if rewardCfg.item then
            for k, v in ipairs(rewardCfg.item) do
                if v.id == itemId and k == itemIndex then
                    self.cfg = v;
                    break
                end
            end
        end
    end
end

function this:GetData()
    return self.data;
end

function this:GetCfg()
    return self.cfg;
end

function this:SetShopID(shopID)
    self.shopID = shopID;
end

function this:GetShopID()
    return self.shopID or 0;
end

function this:SetPoolID(poolId)
    self.poolID=poolId;
end

function this:GetPoolID()
    return self.poolID or nil;
end

function this:GetID()
    return self.data and self.data.id or nil;
end

function this:GetTabID()
    return nil;
end

function this:GetRewardID()
    return self.data and self.data.reward_id or nil;
end

-- 配置表数据列index
function this:GetIndex()
    return self.data and self.data.index or nil;
end

function this:GetSort()
    return self.sortIdx or 0;
end

-- function this:GetTIcon()
--     return nil;
-- end

-- 兑换下标
function this:SetExchangeIndex(index)
    self.exchangeIndex = index;
end

function this:GetExchangeIndex()
    return self.exchangeIndex or 1;
end

function this:GetIcon()
    return self.goods and self.goods:GetIcon() or nil;
end

function this:GetQuality()
    return self.goods and self.goods:GetQuality() or nil;
end

-- 返回获得物品的数据
function this:GetCommodityList()
    local info = {};
    if self.data then
        info = {{
            data = self.goods,
            cid = self:GetID(),
            num = self.cfg.count,
            type = self.data.type
        }}
    end
    return info;
end

-- 返回可兑换次数
function this:GetNum()
    local num = 0;
    if self.data.buyLimit == nil then -- 不限购
        num = -1; -- 不限制兑换次数
    elseif self.data.had_get and (self.data.buyLimit - self.data.had_get > 0) then
        num = self.data.buyLimit - self.data.had_get;
    elseif self.data.had_get == nil and self.data then
        num = self.data.buyLimit;
    end
    return num;
end

-- 是否售完
function this:IsOver()
    local isOver = false;
    if self:GetNum() ~= -1 and self:GetNum() <= 0 then
        isOver = true;
    end
    if self.goods and isOver ~= true then
        if self.goods:GetType() == ITEM_TYPE.THEME then
            local dyVal1 = self.goods:GetDyVal1();
            isOver = ShopCommFunc.GetThemeInfo(dyVal1) ~= nil;
        elseif self.goods:GetType() == ITEM_TYPE.FORNITURE then -- 判断是否超过持有数，超过持有数不能购买
            local dyVal1 = self.goods:GetDyVal1();
            local cfg = Cfgs.CfgFurniture:GetByID(dyVal1);
            local buyCount = DormMgr:GetBuyCount(dyVal1);
            isOver = buyCount >= cfg.buyNumLimit;
        end
    end
    return isOver;
end

function this:GetPrice()
    local priceInfo = nil;
    if self.cfg and self.cfg.price and self.data then
        priceInfo = {{
            id = self.cfg.price[1],
            num = self.cfg.price[2]
        }};
    end
    return priceInfo;
end

function this:GetNowDiscount()
    return self.data and self.data.dis or 0;
end

function this:GetNowDiscountTips()
    local code = CSAPI.RegionalCode();
    local discount = self:GetNowDiscount();
    if discount == 1 then
        return nil;
    end
    -- if code~=1 and code~=2 then
    local dis = math.floor((1 - discount) * 100 + 0.5);
    return string.format(LanguageMgr:GetByID(18122), dis);
    -- else
    --     local dis=math.floor(discount*10+0.5);
    --     return string.format(LanguageMgr:GetByID(18074),dis);
    -- end
end

function this:GetDesc()
    return self.cfg and self.cfg.desc or nil;
end

-- 返回购买商品所获得的道具数量
-- function this:GetGoodsNum()
--     return self.data and self.data.num or 0;
-- end

function this:GetName()
    return self.cfg and self.cfg.productName or "";
    -- return self.goods and self.goods:GetName() or nil;
end

function this:GetRealPrice()
    local priceInfo = nil;
    if self.goods and self.goods:GetType() == ITEM_TYPE.THEME then
        local dyVal1 = self.goods:GetDyVal1();
        local cfg = Cfgs.CfgFurniture:GetByID(dyVal1);
        local price1, price2 = DormMgr:GetThemePrices(dyVal1);
        if cfg.price_1 then
            priceInfo=priceInfo or {}
            table.insert(priceInfo, {
                id = cfg.price_1[1][1],
                num = price1
            });
        end
        if cfg.price_2 then
            priceInfo=priceInfo or {}
            table.insert(priceInfo, {
                id = cfg.price_2[1][1],
                num = price2
            });
        end
    elseif self.data then
        priceInfo = {{
            id = self.data.price[1],
            num = self.data.price[2]
        }};
    end
    return priceInfo;
end

function this:GetClassType()
    return "RandCommodityData"
end

-- 返回商品限购描述
function this:GetLimitDesc()
    local str = "";
    local num = self:GetNum();
    if num > 0 then
        str = tostring( num);
    end
    return str;
end

function this:GetType()
    return self.data and self.data.type or 1;
end

function this:IsPackage()
    return false;
end

function this:GetOnecBuyLimit()
    return self:GetNum();
end

function this:IsLimitTime()
    return false
end

function this:GetResetTips()
    local str = ""
    local str1, str2 = "", "";
    if self:GetNum() >= 0 then
        str1 = LanguageMgr:GetByID(18024);
        str2 = tostring(self:GetNum());
        str = str1 .. str2
    end
    return str, str1, str2
end

function this:IsShow()
    return true;
end

function this:GetEndBuyTime()
    return 0;
end

function this:GetEndBuyTips()
    return nil;
end

function this:GetShowLimitRet()
    return true
end

-- 返回解锁描述
function this:GetBuyLimitDesc()
    local str = ""
    return str;
end

-- 返回是否满足购买条件 前置购买条件&购买限制都要满足才能购买
function this:GetBuyLimit()
    return true
end

-- 返回后台商店ID
function this:GetChargeID()
    -- local chargeCfg=Cfgs.CfgRecharge:GetByID(self:GetID());
    -- if chargeCfg then
    --     return chargeCfg.iosID;
    -- end
    return nil;
end

function this:CanUseVoucher()
    return false;
end

function this:GetUseVoucherTypes()
    return nil
end

function this:HasOtherPrice(shopPriceKey)
    return false
end

function this:GetBundlingType()
    return nil
end

function this:GetBundlingID()
    return nil
end

function this:GetBuySum()
    if self.data and self.data.had_get then
        return self.data.had_get
    end
    return 0;
end

function this:GetOrgCosts()
    return nil
end

function this:GetOrgEndBuyTips()
    return nil
end

function this:GetOrgCostsByCostKey(key)
    return nil;
end

-- 返回现金价格符号
function this:GetCurrencySymbols(isFixed)
    local str = LanguageMgr:GetByID(18013);
    if (CSAPI.IsADV()) and isFixed ~= true then
        str = self:GetCfg().displayCurrency or str;
    end
    return str;
end
---中台SDK价格显示
---如果有SDK数据，优先显示
---如果没有SDK数据，就显示配置表真实价格
function this:GetSDKdisplayPrice()
    if CSAPI.IsADV() then
        if (self:GetCfg().displayPrice ~= nil) then
            local displayPrice = self:GetCfg().displayPrice;
            return tostring(displayPrice);
        end
    end
    return nil;
end
----封装方法
---Price 传入原有需要显示的价格通常是定价表价格
function this:UIShowdisplayPrice(Price)
    return self:GetSDKdisplayPrice() and self:GetSDKdisplayPrice() or Price;
end
function this:GetSubType()
    return nil;
end

function this:SetGrid1()
end

function this:SetGrid2()
end

function this:IsShowTag()
    local isShow=true;
    if self:IsOver() then
        isShow=false;
    end
    return isShow;
end

-- 返回标签信息
function this:GetTagsData()
    local list = {};
    if self:IsLimitTime() then -- 剩余时间
        local t=5;
        table.insert(list, {
            type=t,
            img = ShopCommFunc.TagsImgName[t],
            color=ShopCommFunc.TagsColor[t],
            color2=ShopCommFunc.TagsColor2[t],
            icon=ShopCommFunc.TagsIconName[t],
            icon2=ShopCommFunc.TagsIconName2[t],
            tips = self:GetEndBuyTips(),
        });
    end
    local discountTips = self:GetNowDiscountTips();
    if discountTips ~= nil then -- 折扣
        local t=6
        table.insert(list, {
            type=t,
            img = ShopCommFunc.TagsImgName[t],
            color=ShopCommFunc.TagsColor[t],
            icon=ShopCommFunc.TagsIconName[t],
            color2=ShopCommFunc.TagsColor2[t],
            icon2=ShopCommFunc.TagsIconName2[t],
            tips =discountTips
        });
    end
    table.sort(list, function(a, b)
        return ShopCommFunc.TagsSort[a.type] < ShopCommFunc.TagsSort[b.type];
    end);
    return list;
end

return this;
