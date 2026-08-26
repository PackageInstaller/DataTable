-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyMembersModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyMembersModel", package.seeall)

local OdysseyMembersModel = class("OdysseyMembersModel", BaseModel)

function OdysseyMembersModel:onInit()
	self:reInitData()
end

function OdysseyMembersModel:reInitData()
	self.hasClickReligionIdMap = {}
end

function OdysseyMembersModel:initLocalClueUnlockState()
	self.curClueSaveStrList = {}

	local saveLocalClueStr = OdysseyDungeonController.instance:getPlayerPrefs(OdysseyEnum.LocalSaveKey.ReligionClue, "")

	if not string.nilorempty(saveLocalClueStr) then
		self.curClueSaveStrList = cjson.decode(saveLocalClueStr)
	end
end

function OdysseyMembersModel:setHasClickReglionId(religionId)
	self.hasClickReligionIdMap[religionId] = religionId
end

function OdysseyMembersModel:getHasClickReglionId(religionId)
	return self.hasClickReligionIdMap[religionId]
end

function OdysseyMembersModel:checkReligionMemberCanExpose(religionId)
	local religionCo = OdysseyConfig.instance:getReligionConfig(religionId)
	local clueList = string.splitToNumber(religionCo.clueList, "#")

	for _, clueId in ipairs(clueList) do
		local clueCo = OdysseyConfig.instance:getReligionClueConfig(clueId)
		local unlockConditionStr = clueCo.unlockCondition
		local canUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(unlockConditionStr)

		if not canUnlock then
			return false
		end
	end

	return true
end

function OdysseyMembersModel:saveLocalNewClueUnlockState()
	local religionCoList = OdysseyConfig.instance:getReligionConfigList()

	for _, religionCo in ipairs(religionCoList) do
		local unlockClueIdList = {}
		local hasClick = self.hasClickReligionIdMap[religionCo.id]

		if hasClick then
			unlockClueIdList = self:getCanUnlockClueList(religionCo)

			local saveStr = string.format("%s|%s|%s", religionCo.id, table.concat(unlockClueIdList, "#"), #unlockClueIdList)

			self:removeHasSaveData(religionCo.id)
			table.insert(self.curClueSaveStrList, saveStr)
		end
	end

	OdysseyDungeonController.instance:setPlayerPrefs(OdysseyEnum.LocalSaveKey.ReligionClue, cjson.encode(self.curClueSaveStrList))

	self.hasClickReligionIdMap = {}
end

function OdysseyMembersModel:getCanUnlockClueList(religionCo)
	local unlockClueIdList = {}
	local clueIdList = string.splitToNumber(religionCo.clueList, "#")

	for index, cludId in ipairs(clueIdList) do
		local clueCo = OdysseyConfig.instance:getReligionClueConfig(cludId)
		local unlockConditionStr = clueCo.unlockCondition
		local canUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(unlockConditionStr)

		if canUnlock then
			table.insert(unlockClueIdList, cludId)
		end
	end

	return unlockClueIdList
end

function OdysseyMembersModel:removeHasSaveData(religionId)
	for i = #self.curClueSaveStrList, 1, -1 do
		local hasSaveStrData = string.split(self.curClueSaveStrList[i], "|")

		if tonumber(hasSaveStrData[1]) == religionId then
			table.remove(self.curClueSaveStrList, i)
		end
	end
end

function OdysseyMembersModel:checkHasNewClue(religionId)
	local religionCo = OdysseyConfig.instance:getReligionConfig(religionId)
	local unlockClueIdList = self:getCanUnlockClueList(religionCo)

	for _, saveStr in ipairs(self.curClueSaveStrList) do
		local hasSaveStrData = string.split(saveStr, "|")

		if tonumber(hasSaveStrData[1]) == religionId then
			return #unlockClueIdList > tonumber(hasSaveStrData[3])
		end
	end

	return #unlockClueIdList > 0
end

function OdysseyMembersModel:getNewClueIdList(religionId)
	local newUnlockClueIdList = {}
	local religionCo = OdysseyConfig.instance:getReligionConfig(religionId)
	local unlockClueIdList = self:getCanUnlockClueList(religionCo)

	for _, saveStr in ipairs(self.curClueSaveStrList) do
		local hasSaveStrData = string.split(saveStr, "|")

		if tonumber(hasSaveStrData[1]) == religionId then
			local saveLocalClueIdList = string.splitToNumber(hasSaveStrData[2], "#")

			for _, cludId in ipairs(unlockClueIdList) do
				if not tabletool.indexOf(saveLocalClueIdList, cludId) then
					table.insert(newUnlockClueIdList, cludId)
				end
			end

			return newUnlockClueIdList
		end
	end

	return unlockClueIdList
end

function OdysseyMembersModel:checkCanShowNewDot()
	self:initLocalClueUnlockState()

	local religionCoList = OdysseyConfig.instance:getReligionConfigList()

	for _, religionCo in ipairs(religionCoList) do
		local religionMo = OdysseyModel.instance:getReligionInfoData(religionCo.id)
		local hasNewClue = self:checkHasNewClue(religionCo.id)
		local canExpose = self:checkReligionMemberCanExpose(religionCo.id)

		if not religionMo and (hasNewClue or canExpose) then
			return true
		end
	end

	return false
end

OdysseyMembersModel.instance = OdysseyMembersModel.New()

return OdysseyMembersModel
