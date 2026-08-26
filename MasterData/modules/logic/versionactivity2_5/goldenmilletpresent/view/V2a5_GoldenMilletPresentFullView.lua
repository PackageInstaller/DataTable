-- chunkname: @modules/logic/versionactivity2_5/goldenmilletpresent/view/V2a5_GoldenMilletPresentFullView.lua

module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentFullView", package.seeall)

local V2a5_GoldenMilletPresentFullView = class("V2a5_GoldenMilletPresentFullView", BaseViewExtended)

function V2a5_GoldenMilletPresentFullView:onInitView()
	self._goReceiveView = gohelper.findChild(self.viewGO, "#go_ReceiveView")
	self._goDisplayView = gohelper.findChild(self.viewGO, "#go_DisplayView")

	gohelper.setActive(self._goReceiveView, false)
	gohelper.setActive(self._goDisplayView, false)
end

function V2a5_GoldenMilletPresentFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	local isDisplayView = not GoldenMilletPresentModel.instance:isShowRedDot()

	self:switchExclusiveView(isDisplayView)
end

function V2a5_GoldenMilletPresentFullView:switchExclusiveView(isDisplayView)
	self._showingReceiveView = true

	local exclusiveViewIndex = self.viewContainer.ExclusiveView.ReceiveView
	local exclusiveView = V2a5_GoldenMilletPresentReceiveFullView
	local exclusiveViewGO = self._goReceiveView

	if isDisplayView then
		exclusiveViewIndex = self.viewContainer.ExclusiveView.DisplayView
		exclusiveView = V2a5_GoldenMilletPresentDisplayView
		exclusiveViewGO = self._goDisplayView
		self._showingReceiveView = false
	end

	self:openExclusiveView(nil, exclusiveViewIndex, exclusiveView, exclusiveViewGO)
end

function V2a5_GoldenMilletPresentFullView:onClickModalMask()
	if self._showingReceiveView then
		self:switchExclusiveView(true)
	else
		self:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return V2a5_GoldenMilletPresentFullView
