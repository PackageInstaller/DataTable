-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/data/FreeScuffleEggSpineCtrl.lua

module("logic.extensions.stknexp.data.FreeScuffleEggSpineCtrl", package.seeall)

local FreeScuffleEggSpineCtrl = class("FreeScuffleEggSpineCtrl", HLSpineCtrl)

function FreeScuffleEggSpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	FreeScuffleEggSpineCtrl.super.onInit(self, spineRoot, view)
end

function FreeScuffleEggSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function FreeScuffleEggSpineCtrl:_getDefaultScale()
	return 1
end

function FreeScuffleEggSpineCtrl:playDefaultAnim()
	self:_playAnim("1", true)
end

return FreeScuffleEggSpineCtrl
