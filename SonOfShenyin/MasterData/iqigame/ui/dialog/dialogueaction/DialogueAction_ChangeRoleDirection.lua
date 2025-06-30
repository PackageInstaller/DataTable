-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ChangeRoleDirection.lua

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

	local actor = HomeModule.GetRoomComponentWithId(self.args.roleId)

	if not actor then
		logError("【RPG】设置角色方向失败，没有找到角色 id =" .. self.args.roleId)

		return
	end

	actor:ChangeDirection(self.args.direction)

	self.isComplete = true
end

return m
