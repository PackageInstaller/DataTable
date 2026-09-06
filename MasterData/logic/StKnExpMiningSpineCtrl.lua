-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/data/StKnExpMiningSpineCtrl.lua

module("logic.extensions.stknexp.data.StKnExpMiningSpineCtrl", package.seeall)

local StKnExpMiningSpineCtrl = class("StKnExpMiningSpineCtrl", HLSpineCtrl)

function StKnExpMiningSpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	StKnExpMiningSpineCtrl.super.onInit(self, spineRoot, view)
end

function StKnExpMiningSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function StKnExpMiningSpineCtrl:_getDefaultScale()
	return 1
end

function StKnExpMiningSpineCtrl:playDefaultAnim()
	self:_playAnim("idle", true)
end

return StKnExpMiningSpineCtrl
