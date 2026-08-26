-- chunkname: @modules/logic/versionactivity1_2/jiexika/model/Activity114TaskMo.lua

module("modules.logic.versionactivity1_2.jiexika.model.Activity114TaskMo", package.seeall)

local Activity114TaskMo = pureTable("Activity114TaskMo")

function Activity114TaskMo:ctor()
	self.id = 0
	self.config = nil
	self.progress = 0
	self.finishStatus = 0
end

function Activity114TaskMo:update(info)
	if self.id ~= info.taskId or not self.config then
		self.config = Activity114Config.instance:getTaskCoById(Activity114Model.instance.id, info.taskId)
		self.id = info.taskId
	end

	self.progress = info.progress
	self.finishStatus = info.progress < self.config.maxProgress and Activity114Enum.TaskStatu.NoFinish or info.hasGetBonus and Activity114Enum.TaskStatu.GetBonus or Activity114Enum.TaskStatu.Finish
end

return Activity114TaskMo
