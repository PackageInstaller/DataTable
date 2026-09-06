-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/data/FreeScuffleWorkSpineCtrl.lua

module("logic.extensions.freescuffle.view.data.FreeScuffleWorkSpineCtrl", package.seeall)

local FreeScuffleWorkSpineCtrl = class("FreeScuffleWorkSpineCtrl", HLSpineCtrl)

function FreeScuffleWorkSpineCtrl:onInit(spineRoot, view, resName)
	if self._spineRoot == spineRoot and self._view == view and self._resName == resName then
		return
	end

	self._resName = resName
	self._spinePath = GameUrl.getSpineUIUrl(resName)

	FreeScuffleWorkSpineCtrl.super.onInit(self, spineRoot, view)
end

function FreeScuffleWorkSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function FreeScuffleWorkSpineCtrl:_getDefaultScale()
	return 1
end

function FreeScuffleWorkSpineCtrl:playDefaultAnim()
	self:_playAnim("idle", true)
end

return FreeScuffleWorkSpineCtrl
