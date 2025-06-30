-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_EnterRoom.lua

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

	WorldMapModule.EnterRoom(self.args.roomId, true, self.args.playerPos and WorldMapModule.PackingEnterRoomData(self.args.playerPos) or "")

	local actionData = WorldMapModule.GetComponentActionDataWithId(self.args.triggerActionId)

	EventDispatcher.AddEventListener(EventID.WorldMapRGP_EnterRoomCompleteEvent, function()
		self.isComplete = true

		if self.args.triggerActionId and self.args.triggerActionId ~= 0 then
			WorldMapModule.RPGActionTrigger(actionData:GetCfg().ActionType, actionData:GetCfg().ActionParam)
		end
	end)
end

function m:OnDestroy()
	EventDispatcher.RemoveEventListenerByType(EventID.WorldMapRGP_EnterRoomCompleteEvent)
end

return m
