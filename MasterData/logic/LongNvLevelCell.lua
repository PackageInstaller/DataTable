-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/LongNvLevelCell.lua

module("logic.extensions.directpurchase.view.LongNvLevelCell", package.seeall)

local LongNvLevelCell = class("LongNvLevelCell", LongNvCellBase)
local json = require("cjson")

function LongNvLevelCell:ctor()
	return
end

function LongNvLevelCell:buildUI(go)
	LongNvLevelCell.super.buildUI(self, go)

	self._txtPower = goutil.findChildTextComponent(go, "power/txtPower")
	self._icon = goutil.findChild(go, "btnBuy/icon")

	self._icon:SetActive(false)

	self.showpriceGo = goutil.findChild(go, "showprice")
	self.iconShowPrice = goutil.findChild(go, "showprice/icon")
	self.txtShowPrice = goutil.findChildTextComponent(go, "showprice/txt")
end

function LongNvLevelCell:init(id, activityId, activityType)
	self._id = id

	LongNvLevelCell.super.init(self, id, activityId)
	self._btnBuy.gameObject:SetActive(true)

	self._activityType = activityType

	local cfg
	local cfgCommon = PayStrengthenConfig.instance:getPermanentCfgById(self._id)

	cfg = self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN and PayStrengthenConfig.instance:getActivityCfg(self._activityId, self._id) or self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT and cfgCommon or cfgCommon

	if not cfg then
		return
	end

	self._payType = cfg.payType
	self._payGoodsId = cfg.payGoodsId
	self._showPrice = cfg.showPrice
	self._isRmb = self._payType == GameEnum.PayShopPayType.RMB

	goutil.setActive(self._icon, not self._isRmb)

	local isCanBuyExceptBuyCount = self:_isCanBuyExceptBuyCount()

	if self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN then
		local maxBuyNum = cfg.times
		local curBuyNum = PayStrengthenModel.instance:getUsedTimes(self._id)

		if curBuyNum < maxBuyNum then
			if self._isRmb then
				self:_setRmbItem()
			else
				self:_setGameGoodsItem()
			end

			self:_setTxtLimit(curBuyNum, maxBuyNum)
			self:_setBtnGray(maxBuyNum <= curBuyNum or not isCanBuyExceptBuyCount)
		else
			self:_setCommonBuyState(isCanBuyExceptBuyCount)
		end
	else
		self:_setCommonBuyState(isCanBuyExceptBuyCount)
	end

	self:_setPower()
end

function LongNvLevelCell:_setCommonBuyState(isCanBuyExceptBuyCount)
	if self._isRmb then
		self:_setRmbItem()
	else
		self:_setGameGoodsItem()
	end

	self._txtLimit.text = ""

	self:_setBtnGray(not isCanBuyExceptBuyCount)
end

function LongNvLevelCell:onExit()
	MaterialMgr.clearIcon(self._icon)
end

function LongNvLevelCell:_setRmbItem()
	local price = checknumber(string.split(self._payGoodsId, "_")[2])

	self._txtPrice.text = price .. "元"
end

function LongNvLevelCell:_setGameGoodsItem()
	local matType, id, matNum = MaterialMgr.getMatParams(self._payGoodsId)

	MaterialMgr.setIcon(self._icon, matType, id)

	self._txtPrice.text = matNum

	GameUtil.SetActive(self.showpriceGo, false)

	if not string.nilorempty(self._showPrice) then
		GameUtil.SetActive(self.showpriceGo, true)

		local sType, sId, sNum = MaterialMgr.getMatParams(self._showPrice)

		MaterialMgr.setIcon(self.iconShowPrice, sType, sId)

		self.txtShowPrice.text = sNum
	end
end

function LongNvLevelCell:_isHasBuyCount()
	if self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN then
		local cfg = PayStrengthenConfig.instance:getActivityCfg(self._activityId, self._id)

		if cfg then
			local maxBuyNum = cfg.times
			local curBuyNum = PayStrengthenModel.instance:getUsedTimes(self._id)

			return curBuyNum < maxBuyNum
		end
	elseif self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT then
		local config = PayStrengthenConfig.instance:getLimitCfg(self._activityId, self._id)
		local info = PayStrengthenModel.instance:getInfoIsLimit(self._activityId, self._id)

		if config and info and info.times and checknumber(info.times) >= config.times then
			return false
		end
	end

	return true
