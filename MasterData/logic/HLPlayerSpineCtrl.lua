-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/spine/HLPlayerSpineCtrl.lua

module("logic.extensions.holylight.view.spine.HLPlayerSpineCtrl", package.seeall)

local HLPlayerSpineCtrl = class("HLPlayerSpineCtrl", HLSpineCtrl)

HLPlayerSpineCtrl.AnimName = {
	Huanhu = "huanhu",
	Idle = "idle",
	Run = "run"
}

function HLPlayerSpineCtrl:_getUrl()
	return "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"
end

function HLPlayerSpineCtrl:playDefaultAnim()
	local animName = HLPlayerSpineCtrl.AnimName.Idle

	self:_playAnim(animName, true)
end

function HLPlayerSpineCtrl:playRunAnim()
	local animName = HLPlayerSpineCtrl.AnimName.Run

	self:_playAnim(animName, true)
end

function HLPlayerSpineCtrl:playHuanhuAnim()
	local animName = HLPlayerSpineCtrl.AnimName.Huanhu

	self:_playAnim(animName, false, function()
		self:playDefaultAnim()
	end)
end

return HLPlayerSpineCtrl
