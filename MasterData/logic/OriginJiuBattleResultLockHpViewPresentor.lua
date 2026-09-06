-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginJiuBattleResultLockHpViewPresentor.lua

module("logic.extensions.originjiu.view.OriginJiuBattleResultLockHpViewPresentor", package.seeall)

local OriginJiuBattleResultLockHpViewPresentor = class("OriginJiuBattleResultLockHpViewPresentor", ViewPresentor)

function OriginJiuBattleResultLockHpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginJiuBattleResultLockHpViewPresentor:dependWhatResources()
	return {
		"ui/views/originjiu/originjiubattleresultlockhpview.prefab"
	}
end

function OriginJiuBattleResultLockHpViewPresentor:buildViews()
	return {
		OriginJiuBattleResultLockHpView.New()
	}
end

return OriginJiuBattleResultLockHpViewPresentor
