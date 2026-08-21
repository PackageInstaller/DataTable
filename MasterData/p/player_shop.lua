-- Desc: 商店
---@class Player
local Player = require "Player"
local GameGlobal, DataLogMgr
if GV.IsServer then
    GameGlobal = require "GameGlobal"
	DataLogMgr = require "DataLogMgr"
end


--系统重置时间
local DailyResetTime = Config.GetConfigInfo("DailyResetTime") * 3600
--普通商店数据

---@return GeneralShopData
function Player:getShopGeneralData()
	return self.generalShopData
end

--获得商店刷新数据
---@return table?
function Player:getShopRefreshData()
	local shopData = self:getShopGeneralData()
	if not shopData.shopRefreshMap then
		shopData.shopRefreshMap = {}
	end
	return shopData.shopRefreshMap
end

--获得普通商品数据
---@return table?
function Player:getGeneralGoodsMap()
	local shopData = self:getShopGeneralData()
	if not shopData.generalGoodsMap then
		shopData.generalGoodsMap = {}
	end
	return shopData.generalGoodsMap
end

--获得指定普通商店数据
---@param shopTab integer 商店页签
---@return ShopInfo?
function Player:getShopGeneralInfo(shopTab)
	local shopData = self:getShopRefreshData()
	return shopData[shopTab]
end

--获得指定普通商品信息
---@param goodsId integer 商品ID
---@return GoodsInfo?
function Player:getGeneralGoodsInfo(goodsId)
	local goodsMap = self:getGeneralGoodsMap()
	return goodsMap[goodsId]
end

--增加普通商品信息
---@param info GoodsInfo 商品信息
function Player:addGeneralGoodsInfo(info, proto)
	local goodsMap = self:getGeneralGoodsMap()
	goodsMap[info.id] = info
end

--proto商店更新
---@param shopTab integer 商店页签
---@param proto UserInfo 玩家信息差量更新结构
function Player:protoUpdateGeneralShopData(shopTab, proto)
	if not proto then
		return
	end

	if not proto.generalShopData then
		proto.generalShopData = {}
	end
	if not proto.generalShopData.shopRefreshMap then
		proto.generalShopData.shopRefreshMap = {}
	end

	local shopData = self:getShopGeneralInfo(shopTab)
	proto.generalShopData.shopRefreshMap[shopTab] = shopData or {}
end

--proto商品更新
---@param goodsId integer 商品ID
---@param proto UserInfo 玩家信息差量更新结构
function Player:protoUpdateGeneralGoodsData(goodsId, proto)
	if not proto then
		return
	end

	if not proto.generalShopData then
		proto.generalShopData = {}
	end
	if not proto.generalShopData.generalGoodsMap then
		proto.generalShopData.generalGoodsMap = {}
	end

	local goodsInfo = self:getGeneralGoodsInfo(goodsId)
	proto.generalShopData.generalGoodsMap[goodsId] = goodsInfo or {}
end

--登录时检测普通商店
function Player:checkGeneralShopData(proto)
	local curTime = DLuaUtil.GetGreenwichTime()
	--检测是否有普通商店配置变化
	self:checkGeneralShopConfigChange(curTime, proto)

	--检测是否有常驻商品配置变化
	self:checkPermanentGoodsConfigChange(curTime, proto)

	--检测商店刷新时间
	self:checkShopRefreshTime(curTime, proto)

	--检测商品刷新时间
	self:checkGeneralGoodsRefreshTime(curTime, proto)
end

--清空普通商店数据
---@param shopTab integer 商店页签
---@param proto UserInfo 玩家信息差量更新结构
function Player:clearGeneralShopData(shopTab, proto)
	local goodsList = {}
	local goodsMap = self:getGeneralGoodsMap()
	for k, info in pairs(goodsMap) do
		if info.shopTab == shopTab then
			goodsList[k] = k
		end
	end
	for k, _ in pairs(goodsList) do
		goodsMap[k] = nil
		--proto商品更新
		self:protoUpdateGeneralGoodsData(k, proto)
	end
end

--检测是否有普通商店配置变化
---@param curTime number
---@param proto UserInfo
function Player:checkGeneralShopConfigChange(curTime, proto)
	local shopData = self:getShopRefreshData()
	local allConfig = Config.GetAllConfig("ShopListTable")
	for shopTab, shopCfg in pairs(allConfig) do
		--检测此商店是否开启
		if not shopData[shopTab] and ((shopCfg.shopOpen == 0 or shopCfg.shopOpen < curTime) and (shopCfg.shopClose == 0 or shopCfg.shopClose > curTime)) then
			--初始化商店
			shopData[shopTab] = {
				refreshNum = 0,
				nextRefreshTime = 0
			}
			local ret = self:refreshShopData(shopTab, proto)
			if ret ~= ActionFailReason.None then
				LuaLogger.es("refreshShopData failed", ret, shopTab)
			end
		--检测此商店是否关闭
		elseif shopData[shopTab] and ((shopCfg.shopOpen ~= 0 and shopCfg.shopOpen > curTime) or (shopCfg.shopClose ~= 0 and shopCfg.shopClose < curTime)) then
			shopData[shopTab] = nil
			--proto商店更新
			self:protoUpdateGeneralShopData(shopTab, proto)
		end
	end
