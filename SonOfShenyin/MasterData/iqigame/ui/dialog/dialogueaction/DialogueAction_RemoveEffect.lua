-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_RemoveEffect.lua

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

	CommonDialogueActionUtil.RemoveEffect(self.args.roleId, self.args.effectId)

	self.isComplete = true
end

return m
