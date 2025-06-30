-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_OpenBox.lua

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

	local actionData = WorldMapModule.GetComponentActionDataWithId(self.args.actionCid)

	self.box = HomeModule.GetRoomComponentWithId(actionData.compCid)

	if not self.box then
		logError("【RPG】开启宝箱错误，没有找到目标组件id = " .. actionData.compCid)

		return
	end

	self.box:PlayAnimation("open", false)

	self.isCheckOpenAni = true
	self.dStartTime = Time.time

	EventDispatcher.Dispatch(EventID.MainUI_SetJoyStickViewEnabledEvent, false)
end

function m:OnUpdate()
	if self.isComplete then
		return
	end

	if self.isCheckOpenAni then
		self:_CheckOpenAni()
	end
end

function m:_CheckOpenAni()
	if Time.time - self.dStartTime >= 2 then
		net_sceneMap.triggerAction(self.args.actionCid, WorldMapModule.GetActionScheduleWithType(Constant.CommonDialogActionType.OpenBox), "")

		self.isCheckOpenAni = false
		self.isComplete = true

		EventDispatcher.Dispatch(EventID.MainUI_SetJoyStickViewEnabledEvent, true)
	end
end

return m
