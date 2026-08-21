-- Desc: 氪金商店
---@class Player
local Player = require "Player"

--系统重置时间
local DailyResetTime = Config.GetConfigInfo("DailyResetTime") * 3600


--登录时检测氪金商店数据
function Player:loginCheckKJShopData()
    local shopData = self:getKJShopData()
    if not shopData then
        return
    end

    local nowTime = DLuaUtil.GetGreenwichTime()

    --检测是否有新增的氪金商品
    local allCfg = Config.GetAllConfig("GiftTable")
    for goodsId, cfg in pairs(allCfg) do
        --不在有效期内
        if (cfg.TimeoutStart ~= 0 and cfg.TimeoutStart > nowTime)
            or (cfg.timeout ~= 0 and cfg.timeout < nowTime) then
            goto continue
        end

        --不是充值商品
        if cfg.Cost_type ~= GE.ShopCostType.recharge then
            goto continue
        end

        --已加入商店
        if shopData[goodsId] then
            goto continue
        end

        shopData[goodsId] = self:initKJGoodsInfo(cfg)

        ::continue::
    end
end

--获得氪金商店数据
---@return table<integer, GoodsInfo>
function Player:getKJShopData()
	return self.premiumShopMap
end

--获得氪金商品数据
---@param goodsId integer
---@return GoodsInfo?
function Player:getKJGoodsInfo(goodsId)
    local shopInfo = self:getKJShopData()
    return shopInfo[goodsId]
end

--每日检测氪金商品限购数据
function Player:dailyCheckKJShopData()
    local shopInfo = self:getKJShopData()
    if not shopInfo then
        return
    end

    local nowTime = DLuaUtil.GetGreenwichTime()

    for goodsId, info in pairs(shopInfo) do
		local goodsCfg = Config.GetGiftInfo(goodsId)
		if not goodsCfg then
			LuaLogger.es("goodsCfg is nil", goodsId, type(goodsId))
			goto continue
		end

        --检测商品时间
        if info.nextRefreshTime > 0 and info.nextRefreshTime <= nowTime then
            --获得下次刷新时间
            info.nextRefreshTime = self:getNextRefreshTimeByType(goodsCfg.LimitType, nowTime)
            info.buyTimes = 0
        end

        ::continue::
	end
end

--判断商品是否能买
---@param goodsId integer
---@return ActionFailReason
function Player:checkKJGoodsBuy(goodsId)
	local goodsCfg = Config.GetGiftInfo(goodsId)
	if not goodsCfg then
		return ActionFailReason.CfgNotFind
	end

    local shopInfo = self:getKJGoodsInfo(goodsId)
    if not shopInfo then
        return ActionFailReason.ShopGoodsNoFind
    end

    local nowTime = DLuaUtil.GetGreenwichTime()

	--不在有效期内
    if (goodsCfg.TimeoutStart ~= 0 and goodsCfg.TimeoutStart > nowTime)
        or (goodsCfg.timeout ~= 0 and goodsCfg.timeout < nowTime) then
            return ActionFailReason.ShopGoodsDated
    end

    --限购商品检测
	if goodsCfg.LimitType ~= 0 then
		if shopInfo.buyTimes >= goodsCfg.Limit then
			return ActionFailReason.ShopGoodsBuyMax
		end

		--有限购商品尚未完成，请稍后再试。
		if self:BeBuyingGoods(goodsId) then
			return ActionFailReason.HavePayOrderNotDone
		end

	end

    --商品购买条件检测
	if goodsCfg.UnlockCondition and goodsCfg.UnlockCondition[2] > self.level then
		return ActionFailReason.PayValidateFailed_CheckError
	end

	--未满18岁购买限制
    local cost = GF.getPayDiscountChannel(self.channel, goodsCfg)
    local ret = self:checkUnder18AgeRecharge(cost)
    if ret ~= ActionFailReason.None then
        return ret
    end

	return ActionFailReason.None
end

--购买成功修改商品数据
---@param goodsId integer
---@param times integer
---@param proto UserInfo 玩家信息差量更新结构
function Player:setKJGoodsBuyTimes(goodsId, times, proto)
    local shopInfo = self:getKJGoodsInfo(goodsId)
    if shopInfo == nil then
        shopInfo = {
            id = goodsId,
            times = 0,
            shopTab = 0,
            nextRefreshTime = 0
        }
        self.premiumShopMap[goodsId] = shopInfo
    end
    shopInfo.buyTimes = shopInfo.buyTimes + times
    if proto then
        if not proto.premiumShopMap then
            proto.premiumShopMap = {}
        end
        proto.premiumShopMap[goodsId] = shopInfo
    end
    -- self:missionTrigger(GE.MissionFinishType.BuyGift, {id, times}, proto)
end

--初始化单个KJ商品数据
---@param cfg table 商品配置表
---@return GoodsInfo
function Player:initKJGoodsInfo(cfg)
    local info = {
        id = cfg.id,
        buyTimes = 0,
        nextRefreshTime = self:getNextRefreshTimeByType(cfg.LimitType),
    }

    return info
end


function Player:GetRechargeItemList()

	---@type GiftTable[]
	local goodsTab = {}
	---@type GiftTable[]
	local cfgs = Config.GetAllConfig("GiftTable")
	for k, v in pairs(cfgs) do
        if v.Tab ~= 1 then
            goto continue
        end
		if not self:CheckRechargeItemOpen(v.id) then			
			goto continue
		end
		table.insert(goodsTab, v)
		::continue::
	end

	table.sort(goodsTab, function(a, b)
		if a.index ~= b.index then
			return a.index < b.index
		end
		return a.id > b.id
	end)
	return goodsTab

end


---检测该切页是否解锁 ✔
---@param shopType integer
---@return boolean
function Player:CheckRechargeItemOpen(giftId)
	local cfg = Config.GetGiftInfo(giftId)
	if cfg == nil then
		return false
	end

	--检测此商店是否开启
	local nowTime = Me:GetServerTime()
	if (cfg.TimeoutStart ~= 0 and cfg.TimeoutStart > nowTime)
		or (cfg.timeout ~= 0 and cfg.timeout < nowTime) then
		return false
	end

	--检测玩家是否开启此商店
	if cfg.UnlockCondition ~= nil then
		local isOpen = Player:canOpenFunctionByCfg(cfg.UnlockCondition)
		if not isOpen then
			return false
		end
	end
	return true
end

---@return GoodsInfo
function Player:GetRechargeItemInfo(giftId)
	if self.premiumShopMap == nil then
        return nil
    end
    return self.premiumShopMap[giftId]
end

return Player