-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetPve.lua

module("logic.extensions.task.model.target.TaskTargetPve", package.seeall)

local TaskTargetPve = class("TaskTargetPve", TaskTargetBase)

function TaskTargetPve:getBattleResultPerformed()
	if BattleFacade.instance:getLastBattleResult() == GameEnum.BattleResult.Failed then
		if self.target.failedStoryId and self.target.failedStoryId > 0 and not self.battleFailedPerformed then
			self.battleFailedPerformed = {
				performedType = TaskConst.PERFORMED_BATTLERELTFAILED,
				method = TaskConst.PM_STORY
			}
			self.battleFailedPerformed.storyId = self.target.failedStoryId
			self.battleFailedPerformed.taskStep = self.taskStep
			self.battleFailedPerformed.target = self
		end

		return self.battleFailedPerformed
	elseif BattleFacade.instance:getLastBattleResult() == GameEnum.BattleResult.Success or BattleFacade.instance:getLastBattleResult() == GameEnum.BattleResult.ExpSuccess then
		if self.target.successStoryId and self.target.successStoryId > 0 and not self.battleSuccPerformed then
			self.battleSuccPerformed = {
				performedType = TaskConst.PERFORMED_BATTLERELTSUCCESS,
				method = TaskConst.PM_STORY
			}
			self.battleSuccPerformed.storyId = self.target.successStoryId
			self.battleSuccPerformed.taskStep = self.taskStep
			self.battleSuccPerformed.target = self
		end

		return self.battleSuccPerformed
	end
end

return TaskTargetPve
