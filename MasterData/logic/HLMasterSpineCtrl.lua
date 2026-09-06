-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/spine/HLMasterSpineCtrl.lua

module("logic.extensions.holylight.view.spine.HLMasterSpineCtrl", package.seeall)

local HLMasterSpineCtrl = class("HLMasterSpineCtrl", HLSpineCtrl)

HLMasterSpineCtrl.ResName = {
	"0303_eling",
	"0303_eling01",
	"0303_eling02"
}
HLMasterSpineCtrl.AnimName = {
	Idle = "idle",
	Die = "die"
}

function HLMasterSpineCtrl:onInit(spineRoot, view, masterId)
	self._masterId = masterId

	HLMasterSpineCtrl.super.onInit(self, spineRoot, view)
end

function HLMasterSpineCtrl:_getUrl()
	local resName = HLMasterSpineCtrl.ResName[(self._masterId - 1) % #HLMasterSpineCtrl.ResName + 1]

	return {
		GameUrl.getLihuiSpineUIUrl(resName)
	}
end

function HLMasterSpineCtrl:_getDefaultScale()
	return 0.1
end

function HLMasterSpineCtrl:playDefaultAnim()
	local animName = HLMasterSpineCtrl.AnimName.Idle

	self:_playAnim(animName, true)
end

function HLMasterSpineCtrl:playDieAnim()
	local animName = HLMasterSpineCtrl.AnimName.Die

	self:_playAnim(animName, true)
end

return HLMasterSpineCtrl
