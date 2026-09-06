-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenyiresultViewPresentor.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenyiresultViewPresentor", package.seeall)

local HeartofjieshenyiresultViewPresentor = class("HeartofjieshenyiresultViewPresentor", ViewPresentor)

function HeartofjieshenyiresultViewPresentor:ctor()
	HeartofjieshenyiresultViewPresentor.super.ctor(self)
end

function HeartofjieshenyiresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HeartofjieshenyiresultViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofjieshen/heartofjieshenyiresultview.prefab"
	}
end

function HeartofjieshenyiresultViewPresentor:buildViews()
	return {
		HeartofjieshenyiresultView.New()
	}
end

return HeartofjieshenyiresultViewPresentor
