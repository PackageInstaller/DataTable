-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/model/DivineKingNuoYaModel.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaModel", package.seeall)

local DivineKingNuoYaModel = class("DivineKingNuoYaModel", BaseModel)

DivineKingNuoYaModel.MaxBuffProgress = 300

function DivineKingNuoYaModel:ctor()
	return
end

function DivineKingNuoYaModel:onInit()
	self:onReset()
end

function DivineKingNuoYaModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._preChanllengeStageIdx = 0
	self._preSelectStageDic = {}
end

function DivineKingNuoYaModel:getInfo(activityId)
	return self._infos[activityId]
end

function DivineKingNuoYaModel:handlePM_DivineKingNoahClgGetInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._infos[msg.activityId] = pb
	self._infos[msg.activityId].stageLists = {}
	self._infos[msg.activityId].banItemPosIds = msg.banItemPosIds or {}

	local stageLists = self._infos[msg.activityId].stageLists

	if pb.stageList then
		for k, stageInfo in pairs(pb.stageList) do
			local stageId = stageInfo.stageId

			stageLists[stageId] = stageInfo
		end
	end
end

function DivineKingNuoYaModel:handlePM_DivineKingNoahClgSetBanItemsRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[msg.activityId]

	info.lightLineCount = msg.lightLineCount
	info.darkLineCount = msg.darkLineCount
	info.banItemPosIds = msg.banItemPosIds or {}

	for i, changeStageInfo in pairs(msg.stageList) do
		local stageId = changeStageInfo.stageId

		if stageId then
			info.stageLists[stageId] = changeStageInfo
		end
	end
end

function DivineKingNuoYaModel:handlePM_DivineKingNoahClgNotifyFightRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[msg.activityId]

	info.lightLineCount = msg.lightLineCount
	info.darkLineCount = msg.darkLineCount

	for i, changeStageInfo in pairs(msg.stageList) do
		local stageId = changeStageInfo.stageId

		if stageId then
			info.stageLists[stageId] = changeStageInfo
		end
	end
end

function DivineKingNuoYaModel:getPassStageNum(activityId)
	local info = self._infos[activityId]
	local passStageNum = 0

	if info then
		local stageList = info.stageLists

		for i, data in pairs(stageList) do
			if data.lineState > 0 then
				passStageNum = passStageNum + 1
			end
		end
	end

	return passStageNum
end

function DivineKingNuoYaModel:getLineCount(activityId)
	local info = self._infos[activityId]

	return info.lightLineCount, info.darkLineCount
end

function DivineKingNuoYaModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = DivineKingNuoYaFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function DivineKingNuoYaModel:setCurSelectStageIdx(activityId, stageId)
	self._preSelectStageDic[activityId] = stageId
end

function DivineKingNuoYaModel:getCurSelectStageIdx(activityId)
	return checknumber(self._preSelectStageDic[activityId])
end

DivineKingNuoYaModel.instance = DivineKingNuoYaModel.New()

return DivineKingNuoYaModel
