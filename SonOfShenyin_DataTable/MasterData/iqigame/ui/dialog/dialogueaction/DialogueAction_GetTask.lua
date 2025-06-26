-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_GetTask.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	TaskSystemModule.ObtainTask(self.args.taskId)
	EventDispatcher.AddEventListener(EventID.CommonDialogControl_Action_GetTask, function(taskId)
		if taskId ~= self.args.taskId then
			return
		end

		self.isComplete = true
	end)
end

function m:OnDestroy()
	EventDispatcher.RemoveEventListenerByType(EventID.CommonDialogControl_Action_GetTask)
end

return m
