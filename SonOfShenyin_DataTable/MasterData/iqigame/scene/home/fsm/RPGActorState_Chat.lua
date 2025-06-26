-- chunkname: @IQIGame\\Scene\\Home\\FSM\\RPGActorState_Chat.lua

local m = class(nil, FSMState)

m.Name = Constant.RPGActorFSMState.Chat

function m:OnEnter(args)
	self.args = args

	if not self.args.isFilterPos then
		EventDispatcher.Dispatch(EventID.MainUI_ShowDialogEvent, self.args.actor:GetComponentId(), self.args.dialogId)
		EventDispatcher.Dispatch(EventID.MainUI_HideHudPanelEvent)

		return
	end

	local playerActor = HomeModule.GetPlayer()

	playerActor:Idle()
	playerActor.controller.autoMoveController:FacingTarget(self.args.actor.transform.position)
	self.args.actor:StopMove()
	self.args.actor.controller.autoMoveController:FacingTarget(playerActor.transform.position)
	self.args.actor:Idle()
	EventDispatcher.Dispatch(EventID.MainUI_ShowDialogEvent, self.args.actor:GetComponentId(), self.args.dialogId)
	EventDispatcher.Dispatch(EventID.MainUI_HideHudPanelEvent)
end

function m:OnUpdate(deltaTime)
	if self.isMoveEnd then
		local playerActor = HomeModule.GetPlayer()

		playerActor:StopMove()
		playerActor.controller.autoMoveController:FacingTarget(self.args.actor.transform.position)
		self.args.actor.controller.autoMoveController:FacingTarget(playerActor.transform.position)
		EventDispatcher.Dispatch(EventID.MainUI_ShowDialogEvent, self.args.actor:GetComponentId(), self.args.dialogId)

		self.isMoveEnd = false
	end
end

function m:OnExit()
	if self.args.isFilterPos then
		self.args.actor:StopMove()
	end
end

return m