end

--检测是否有常驻商品配置变化
---@param curTime number
---@param proto UserInfo
function Player:checkPermanentGoodsConfigChange(curTime, proto)
	local goodsMap = self:getGeneralGoodsMap()
	local allGoodsConfig = Config.GetAllConfig("ShopMerchandiseTable")
	for goodsId, goodsCfg in pairs(allGoodsConfig) do
		local shopCfg = Config.GetShopListInfo(goodsCfg.shop)
		--商品不在身上&&对应商店是常驻商店
		if not goodsMap[goodsId] and shopCfg and shopCfg.shopRefreshType == 0 then
			local info = self:initGeneralGoodsInfo(goodsId, goodsCfg.shop)
			self:addGeneralGoodsInfo(info)
			--proto商品更新
			self:protoUpdateGeneralGoodsData(goodsId, proto)
		end
	end
end

--检测商店刷新时间
---@param curTime number
---@param proto UserInfo
function Player:checkShopRefreshTime(curTime, proto)
	local shopData = self:getShopRefreshData()
	for shopTab, shopInfo in pairs(shopData) do
		if shopInfo.nextRefreshTime > 0 and shopInfo.nextRefreshTime <= curTime then
			--刷新商店数据
			local ret = self:refreshShopData(shopTab, proto)
			shopInfo.refreshNum = 0
			if ret ~= ActionFailReason.None then
				LuaLogger.es("refreshShopData failed", ret, shopTab)
			end
		end
	end
end

--检测商品刷新时间
---@param curTime number
---@param proto UserInfo
function Player:checkGeneralGoodsRefreshTime(curTime, proto)
	local goodsMap = self:getGeneralGoodsMap()
	for goodsId, goodsInfo in pairs(goodsMap) do
		local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
		if goodsCfg then
			if goodsInfo.nextRefreshTime > 0 and goodsInfo.nextRefreshTime <= curTime then
				--重置商品购买次数
				goodsInfo.buyTimes = 0
				--更新下次刷新时间
				goodsInfo.nextRefreshTime = self:getNextRefreshTimeByType(goodsCfg.limitType, curTime)
				--proto商品更新
				self:protoUpdateGeneralGoodsData(goodsId, proto)
			end
		else
			LuaLogger.es("goodsCfg is nil", goodsId, type(goodsId))
		end
	end
end

--刷新商店数据
---@param shopTab integer 商店页签
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason
function Player:refreshShopData(shopTab, proto)
	--获得商店配置数据
	local shopCfg = Config.GetShopListInfo(shopTab)
	if not shopCfg then
		return ActionFailReason.CfgNotFind
	end

	--获得商店数据
	local shopInfo = self:getShopGeneralInfo(shopTab)
	if not shopInfo then
		return ActionFailReason.ShopNoFind
	end

	--清空对应商店的商品数据
	self:clearGeneralShopData(shopTab, proto)

	--整店全要
	if shopCfg.shopGroupcontrolType == GE.ShopGroupControlType.All then
		local allGoodsList = Config.GetShopMerchandiseByShopId(shopTab) or {}
		for _, goodsCfg in pairs(allGoodsList) do
			local info = self:initGeneralGoodsInfo(goodsCfg.id, shopTab)
			self:addGeneralGoodsInfo(info)
			--proto商品更新
			self:protoUpdateGeneralGoodsData(info.id, proto)
		end

	--组内随机
	elseif shopCfg.shopGroupcontrolType == GE.ShopGroupControlType.Random then
		--根据组id获得互斥组商品
		--每组多少个，按权重获得商品
		for _, randomCfg in pairs(shopCfg.merchandiseGroup) do
			local groupId = randomCfg[1]
			local groupCount = randomCfg[2]
			--组内随机获得商品
			local randomGoodsList = self:groupRandomGoodsList(groupId, groupCount)
			for _, goodsId in pairs(randomGoodsList) do
				local info = self:initGeneralGoodsInfo(goodsId, shopTab)
				self:addGeneralGoodsInfo(info)
				--proto商品更新
				self:protoUpdateGeneralGoodsData(info.id, proto)
			end
		end
	elseif shopCfg.shopGroupcontrolType == GE.ShopGroupControlType.None then
		--不做处理
		return ActionFailReason.None
	else
		return ActionFailReason.FailedEnum
	end

	--更新商店下次刷新时间
	shopInfo.nextRefreshTime = self:getNextRefreshTimeByType(shopCfg.shopRefreshType)

	--proto商店更新
	self:protoUpdateGeneralShopData(shopTab, proto)
	return ActionFailReason.None
