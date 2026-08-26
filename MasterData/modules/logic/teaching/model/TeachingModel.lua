-- chunkname: @modules/logic/teaching/model/TeachingModel.lua

module("modules.logic.teaching.model.TeachingModel", package.seeall)

local TeachingModel = class("TeachingModel", BaseModel)

function TeachingModel:onInit()
	self._teachingMo = nil
	self._selectedTeachingId = nil
	self._needShowPopInfo = nil
	self._teachingShowRecord = {}
	self._teachingAniPlayInfo = {}
	self._needOpenView = nil

	self:initPopData()
end

function TeachingModel:reInit()
	self._selectedTeachingId = nil
	self._needShowPopInfo = nil
	self._teachingShowRecord = {}
	self._teachingAniPlayInfo = {}
	self._needOpenView = nil

	self:initPopData()
end

function TeachingModel:updateTeachingMo(info)
	if self._teachingMo == nil then
		self._teachingMo = TeachingMo.New()
	end

	self._teachingMo:update(info)
end

function TeachingModel:updateTeachingMoByServer(teachings)
	if self._teachingMo ~= nil then
		self._teachingMo:updateByTeachings(teachings)
	end
end

function TeachingModel:setSelectTeachingId(teachingId)
	self._selectedTeachingId = teachingId

	self:recordShowTeaching(teachingId)
	TeachingController.instance:dispatchEvent(TeachingEvent.OnSelectTeachingId)
end

function TeachingModel:getSelectTeachingId()
	return self._selectedTeachingId
end

function TeachingModel:getCurSelectTeachingStatus()
	return self:getTeachingStatusByTeachingId(self._selectedTeachingId)
end

function TeachingModel:getTeachingStatusByTeachingId(teachingId)
	if self._teachingMo == nil or teachingId == nil then
		return TeachingEnum.TeachingStatus.NotFinish
	end

	return self._teachingMo:getTeachingStatus(teachingId)
end

function TeachingModel:getAllTeachingId()
	local allConfig = TeachingConfig.instance:getAllTeachingConfig()
	local allTeachingId = {}
	local count = tabletool.len(allConfig)

	for i = 1, count do
		local teachingConfig = allConfig[i]

		table.insert(allTeachingId, teachingConfig.id)
	end

	return allTeachingId
end

function TeachingModel:getAllTeachingRewardCount()
	local allConfig = TeachingConfig.instance:getAllTeachingConfig()
	local allTeachingRewardCount = 0
	local getRewardCount = 0
	local count = tabletool.len(allConfig)

	for i = 1, count do
		local teachingConfig = allConfig[i]
		local bonus = teachingConfig.bonus

		if bonus then
			local bonusList = string.splitToNumber(bonus, "#")

			if tabletool.len(bonusList) == 3 then
				local bonusCount = bonusList[3]

				if self:getTeachingStatusByTeachingId(teachingConfig.id) == TeachingEnum.TeachingStatus.Rewarded then
					getRewardCount = getRewardCount + bonusCount
				end

				allTeachingRewardCount = allTeachingRewardCount + bonusCount
			end
		end
	end

	return getRewardCount, allTeachingRewardCount
end

function TeachingModel:initPopData()
	local data = PlayerPrefsHelper.getString(PlayerPrefsKey.TeachingPopViewInfo, "")

	if string.nilorempty(data) then
		self._needShowPopInfo = nil
	else
		self._needShowPopInfo = cjson.decode(data)
	end

	local teachingData = PlayerPrefsHelper.getString(PlayerPrefsKey.TeachingShowInfo, "")

	if not string.nilorempty(teachingData) then
		local data = cjson.decode(teachingData)

		for _, id in ipairs(data) do
			self._teachingShowRecord[id] = true
		end
	end

	local teachingAniInfo = PlayerPrefsHelper.getString(PlayerPrefsKey.TeachingAniPlay, "")

	if not string.nilorempty(teachingAniInfo) then
		local data = cjson.decode(teachingAniInfo)

		for _, id in ipairs(data) do
			self._teachingAniPlayInfo[id] = true
		end
	end
end

function TeachingModel:updateTeachingPopData(heroId, teachingId)
	if self._needShowPopInfo == nil then
		self._needShowPopInfo = {
			heroId = heroId,
			teachingId = teachingId
		}
	else
		self._needShowPopInfo.heroId = heroId
		self._needShowPopInfo.teachingId = teachingId
	end

	self:saveData()
end

function TeachingModel:saveData()
	if self._needShowPopInfo == nil then
		return
	end

	local data = cjson.encode(self._needShowPopInfo)

	PlayerPrefsHelper.setString(PlayerPrefsKey.TeachingPopViewInfo, data)
end

function TeachingModel:getTeachingPopData()
	return self._needShowPopInfo
end

function TeachingModel:clearTeachingPopData()
	self._needShowPopInfo = nil

	PlayerPrefsHelper.setString(PlayerPrefsKey.TeachingPopViewInfo, "")
end

function TeachingModel:getTeachingMo()
	return self._teachingMo
end

function TeachingModel:haveCanReceiveRewardTeaching()
	local allTeachingId = self:getAllTeachingId()

	for _, teachingId in ipairs(allTeachingId) do
		if self:getTeachingStatusByTeachingId(teachingId) == TeachingEnum.TeachingStatus.FinishNotReward then
			return true
		end
	end

	return false
end

function TeachingModel:haveNewTeaching()
	local allTeachingId = self:getAllTeachingId()

	for _, teachingId in ipairs(allTeachingId) do
		if self:needShowNew(teachingId) then
			return true
		end
	end

	return false
end

function TeachingModel:needShowNew(teachingId)
	if self._teachingShowRecord and self._teachingShowRecord[teachingId] then
		return false
	end

	return true
end

function TeachingModel:recordShowTeaching(teachingId)
	if self._teachingShowRecord and self._teachingShowRecord[teachingId] then
		return
	end

	self._teachingShowRecord[teachingId] = true

	local tempTable = {}

	for k, _ in pairs(self._teachingShowRecord) do
		table.insert(tempTable, k)
	end

	local data = cjson.encode(tempTable)

	PlayerPrefsHelper.setString(PlayerPrefsKey.TeachingShowInfo, data)
end

function TeachingModel:getNeedOpenView()
	return self._needOpenView
end

function TeachingModel:setNeedOpenView(viewName)
	self._needOpenView = viewName
end

function TeachingModel:needShowFinishAni(teachingId)
	if self._teachingAniPlayInfo and self._teachingAniPlayInfo[teachingId] then
		return false
	end

	return true
end

function TeachingModel:recordShowTeachingAni(teachingId)
	if self._teachingAniPlayInfo and self._teachingAniPlayInfo[teachingId] then
		return
	end

	self._teachingAniPlayInfo[teachingId] = true

	local tempTable = {}

	for k, _ in pairs(self._teachingAniPlayInfo) do
		table.insert(tempTable, k)
	end

	local data = cjson.encode(tempTable)

	PlayerPrefsHelper.setString(PlayerPrefsKey.TeachingAniPlay, data)
end

TeachingModel.instance = TeachingModel.New()

return TeachingModel
