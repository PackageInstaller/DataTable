-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/model/ElementSparkModel.lua

module("logic.extensions.elementspark.model.ElementSparkModel", package.seeall)

local ElementSparkModel = class("ElementSparkModel", BaseModel)

function ElementSparkModel:ctor()
	return
end

function ElementSparkModel:onInit()
	self:onReset()
end

function ElementSparkModel:onReset()
	self.stageType = -1
	self.isSignUp = false
	self.sparkChunkId = 0
	self.petShopChunkId = 0
	self.petshopScore = 0
	self.power = 0
	self.board = ""
	self.info = {}
	self.campInfo = {}
	self.commanderInfo = {}
	self.mapInfo = {}
	self._tagInfo = {}
	self.commandInfo = {}
	self.lastestCommand = nil
	self.campRankInfo = {}
	self.personRankInfo = {}
	self.resourceInfo = {}
	self.myFormsInfo = {}
	self.forms = {}
	self.otherGuardInfo = {}
	self.guardInfo = {}
	self.selectTeamId = 1
	self._elementSparkFmtMo = nil
	self._isTagMode = nil
	self._sparkInfo = nil
	self._buyItemIds = {}
	self._defenseChunkId2TeamId = {}
	self._myCampChunkId = -1
	self._campChunkInfos = {}
end

function ElementSparkModel:setStageType(type)
	self.stageType = type
end

function ElementSparkModel:getStageType()
	return self.stageType
end

function ElementSparkModel:setSparkChunkId(id)
	self.sparkChunkId = id
end

function ElementSparkModel:getSparkChunkId()
	return self.sparkChunkId
end

function ElementSparkModel:setPetShopId(id)
	self.petShopChunkId = id
end

function ElementSparkModel:getPetShopChunkId()
	return self.petShopChunkId
end

function ElementSparkModel:setRegisterInfo(register)
	self.isSignUp = register
end

function ElementSparkModel:getRegisterInfo()
	return self.isSignUp
end

function ElementSparkModel:setInfo(msg)
	self.info = {}

	GameUtil.pbToTable(msg, self.info)
	self:setMapInfo(self.info.mapInfo)
	self:setPetShopScore(self.info.petShopScore)
	self:_setBuyItems()
	self:setPowerValue(self.info.minDefenseFormZdl or 0)

	if self.info.latestCommand then
		self:setLastestCommand(self.info.latestCommand.command)
	end

	self:setMyFormsInfo(msg.myForms)
	self:_setMyCampChunkId()

	self._firstOpenInfo = self.info.firstOpenInfo

	ElementSparkController.instance:setPetShopChunkId()
end

function ElementSparkModel:getInfo()
	return self.info
end

function ElementSparkModel:getFristOpenInfo()
	return self._firstOpenInfo
end

function ElementSparkModel:clearFirstOpenInfo()
	self._firstOpenInfo = nil
end

function ElementSparkModel:getMyCampId()
	return self.info.campId or 0
end

function ElementSparkModel:getWinnerCampId()
	return self.info.winnerCampId or 0
end

function ElementSparkModel:getPetShopScore()
	return self.petshopScore or 0
end

function ElementSparkModel:setPetShopScore(petShopScore)
	self.petshopScore = petShopScore
end

function ElementSparkModel:setCampScore(score)
	if self.info then
		self.info.campScore = score
	end
end

function ElementSparkModel:addCampScore(addScore)
	if self.info then
		addScore = addScore or 0
		self.info.campScore = self.info.campScore + addScore
	end
end

function ElementSparkModel:_setBuyItems()
	self._buyItemIds = {}

	if self.info.buyItemIds then
		for i, v in ipairs(self.info.buyItemIds) do
			table.insert(self._buyItemIds, v)
		end
	end
end

function ElementSparkModel:getPetShopItems()
	return self._buyItemIds
end

function ElementSparkModel:addPetShopItem(itemId)
	if not table.indexof(self._buyItemIds, itemId) then
		table.insert(self._buyItemIds, itemId)
	end
end

function ElementSparkModel:setCampInfo(msg)
	GameUtil.pbToTable(msg, self.campInfo)
	self:setCommanderInfo()
	self:setBoardInfo(self.campInfo.board)
	self:setPowerValue(self.campInfo.minDefenseFormZdl)
	self:setCommandsInfo(self.campInfo.commands)
end

function ElementSparkModel:getCampInfo()
	return self.campInfo or {}
end

function ElementSparkModel:setCommanderInfo()
	self.commanderInfo = self.campInfo.commanderHeadInfos
end

function ElementSparkModel:getCommanderInfo()
	return self.commanderInfo or {}
