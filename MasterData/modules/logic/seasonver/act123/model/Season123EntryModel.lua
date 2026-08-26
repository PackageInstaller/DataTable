-- chunkname: @modules/logic/seasonver/act123/model/Season123EntryModel.lua

module("modules.logic.seasonver.act123.model.Season123EntryModel", package.seeall)

local Season123EntryModel = class("Season123EntryModel", BaseModel)

function Season123EntryModel:release()
	return
end

function Season123EntryModel:init(actId)
	self.activityId = actId
	self._currentStage = 1
	self._currentStageIndex = 1

	self:initDatas()
	self:initDefaultStage()
end

function Season123EntryModel:getActId()
	return self.activityId
end

function Season123EntryModel:initDatas()
	self.userId = PlayerModel.instance:getMyUserId()

	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		logError("Not available season123 data! actId = " .. tostring(self.activityId))

		return
	end

	local stageList = Season123Config.instance:getStageCos(self.activityId)

	if stageList and #stageList > 0 then
		local index = 1

		self._currentStage = stageList[index].stage
		self._currentStageIndex = index
	end
end

function Season123EntryModel:initDefaultStage()
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return
	end

	if seasonMO.stage ~= 0 and Season123ProgressUtils.stageInChallenge(self.activityId, seasonMO.stage) then
		self:setCurrentStage(seasonMO.stage)
	else
		local stageList = Season123Config.instance:getStageCos(self.activityId)

		for i, stageCO in ipairs(stageList) do
			local stageMO = seasonMO:getStageMO(stageCO.stage)

			if stageMO and stageMO:isNeverTry() then
				self:setCurrentStage(stageCO.stage)
			end
		end
	end
end

function Season123EntryModel:getStageMO(stage)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return nil
	end

	return seasonMO:getStageMO(stage)
end

function Season123EntryModel:getPrevStage()
	local stageList = Season123Config.instance:getStageCos(self.activityId)

	if not stageList then
		return
	end

	if self._currentStageIndex > 1 then
		local prevIndex = self._currentStageIndex - 1
		local stageCo = stageList[prevIndex]

		return stageCo.stage
	end
end

function Season123EntryModel:getNextStage()
	local stageList = Season123Config.instance:getStageCos(self.activityId)

	if not stageList then
		return
	end

	if self._currentStageIndex < #stageList then
		local nextIndex = self._currentStageIndex + 1
		local stageCo = stageList[nextIndex]

		return stageCo.stage
	end
end

function Season123EntryModel:getCurrentStage()
	return self._currentStage
end

function Season123EntryModel:getCurrentStageIndex()
	return self._currentStageIndex
end

function Season123EntryModel:setCurrentStage(stage)
	if self._currentStage == stage then
		return
	end

	local stageList = Season123Config.instance:getStageCos(self.activityId)

	if not stageList then
		return
	end

	for index = 1, #stageList do
		local stageCo = stageList[index]

		if stageCo.stage == stage then
			self._currentStageIndex = index
			self._currentStage = stage

			return
		end
	end
end

function Season123EntryModel:getUTTUTicketNum()
	local curTicketId = Season123Config.instance:getEquipItemCoin(self.activityId, Activity123Enum.Const.UttuTicketsCoin)
	local ticketCO = CurrencyConfig.instance:getCurrencyCo(curTicketId)

	if ticketCO then
		local maxCount = ticketCO.recoverLimit
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, curTicketId)

		return quantity, maxCount
	else
		return nil, nil
	end
end

function Season123EntryModel:isFirstOpen()
	local localKey = self:getLocalKey()

	if not string.nilorempty(localKey) then
		local rs = PlayerPrefsHelper.getString(localKey, "")

		return string.nilorempty(rs)
	end
end

function Season123EntryModel:setAlreadyVisited(actId)
	local localKey = self:getLocalKey(actId)

	if not string.nilorempty(localKey) then
		PlayerPrefsHelper.setString(localKey, "1")
	end
end

function Season123EntryModel:getLocalKey(actId)
	if not self._localKey then
		local playerInfo = PlayerModel.instance:getPlayinfo()

		if not playerInfo or playerInfo.userId == 0 then
			return nil
		end

		self._localKey = "Season123EntryModel#FirstEntry#" .. tostring(playerInfo.userId) .. "#" .. tostring(actId)
	end

	return self._localKey
end

function Season123EntryModel:getTrialCO()
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if seasonMO and seasonMO.trial ~= 0 then
		return Season123Config.instance:getTrialCO(self.activityId, seasonMO.trial)
	end

	return nil
end

function Season123EntryModel:isRetailOpen()
	local stageId = Season123Config.instance:getSeasonConstNum(self.activityId, Activity123Enum.Const.RetailOpenStage)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return false
	end

	local stageMO = seasonMO:getStageMO(stageId)

	if stageMO then
		return stageMO.isPass
	else
		return false
	end
end

function Season123EntryModel.getRandomRetailRes(retailId)
	local index = retailId % #SeasonEntryEnum.ResPath + 1

	return index, SeasonEntryEnum.ResPath[index]
end

function Season123EntryModel:stageIsPassed(stage)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return false
	end

	local stageMO = seasonMO.stageMap[stage]

	return stageMO and stageMO.isPass
end

function Season123EntryModel:needPlayUnlockAnim(actId, stage)
	local unlockKey = self:getUnlockKey(actId, stage)

	if not string.nilorempty(unlockKey) then
		local rs = PlayerPrefsHelper.getString(unlockKey, "")

		return string.nilorempty(rs)
	end
end

function Season123EntryModel:setAlreadyUnLock(actId, stage)
	local unlockKey = self:getUnlockKey(actId, stage)

	if not string.nilorempty(unlockKey) then
		PlayerPrefsHelper.setString(unlockKey, "1")
	end
end

function Season123EntryModel:getUnlockKey(actId, stage)
	return "EntryViewStageUnlock" .. tostring(self.userId) .. "#" .. tostring(actId) .. tostring(stage)
end

function Season123EntryModel:needPlayUnlockAnim1(actId, stage)
	local unlockKey = self:getUnlockKey1(actId, stage)

	if not string.nilorempty(unlockKey) then
		local rs = PlayerPrefsHelper.getString(unlockKey, "")

		return string.nilorempty(rs)
	end
end

function Season123EntryModel:setAlreadyUnLock1(actId, stage)
	local unlockKey = self:getUnlockKey1(actId, stage)

	if not string.nilorempty(unlockKey) then
		PlayerPrefsHelper.setString(unlockKey, "1")
	end
end

function Season123EntryModel:getUnlockKey1(actId, stage)
	return "EntryOverviewStageUnlock" .. tostring(self.userId) .. "#" .. tostring(actId) .. tostring(stage)
end

Season123EntryModel.instance = Season123EntryModel.New()

return Season123EntryModel
