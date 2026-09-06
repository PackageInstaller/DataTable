-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TraincampqiecuoContractSelectPopViewPresentor.lua

module("logic.extensions.traincampqiecuo.view.TraincampqiecuoContractSelectPopViewPresentor", package.seeall)

local TraincampqiecuoContractSelectPopViewPresentor = class("TraincampqiecuoContractSelectPopViewPresentor", ViewPresentor)

function TraincampqiecuoContractSelectPopViewPresentor:ctor()
	TraincampqiecuoContractSelectPopViewPresentor.super.ctor(self)
end

function TraincampqiecuoContractSelectPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TraincampqiecuoContractSelectPopViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractselectpopview.prefab"
	}
end

function TraincampqiecuoContractSelectPopViewPresentor:buildViews()
	return {
		TraincampqiecuoContractSelectPopView.New()
	}
end

return TraincampqiecuoContractSelectPopViewPresentor
