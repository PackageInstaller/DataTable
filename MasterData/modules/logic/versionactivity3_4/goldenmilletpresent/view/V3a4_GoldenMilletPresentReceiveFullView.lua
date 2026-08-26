-- chunkname: @modules/logic/versionactivity3_4/goldenmilletpresent/view/V3a4_GoldenMilletPresentReceiveFullView.lua

module("modules.logic.versionactivity3_4.goldenmilletpresent.view.V3a4_GoldenMilletPresentReceiveFullView", package.seeall)

local V3a4_GoldenMilletPresentReceiveFullView = class("V3a4_GoldenMilletPresentReceiveFullView", V3a4_GoldenMilletPresentReceiveView)

function V3a4_GoldenMilletPresentReceiveFullView:addEvents()
	gohelper.setActive(self._btnCloseReceive.gameObject, false)

	if self._btnIcon then
		self._btnIcon:AddClickListener(self._btnGotoOnClick, self)
	end

	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.afterReceive, self)
end

return V3a4_GoldenMilletPresentReceiveFullView
