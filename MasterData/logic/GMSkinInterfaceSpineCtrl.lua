-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmskininterface/spinectrl/GMSkinInterfaceSpineCtrl.lua

module("logic.extensions.gm.view.gmskininterface.spinectrl.GMSkinInterfaceSpineCtrl", package.seeall)

local GMSkinInterfaceSpineCtrl = class("GMSkinInterfaceSpineCtrl", HLSpineCtrl)

GMSkinInterfaceSpineCtrl.AnimName = {
	Default = "1",
	Idle = "idle",
	Run = "run"
}

function GMSkinInterfaceSpineCtrl:onInit(spineRoot, view, params)
	self._url = params.url
	self._scale = params.scale or 0.05

	self:regCallBackOfSpineLoaded(params.callBackOfSpineLoaded)
	GMSkinInterfaceSpineCtrl.super.onInit(self, spineRoot, view, params)
end

function GMSkinInterfaceSpineCtrl:_getUrl()
	return self._url
end

function GMSkinInterfaceSpineCtrl:_getDefaultScale()
	return self._scale
end

function GMSkinInterfaceSpineCtrl:playDefaultAnim()
	local animName = GMSkinInterfaceSpineCtrl.AnimName.Default

	self:_playAnim(animName, true)
end

function GMSkinInterfaceSpineCtrl:playRunAnim()
	local animName = GMSkinInterfaceSpineCtrl.AnimName.Run

	self:_playAnim(animName, true)
end

return GMSkinInterfaceSpineCtrl
