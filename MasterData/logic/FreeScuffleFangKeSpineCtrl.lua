-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/data/FreeScuffleFangKeSpineCtrl.lua

module("logic.extensions.stknexp.data.FreeScuffleFangKeSpineCtrl", package.seeall)

local FreeScuffleFangKeSpineCtrl = class("FreeScuffleFangKeSpineCtrl", HLSpineCtrl)

function FreeScuffleFangKeSpineCtrl:onInit(spineRoot, view, spinePath)
	if self._spineRoot == spineRoot and self._view == view and self._spinePath == spinePath then
		return
	end

	self._spinePath = spinePath

	FreeScuffleFangKeSpineCtrl.super.onInit(self, spineRoot, view)
end

function FreeScuffleFangKeSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function FreeScuffleFangKeSpineCtrl:_getDefaultScale()
	return 1
end

function FreeScuffleFangKeSpineCtrl:playDefaultAnim()
	self:_playAnim("jingxia2", true)
end

return FreeScuffleFangKeSpineCtrl
