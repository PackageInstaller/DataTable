-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerPartnerSelectMediator.lua

TowerPartnerSelectMediator = class("TowerPartnerSelectMediator", DmPopupViewMediator, _M)

TowerPartnerSelectMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")
TowerPartnerSelectMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TowerPartnerSelectMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function TowerPartnerSelectMediator:initialize()
	super.initialize(self)
end

function TowerPartnerSelectMediator:dispose()
	super.dispose(self)
end

function TowerPartnerSelectMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TowerPartnerSelectMediator:onRemove()
	super.onRemove(self)
end

function TowerPartnerSelectMediator:enterWithData(data)
	self._data = data

	self:initWidget()
	self:refreshView()
	self:setupClickEnvs()
end

function TowerPartnerSelectMediator:initWidget()
	return
end

function TowerPartnerSelectMediator:refreshView()
	return
end

function TowerPartnerSelectMediator:onTouchLayout(sender, eventType)
	return
end

function TowerPartnerSelectMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_TowerPartnerSelectMediator")
	end))

	self:getView():runAction(sequence)
end