end

--组内随机获得商品
---@param groupId integer 组ID
---@param groupCount integer 组内商品数量
---@return table?
function Player:groupRandomGoodsList(groupId, groupCount)
	local goodsList = Config.GetShopMerchandiseByGroupId(groupId)
	if not goodsList then
		return nil
	end

	--克隆商品列表，避免修改原始数据
	local tempList = clone(goodsList)

	---移除掉未解锁的商品
    for i = #tempList, 1, -1 do
        local goodsCfg = tempList[i]
		--检测玩家是否开启此商店
		if goodsCfg.limitCondition ~= nil then
			local isOpen = self:canOpenFunctionByCfg(goodsCfg.limitCondition)
			if not isOpen then
				table.remove(tempList, i)
			end
		end
    end

	local listLen = #tempList
	-- 确保不超出最大数量
	groupCount = math.min(groupCount, listLen)
	local newGoodsList = {}

	-- 计算权重
	local totalWeight = 0
	for i = 1, listLen do
		totalWeight = totalWeight + tempList[i].weight
	end
	for _ = 1, groupCount do
		if totalWeight <= 0 then
			break
		end
		--- 随机获得商品
		local randomNum = math.random(1, totalWeight)
		local curWeight = 0
		for index = 1, listLen do
			local goodsCfg = tempList[index]
			curWeight = curWeight + goodsCfg.weight
			if randomNum <= curWeight then
				-- 将选中的商品添加到新列表中
				table.insert(newGoodsList, goodsCfg.id)
				-- 与末尾交换并缩短长度，O(1) 移除，避免 table.remove 的 O(n) 开销
				tempList[index] = tempList[listLen]
				tempList[listLen] = nil
				listLen = listLen - 1
				totalWeight = totalWeight - goodsCfg.weight
				break
			end
		end
	end

	return newGoodsList
end

--购买商品
---@param goodsId integer 商品ID
---@param buyNum integer 购买数量
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason
---@return table?
function Player:shopBuy(goodsId, buyNum, proto)
	--入参检测
	if not goodsId or not buyNum or buyNum <= 0 then
		return ActionFailReason.ParameterInvalid
	end

	--获得商品信息
	local goodsInfo = self:getGeneralGoodsInfo(goodsId)
	if not goodsInfo then
		return ActionFailReason.ShopGoodsNoFind
	end

	--获得商品配置
	local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
	if not goodsCfg then
		return ActionFailReason.CfgNotFind
	end

	--获得商店配置数据
	local shopCfg = Config.GetShopListInfo(goodsInfo.shopTab)
	if not shopCfg then
		return ActionFailReason.CfgNotFind
	end

	--检测商店开放时间
	local nowTime = DLuaUtil.GetGreenwichTime()
	if (shopCfg.shopOpen ~= 0 and shopCfg.shopOpen > nowTime)
		or (shopCfg.shopClose ~= 0 and shopCfg.shopClose < nowTime) then
		return ActionFailReason.ShopNoOpen
	end

	--检测商品开放时间
	if (goodsCfg.merchandiseOpen ~= 0 and goodsCfg.merchandiseOpen > nowTime)
		or (goodsCfg.merchandiseClose ~= 0 and goodsCfg.merchandiseClose < nowTime) then
		return ActionFailReason.ShopNoOpen
	end

	--检测玩家是否开启此商店
	local shopOpenState  = self:getFunctionOpenStateById(shopCfg.shopopenconditionType)
	if shopOpenState and shopOpenState == GE.FunctionOpenState.Lock then
		return ActionFailReason.ShopNoOpen
	end

	--检测玩家是否开启此商品
	local isOpen = self:canOpenFunctionByCfg(goodsCfg.limitCondition)
	if not isOpen then
		return ActionFailReason.ShopNoOpen
	end

	--检测商品购买次数
	if goodsCfg.limitType ~= GE.ShopLimitType.None and goodsCfg.buylimit ~= 0 then
		if goodsInfo.buyTimes + buyNum > goodsCfg.buylimit then
			return ActionFailReason.ShopGoodsBuyMax
		end
	end

	--检测消耗资源
	local price = goodsCfg.discount	--折扣价
	local itemId = price[2]
	if price[1] == GE.RewardType.ItemProp then
		local itemConfig = Config.GetItemInfo(itemId)
		if not itemConfig then
			return ActionFailReason.CfgNotFind
		end
		local itemCount = self:getItemCountById(itemId)
		if itemConfig.replaceItem ~= 0 then--抵扣道具
			local replaceItemcount = self:getItemCountById(itemConfig.replaceItem)
			itemCount = itemCount + replaceItemcount
		end
		if itemCount < price[3] * buyNum then
			return ActionFailReason.ItemNoEnough
		end
	else
		--todo 其他类型消耗检测
		return ActionFailReason.FailedEnum
	end

	--购买成功
	--扣除资源
	local ret = self:useItem(price[2], price[3] * buyNum, proto, GE.EventItemType.BuyGoods, goodsId)
	if ret ~= ActionFailReason.None then
		return ret
	end

	--奖励发放

	---@type integer[][]
	local allContent = {}
	for i = 1, buyNum do
		for j = 1, #goodsCfg.content do
			local addItem = goodsCfg.content[j]
			local f = tablex.findSingle(allContent, function(t)
				if t[1] == addItem[1] and t[2] == addItem[2] then
					return true
				end
				return false
			end)
			if f then
				f[3] = f[3] + addItem[3]
			else
				f = tablex.clone(addItem, true)
				table.insert(allContent, f)
			end
		end
	end

	local rewardList = self:addRewardList(allContent, proto, GE.EventItemType.BuyGoods, goodsId)

	--增加商品购买次数
	goodsInfo.buyTimes = goodsInfo.buyTimes + buyNum

	--proto商品更新
	self:protoUpdateGeneralGoodsData(goodsId, proto)

	--触发任务：在指定商店类型购买商品次数
	self:missionTrigger(GE.MissionFinishType.BuyItemCountByShopType, {shopType = goodsInfo.shopTab}, proto)

	--记录日志
	if DataLogMgr then
		DataLogMgr.LogShopSail({
			shopId = goodsInfo.shopTab,
			goodsId = goodsId,
			buyNum = buyNum,
			salePrice = price[3],
			resourceType = price[2],
		}, self)
	end

	return ActionFailReason.None, rewardList
