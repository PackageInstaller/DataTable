-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardPackUseView.lua

module("logic.extensions.echocardpack.view.EchoCardPackUseView", package.seeall)

local M = class("EchoCardPackUseView", ViewComponent)

function M:buildUI()
	self._btnFive = Astral.SimpleLuaComponentContainer.Add(self:getGo("4&btn_right_1251431307"), CommButton)
	self._btnOne = Astral.SimpleLuaComponentContainer.Add(self:getGo("3&btn_left_-1571983320"), CommButton)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnOne:AddClickListener(self._onClickOne, self)
	self._btnFive:AddClickListener(self._onClickFive, self)
end

function M:unbindEvents()
	self._btnOne:RemoveClickListener()
	self._btnFive:RemoveClickListener()
end

function M:_setEvents(add)
	return
end

function M:onEnter()
	local param = self:getOpenParam()

	if not param or param[1] == EchoCardPackController.ViewType.Buy then
		return
	end

	self._itemData = param[2]
	self._poolConfig = EchoCardPackController.instance:getEchoPoolConfig(self._itemData:getItemId())

	self._btnFive:setActiveState(self._itemData:getCount() >= 5)
end

function M:onExit()
	return
end

function M:_onClickOne()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, true) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.EchoCardUnpackView) then
		return
	end

	if not self._poolConfig then
		printError("没找到卡包对应的卡池,请检查配置! 道具id=" .. self._itemData:getItemId())

		return
	end

	local isActivity = self._poolConfig.campType == 2

	RetrieveAgent.instance:sendLotteryEchoRequest(self._poolConfig.code, 1, isActivity, self._itemData:getItemId())
	self:close()
end

function M:_onClickFive()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, true) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.EchoCardUnpackView) then
		return
	end

	if not self._poolConfig then
		printError("没找到卡包对应的卡池,请检查配置! 道具id=" .. self._itemData:getItemId())

		return
	end

	if self._itemData:getCount() < 5 then
		FloatWordMgr.instance:show(langF("tip_echo_card_pack_use", self._itemData:getName()))

		return
	end

	local isActivity = self._poolConfig.campType == 2

	RetrieveAgent.instance:sendLotteryEchoRequest(self._poolConfig.code, 5, isActivity, self._itemData:getItemId())
	self:close()
end

return M
