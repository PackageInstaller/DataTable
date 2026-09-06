-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPraySpineCtrl.lua

module("logic.extensions.newyearpray.view.NewYearPraySpineCtrl", package.seeall)

local NewYearPraySpineCtrl = class("NewYearPraySpineCtrl", HLSpineCtrl)

function NewYearPraySpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	NewYearPraySpineCtrl.super.onInit(self, spineRoot, view)
end

function NewYearPraySpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function NewYearPraySpineCtrl:_getDefaultScale()
	return 1
end

function NewYearPraySpineCtrl:playDefaultAnim()
	return
end

return NewYearPraySpineCtrl
