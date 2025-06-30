-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_SetHudOpen.lua

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

	if self.args.open == 0 then
		EventDispatcher.Dispatch(EventID.MainUI_HideHudPanelEvent)
	elseif self.args.open == 1 then
		EventDispatcher.Dispatch(EventID.MainUI_ShowHudPanelEvent)
	else
		logError("【RPG】设置hud显示行为没有类型 = " .. self.args.open)
	end

	self.isComplete = true
end

return m
