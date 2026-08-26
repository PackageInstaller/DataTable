-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/spine/TravelGoPlayerSpine.lua

module("modules.logic.versionactivity3_7.travelgo.view.spine.TravelGoPlayerSpine", package.seeall)

local TravelGoPlayerSpine = class("TravelGoPlayerSpine", TravelGoSpineComp)

function TravelGoPlayerSpine:onSetData()
	self.res = "roles_special/roles_v3a7_xran/v3a7_314601_xran/314601_xran_ui.prefab"
	self.dir = SpineLookDir.Right
end

function TravelGoPlayerSpine:playBorn()
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_ruchang)
	self.play(self, "born", false, true, self.onBornComplete, self)
end

function TravelGoPlayerSpine:addEventListeners()
	TravelGoPlayerSpine.super.addEventListeners(self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnPlayGainRewardAnimation, self.onPlayGainRewardAnimation, self)
end

function TravelGoPlayerSpine:onBornComplete()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnPlayerBornComplete)
end

function TravelGoPlayerSpine:onPlayGainRewardAnimation()
	self:play("idle_special", false, true)
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_acquire)
end

return TravelGoPlayerSpine