end

function ElementSparkModel:setBoardInfo(desc)
	self.board = desc
end

function ElementSparkModel:getBoardInfo()
	if string.nilorempty(self.board) then
		return "欢迎来到龙裔争夺战"
	end

	return self.board
end

function ElementSparkModel:setPowerValue(value)
	self.power = value
end

function ElementSparkModel:getPowerValue()
	return self.power or 0
end

function ElementSparkModel:setCommandsInfo(commands)
	self.commandInfo = {}

	for _, v in ipairs(commands or {}) do
		table.insert(self.commandInfo, v)
	end

	table.sort(self.commandInfo, function(a, b)
		return a.commandTimeMillis > b.commandTimeMillis
	end)
end

function ElementSparkModel:addCommands(command)
	local newData = {}
	local oriData = self.commandInfo

	table.insert(newData, command)
	TableUtil.AddTable(newData, oriData)

	self.commandInfo = newData

	return newData
end

function ElementSparkModel:getCommands()
	return self.commandInfo or {}
end

function ElementSparkModel:setLastestCommand(command)
	if command ~= nil then
		self.lastestCommand = command
	end
end

function ElementSparkModel:getLastestCommand()
	return self.lastestCommand or "指挥官暂未发布指令"
end

function ElementSparkModel:setMapInfo(mapInfo)
	for _, v in ipairs(mapInfo.chunks) do
		self.mapInfo[v.chunkId] = v
	end

	local myCampLayerInfo = mapInfo.myCampLayerInfo

	self._campChunkInfos = {}

	if myCampLayerInfo then
		for _, v in ipairs(myCampLayerInfo.tags or {}) do
			self:addTag(v)
		end

		local minRefreshMsTime = -1

		for i, v in ipairs(myCampLayerInfo.campChunkInfos or {}) do
			self._campChunkInfos[v.chunkId] = v

			local targetTime = checknumber(v.beAttackSignEndTimeMillis)

			if minRefreshMsTime == -1 or targetTime < minRefreshMsTime then
				minRefreshMsTime = targetTime
			end
		end

		local nowMs = ServerTime.nowMs()

		if minRefreshMsTime > 0 and nowMs < minRefreshMsTime then
			ElementSparkController.instance:delayRefreshMap(minRefreshMsTime)
		end
	end
end

function ElementSparkModel:isBeAttack(chunkId)
	local info = self._campChunkInfos[chunkId]

	if not info then
		return false
	end

	return ServerTime.nowMs() < checknumber(info.beAttackSignEndTimeMillis)
end

function ElementSparkModel:addTag(sparkTag)
	self._tagInfo[sparkTag.tagId] = sparkTag
end

function ElementSparkModel:getTagUseNum()
	local count = 0

	for k, v in pairs(self._tagInfo or {}) do
		if v.signId > 0 then
			count = count + 1
		end
	end

	return count
end

function ElementSparkModel:getTagInfo(chunkId)
	for k, v in pairs(self._tagInfo) do
		if v.chunkId == chunkId then
			return v
		end
	end

	return nil
end

function ElementSparkModel:getMapInfo()
	return self.mapInfo or {}
end

function ElementSparkModel:getChunkBelong(chunkId)
	if self.mapInfo[chunkId] then
		return self.mapInfo[chunkId].campBelong
	end

	return -1
end

function ElementSparkModel:setChunkBelong(chunkId, campId)
	if self.mapInfo[chunkId] then
		self.mapInfo[chunkId].campBelong = campId
	end
end

function ElementSparkModel:getChunkLevel(chunkId)
	if self.mapInfo[chunkId] then
		return self.mapInfo[chunkId].level or 0
	end

	return -1
end

function ElementSparkModel:getChunkInProtect(chunkId)
	if self.mapInfo[chunkId] then
		return ServerTime.now() <= self:getGuardProtectTime(chunkId)
	end

	return false
end

function ElementSparkModel:getGuardProtectTime(chunkId)
	if self.mapInfo[chunkId] then
		return math.ceil(checknumber(self.mapInfo[chunkId].guardProtectTimeMillis) / 1000)
	end

	return 0
end

function ElementSparkModel:getChunlBelongMe(chunkId)
	local value = self:getChunkBelong(chunkId)

	return value == self:getMyCampId()
end

function ElementSparkModel:setResourceInfo(msg)
	self.resourceInfo = {}

	GameUtil.pbToTable(msg.chunks, self.resourceInfo)
end

function ElementSparkModel:getResourceInfo()
	return self.resourceInfo or {}
end