end

--商店刷新
---@param shopTab integer 商店页签
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason
function Player:shopRefresh(shopTab, proto)
	--获得商店配置数据
	local shopCfg = Config.GetShopListInfo(shopTab)
	if not shopCfg then
		return ActionFailReason.CfgNotFind
	end

	--是否可以手动刷新
	if shopCfg.isManualRefresh ~= 1 then
		return ActionFailReason.ShopNoRefresh
	end

	--检测商店时间
	local nowTime = DLuaUtil.GetGreenwichTime()
	if (shopCfg.shopOpen ~= 0 and shopCfg.shopOpen > nowTime)
		or (shopCfg.shopClose ~= 0 and shopCfg.shopClose < nowTime) then
		return ActionFailReason.ShopNoOpen
	end

	--检测玩家是否开启此商店
	local shopOpenState  = self:getFunctionOpenStateById(shopCfg.shopopenconditionType)
	if shopOpenState and shopOpenState == GE.FunctionOpenState.Lock then
		return ActionFailReason.ShopNoOpen
	end

	--获得商店数据
	local shopInfo = self:getShopGeneralInfo(shopTab)
	if not shopInfo then
		return ActionFailReason.ShopNoFind
	end

	--检测刷新次数
	if shopInfo.refreshNum >= shopCfg.manualRefreshLimit then
		return ActionFailReason.ShopRefreshMax
	end

	--检测消耗资源
	local index = math.min(shopInfo.refreshNum + 1, #shopCfg.manualRefresh)
	local price = shopCfg.manualRefresh[index]
	if price[1] == GE.RewardType.ItemProp then
		local itemInfo = self:getItemById(price[2])
		if not itemInfo or itemInfo.num < price[3] then
			return ActionFailReason.ItemNoEnough
		end
	else
		--todo 其他类型消耗检测
		return ActionFailReason.FailedEnum
	end

	--刷新商店数据
	local ret = self:refreshShopData(shopTab, proto)
	if ret ~= ActionFailReason.None then
		return ret
	end

	shopInfo.refreshNum = shopInfo.refreshNum + 1

	self:missionTrigger(GE.MissionFinishType.RefreshShop, {shopId = shopCfg.id, count = 1}, proto)

	--扣除资源
	ret = self:useItem(price[2], price[3], proto, GE.EventItemType.RefreshShop, shopTab)
	if ret ~= ActionFailReason.None then
		return ret
	end

	--proto商店更新
	self:protoUpdateGeneralShopData(shopTab, proto)

	return ActionFailReason.None
end

--普通商品初始化
---@param goodsId integer 商品ID
---@param shopTab integer 商店页签
---@return GoodsInfo
function Player:initGeneralGoodsInfo(goodsId, shopTab)
	local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
	local goodsInfo = {
		id = goodsId,
		buyTimes = 0,
		shopTab = shopTab,
		nextRefreshTime = self:getNextRefreshTimeByType(goodsCfg.limitType),
	}
	return goodsInfo
end

--根据商店/商品的刷新类型获得下次刷新时间
---@param refreshType integer 刷新类型 GE.ShopRefreshType
---@param nowTime? integer 当前时间
---@return integer 下次刷新时间
function Player:getNextRefreshTimeByType(refreshType, nowTime)
	local nextRefreshTime = 0
	nowTime = nowTime or DLuaUtil.GetGreenwichTime()
	--每日
	if refreshType == GE.ShopLimitType.Daily then
		nextRefreshTime = self.nextResetTime
	---每周
	elseif refreshType == GE.ShopLimitType.Weekly then
		nextRefreshTime = DLuaUtil.GetNextWeekTime(nowTime, DailyResetTime)
	---每月
	elseif refreshType == GE.ShopLimitType.Monthly then
		nextRefreshTime = DLuaUtil.GetNextMonthTime(nowTime, DailyResetTime)
	--其他
	else
		-- nextRefreshTime = refreshType
	end
	return nextRefreshTime
end

--------------------------------------------------------------------------------
--client
-------------------------------------------------------------------------
---

---更新服务器数据
---@param v GeneralShopData
function Player:updateGeneralShopData(v)
	if v.shopRefreshMap ~= nil then
		local refreshMap = self:getShopRefreshData()
		for key, value in pairs(v.shopRefreshMap) do
			if not next(value) then
				refreshMap[key] = nil
			else
				refreshMap[key] = value
			end
    	end
	end
	if v.generalGoodsMap ~= nil then
		local goodsMap = self:getGeneralGoodsMap()
		for key, value in pairs(v.generalGoodsMap) do
			if not next(value) or value == "nil" then
				goodsMap[key] = nil
			else
				goodsMap[key] = value
			end
		end
	end
end

---@param v table<integer, GoodsInfo>
function Player:updatePremiumShopMap(v)

	local goodsMap = self:getKJShopData()
	for key, value in pairs(v) do
		if not next(value) or value == "nil" then
			goodsMap[key] = nil
		else
			goodsMap[key] = value
		end
	end
end


---获得商品服务器数据 ✔
---@param goodsId integer
---@return GeneralGoodsInfo?
function Player:GetGoodsServerData(goodsId)
	if self:getShopGeneralData() == nil then
		return nil
	end
	local generalShopData = self:getShopGeneralData().generalGoodsMap
	if generalShopData == nil then
		return nil
	end
	---@type GeneralGoodsInfo
	return generalShopData[goodsId]
end



---获取商城菜单列表 Cliente
---@param shopGroup ShopGroupType
---@return number[]
function Player:GetShopMenuList(shopGroup)
	local menuList = {}
	local cfgs = Config.GetAllConfig("ShopListTable")
	for k, v in pairs(cfgs) do
		if v.shopType ~= shopGroup then
			goto continue
		end
		local shopMenuId = k
		if self:CheckShopMenuOpen(shopMenuId) then			
			table.insert(menuList, k)
		end
		::continue::
	end
	table.sort(menuList, function(a, b)
		local cfga = Config.GetShopListInfo(a)
		local cfgb = Config.GetShopListInfo(b)
		if cfga == nil then
			return false
		end
		if cfgb == nil then
			return false
		end
		if cfga.order ~= cfgb.order then
			return cfga.order < cfgb.order
		end
		return cfga.id < cfgb.order
	end)
	return menuList
end


---检测该切页是否解锁 Client
---@param shopType integer
---@return boolean
function Player:CheckShopMenuOpen(shopType)
	local cfg = Config.GetShopListInfo(shopType)
	if cfg == nil then
		return false
	end

	--检测此商店是否开启
	local nowTime = Me:GetServerTime()
	if (cfg.shopOpen ~= 0 and cfg.shopOpen > nowTime)
		or (cfg.shopClose ~= 0 and cfg.shopClose < nowTime) then
		return false
	end

	--检测玩家是否开启此商店
	if cfg.shopopenconditionType ~= nil and cfg.shopopenconditionType ~= 0 then
		local isOpen = self:getFunctionOpenStateById(cfg.shopopenconditionType)
		isOpen = isOpen ~= GE.FunctionOpenState.Lock
		if not isOpen then
			return false
		end
	end
	return true
end

---获取商城切页下商品id ✔
---@param shopType integer
---@return integer[]
function Player:GetShopItemList(shopType)

	local goodsTab = {}
	local shopCfg = Config.GetShopListInfo(shopType)
	if shopCfg == nil then
		return goodsTab
	end

	local goodsMap = self:getShopGeneralData().generalGoodsMap
	if goodsMap == nil then
		return goodsTab
	end

	for k, v in pairs(goodsMap) do
		if v.shopTab ~= shopType then
			goto continue
		end
		local id = v.id
		local isunlock = self:CheckGoodsTimeUnlock(id)
		if not isunlock then
			goto continue
		end
		table.insert(goodsTab,  id)
	    ::continue::
	end

	--排序
	table.sort(goodsTab, BindCallback_NoParams(self, self.SortGoods))
	return goodsTab
end


---商品排序
---@param a integer 商品id
---@param b integer 商品id
---@return boolean
function Player:SortGoods(a, b)

	local cfga = Config.GetShopMerchandiseInfo(a)
	local cfgb = Config.GetShopMerchandiseInfo(b)
	if cfga == nil then
		return false
	end
	if cfgb == nil then
		return true
	end

	--是否解锁
	local unlocka = self:CheckGoodsUnlock(a)
	local unlockb = self:CheckGoodsUnlock(b)
	if unlocka ~= unlockb then
		return unlocka
	end

	--第一优先级 是否售罄
	local isSellout_a = false
	local isSellout_b = false
	if cfga.buylimit ~= 0 then
		local curBuyCount, maxBuyCount, limitType = self:GetGoodLimitCount(a)
		isSellout_a = curBuyCount <= 0
	end

	if cfgb.buylimit ~= 0 then
		local curBuyCount, maxBuyCount, limitType = self:GetGoodLimitCount(b)
		isSellout_b = curBuyCount <= 0
	end
	if isSellout_a ~= isSellout_b then
		return isSellout_b
	end

	---是否拥有 未拥有的排序靠前
	local rType, rItemId = cfga.content[1][1], cfga.content[1][2]
	local isOwna = self:IsOwn(rType, rItemId)
	local rType, rItemId = cfgb.content[1][1], cfgb.content[1][2]
	local isOwnb = self:IsOwn(rType, rItemId)
	if isOwna ~= isOwnb then
		return isOwna
	end

	--商品排序顺序
	if cfga.sort ~= cfgb.sort then
		return cfga.sort > cfgb.sort
	end
	return cfga.id > cfgb.id
end


---判断道具是否拥有
---@param itemType GE.RewardType
---@param itemId integer
---@return boolean
function Player:IsOwn(itemType, itemId)
    if itemType == GE.RewardType.Character then--角色类型
        return self.heroList[itemId] ~= nil
    elseif itemType == GE.RewardType.Skin then--角色类型
        return self.skinList[itemId] == nil
    end
	return false
end



---检测商品是否解锁 Cient
---@param goodsId integer
---@return boolean
function Player:CheckGoodsUnlock(goodsId)
	local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
	if goodsCfg == nil then
		return false
	end
	--检测此商店是否开启
	local nowTime = Me:GetServerTime()
	if (goodsCfg.merchandiseOpen ~= 0 and goodsCfg.merchandiseOpen > nowTime)
		or (goodsCfg.merchandiseClose ~= 0 and goodsCfg.merchandiseClose < nowTime) then
		return false, 1
	end

	--检测玩家是否开启此商店
	if goodsCfg.limitCondition ~= nil then
		local isOpen = self:canOpenFunctionByCfg(goodsCfg.limitCondition)
		if not isOpen then
			return false, 2
		end
	end
	return true
end

---检测商品是否在销售期间 Client
---@param goodsId integer
---@return boolean
function Player:CheckGoodsTimeUnlock(goodsId)
	local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
	if goodsCfg == nil then
		return false
	end
	--检测此商店是否开启
	local nowTime = Me:GetServerTime()
	if (goodsCfg.merchandiseOpen ~= 0 and goodsCfg.merchandiseOpen > nowTime)
		or (goodsCfg.merchandiseClose ~= 0 and goodsCfg.merchandiseClose < nowTime) then
		return false
	end
	return true
end



---获得商品限购信息 ✔
---@param shopType integer
---@param goodsId integer 
---@return number 可购买数量, number 最大购买数量, GE.ShopLimitType 限购类型 
function Player:GetGoodLimitCount(goodsId)
	---@type ShopMerchandiseTable
	local goodCfg = Config.GetShopMerchandiseInfo(goodsId)
	if goodCfg == nil then
		return 0, 0, GE.ShopLimitType.None
	end

	local goodsData = self:GetGoodsServerData(goodsId)
	if goodsData == nil then
		return 0, 0, GE.ShopLimitType.None  
	end
	local curBuyMaxCount = goodCfg.buylimit
	if goodCfg.limitType ~= GE.ShopLimitType.None then
 		curBuyMaxCount = goodCfg.buylimit - goodsData.buyTimes
	end
	return curBuyMaxCount, goodCfg.buylimit, goodCfg.limitType
end

---获得物品价格 ✔
---@param goodsId integer
---@return number 道具id, number 道具数量, number 折扣率
function Player:GetShopItemPic(goodsId)
	local cfg = Config.GetShopMerchandiseInfo(goodsId)
	if cfg == nil then
		return 0, 0, 0
	end
	return cfg.discount[2], cfg.discount[3], cfg.showDiscount or 100
end

---获取刷新商店消耗的道具信息 ✔
---@param shopType integer
---@return integer|nil 道具类型, integer|nil 道具id, integer|nil 道具数量
function Player:GetShopRefreshItemInfo(shopType)
	local shopCfg = Config.GetShopListInfo(shopType)
	if shopCfg == nil then
		return
	end
	--是否可以手动刷新
	if shopCfg.isManualRefresh ~= 1 then
		return
	end

    local serverShopData = self:getShopRefreshData()
    if serverShopData == nil then
        return
    end

	---@type ShopInfo
	local shopData = serverShopData[shopType]
	if shopData == nil then
		return
	end

	--检测消耗资源
	local index = math.min(shopData.refreshNum + 1, #shopCfg.manualRefresh)
	local price = shopCfg.manualRefresh[index]
	if price[1] == GE.RewardType.ItemProp then
		return  price[1], price[2], price[3]
	end
end

---获得商品显示信息 ✔
---@param goodsId integer
---@return string 道具名, string desc, string icon, integer quality
function Player:GetGoodsItemDisplayInifo(goodsId)
	local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
	if goodsCfg == nil then
		return "", "", "", 1
	end
	if goodsCfg.content == nil or #goodsCfg.content == 0 then
		return "", "", "", 1
	end
	local itemType = goodsCfg.content[1][1]
	local itemId = goodsCfg.content[1][2]
	
	local goodsName = goodsCfg.merchandiseName
	local goodsDesc = goodsCfg.merchandiseDesc
	local goodsIcon = goodsCfg.merchandiseIcon
	if not string.isNullOrEmpty(goodsIcon) then
		goodsIcon = string.format(Config.SpritePath.ItemIconPath, goodsIcon)	
	end

	local goodsQuality = 1
	local itemName, itemDesc, itemIcon, itemQuality = self:GetRewardShowInfo(itemType, itemId)

	if string.isNullOrEmpty(goodsName) then
		goodsName = itemName
	end
	if string.isNullOrEmpty(goodsDesc) then
		goodsDesc = itemDesc
	end
	if string.isNullOrEmpty(goodsIcon) then
		goodsIcon = itemIcon
	end
	goodsQuality = itemQuality
	return goodsName, goodsDesc, goodsIcon, goodsQuality
end

--获得奖励显示信息
---@param itemType GE_RewardType
---@param itemId integer
---@return string? 道具名, string? desc, string? icon, integer quality
function Player:GetRewardShowInfo(itemType, itemId)

	local name = nil
	local desc = nil
	local icon = nil
	local quality = 0
	local itemCfg = nil
	if itemType == GE.RewardType.ItemProp then
		itemCfg = Config.GetItemInfo(itemId)
		if itemCfg == nil then
			LuaLogger.es("ItemProp 数据配置错误 id:" .. tostring(itemId))
			return name, desc, icon, quality
		end
		name = itemCfg.itemName
		desc = itemCfg.describe
		icon = string.format(Config.SpritePath.ItemIconPath, itemCfg.icon)	
		quality = itemCfg.quality

	elseif itemType == GE.RewardType.Character then--角色类型
		itemCfg = Config.GetCharacterInfo(itemId)
		if itemCfg == nil then
			LuaLogger.es("Character 数据配置错误 id:" .. tostring(itemId))
			return name, desc, icon, quality
		end
		local skinId = itemCfg.baseSkinID
		itemCfg = Config.GetCharacterSkinInfo(skinId)
		if itemCfg == nil then
			LuaLogger.es("Skin 数据配置错误 skinId:" .. tostring(skinId))
			return name, desc, icon, quality
		end
		name = itemCfg.skinName
		desc = itemCfg.skinDesc
		local resourceFolder = nil
		if tonumber(itemCfg.resourceFolder) ~= nil then
			resourceFolder = tostring(math.floor(tonumber(itemCfg.resourceFolder)))
		else
			resourceFolder = itemCfg.resourceFolder
		end
		icon = string.format(Config.SpritePath.IconRolePath, resourceFolder, itemCfg.driverKey)
		quality = 1

	elseif itemType == GE.RewardType.Equipment then--装备类型
		itemCfg = Config.GetEquipmentInfo(itemId)
		if itemCfg == nil then
			LuaLogger.es("Equipment 数据配置错误 id:" .. tostring(itemId))
			return name, desc, icon, quality
		end
		name = itemCfg.name
		desc = itemCfg.dec
		icon = string.format(Config.SpritePath.EquipIconPath, itemCfg.icon)
		quality = itemCfg.quality

	elseif itemType == GE.RewardType.Weapon then--武器类型
		itemCfg = Config.GetWeaponInfo(itemId)
		if itemCfg == nil then
			LuaLogger.es("Weapon数据配置错误 id:" .. tostring(itemId))
			return name, desc, icon, quality
		end

		name = itemCfg.name
		desc = itemCfg.weaponTypeDec
		icon = string.format(Config.SpritePath.WeaponIconPath, itemCfg.icon)
		quality = itemCfg.rare
	elseif itemType == GE.RewardType.Skin then	--皮肤
		itemCfg = Config.GetCharacterSkinInfo(itemId)
		if itemCfg == nil then
			LuaLogger.es("Skin 数据配置错误 id:" .. tostring(itemId))
			return name, desc, icon, quality
		end
		name = itemCfg.skinName
		desc = itemCfg.skinDesc
		local resourceFolder = nil
		if tonumber(itemCfg.resourceFolder) ~= nil then
			resourceFolder = tostring(math.floor(tonumber(itemCfg.resourceFolder)))
		else
			resourceFolder = itemCfg.resourceFolder
		end
		icon = string.format(Config.SpritePath.IconRolePath, resourceFolder, itemCfg.driverKey)
		quality = 1
	elseif itemType == GE.RewardType.CycleCard then --周期卡
		itemCfg = Config.GetMonthCardInfo(itemId)
		if itemCfg == nil then
			LuaLogger.es("CycleCard 数据配置错误 id:" .. tostring(itemId))
			return name, desc, icon, quality
		end
		name = itemCfg.cardName
		quality = 1
	end
	return name, desc, icon, quality
end



---获得商店过期商品id Client
---@param shopId integer 商店id
---@return integer[] 过期商品列表
function Player:GetExceedTimeLimitShopItemList(shopId)

	local ids = {}
	---@type table<integer, ShopMerchandiseTable>
	local goodsList = Config.GetShopMerchandiseByShopId(shopId)
	if goodsList == nil then
		return ids
	end
	local curTime = EngineUtil.ServerTime_Seconds()
	curTime = curTime + Me:getTimeZone() * 3600		--转换成格林威治
	for k, v in pairs(goodsList) do
		if v.merchandiseClose ~= 0 and v.merchandiseClose <= curTime then
			table.insert(ids, v.id)
		end
	end
	table.sort(ids, function(a, b)
		return a > b
	end)
	return ids
end


----购买道具 Client使用
---@param goodsId integer
---@param buyNum integer? 
---@param callback fun(goodsId:integer)?
---@param callBackAfterReward fun()? 
function Player:BuyItem(goodsId, buyNum, callback, callBackAfterReward)
	buyNum = buyNum or 1
    --计算可以购买的最大数量
    local picId, picNum, picRate  = self:GetShopItemPic(goodsId)
    local itemCfg = Config.GetItemInfo(picId)
    local ownPicNum = self:getItemCountById(picId)

    local isCanBy = ownPicNum >= picNum
    if isCanBy then
        local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
        local name, desc, icon, quality = self:GetGoodsItemDisplayInifo(goodsId)
        UICommonUtils.PopMsgBox(LocalStrEnum.merchandiseBuyPrompt_2, string.format(LocalStrEnum.merchandiseBuyPromptDesc_2, costStr,picNum, buyNum,name), MsgBoxType.Msg_Emoji, function()
            self:ShopBuyReq(goodsId, 1, callback, callBackAfterReward)
        end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
        return
    end

    if picId == GE.ResourceType.PayDiamond then
        local curBuyCount, maxBuyCount, limitType = self:GetGoodLimitCount(goodsId)
        if curBuyCount > 0 then --提示钻石不足
            local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
            UICommonUtils.PopMsgBox(LocalStrEnum.merchandiseBuyPrompt_1, string.format(LocalStrEnum.merchandiseBuyPromptDesc_1, costStr), MsgBoxType.Msg_Emoji, function()
                local trunToId = 1310002
                UICommonUtils.CommonTurnTo(trunToId,  nil)
                --跳转
            end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
        end
 	elseif picId == GE.ResourceType.FreeDiamond then
        local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
        UICommonUtils.PopMsgBox(LocalStrEnum.ItemExchange_Title, string.format(LocalStrEnum.ItemExchange_Content, costStr), MsgBoxType.Msg_Emoji, function()
            local goodsId = 9901
            local ownCount = self:getItemCountById(picId)
            local c = picNum - ownCount
            c = math.max(1, c)
            UIMgr:popUICover("ItemExchagnePanel", {goodsId = goodsId, minCount = c})
        end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)

    else
	    UICommonUtils.PopToast(string.format(LocalStrEnum.merchandiseBuyTip_1, itemCfg.itemName))
    end
end

--#endregion
return Player