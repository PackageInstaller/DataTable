-- chunkname: @modules/logic/versionactivity3_4/goldenmilletpresent/view/V3a4_GoldenMilletPresentFullView.lua

module("modules.logic.versionactivity3_4.goldenmilletpresent.view.V3a4_GoldenMilletPresentFullView", package.seeall)

local V3a4_GoldenMilletPresentFullView = class("V3a4_GoldenMilletPresentFullView", BaseViewExtended)

function V3a4_GoldenMilletPresentFullView:onInitView()
	self._goReceiveView = gohelper.findChild(self.viewGO, "#go_ReceiveView")
	self._goDisplayView = gohelper.findChild(self.viewGO, "#go_DisplayView")

	gohelper.setActive(self._goReceiveView, false)
	gohelper.setActive(self._goDisplayView, false)
end

function V3a4_GoldenMilletPresentFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	local isDisplayView = not GoldenMilletPresentModel.instance:isShowRedDot()

	self:switchExclusiveView(isDisplayView)
end

function V3a4_GoldenMilletPresentFullView:switchExclusiveView(isDisplayView)
	self._showingReceiveView = true

	local exclusiveViewIndex = self.viewContainer.ExclusiveView.ReceiveView
	local exclusiveView = V3a4_GoldenMilletPresentReceiveFullView
	local exclusiveViewGO = self._goReceiveView

	if isDisplayView then
		exclusiveViewIndex = self.viewContainer.ExclusiveView.DisplayView
		exclusiveView = V3a4_GoldenMilletPresentDisplayView
		exclusiveViewGO = self._goDisplayView
		self._showingReceiveView = false
	end

	self:openExclusiveView(nil, exclusiveViewIndex, exclusiveView, exclusiveViewGO)
end

function V3a4_GoldenMilletPresentFullView:onClickModalMask()
	if self._showingReceiveView and GoldenMilletPresentModel.instance:haveReceivedSkin() then
		self:switchExclusiveView(true)
	else
		self:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return V3a4_GoldenMilletPresentFullView
