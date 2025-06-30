-- chunkname: @IQIGame\\Net\\NetTaskResponse.lua

function net_quest.commitQuestResult_delegate(code, cids, awards)
	NetCommController.Responded()

	if code == 0 then
		TaskModule.ResponseCommitTaskMsg(cids, awards)
	else
		NoticeModule.ShowServerError(code)
	end

	for i = 1, #cids do
		SDKLoginModule.LogGetTaskReward(cids[i], code == 0 and 1 or 2)
	end
end

function net_quest.notifyAutoCommit(cid, awards)
	TaskModule.ResponseCommitTaskMsg({
		cid
	}, awards)
	SDKLoginModule.LogGetTaskReward(cid, 1)
end

function net_quest.giveUpQuestResult(code, cid)
	TaskModule.ResponseGiveUpTaskMsg(cid)
end

function net_quest.notifyUpdateQuest(updateQuest, isRemove)
	if not LotteryModule.PushUpdateTaskMsgWhenDrawing(updateQuest, isRemove) then
		TaskModule.ResponseUpdateTaskMsg(updateQuest, isRemove)
	end
end

function net_quest.notifyFinishQuestList(cid, remove)
	TaskModule.ResponseUpdateFinishTaskMsg(cid, remove)
end

function net_quest.notifyFailQuestList(cid, remove)
	TaskModule.ResponseUpdateFailTaskMsg(cid, remove)
end

function net_quest.unlockChapterTasksResult(cid, ids)
	MazeChallengeBonusModule.UnlockChapterTasksResult(ids)
end
