-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/model/HuiDiaoLanModel.lua

module("modules.logic.versionactivity3_2.huidiaolan.model.HuiDiaoLanModel", package.seeall)

local HuiDiaoLanModel = class("HuiDiaoLanModel", BaseModel)

function HuiDiaoLanModel:onInit()
	return
end

function HuiDiaoLanModel:reInit()
	self.curEpisodeId = 0
	self.unFinishEpisodeIdList = {}
	self.newUnlockEpisodeInfoList = {}
	self.activityId = VersionActivity3_2Enum.ActivityId.HuiDiaoLan
	self.episodeInfoMap = {}
end

function HuiDiaoLanModel:initEpisodeInfo(episodeInfos)
	self.episodeInfoMap = {}
	self.unFinishEpisodeIdList = {}

	for _, infoData in ipairs(episodeInfos) do
		local episodeInfo = self:buildEpisodeInfo(infoData)

		if not episodeInfo.isFinished then
			table.insert(self.unFinishEpisodeIdList, infoData.episodeId)
		end
	end
end

function HuiDiaoLanModel:buildEpisodeInfo(infoData)
	local episodeInfo = self.episodeInfoMap[infoData.episodeId]

	if not episodeInfo then
		episodeInfo = {
			episodeId = infoData.episodeId,
			isFinished = infoData.isFinished,
			unlockBranchIds = {}
		}

		for _, unlockBranchId in ipairs(infoData.unlockBranchIds) do
			table.insert(episodeInfo.unlockBranchIds, unlockBranchId)
		end

		episodeInfo.progress = infoData.progress
		self.episodeInfoMap[infoData.episodeId] = episodeInfo
	end

	return episodeInfo
end

function HuiDiaoLanModel:updateEpisodeFinishState(episodeId)
	local episodeInfo = self.episodeInfoMap[episodeId]

	if episodeInfo then
		episodeInfo.isFinished = true

		HuiDiaoLanGameModel.instance:setWinState(episodeId, true)
	end

	self:updateUnFinishEpisodeList()
end

function HuiDiaoLanModel:setNewUnlockEpisodeInfoList(episodeInfos)
	self.newUnlockEpisodeInfoList = {}

	for _, infoData in ipairs(episodeInfos) do
		local episodeInfo = self:buildEpisodeInfo(infoData)

		table.insert(self.newUnlockEpisodeInfoList, episodeInfo)
	end

	self:updateUnFinishEpisodeList()
end

function HuiDiaoLanModel:updateUnFinishEpisodeList()
	self.unFinishEpisodeIdList = {}

	for episdoeId, episodeInfo in pairs(self.episodeInfoMap) do
		if not episodeInfo.isFinished then
			table.insert(self.unFinishEpisodeIdList, episodeInfo.episodeId)
		end
	end
end

function HuiDiaoLanModel:getNewUnlockEpisodeInfoList()
	return self.newUnlockEpisodeInfoList
end

function HuiDiaoLanModel:cleanNewUnlockEpisodeInfoList()
	self.newUnlockEpisodeInfoList = {}
end

function HuiDiaoLanModel:setCurEpisodeId(episodeId)
	self.curEpisodeId = episodeId
end

function HuiDiaoLanModel:getCurEpisodeId()
	return self.curEpisodeId
end

function HuiDiaoLanModel:getInitEpisodeId()
	local episodeConfigList = HuiDiaoLanConfig.instance:getAllEpisodeConfigList()

	for index, episodeCo in ipairs(episodeConfigList) do
		local preEpisodeId = episodeCo.preEpisodeId
		local episodeInfo = self.episodeInfoMap[episodeCo.episodeId]

		if episodeInfo and not episodeInfo.isFinished and preEpisodeId > 0 then
			local isPreFinish = self.episodeInfoMap[preEpisodeId].isFinished

			if not isPreFinish then
				self.curEpisodeId = preEpisodeId

				return self.curEpisodeId
			else
				self.curEpisodeId = episodeCo.episodeId

				return self.curEpisodeId
			end
		elseif episodeInfo and not episodeInfo.isFinished and preEpisodeId == 0 then
			self.curEpisodeId = episodeCo.episodeId

			return self.curEpisodeId
		end
	end

	self.curEpisodeId = episodeConfigList[#episodeConfigList].episodeId

	return self.curEpisodeId
end

function HuiDiaoLanModel:getEpisodeFinishState(episodeId)
	local episodeInfo = self.episodeInfoMap[episodeId]

	return episodeInfo and episodeInfo.isFinished
end

function HuiDiaoLanModel:getEpisodeInfo(episodeId)
	return self.episodeInfoMap[episodeId]
end

HuiDiaoLanModel.instance = HuiDiaoLanModel.New()

return HuiDiaoLanModel
