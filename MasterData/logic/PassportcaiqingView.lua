-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportcaiqingView.lua

module("logic.extensions.passport.view.PassportcaiqingView", package.seeall)

local PassportcaiqingView = class("PassportcaiqingView", PassportCampView)

function PassportcaiqingView:ctor()
	PassportcaiqingView.super.ctor(self)
end

function PassportcaiqingView:unbindEvents()
	PassportcaiqingView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCaiqing)
	GameUtil.rmClickHandler(self._btnBuyProgress)
end

function PassportcaiqingView:bindEvents()
	PassportcaiqingView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCaiqing, self._onClickCaiqing, self)
	GameUtil.addClickHandler(self._btnBuyProgress, self._onClickBuyProgress, self)
end

function PassportcaiqingView:buildUI()
	PassportcaiqingView.super.buildUI(self)

	self._btnCaiqing = self:getBtn("btnCaiqing")
	self._btnBuyProgress = self:getBtn("btnBuyProgress")
end

function PassportcaiqingView:onEnter()
	PassportcaiqingView.super.onEnter(self)
	GameUtil.SetActive(self._btnCaiqing, true)
	GameUtil.SetActive(self._btnGoTo, false)
end

function PassportcaiqingView:_refreshView()
	PassportcaiqingView.super._refreshView(self)
	GameUtil.SetActive(self._btnBuyProgress, self._curData.progressAbletToBuy > 0)
end

function PassportcaiqingView:_onClickCaiqing()
	UIStateManager.instance:push(ViewName.CaiqingdrawView)
end

function PassportcaiqingView:_onClickBuyProgress()
	if self._curData.progressAbletToBuy <= 0 then
		GameUtil.SetActive(self._goBuyProgress, false)

		return
	end

	UIStateManager.instance:push(ViewName.PassportbuyporgressView, self._curData.funcCfg, self._curData.actCfg, self._curData.progressAbletToBuy)
end

return PassportcaiqingView
