-- chunkname: @modules/logic/versionactivity3_4/goldenmilletpresent/view/V3a4_GoldenMilletPresentView.lua

module("modules.logic.versionactivity3_4.goldenmilletpresent.view.V3a4_GoldenMilletPresentView", package.seeall)

local V3a4_GoldenMilletPresentView = class("V3a4_GoldenMilletPresentView", BaseViewExtended)

function V3a4_GoldenMilletPresentView:onInitView()
	self._goReceiveView = gohelper.findChild(self.viewGO, "#go_ReceiveView")
	self._goDisplayView = gohelper.findChild(self.viewGO, "#go_DisplayView")

	gohelper.setActive(self._goReceiveView, false)
	gohelper.setActive(self._goDisplayView, false)
end

function V3a4_GoldenMilletPresentView:onOpen()
	if self.viewParam then
		if not self.viewParam.isDisplayView then
			local isDisplayView = false

			self:switchExclusiveView(isDisplayView)
		end
	end
end

function V3a4_GoldenMilletPresentView:switchExclusiveView(isDisplayView)
	self._showingReceiveView = true

	local exclusiveViewIndex = self.viewContainer.ExclusiveView.ReceiveView
	local exclusiveView = V3a4_GoldenMilletPresentReceiveView
	local exclusiveViewGO = self._goReceiveView

	if isDisplayView then
		exclusiveViewIndex = self.viewContainer.ExclusiveView.DisplayView
		exclusiveView = V3a4_GoldenMilletPresentDisplayView
		exclusiveViewGO = self._goDisplayView
		self._showingReceiveView = false
	end

	self:openExclusiveView(nil, exclusiveViewIndex, exclusiveView, exclusiveViewGO)
end

function V3a4_GoldenMilletPresentView:onClickModalMask()
	if self._showingReceiveView and GoldenMilletPresentModel.instance:haveReceivedSkin() then
		self:switchExclusiveView(true)
	else
		self:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return V3a4_GoldenMilletPresentView
