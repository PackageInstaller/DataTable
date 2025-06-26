-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_CreateRole.lua

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

	WorldMapModule.TriggerAction(self.args.actionId, 0)
	EventDispatcher.AddEventListener(EventID.CommonDialogControl_Action_CreateRole, function(cid)
		if self.args.roleId ~= cid then
			return
		end

		self.isComplete = true
	end)
end

function m:OnDestroy()
	EventDispatcher.RemoveEventListenerByType(EventID.CommonDialogControl_Action_CreateRole)
end

return m
