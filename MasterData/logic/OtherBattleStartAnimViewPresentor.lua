-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/view/OtherBattleStartAnimViewPresentor.lua

module("logic.extensions.battlestartanim.view.OtherBattleStartAnimViewPresentor", package.seeall)

local OtherBattleStartAnimViewPresentor = class("OtherBattleStartAnimViewPresentor", ViewPresentor)

function OtherBattleStartAnimViewPresentor:ctor()
	OtherBattleStartAnimViewPresentor.super.ctor(self)
end

function OtherBattleStartAnimViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OtherBattleStartAnimViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/otherbattlestartanimview.prefab"
	}
end

function OtherBattleStartAnimViewPresentor:buildViews()
	return {
		OtherBattleStartAnimView.New()
	}
end

return OtherBattleStartAnimViewPresentor
