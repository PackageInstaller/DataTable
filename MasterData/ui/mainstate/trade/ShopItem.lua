-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\ShopItem.lua

local ResShopExchg = require("ClientData/ResShopExchg")
local ShopUtils = require("UI/MainState/Trade/ShopUtils")
local ResItem = require("ClientData/ResItem")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResHero = require("ClientData/ResHero")
local ResVoidHero = require("ClientData/ResVoidHero")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResPet = require("ClientData/ResPet")
local ResOpActivityShopDetail = require("ClientData/ResOpActivityShopDetail")
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")
local ShopItem = Class("ShopItem")

function ShopItem:ctor(shopID, shopItemID, hasBoughtNum, recoverTime, actId)
	self.shopID = shopID
	self.id = shopItemID
	self.data = ResShopExchg[shopItemID]
	self.actId = actId

	local data = self.data

	self.sellStyle = data.sell_style
	self.sellStylePath = data.sell_style_path
	self.indexPriority = data.index_priority
	self.showGotNum = data.notice_got_num == 1

	local itemInfo = self.data.exchg[1]

	self.buyNum = itemInfo.value or 1
	self.object = BaseObject.GetObject(itemInfo.key, itemInfo.value or 1, true)
	self.desc = self:_getDesc()
	self.isRelateLimited = false

	self:setBoughtNum(hasBoughtNum or 0)
	self:setRecoverTime(recoverTime)
	self:updateState()
end

function ShopItem:getItemHasNum()
	if self.showGotNum and self.object then
		return ClientUtils.getMoney(self.object.id)
	end
end

function ShopItem:setRecoverTime(recoverTime)
	self.recoverTime = recoverTime
end

function ShopItem:updateState(playerLevel)
	if playerLevel == nil then
		playerLevel = CurAvatar:getLevel()
	end

	self:_updateIsLocked(playerLevel)
end

function ShopItem:_updateIsLocked(playerLevel)
	if playerLevel == nil then
		playerLevel = CurAvatar:getLevel()
	end

	local data = self.data
	local lockHint, shortLockHint = ShopUtils.getLockHintCommon(playerLevel, data.level, data.lock_condition_id)

	if shortLockHint ~= "" then
		self.shortLockHint = shortLockHint
	else
		self.shortLockHint = nil
	end

	local isLocked = lockHint ~= nil
	local isRelateLimited = false

	if data.relate_limit then
		local resData = ResItem[data.exchg[1].key]

		if resData and resData.subtype == Const.ITEM_STYPE_PET_FRAG then
			local petId = resData.extend_args2
			local petData = ResPet[petId]

			if petData then
				isRelateLimited = CurAvatar:getPetByResId(petId) == nil
				lockHint = string.format(Lang.get(30563), petData.name)
			end
		elseif resData and resData.type == 5 and resData.extend_args2 then
			local heroId = resData.extend_args2
			local heroName = ResHero[heroId].hero_name

			if ResVoidHero[heroId] then
				local uniqueHeroId = ResVoidHero[heroId].voidhero_resid

				heroName = heroName .. Lang.get(58925) .. ResHero[uniqueHeroId].hero_name
				isRelateLimited = CurAvatar.handBookHeroDic[heroId] == nil and CurAvatar.handBookHeroDic[uniqueHeroId] == nil
				lockHint = string.format(Lang.get(30563), heroName)
			else
				isRelateLimited = CurAvatar.handBookHeroDic[heroId] == nil
				lockHint = string.format(Lang.get(30563), heroName)
			end
		end
	end

	if self.actId then
		local actObj = CurAvatar:getActivityObj(self.actId)

		if actObj and actObj:isValid() and not actObj.actData:isShopItemUnlock(self.id) then
			local unlocked

			unlocked, lockHint = actObj.actData:isShopItemUnlock(self.id)
			isLocked = not unlocked
		end
	end

	self._isLocked = isLocked
	self.isRelateLimited = isRelateLimited
	self.lockHint = lockHint
end

function ShopItem:isInHide()
	if self.data.condition_id and ConditionLimitManager.inLimitState(self.data.condition_id) then
		return true
	end

	if self.data.expire_tick and ClientUtils.getServerTime() >= ClientUtils.getServerTimeByTimeStr(self.data.expire_tick) then
		return true
	end

	if self.data.parent_expire_shop then
		local parData = ResShopExchg[self.data.parent_expire_shop]

		if parData and parData.expire_tick and ClientUtils.getServerTime() < ClientUtils.getServerTimeByTimeStr(parData.expire_tick) then
			return true
		end
	end

	if self.data.valid_time_id and not ClientUtils.isTimeConfigPassed(self.data.valid_time_id) then
		return true
	end

	return false
end

function ShopItem:getDisappearTime()
	if self.data.expire_tick then
		return ClientUtils.getServerTimeByTimeStr(self.data.expire_tick) - ClientUtils.getServerTime()
	end
