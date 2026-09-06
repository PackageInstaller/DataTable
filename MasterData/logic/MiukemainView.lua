-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miukechallenge/view/MiukemainView.lua

module("logic.extensions.miukechallenge.view.MiukemainView", package.seeall)

local MiukemainView = class("MiukemainView", InfinitefutureView)

MiukemainView.PageIndex = nil

function MiukemainView:buildUI()
	MiukemainView.super.buildUI(self)

	self._btnJump2 = self:getBtn("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getBtn("jumpBtnCol/btnJump3")
	self._btnJump1 = self:getBtn("jumpBtnCol/btnJump1")
end

function MiukemainView:bindEvents()
	MiukemainView.super.bindEvents(self)
	self._btnJump2:AddClickListener(self._onClickbtnJump2, self)
	self._btnJump3:AddClickListener(self._onClickbtnJump3, self)
	self._btnJump1:AddClickListener(self._onClickbtnJump1, self)
end

function MiukemainView:unbindEvents()
	MiukemainView.super.unbindEvents(self)
	self._btnJump2:RemoveClickListener()
	self._btnJump3:RemoveClickListener()
	self._btnJump1:RemoveClickListener()
end

function MiukemainView:_onClickbtnJump2()
	self:_onClickbtnJump(2)
end

function MiukemainView:_onClickbtnJump3()
	self:_onClickbtnJump(3)
end

function MiukemainView:_onClickbtnJump1()
	self:_onClickbtnJump(1)
end

function MiukemainView:_onClickbtnJump(index)
	local cfg = InfinitefutureConfig.instance:getPlanCfg(InfinitefutureModel.instance.curActId)
	local jumpStr = cfg["jumpTo" .. index]

	if not string.nilorempty(jumpStr) then
		GotoMgr.gotoByString(jumpStr)
	end
end

function MiukemainView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.MiukechallengeView)
	elseif index == 2 then
		self:showTabAt(self._container, ViewName.MiukelotteryView)
	elseif index == 3 then
		printError("没有处理")
	end

	for i = 1, 3 do
		self._tabs[i].selected:SetActive(i == index)
	end

	MiukemainView.PageIndex = index
end

function MiukemainView:_getConstPageIndex()
	return MiukemainView.PageIndex
end

function MiukemainView:_resetConstPageIndex()
	MiukemainView.PageIndex = nil
end

function MiukemainView:setIds()
	InfinitefutureModel.instance.curActId = 123014
	InfinitefutureModel.instance.curPetId = 15022

	if self:getFirstParam() then
		InfinitefutureModel.instance.curActId = checknumber(self:getFirstParam())
	end
end

function MiukemainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "miuke_rule")
end

return MiukemainView
