-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooDigView.lua

module("logic.extensions.zoo.view.ZooDigView", package.seeall)

local ZooDigView = class("ZooDigView", TreasurenewDigView)

function ZooDigView:destroyUI()
	ZooDigView.super.destroyUI(self)
	self:_releaseRes()
end

function ZooDigView:onEnter()
	ZooDigView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LeaveCityDone, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onOpenView, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureAutoStop, self._onClickCancel, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooDigEd, self.close, self)
	self:_preLoadRes()
	goutil.setActive(self._goDig, true)
	goutil.setActive(self._goCancel, false)
	goutil.setActive(self._goProgress, false)
end

function ZooDigView:onExit()
	ZooDigView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooDigEd, self.close, self)
end

function ZooDigView:onExitFinished()
	self:_releaseRes()
	ZooDigView.super.onExitFinished(self)
end

function ZooDigView:_onClickBtnDig()
	goutil.setActive(self._goDig, false)
	goutil.setActive(self._goCancel, true)
	goutil.setActive(self._goProgress, true)
	removetimer(self._startDig, self)
	settimer(0.01, self._startDig, self, false)
end

function ZooDigView:_updateTime()
	self._aniTimer = self._aniTimer + 1
	self._sldValue = self._sldValue + self._stepValue

	self._sldProgress:SetValue(self._sldValue)

	if self._aniTimer >= self._totalTimer then
		removetimer(self._updateTime, self)

		local openParam = self:getOpenParam()

		ZooController.instance:sendPM_ZooDigTreasureReq(openParam[1], openParam[2])

		return
	end
end

return ZooDigView
