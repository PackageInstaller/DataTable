-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_EndDialogue.lua

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

	UIModule.Close(Constant.UIControllerName.CommonDialogPanel)
	EventDispatcher.Dispatch(EventID.MainUI_ShowHudPanelEvent)

	self.isComplete = true
end

return m
