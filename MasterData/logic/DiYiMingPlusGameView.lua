-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/diyimingplus/DiYiMingPlusGameView.lua

module("logic.extensions.timelimitedchallenge.view.diyimingplus.DiYiMingPlusGameView", package.seeall)

local DiYiMingPlusGameView = class("DiYiMingPlusGameView", XiuMumGameView)

function DiYiMingPlusGameView:_getMainView()
	return ViewName.DiYiMingPlusMainView
end

function DiYiMingPlusGameView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "diyimingplusmainview_rule")
end

function DiYiMingPlusGameView:_getRuleName()
	return "diyimingplusmainview_rule"
end

function DiYiMingPlusGameView:_getLevelView()
	return ViewName.DiYiMingPlusLevelView
end

return DiYiMingPlusGameView