end

function LongNvLevelCell:_onClickBuy()
	if self._activityId then
		local config = PayStrengthenConfig.instance:getLimitCfg(self._activityId, self._id)
		local info = PayStrengthenModel.instance:getInfoIsLimit(self._activityId, self._id)

		if config then
			if info and info.times and checknumber(info.times) >= config.times then
				TipsFacade.instance:openCommonTips(lang("已使用完当前周期可用次数，请重置后再来"))

				return
			else
				self:_onRealClickBuy()
			end
		else
			self:_onRealClickBuy()
		end
	else
		self:_onRealClickBuy()
	end
end

function LongNvLevelCell:_onRealClickBuy()
	local isBanPet = self:_isBanPet(self._id, self._petId)
	local bagPetMo = BagModel.instance:getPet(self._petId)

	if isBanPet then
		FloatWordMgr.instance:show(string.format("%s无法购买本商品哦", bagPetMo.name))

		return
	end

	if self._petId and self._petId > 0 then
		if self._id == PayStrengthenModel.LEVEL then
			if bagPetMo:isMaxLv() then
				FloatWordMgr.instance:show("该精灵的等级已满")

				return
			end
		elseif self._id == PayStrengthenModel.STARGOD then
			if not bagPetMo:isStarGodMaxSlotCount() then
				local function func()
					ViewAutoShowController.instance:saveCurModalView()
					BagPetsController.instance:openBagPetView(self._petId, 3)
				end

				TipsFacade.instance:openTipWindow(lang("tip"), "请穿戴4个星神再来一键直升", func, "前往")

				return
			end

			if bagPetMo:isStarGodMaxLv() then
				FloatWordMgr.instance:show("该精灵的星神等级已满")

				return
			end
		elseif self._id == PayStrengthenModel.AWAKELEVEL then
			if bagPetMo:isMaxAwaken() then
				FloatWordMgr.instance:show("该精灵的觉醒等级已满")

				return
			end

			local isMax = bagPetMo.awakenLv >= BagModel.instance:getMaxAwakenLv(bagPetMo.raceId)

			if not isMax then
				local tip = string.format("你背包中已经有1只<color=#eb4642>更高觉醒</color>的<color=#eb4642>%s</color>喔。无需再觉醒！", bagPetMo.name)

				TipsFacade.instance:openTipWindow("提示", tip, nil, "知道了")

				return
			end
		elseif self._id == PayStrengthenModel.SKILLLEVEL then
			if not bagPetMo:isMaxLv() then
				FloatWordMgr.instance:show("需要100级精灵方可进行技能升级")

				return
			end

			local maxNormal = BagPetsController.instance:getPetSkillMaxLevel(bagPetMo.raceId, GameEnum.SkillRaceType.Normal)
			local maxUltimate = BagPetsController.instance:getPetSkillMaxLevel(bagPetMo.raceId, GameEnum.SkillRaceType.Ult)
			local maxPassive = BagPetsController.instance:getPetSkillMaxLevel(bagPetMo.raceId, GameEnum.SkillRaceType.Passive)

			if maxUltimate <= bagPetMo.normalSkillLv and maxUltimate <= bagPetMo.ultimateSkillLv and maxPassive <= bagPetMo.passiveSkillLv then
				FloatWordMgr.instance:show("该精灵的技能等级已满")

				return
			end
		elseif self._id == PayStrengthenModel.EQUIPMENT then
			-- block empty
		elseif self._id == PayStrengthenModel.SELECTSTARGOD then
			-- block empty
		end

		if self:_isMatchCondition() then
			if self._isRmb then
				self:_buyRMBItem()
			else
				self:_buyGameGoodsItem()
			end
		end
	else
		FloatWordMgr.instance:show("请先放入精灵")
	end
end

function LongNvLevelCell:_isMatchCondition()
	return true
end

function LongNvLevelCell:_getGameGoodsParam()
	return tostring(self._petId)
end

function LongNvLevelCell:_getRMBParams()
	return {
		param = self._petId
	}
end

