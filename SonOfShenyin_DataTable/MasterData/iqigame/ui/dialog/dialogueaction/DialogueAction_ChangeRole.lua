-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ChangeRole.lua

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

	local home = HomeModule.GetCurrentHomeRoom()

	home:ChangeRole(self.args.actorId, self.args.skinId)

	self.isComplete = true
end

return m
