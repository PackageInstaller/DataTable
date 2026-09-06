-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonRaceTipsView.lua

module("logic.extensions.common.instruction.view.CommonRaceTipsView", package.seeall)

local CommonRaceTipsView = class("CommonRaceTipsView", ViewComponent)

function CommonRaceTipsView:ctor()
	CommonRaceTipsView.super.ctor(self)
end

function CommonRaceTipsView:destroyUI()
	CommonRaceTipsView.super.destroyUI(self)
end

function CommonRaceTipsView:onExitFinished()
	CommonRaceTipsView.super.onExitFinished(self)
end

function CommonRaceTipsView:onEnterFinished()
	CommonRaceTipsView.super.onEnterFinished(self)
end

function CommonRaceTipsView:unbindEvents()
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnHelp)
end

function CommonRaceTipsView:bindEvents()
	CommonRaceTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self.btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self.btnHelp, self._onClickBtnHelp, self)
end

function CommonRaceTipsView:onExit()
	CommonRaceTipsView.super.onExit(self)
end

function CommonRaceTipsView:buildUI()
	CommonRaceTipsView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)
	self.btnClose = self:getGo("Nego_Content/btnClose")
	self.btnHelp = self:getGo("Nego_Content/btnHelp")
end

function CommonRaceTipsView:onEnter()
	CommonRaceTipsView.super.onEnter(self)

	local data, pos

	if self._viewPresentor._openParam then
		data = self._viewPresentor._openParam[1]
		pos = self._viewPresentor._openParam[2]
	end

	GameUtil.SetActive(self.btnClose, data == nil)

	if pos then
		Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	end
end

function CommonRaceTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:_onClickClose()
	end
end

function CommonRaceTipsView:_onClickBtnHelp()
	UIStateManager.instance:popByName(self._viewPresentor.viewName)
	CommonTipsMgr.instance:closeAllTips()
	UIStateManager.instance:open(ViewName.RulesView, "common_race_rule")
end

function CommonRaceTipsView:_onClickClose()
	UIStateManager.instance:popByName(self._viewPresentor.viewName)
	CommonTipsMgr.instance:closeAllTips()
end

return CommonRaceTipsView
