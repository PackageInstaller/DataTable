-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_RefreshRoomActor.lua

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

	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	room:RefreshAllComponent()
end

function m:OnUpdate()
	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	if not room:ValidateComCreateComplete() then
		return
	end

	self.isComplete = true
end

function m:OnSkip()
	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	if not room:ValidateComCreateComplete() then
		return
	end

	self.isComplete = true
end

return m