end

function ShopItem:getRelateActEndTime()
	if self.data.relate_act_id then
		local relateAct = CurAvatar:getActivityObj(self.data.relate_act_id)

		if relateAct then
			return relateAct:getRemainOpenTime()
		end
	end
end

function ShopItem:isLimitFrag()
	return self.data.relate_limit ~= nil
end

function ShopItem:isLocked()
	return self._isLocked
end

function ShopItem:hasCountLimit()
	return self.canBuyCount ~= nil
end

function ShopItem:isRecoverType()
	return self.data.period == 7
end

function ShopItem:setBoughtNum(boughtNum)
	self.boughtNum = boughtNum

	if self.data.exchgmax ~= nil then
		self.canBuyCount = math.max(0, self.data.exchgmax - boughtNum)
	end
end

function ShopItem:getNumHint()
	local countHint

	if self:hasCountLimit() then
		local periodTag = Lang.get(30564)
		local period = self.data.period

		if period == 2 then
			periodTag = Lang.get(30565)
		elseif period == 4 then
			periodTag = Lang.get(30566)
		elseif period == 3 or period == 7 then
			periodTag = ""
		end

		countHint = utils.format(Lang.get(30561), periodTag, self.canBuyCount)
	else
		countHint = Lang.get(30567)
	end

	return countHint
end

function ShopItem:getRecoverStaticHint()
	if self:isRecoverType() then
		return string.format(Lang.get(30562), utils.calcTimeTxt(self.data.time))
	else
		return nil
	end
end

function ShopItem:isSoldOut()
	return self.canBuyCount ~= nil and self.canBuyCount <= 0
end

function ShopItem:isSoldOutAndNotInRecover()
	return not self:isInRecover() and self:isSoldOut()
end

function ShopItem:isInRecover()
	return self:getRecoverTick() ~= nil
end

function ShopItem:getRecoverTick(serverTime)
	if serverTime == nil then
		serverTime = ClientUtils.getServerTime()
	end

	if self.recoverTime == nil or serverTime >= self.recoverTime then
		return nil
	else
		return self.recoverTime - serverTime
	end
end

function ShopItem:getHint()
	local recoverTick, staticHint

	if self:isLocked() then
		staticHint = Lang.get(195)
	elseif self:isInRecover() then
		recoverTick = self:getRecoverTick()
	elseif self.isRelateLimited then
		staticHint = self:getNumHint()
	elseif self:isSoldOut() then
		staticHint = Lang.get(44)
	else
		staticHint = self:getNumHint()
	end

	return staticHint, recoverTick
end

function ShopItem:getComfortable(...)
	local data = RearHouseCommon.getFurnitureInfo(self.object.id)

	if data then
		return data.comfortable
	end
end

function ShopItem:getWeight(...)
	local data = RearHouseCommon.getFurnitureInfo(self.object.id)

	if data then
		return data.weight
	end
end

function ShopItem:isRearHouseType(...)
	return RearHouseCommon.getFurnitureInfo(self.object.id) ~= nil
end

function ShopItem:isSingleFurniture(...)
	return RearHouseCommon.isSingleFurniture(self.object.id)
end

function ShopItem:isSuitFurniture(...)
	return RearHouseCommon.isAttrFurniture(self.object.id) and not RearHouseCommon.isSingleFurniture(self.object.id)
end

function ShopItem:_getDesc()
	local data = self.data

	if data == nil then
		return nil
	end

	local desc = data.content_desc

	if desc == nil then
		local itemInfo = data.exchg and data.exchg[1]
		local itemID = itemInfo and itemInfo.key

		desc = ResItem[itemID] and ResItem[itemID].desc
	end

	return desc
end

function ShopItem:getCostMoneyInfo()
	if self.data.use then
		return self.data.use[1].ID, self.data.use[1].discount
	end
end

function ShopItem:hasCustomDesc()
	return self.data.content_desc ~= nil
end

function ShopItem:getClickHint()
	if self:isLocked() or self.isRelateLimited then
		return self.lockHint
	elseif self:isSoldOutAndNotInRecover() then
		return Lang.get(44)
	elseif self:checkHasLimit() then
		return ResClientNotice[682].notice
	end

	return nil
end

function ShopItem:canBuy()
	if self:isLocked() or self:isSoldOut() or self.isRelateLimited or self:checkHasLimit() then
		return false
	else
		return true
	end
end

function ShopItem:checkHasLimit()
	if not self.object then
		return false
	end

	local id = self.object.id
	local type = BaseObject.GetObjectType(id)

	if type == Const.ITEM_TYPE_ITEM then
		local resData = ResItem[id]

		if resData and resData.subtype and (resData.subtype == Const.ITEM_STYPE_HEAD_FRAME or resData.subtype == Const.ITEM_STYPE_DYNAMIC_ICON) then
			return BaseObject.checkHasObject(self.object)
		end
	end

	return false
end

return ShopItem
