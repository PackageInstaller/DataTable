-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ShowLocationInfo.lua

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

	EventDispatcher.Dispatch(EventID.MainUI_HudPanel_SetLocationInfoEvent, CfgUtil.GetCfgStoryTextDataWithID(self.args.timeId), CfgUtil.GetCfgStoryTextDataWithID(self.args.mainSiteId), CfgUtil.GetCfgStoryTextDataWithID(self.args.branchSiteId))

	self.isComplete = true
end

return m
