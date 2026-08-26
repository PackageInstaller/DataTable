-- chunkname: @modules/logic/gm/controller/sequencework/SendFightLogWork.lua

module("modules.logic.gm.controller.sequencework.SendFightLogWork", package.seeall)

local SendFightLogWork = class("SendFightLogWork", BaseWork)
local combine = System.IO.Path.Combine

SendFightLogWork.logDirName = "fightLog"
SendFightLogWork.logDirPath = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, SendFightLogWork.logDirName)

function SendFightLogWork:ctor(roundIndex, originRoundData)
	self.roundIndex = roundIndex
	self.originRoundData = originRoundData
end

function SendFightLogWork:onStart(context)
	local var_2_0

	if context then
		var_2_0 = context.chapterId or 0

		local var_2_1

		if context then
			var_2_1 = context.episodeId or 0

			local var_2_2

			if context then
				var_2_2 = context.battleId or 0
			end
		end
	end

	self.logFileName = string.format("章节Id_%s_关卡Id_%s_战斗Id_%s_回合数_%s.txt", var_2_0, var_2_1, var_2_2, self.roundIndex)

	local fullPath = combine(SendFightLogWork.logDirPath, self.logFileName)
	local log = FightLogProtobufHelper.getFightRoundString(self.originRoundData)

	SLFramework.FileHelper.WriteTextToPath(fullPath, log)
	logWarn(string.format("写入文件 '%s' 成功, 开始发送文件", self.logFileName))
	SendWeWorkFileHelper.SendFile(fullPath, self.onSendFileDone, self)
end

function SendFightLogWork:onSendFileDone(success)
	if self.status ~= WorkStatus.Running then
		return
	end

	logWarn(string.format("发送文件 '%s' %s", self.logFileName, success and "成功" or "失败"))
	self:onDone(true)
end

function SendFightLogWork:clearWork()
	return
end

return SendFightLogWork
