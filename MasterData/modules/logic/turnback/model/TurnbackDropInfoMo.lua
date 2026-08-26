-- chunkname: @modules/logic/turnback/model/TurnbackDropInfoMo.lua

module("modules.logic.turnback.model.TurnbackDropInfoMo", package.seeall)

local TurnbackDropInfoMo = pureTable("TurnbackDropInfoMo")

function TurnbackDropInfoMo:init(co)
	self.co = co
	self._infos = {}
	self.infoParam = TurnbackEnum.DropInfoParams[co.id]
end

function TurnbackDropInfoMo:refreshInfo(infos)
	self.actId = nil
	self._infos = {}

	if infos then
		for _, info in ipairs(infos) do
			self._infos[info.materialType] = self._infos[info.materialType] or {}
			self._infos[info.materialType][info.materialId] = info
		end
	end
end

function TurnbackDropInfoMo:isUnlock()
	local type = self.co.id

	if self.infoParam and self.infoParam.UnlockOpenId then
		local isOpen = OpenModel.instance:isFuncBtnShow(self.infoParam.UnlockOpenId)

		if not isOpen then
			return false
		end
	end

	if type == TurnbackEnum.DropInfoEnum.MainAct then
		local actId = self:getActId()

		if actId then
			local status = ActivityHelper.getActivityStatus(actId)

			if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
				return true
			end
		end

		return false
	elseif type == TurnbackEnum.DropInfoEnum.Permanent then
		local isOnline = PermanentModel.instance:hasActivityOnline()

		if not isOnline then
			return false
		end

		return true
	elseif type == TurnbackEnum.DropInfoEnum.Rouge then
		return (RougeOutsideModel.instance:isUnlock())
	elseif type == TurnbackEnum.DropInfoEnum.Rouge2 then
		return (Rouge2_Model.instance:isRogueOpen())
	elseif type == TurnbackEnum.DropInfoEnum.Survival then
		return (SurvivalController.instance:isOpenSurvival())
	end

	return true
end

function TurnbackDropInfoMo:isShowRewardItem()
	return self.infoParam and self.infoParam.ShowRewardItem
end

function TurnbackDropInfoMo:getShowRewards()
	if not self:isShowRewardItem() then
		return
	end

	if not self._rewardItems then
		if self.infoParam then
			if not self.infoParam.OnlyShowReward then
				local showRewards = {
					"2#2"
				}

				self._rewardItems = {}

				for _, reward in ipairs(showRewards) do
					local value = string.splitToNumber(reward, "#")

					table.insert(self._rewardItems, value)
				end
			end
		end
	end

	return self._rewardItems
end

function TurnbackDropInfoMo:getCouponCount()
	return self:getCount(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.FreeDiamondCoupon)
end

function TurnbackDropInfoMo:getCount(type, id, defalut)
	local info = self:getInfo(type, id)

	if info then
		return info.totalNum - info.currentNum
	end

	if ItemModel.instance:getItemQuantity(type, id) > 0 then
		return 0
	end

	return defalut or 0
end

function TurnbackDropInfoMo:getInfo(type, id)
	return self._infos[type] and self._infos[type][id]
end

function TurnbackDropInfoMo:getConstRewards()
	local type = self.co.id

	self._rewardItems = {}

	if type == TurnbackEnum.DropInfoEnum.Guide then
		local value = self:_getConstCoSplitValue(TurnbackEnum.ConstId.GuideReward)

		if value and #value == 2 then
			local bonusCO = TaskConfig.instance:gettaskactivitybonusCO(value[1], value[2])

			if bonusCO then
				self._rewardItems = GameUtil.splitString2(bonusCO.bonus, true, "|", "#")
			end
		end
	elseif type == TurnbackEnum.DropInfoEnum.Rouge then
		local value = self:_getConstCoSplitValue(TurnbackEnum.ConstId.RougeReward)

		if value then
			for _, v in ipairs(value) do
				local season = RougeOutsideModel.instance:season()
				local bonusCO = RougeRewardConfig.instance:getConfigById(season, v)

				if bonusCO then
					local bonus = GameUtil.splitString2(bonusCO.value, true, "|", "#")

					tabletool.addValues(self._rewardItems, bonus)
				end
			end
		end
	elseif type == TurnbackEnum.DropInfoEnum.Rouge2 then
		local value = self:_getConstCoSplitValue(TurnbackEnum.ConstId.Rouge2Reward)

		if value then
			for _, v in ipairs(value) do
				local bonusCO = Rouge2_OutSideConfig.instance:getRewardConfigById(v)

				if bonusCO then
					local bonus = GameUtil.splitString2(bonusCO.value, true, "|", "#")

					tabletool.addValues(self._rewardItems, bonus)
				end
			end
		end
	elseif type == TurnbackEnum.DropInfoEnum.Survival then
		local value = self:_getConstCoSplitValue(TurnbackEnum.ConstId.SurvivalReward)

		if value then
			for _, v in ipairs(value) do
				local bonusCO = lua_survival_reward_shop.configDict[v]

				if bonusCO then
					local bonus = GameUtil.splitString2(bonusCO.product, true, "|", "#")

					tabletool.addValues(self._rewardItems, bonus)
				end
			end
		end
	end

	return self._rewardItems
end

function TurnbackDropInfoMo:_getConstCoSplitValue(constId)
	local value = TurnbackConfig.instance:getConstValue(constId)

	if not string.nilorempty(value) then
		return (string.splitToNumber(value, "#"))
	end
end

function TurnbackDropInfoMo:getActId()
	if not self.actId then
		local type = self.co.id

		if type == TurnbackEnum.DropInfoEnum.MainAct then
			for i = #ActivityEnum.VersionActivityIdList, 1, -1 do
				local activityId = ActivityEnum.VersionActivityIdList[i]
				local status = ActivityHelper.getActivityStatus(activityId)

				if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
					self.actId = activityId

					return activityId
				end
			end
		end
	end

	return self.actId
end

function TurnbackDropInfoMo:getName()
	local type = self.co.id

	if type == TurnbackEnum.DropInfoEnum.MainAct then
		local actId = self:getActId()

		if actId then
			local actCo = ActivityConfig.instance:getActivityCo(actId)

			if actCo then
				return actCo.name
			end
		end
	end

	return self.co.name
end

function TurnbackDropInfoMo:getShowTime()
	local type = self.co.id

	if type == TurnbackEnum.DropInfoEnum.MainAct then
		return true
	end
end

return TurnbackDropInfoMo
