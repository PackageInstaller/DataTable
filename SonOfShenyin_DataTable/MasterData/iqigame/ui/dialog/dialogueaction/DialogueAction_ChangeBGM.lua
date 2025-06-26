-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ChangeBGM.lua

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

	HomeModule.ChangeRoomBGM(self.args.soundId)

	self.isComplete = true
end

return m
