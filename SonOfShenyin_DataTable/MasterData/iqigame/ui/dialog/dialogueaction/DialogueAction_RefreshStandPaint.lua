-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_RefreshStandPaint.lua

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

	local path = CfgUtil.GetStoryResourceWithID(self.args.resourceId)

	EventDispatcher.Dispatch(EventID.CommonDialogPanel_RefreshStandPaint, path)

	self.isComplete = true
end

return m
