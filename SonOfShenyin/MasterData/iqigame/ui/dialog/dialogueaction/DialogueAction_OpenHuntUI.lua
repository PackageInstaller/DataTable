-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_OpenHuntUI.lua

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

	UIModule.Open(Constant.UIControllerName.WorldDailyHuntUI, Constant.UILayer.UI)

	self.isComplete = true
end

return m
