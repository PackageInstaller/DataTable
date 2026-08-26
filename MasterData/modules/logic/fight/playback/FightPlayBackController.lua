-- chunkname: @modules/logic/fight/playback/FightPlayBackController.lua

module("modules.logic.fight.playback.FightPlayBackController", package.seeall)

local FightPlayBackController = class("FightPlayBackController")
local RoundOpType = {
	roundOp = 1,
	ClothSkill = 2
}

function FightPlayBackController:startRecordFightData(fightReplyMsg)
	self.roundOpList = self.roundOpList or {}
	self.roundReplyMsgList = self.roundReplyMsgList or {}

	tabletool.clear(self.roundReplyMsgList)
	tabletool.clear(self.roundOpList)

	self.fightReplyMsg = fightReplyMsg
end

function FightPlayBackController:startRecordReconnectFightData(fightReplyMsg)
	self.roundOpList = self.roundOpList or {}
	self.roundReplyMsgList = self.roundReplyMsgList or {}

	tabletool.clear(self.roundReplyMsgList)
	tabletool.clear(self.roundOpList)

	self.fightReplyMsg = fightReplyMsg
end

function FightPlayBackController:recordRoundOp(roundOpList)
	table.insert(self.roundOpList, {
		data = roundOpList,
		type = RoundOpType.roundOp
	})
end

function FightPlayBackController:recordRoundReply(roundReplyMsg)
	table.insert(self.roundReplyMsgList, {
		msg = roundReplyMsg,
		type = RoundOpType.roundOp
	})
end

function FightPlayBackController:recordUseClothSkillRequest(clothSkillId)
	table.insert(self.roundOpList, {
		data = clothSkillId,
		type = RoundOpType.ClothSkill
	})
end

function FightPlayBackController:recordUseClothSkillReply(useSkillReply)
	table.insert(self.roundReplyMsgList, {
		msg = useSkillReply,
		type = RoundOpType.ClothSkill
	})
end

local DIR = SLFramework.FrameworkSettings.PersistentResRootDir .. "/fight_playback/"

function FightPlayBackController:getFullPath(filename)
	return DIR .. filename
end

function FightPlayBackController:writeToFile()
	local filename = self:getFileName()
	local fullPath = self:getFullPath(filename)
	local data = {}
	local chapterId, episodeId, battleId = self:getChapterIdAndEpisodeIdAndBattleId()

	data.chapterId = chapterId
	data.episodeId = episodeId
	data.battleId = battleId
	data.fightReplyMsg = self.fightReplyMsg:SerializeToString()

	self:serializeRoundOpList(data)
	self:serializeMsgList(data)
	SLFramework.FileHelper.EnsureDir(DIR)

	local jsonStr = cjson.encode(data)
	local file = io.open(fullPath, "w")

	if file then
		file:write(jsonStr)
	end

	return fullPath
end

function FightPlayBackController:serializeRoundOpList(data)
	local roundOpList = {}

	data.roundOpList = roundOpList

	for _, roundOp in ipairs(self.roundOpList) do
		local roundOpData = {}

		roundOpData.type = roundOp.type

		if roundOp.type == RoundOpType.roundOp then
			roundOpData.data = {}

			for _, opData in ipairs(roundOp.data) do
				local roundOpDataItem = {}

				roundOpDataItem.operType = opData.operType
				roundOpDataItem.toId = opData.toId
				roundOpDataItem.param1 = opData.param1
				roundOpDataItem.param2 = opData.param2
				roundOpDataItem.param3 = opData.param3

				table.insert(roundOpData.data, roundOpDataItem)
			end
		else
			roundOpData.data = roundOp.data
		end

		table.insert(roundOpList, roundOpData)
	end
end

function FightPlayBackController:serializeMsgList(data)
	local msgDataList = {}

	data.msgReplayList = msgDataList

	for _, msgReplayData in ipairs(self.roundReplyMsgList) do
		local msgData = {}

		table.insert(msgDataList, msgData)

		msgData.type = msgReplayData.type
		msgData.data = msgReplayData.msg:SerializeToString()
	end
end

function FightPlayBackController:getFileName()
	local time = os.time()
	local date = os.date("*t", time)
	local chapterId, episodeId, battleId = self:getChapterIdAndEpisodeIdAndBattleId()

	return (string.format("%d_%d_%d_%d_%d_%d__%s_%s_%s.json", date.year, date.month, date.day, date.hour, date.min, date.sec, chapterId, episodeId, battleId))
end

function FightPlayBackController:getChapterIdAndEpisodeIdAndBattleId()
	local episodeId = self.fightReplyMsg.fight.episodeId
	local battleId = self.fightReplyMsg.fight.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	return episodeCo and episodeCo.chapterId, episodeId, battleId
end

function FightPlayBackController:playPlayback(filename)
	if string.nilorempty(filename) then
		return
	end

	if self.playbackItem then
		ToastController:showToastWithString("已经存在一个回放了")

		return
	end

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Fight then
		ToastController:showToastWithString("正在战斗中")

		return
	end

	local fullPath = self:getFullPath(filename)

	self.playbackItem = FightPlayBackItem.New()

	self.playbackItem:init(fullPath)
	self.playbackItem:startPlay()
end

function FightPlayBackController:deletePlaybackFile(filename)
	if string.nilorempty(filename) then
		return
	end

	local fullPath = self:getFullPath(filename)

	SLFramework.FileHelper.DeleteFile(fullPath)
end

function FightPlayBackController:sendPlaybackFile(filename)
	if string.nilorempty(filename) then
		return
	end
end

function FightPlayBackController:getPlaybackList()
	local fileList = SLFramework.FileHelper.GetDirFilePaths(DIR, false)

	if not fileList then
		return {}
	end

	local preLen = #DIR + 1

	fileList = fileList:ToTable()

	for i, file in ipairs(fileList) do
		fileList[i] = file:sub(preLen)
	end

	return fileList
end

FightPlayBackController.instance = FightPlayBackController.New()

return FightPlayBackController
