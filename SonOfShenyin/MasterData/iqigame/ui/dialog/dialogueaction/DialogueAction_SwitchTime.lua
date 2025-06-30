-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_SwitchTime.lua

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

	WorldMapModule.ChangeMapTimeSpan(self.args.time)
end

return m
