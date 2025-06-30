-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_WorldMapComponentActionEnd.lua

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

	EventDispatcher.AddEventListener(EventID.CommonDialogControl_Action_EndDialog, function(actionId)
		if actionId ~= self.args.actionId then
			return
		end

		self.isComplete = true
	end)
	WorldMapModule.TriggerAction(self.args.actionId, 0)
end

function m:OnDestroy()
	EventDispatcher.RemoveEventListenerByType(EventID.CommonDialogControl_Action_EndDialog)
end

return m
