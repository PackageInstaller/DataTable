-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ActorMove.lua

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

	local actor = HomeModule.GetRoomComponentWithId(self.args.actorId)

	if not actor then
		logError("【RPG】没有找到角色id = " .. self.args.actorId)

		return
	end

	self.actor = actor

	actor.controller.autoMoveController:SetWalkingAnimateName(self.args.animationName)
	actor.controller.autoMoveController:SetSpeed(self.args.moveSpeed)
	actor:StartMove(self.args.endPos, function()
		self.isComplete = true
	end)

	self.lastPos = self.actor.transform.position
	self.startTime = Time.time
end

function m:OnUpdate()
	if self.isComplete then
		return
	end

	if self.actor == nil then
		return
	end

	if self.actor.transform == nil then
		return
	end

	if Time.time - self.startTime > 1 and Vector3.Distance(self.actor.transform.position, self.lastPos) <= 0.01 then
		self.actor.controller.autoMoveController:StopAutoMove()

		self.actor.transform.position = self.args.endPos
		self.isComplete = true
	end
end

function m:OnSkip()
	self.actor:StopMove()

	self.actor.transform.position = self.args.endPos
	self.isComplete = true
end

return m
