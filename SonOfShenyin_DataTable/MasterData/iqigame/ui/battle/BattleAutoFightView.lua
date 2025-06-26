-- chunkname: @IQIGame\\UI\\Battle\\BattleAutoFightView.lua

local BattleAutoFightRoleView = require("IQIGame/UI/Battle/BattleAutoFightRoleView")
local BattleAutoFightView = {}

function BattleAutoFightView.New(view)
	local obj = Clone(BattleAutoFightView)

	obj:__Init(view)

	return obj
end

function BattleAutoFightView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.roleView = BattleAutoFightRoleView.New(self.RoleViewRoot)
end

function BattleAutoFightView:Show()
	self.gameObject:SetActive(true)
	self.roleView:Show()
end

function BattleAutoFightView:Hide()
	self.gameObject:SetActive(false)
	self.roleView:Hide()
end

function BattleAutoFightView:Dispose()
	self.roleView:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return BattleAutoFightView
