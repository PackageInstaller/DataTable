-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodSpineCtrl.lua

module("logic.extensions.femalegod.view.FemaleGodSpineCtrl", package.seeall)

local FemaleGodSpineCtrl = class("FemaleGodSpineCtrl", HLSpineCtrl)

FemaleGodSpineCtrl.AnimName = {
	Baojinbi = "baojinbi"
}

function FemaleGodSpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	FemaleGodSpineCtrl.super.onInit(self, spineRoot, view)
end

function FemaleGodSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function FemaleGodSpineCtrl:_getDefaultScale()
	return 1
end

function FemaleGodSpineCtrl:playDefaultAnim()
	local animName = FemaleGodSpineCtrl.AnimName.Baojinbi

	self:_playAnim(animName, false)
end

return FemaleGodSpineCtrl