function LongNvLevelCell:_buyRMBItem()
	local rmbParam = self:_getRMBParams()
	local paySubGoodsType

	PayController.instance:pay(self._payGoodsId, self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN and GameEnum.PaySubGoodsType.PAY_ACTIVITY_STRENGTHEN or self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT and GameEnum.PaySubGoodsType.PAY_STRENGTHEN or GameEnum.PaySubGoodsType.PAY_STRENGTHEN, self._id, json.encode(rmbParam))
end

function LongNvLevelCell:_buyGameGoodsItem()
	local matType, id, matNum = MaterialMgr.getMatParams(self._payGoodsId)
	local moneyName = MaterialMgr.getMaterialsName(matType, id)
	local itemName = self._txtTitle.text
	local content = string.format("确定要花费<color=#d44c28>%d%s</color>,购买<color=#d44c28>%s</color>吗？", matNum, moneyName, itemName)
	local buyParam = self:_getGameGoodsParam()

	TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, function()
		if self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN then
			local cfg = PayStrengthenConfig.instance:getActivityCfg(self._activityId, self._id)

			if PayStrengthenModel.instance:getUsedTimes(self._id) < cfg.times then
				PayStrengthenAgent.instance:sendPM_ActivityBuyItemReq(self._id, buyParam, self._activityId)
			else
				PayStrengthenAgent.instance:sendPM_CommonBuyItemReq(self._id, buyParam)
			end
		elseif self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT then
			PayStrengthenAgent.instance:sendPM_CommonBuyItemReq(self._id, buyParam)
		else
			PayStrengthenAgent.instance:sendPM_CommonBuyItemReq(self._id, buyParam)
		end
	end)
end

function LongNvLevelCell:_isBanPet(type, petId)
	local payStrengthenCfg = PayStrengthenConfig.instance:getPermanentCfgById(type)

	if payStrengthenCfg and not string.nilorempty(payStrengthenCfg.param) then
		local bagPetMo = BagModel.instance:getPet(petId)

		if bagPetMo then
			local raceId = bagPetMo.raceId
			local list = string.split(payStrengthenCfg.param, ",")

			for i, v in ipairs(list) do
				if raceId == checknumber(v) then
					return true
				end
			end

			return false
		end
	end

	return false
end

function LongNvLevelCell:setPetInfo(petId)
	self._petId = petId

	self:update()
end

function LongNvLevelCell:update()
	local cfg
	local cfgCommon = PayStrengthenConfig.instance:getPermanentCfgById(self._id)

	cfg = self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN and PayStrengthenConfig.instance:getActivityCfg(self._activityId, self._id) or self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT and cfgCommon or cfgCommon

	if not cfg then
		return
	end

	self._payGoodsId = cfgCommon.payGoodsId
	self._showPrice = cfgCommon.showPrice

	local maxBuyNum = 0
	local curBuyNum = 0
	local config, info
	local isCanBuyExceptBuyCount = self:_isCanBuyExceptBuyCount()

	if self._activityType == nil then
		self:_setCommonBuyState(isCanBuyExceptBuyCount)

		return
	end

	if self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN then
		maxBuyNum = cfg.times
		curBuyNum = PayStrengthenModel.instance:getUsedTimes(self._id)
	elseif self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT then
		config = PayStrengthenConfig.instance:getLimitCfg(self._activityId, self._id)
		info = PayStrengthenModel.instance:getInfoIsLimit(self._activityId, self._id)

		if config and info then
			maxBuyNum = checknumber(config.times)
			curBuyNum = checknumber(info.times) or curBuyNum
		end
	end

	local bagPetMo = self._petId and BagModel.instance:getPet(self._petId) or nil

	if not bagPetMo then
		if curBuyNum < maxBuyNum then
			if self._isRmb then
				self:_setRmbItem()
			else
				self:_setGameGoodsItem()
			end

			if self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN then
				self:_setTxtLimit(curBuyNum, maxBuyNum)
			elseif config and info then
				self._txtLimit.text = string.format("限购次数 %d/%d", math.max(0, checknumber(config.times) - checknumber(info.times)), checknumber(config.times))
			end

			self:_setBtnGray(maxBuyNum <= curBuyNum or not isCanBuyExceptBuyCount)
		else
			self:_setCommonBuyState(isCanBuyExceptBuyCount)
		end

		return
	end

	isCanBuyExceptBuyCount = curBuyNum > 0 and maxBuyNum <= curBuyNum or not isCanBuyExceptBuyCount
	isCanBuyExceptBuyCount = not isCanBuyExceptBuyCount

	self:_setBtnGray(not isCanBuyExceptBuyCount)

	if self._id == PayStrengthenModel.LEVEL then
		if not bagPetMo:isMaxLv() then
			if maxBuyNum <= curBuyNum then
				self:_setCommonBuyState(isCanBuyExceptBuyCount)
			elseif self._isRmb then
				self:_setRmbItem()
			else
				self:_setGameGoodsItem()
			end
		elseif maxBuyNum <= curBuyNum then
			self:_setCommonBuyState(isCanBuyExceptBuyCount)
		else
			self._txtPrice.text = "已满级"
		end
	elseif self._id == PayStrengthenModel.STARGOD then
		if not bagPetMo:isStarGodMaxLv() then
			if maxBuyNum <= curBuyNum then
				self:_setCommonBuyState(isCanBuyExceptBuyCount)
			elseif self._isRmb then
				self:_setRmbItem()
			else
				self:_setGameGoodsItem()
			end
		elseif maxBuyNum <= curBuyNum then
			self:_setCommonBuyState(isCanBuyExceptBuyCount)
		else
			self._txtPrice.text = "已满级"
		end
	elseif self._id == PayStrengthenModel.AWAKELEVEL or self._id == PayStrengthenModel.SKILLLEVEL or self._id == PayStrengthenModel.EQUIPMENT or self._id == PayStrengthenModel.SELECTSTARGOD then
		if maxBuyNum <= curBuyNum then
			self:_setCommonBuyState(isCanBuyExceptBuyCount)
		elseif self._isRmb then
			self:_setRmbItem()
		else
			self:_setGameGoodsItem()
		end
	end

	if config and info then
		self._txtLimit.text = string.format("限购次数 %d/%d", math.max(0, checknumber(config.times) - checknumber(info.times)), checknumber(config.times))
	end
