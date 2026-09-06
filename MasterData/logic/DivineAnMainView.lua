-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnMainView.lua

module("logic.extensions.divinean.view.DivineAnMainView", package.seeall)

local DivineAnMainView = class("DivineAnMainView", InfinitefutureView)

DivineAnMainView.PageIndex = nil

function DivineAnMainView:buildUI()
	DivineAnMainView.super.buildUI(self)

	self._btnJump1 = self:getBtn("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getBtn("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getBtn("jumpBtnCol/btnJump3")
end

function DivineAnMainView:bindEvents()
	DivineAnMainView.super.bindEvents(self)
	self._btnJump1:AddClickListener(self._onClickbtnJump1, self)
	self._btnJump2:AddClickListener(self._onClickbtnJump2, self)
	self._btnJump3:AddClickListener(self._onClickbtnJump3, self)
end

function DivineAnMainView:unbindEvents()
	DivineAnMainView.super.unbindEvents(self)
	self._btnJump2:RemoveClickListener()
	self._btnJump3:RemoveClickListener()
	self._btnJump1:RemoveClickListener()
end

function DivineAnMainView:_onClickbtnJump1()
	self:_onClickbtnJump(1)
end

function DivineAnMainView:_onClickbtnJump2()
	self:_onClickbtnJump(2)
end

function DivineAnMainView:_onClickbtnJump3()
	self:_onClickbtnJump(3)
end

function DivineAnMainView:_onClickbtnJump(index)
	local cfg = InfinitefutureConfig.instance:getPlanCfg(InfinitefutureModel.instance.curActId)
	local jumpStr = cfg["jumpTo" .. index]

	if not string.nilorempty(jumpStr) then
		GotoMgr.gotoByString(jumpStr)
	else
		FloatWordMgr.instance:show("未配置跳转指令，请前往y运营-无限未来挑战.xlsx进行配置")
	end
end

function DivineAnMainView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.DivineAnChallengeView)
	elseif index == 2 then
		printError("没有处理")
	elseif index == 3 then
		printError("没有处理")
	end

	for i = 1, 3 do
		self._tabs[i].selected:SetActive(i == index)
	end

	DivineAnMainView.PageIndex = index
end

function DivineAnMainView:_getConstPageIndex()
	return DivineAnMainView.PageIndex
end

function DivineAnMainView:_resetConstPageIndex()
	DivineAnMainView.PageIndex = nil
end

function DivineAnMainView:setIds()
	InfinitefutureModel.instance.curActId = 123015
	InfinitefutureModel.instance.curPetId = 15022

	local cfg = TimeLimitedConfig.instance:getTimedChallengeCfgByViewName(self._viewPresentor.viewName)

	if cfg then
		InfinitefutureModel.instance.curPetId = cfg.raceId
	else
		FloatWordMgr.instance:show("未找到精灵Id，请去限时挑战表配置活动信息")
	end

	if self:getFirstParam() then
		InfinitefutureModel.instance.curActId = checknumber(self:getFirstParam())
	end
end

function DivineAnMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "divineanmain_rule")
end

return DivineAnMainView
