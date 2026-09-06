-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shareqrcode/ShareQRCodeViewPresentor.lua

module("logic.extensions.shareqrcode.ShareQRCodeViewPresentor", package.seeall)

local ShareQRCodeViewPresentor = class("ShareQRCodeViewPresentor", ViewPresentor)

function ShareQRCodeViewPresentor:ctor()
	ShareQRCodeViewPresentor.super.ctor(self)
end

function ShareQRCodeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShareQRCodeViewPresentor:dependWhatResources()
	return {
		"ui/views/shareqrcode/shareqrcodeview.prefab"
	}
end

function ShareQRCodeViewPresentor:buildViews()
	return {
		ShareQRCodeView.New()
	}
end

function ShareQRCodeViewPresentor:getTempResources()
	local resultPath = {}

	self._chapterId = self:getFirstParam()

	local params = self:getOpenParam()
	local bgImageName = params[1]

	table.insert(resultPath, string.format("ui/bigbg/shareqrcode/%s.png", bgImageName))

	return resultPath
end

return ShareQRCodeViewPresentor
