-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballRestLoadingViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballRestLoadingViewContainer", package.seeall)

local PinballRestLoadingViewContainer = class("PinballRestLoadingViewContainer", PinballLoadingViewContainer)

function PinballRestLoadingViewContainer:buildViews()
	return {}
end

function PinballRestLoadingViewContainer:onContainerOpen(...)
	PinballRestLoadingViewContainer.super.onContainerOpen(self, ...)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio10)

	local txt1 = gohelper.findChild(self.viewGO, "bg/#txt_dec")
	local txt2 = gohelper.findChild(self.viewGO, "bg/#txt_dec2")

	gohelper.setActive(txt1, PinballModel.instance.restCdDay <= 0)
	gohelper.setActive(txt2, PinballModel.instance.restCdDay > 0)

	self._openDt = UnityEngine.Time.realtimeSinceStartup
end

function PinballRestLoadingViewContainer:onContainerClickModalMask()
	if not self._openDt or UnityEngine.Time.realtimeSinceStartup - self._openDt > 1 then
		self:closeThis()
	end
end

function PinballRestLoadingViewContainer:onContainerClose(...)
	PinballRestLoadingViewContainer.super.onContainerClose(self, ...)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio11)
end

return PinballRestLoadingViewContainer
