-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ShowDialogue.lua

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

	local actorData = CommonDialogueActionUtil.GetActorDataWithCfgType(self.args.cfgType, self.args.roleId)

	if not actorData then
		logError("【RPG】DialogueAction_ShowDialogue 没有找到角色数据 id =" .. self.args.roleId)

		return
	end

	local params = {}

	params.mountPoint = actorData.mountPoint
	params.nameString = actorData.nameString
	params.dialogueId = self.args.dialogId
	params.cfgType = self.args.cfgType
	params.roleId = self.args.roleId

	self.args.dialogueController:ShowDialog(params)
	EventDispatcher.Dispatch(EventID.MainUI_HideHudPanelEvent)

	self.isComplete = true
end

function m:OnSkip()
	return
end

return m
