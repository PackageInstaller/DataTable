-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/IceQiBuOperationSignInViewPresentor.lua

module("logic.extensions.operationsignin.view.IceQiBuOperationSignInViewPresentor", package.seeall)

local IceQiBuOperationSignInViewPresentor = class("IceQiBuOperationSignInViewPresentor", ViewPresentor)

function IceQiBuOperationSignInViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function IceQiBuOperationSignInViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/iceqibuoperationsigninview.prefab"
	}
end

function IceQiBuOperationSignInViewPresentor:buildViews()
	return {
		IceQiBuOperationSignInView.New()
	}
end

return IceQiBuOperationSignInViewPresentor
