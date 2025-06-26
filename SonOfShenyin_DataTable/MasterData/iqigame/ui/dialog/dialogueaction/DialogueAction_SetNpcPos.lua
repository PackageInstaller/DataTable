-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_SetNpcPos.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	local actor = HomeModule.GetRoomComponentWithId(self.args.roleId)

	if not actor then
		logError(string.format("【RPG】设置角色位置行为失败，没有找到角色 id = %s", self.args.roleId))

		return
	end

	LuaUtility.SetTransformWithGameObject(actor:GetRootGameObject(), self.args.pos)

	self.isComplete = true
end

return m