end

function LongNvLevelCell:_setPower()
	return
end

function LongNvLevelCell:_setTxtTitle()
	return
end

function LongNvLevelCell:_isCanBuyExceptBuyCount()
	local isBanPet = self:_isBanPet(self._id, self._petId)

	if isBanPet then
		return false
	end

	local cfg
	local cfgCommon = PayStrengthenConfig.instance:getPermanentCfgById(self._id)

	if (self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN and PayStrengthenConfig.instance:getActivityCfg(self._activityId, self._id) or self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT and cfgCommon or cfgCommon) and self._petId and self._petId > 0 then
		local bagPetMo = BagModel.instance:getPet(self._petId)

		if not bagPetMo then
			return false
		end

		if self._id == PayStrengthenModel.LEVEL then
			if bagPetMo:isMaxLv() then
				return false
			end
		elseif self._id == PayStrengthenModel.STARGOD then
			if bagPetMo:isStarGodMaxLv() then
				return false
			end
		elseif self._id == PayStrengthenModel.AWAKELEVEL then
			if bagPetMo:isMaxAwaken() then
				return false
			end

			local isMax = bagPetMo.awakenLv >= BagModel.instance:getMaxAwakenLv(bagPetMo.raceId)

			if not isMax then
				return false
			end
		elseif self._id == PayStrengthenModel.SKILLLEVEL then
			if not bagPetMo:isMaxLv() then
				return false
			end

			local maxNormal = BagPetsController.instance:getPetSkillMaxLevel(bagPetMo.raceId, GameEnum.SkillRaceType.Normal)
			local maxUltimate = BagPetsController.instance:getPetSkillMaxLevel(bagPetMo.raceId, GameEnum.SkillRaceType.Ult)
			local maxPassive = BagPetsController.instance:getPetSkillMaxLevel(bagPetMo.raceId, GameEnum.SkillRaceType.Passive)

			if maxUltimate <= bagPetMo.normalSkillLv and maxUltimate <= bagPetMo.ultimateSkillLv and maxPassive <= bagPetMo.passiveSkillLv then
				return false
			end
		elseif self._id == PayStrengthenModel.EQUIPMENT then
			-- block empty
		elseif self._id == PayStrengthenModel.SELECTSTARGOD then
			-- block empty
		end
	end

	return true
end

return LongNvLevelCell
