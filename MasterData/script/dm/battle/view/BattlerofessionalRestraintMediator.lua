-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattlerofessionalRestraintMediator.lua

local kBtnHandlers = {}

BattlerofessionalRestraintMediator = class("BattlerofessionalRestraintMediator", PopupViewMediator, _M)

function BattlerofessionalRestraintMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function BattlerofessionalRestraintMediator:onTouchMaskLayer()
	self:close()
end
