-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Item.lua

local ResItem = require("ClientData/ResItem")
local BaseObject = require("Common/Object/BaseObject")
local ResHero = require("ClientData/ResHero")
local strClassName = "Item"
local Item = Class(strClassName, BaseObject)

function Item:ctor(data)
	return
end

function Item:_initData()
	Item.super._initData(self)

	self.id = self._serverData.id
	self.num = self._serverData.num or 0

	if self._serverData._CType == "datap.ZoneItem" then
		self.activityOpID = self._serverData.act_id
	end

	self.frozenNum = 0
	self.resData = ResItem[self.id]

	if self.resData then
		self.quality = self.resData.quality
		self.subType = self.resData.subtype
		self.name = self.resData.name
	end

	if self:isFragmentItem() then
		self.itemType = Const.ITEM_TYPE_FRAG_ITEM

		if self.subType == Const.ITEM_STYPE_HERO_FRAG and self.resData then
			self.hero = self.resData.extend_args2
		end
	else
		self.itemType = Const.ITEM_TYPE_ITEM
		self.isCanUse = Const.BAG_CANUSE_STYPE[self.subType] ~= nil and 1 or 0
	end
end

function Item:updateFromChange(iInfo)
	self._serverData.num = iInfo.num or 0
	self.num = self._serverData.num
end

function Item:setFrozenNum(num)
	self.frozenNum = num or 0
end

function Item:getNumStr(exceptFrozen)
	if exceptFrozen == true then
		return ClientUtils.getNumShortStr(self.num - self.frozenNum)
	end

	return ClientUtils.getNumShortStr(self.num)
end

function Item:isCommonItem()
	return not self:isFragmentItem()
end

function Item:isFragmentItem()
	return Const.ITEM_DICT_FRAG[self.subType]
end

function Item:isFurniture()
	return Const.ITEM_DICT_REAR_HOUSE[self.subType]
end

function Item:getRelatedActivity()
	if self.activityOpID and self.activityOpID ~= 0 then
		return CurAvatar:getActivityObjByOpId(self.activityOpID)
	elseif self.resData.related_activity and CurAvatar then
		for _, actId in ipairs(self.resData.related_activity) do
			local act = CurAvatar:getActivityObj(actId)

			if act then
				return act
			end
		end
	end
end

function Item:sellEnable()
	if self.num <= 0 then
		return false
	end

	if self.resData.sell_coin_id then
		local overdue = self:isOverdue()

		if not overdue and (self.resData.related_activity or self.resData.overdue_time) then
			return false
		end

		if self.subType == Const.ITEM_STYPE_CASH then
			return self.num < (self.resData.extend_args1 or 6)
		else
			return true
		end
	end

	return false
end

function Item:isOverdue()
	local overdue = false

	if self.resData.related_activity then
		local actObj = self:getRelatedActivity()

		if not actObj or not actObj.endTime or not (ClientUtils.getServerTime() < actObj.endTime) then
			overdue = true
		end
	end

	if self.resData.overdue_time and ClientUtils.getServerTime() >= ClientUtils.getServerTimeByTimeStr(self.resData.overdue_time) then
		overdue = true
	end

	return overdue
end

function Item:getQualityPath()
	if self:isFragmentItem() then
		if self.subType == Const.ITEM_STYPE_RAND_EQUIP_FRAG then
			return Item.super.getQualityPath(self)
		elseif self.subType == Const.ITEM_STYPE_RAND_ARTIFACT_FRAG then
			return Item.super.getQualityPath(self)
		else
			return UIConst.COMMON_QUALITY_CONFIG[self.quality]
		end
	else
		return Item.super.getQualityPath(self)
	end
end

function Item:getFragHeroStarPath()
	if self.subType == Const.ITEM_STYPE_RAND_HERO_FRAG then
		local star = self.quality or 1

		star = star < 10 and "0" .. star or star

		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			"IconStar" .. star
		}
	end

	if self.hero == nil then
		return
	end

	local heroData = ResHero[self.hero]

	if heroData then
		local star = heroData.ori_star or 1

		star = star < 10 and "0" .. star or star

		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			"IconStar" .. star
		}
	end
end

function Item:isFragCantCompose(heroIdMaxStarDic)
	heroIdMaxStarDic = heroIdMaxStarDic or CurAvatar:getIdMaxStarDic()

	if self:isFragmentItem() then
		if Const.LIGHT_BLACK_FRAG_ID_DIC[self.id] and CurAvatar and CurAvatar:isAllLightBlackMaxStar() then
			return Const.HERO_CANT_COMPOSE_REASON.RAND
		end

		if self.subType == Const.ITEM_STYPE_HERO_FRAG and self.hero then
			local heroRes = ResHero[self.hero]

			if utils.campIsLightOrDark(heroRes.camp) and heroIdMaxStarDic[self.hero] and heroIdMaxStarDic[self.hero] == Const.HERO_MAX_STAR then
				return Const.HERO_CANT_COMPOSE_REASON.DEFINE
			end
		end
	end
end

function Item:getCantComposeNoticeId(heroIdMaxStarDic)
	if self.subType == Const.ITEM_STYPE_SKIN_FRAG and CurAvatar then
		local params = self.resData.extend_args3

		if CurAvatar:hasGetSkinByHeroAndSkinId(params[1], params[2]) then
			return Lang.get(117278)
		end
	end
end

return Item
