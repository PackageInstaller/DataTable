-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PPLBossSpineCtrl.lua

module("logic.extensions.maintainpowerpilla.view.PPLBossSpineCtrl", package.seeall)

local PPLBossSpineCtrl = class("PPLBossSpineCtrl", HLSpineCtrl)

PPLBossSpineCtrl.AnimName = {
	Idle = "idle",
	Die = "die"
}

function PPLBossSpineCtrl:onInit(spineRoot, view, spinePath, scale)
	self._spinePath = spinePath
	self._scale = scale or 0.05

	PPLBossSpineCtrl.super.onInit(self, spineRoot, view)
end

function PPLBossSpineCtrl:_getUrl()
	return {
		GameUrl.getLihuiSpineUIUrl(self._spinePath)
	}
end

function PPLBossSpineCtrl:_getDefaultScale()
	return self._scale
end

function PPLBossSpineCtrl:playDefaultAnim()
	local animName = PPLBossSpineCtrl.AnimName.Idle

	self:_playAnim(animName, true)
end

function PPLBossSpineCtrl:playDieAnim()
	local animName = PPLBossSpineCtrl.AnimName.Die

	self:_playAnim(animName, true)
end

return PPLBossSpineCtrl