function ElementSparkModel:setMyFormsInfo(msg)
	self.myFormsInfo = {}

	GameUtil.pbToTable(msg, self.myFormsInfo)

	self.forms = ElementSparkController.instance:setForms()
	self._defenseChunkId2TeamId = ElementSparkController.instance:getDefenseChunkId2TeamId()
end

function ElementSparkModel:defenseGuardChange(msg)
	if self.myFormsInfo.defenseForms then
		for i, v in ipairs(self.myFormsInfo.defenseForms) do
			v.defenseChunkId = msg.defenseChunkId
			v.defenseChunkMillis = msg.defenseChunkMillis
			v.canRevoke = msg.canRevoke

			break
		end
	end

	self.forms = ElementSparkController.instance:setForms()
	self._defenseChunkId2TeamId = ElementSparkController.instance:getDefenseChunkId2TeamId()
end

function ElementSparkModel:getMyFormInfo()
	return self.myFormsInfo
end

function ElementSparkModel:getForm()
	return self.forms
end

function ElementSparkModel:getDefenseChunkId2TeamId()
	return self._defenseChunkId2TeamId
end

function ElementSparkModel:setSelectTeamId(teamId)
	self.selectTeamId = teamId
end

function ElementSparkModel:getSelectTeamId()
	return self.selectTeamId
end

function ElementSparkModel:getChallengeFmtMo(activityId, teamId, isSetTeam, chunkId, challengeType)
	if self._elementSparkFmtMo == nil then
		self._elementSparkFmtMo = ElementSparkFmtMo.New()
	end

	return self._elementSparkFmtMo
end

function ElementSparkModel:setOtherGuardInfo(msg)
	self.otherGuardInfo = {}

	GameUtil.pbToTable(msg, self.otherGuardInfo)
end

function ElementSparkModel:getOtherGuardInfo()
	return self.otherGuardInfo or {}
end

function ElementSparkModel:setGuardInfo(msg)
	self.guardInfo = {}

	GameUtil.pbToTable(msg, self.guardInfo)
end

function ElementSparkModel:getGuardInfo()
	return self.guardInfo or {}
end

function ElementSparkModel:getGuardBossInfo()
	return self.guardInfo.bossInfo or {}
end

function ElementSparkModel:setCampRankInfo(msg)
	self.campRankInfo = {}

	GameUtil.pbToTable(msg.campRankInfos, self.campRankInfo)
end

function ElementSparkModel:getCampRankInfo()
	return self.campRankInfo or {}
end

function ElementSparkModel:setPersonRankInfo(msg)
	self.personRankInfo = {}

	GameUtil.pbToTable(msg, self.personRankInfo)
end

function ElementSparkModel:getPersonRankInfo()
	return self.personRankInfo
end

function ElementSparkModel:getSparkBelong()
	return self:getChunkBelong(self:getSparkChunkId())
end

function ElementSparkModel:addPersonScore(addScore)
	if self.info then
		addScore = addScore or 0
		self.info.personScore = self.info.personScore + addScore
	end
end

function ElementSparkModel:changeTeamStrength(teamStrength)
	if not teamStrength then
		return
	end

	local forms = ElementSparkModel.instance:getMyFormInfo()

	if not forms.attackForms then
		if #forms.attackForms > 0 then
			for i, v in ipairs(forms.attackForms) do
				if v.teamStrength.teamId == teamStrength.teamId then
					v.teamStrength.strength = teamStrength.strength
					v.teamStrength.lastRefreshTimeMillis = teamStrength.lastRefreshTimeMillis

					break
				end
			end
		end
	end
end

function ElementSparkModel:isTagMode()
	return self._isTagMode
end

function ElementSparkModel:setTagMode(flag)
	self._isTagMode = flag
end

function ElementSparkModel:setSparkInfo(info)
	self._sparkInfo = info
end

function ElementSparkModel:getSparkInfo()
	return self._sparkInfo
end

function ElementSparkModel:isCommander()
	if self.info then
		return self.info.isCommander
	end

	return false
end

function ElementSparkModel:_setMyCampChunkId()
	self._myCampChunkId = -1

	local campId = self:getMyCampId()

	if campId > 0 then
		local planId = ElementSparkController.instance:getMapPlanId()
		local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)

		for k, v in pairs(chunkCfgs) do
			if v.chunkType == GameEnum.ElementSparkChunkType.Camp and v.initCamp == campId then
				self._myCampChunkId = v.chunkId

				break
			end
		end
	end
end

function ElementSparkModel:getMyCampChunkId()
	return self._myCampChunkId
end

ElementSparkModel.instance = ElementSparkModel.New()

return ElementSparkModel
