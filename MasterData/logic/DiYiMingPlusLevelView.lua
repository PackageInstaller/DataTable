-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/diyimingplus/DiYiMingPlusLevelView.lua

module("logic.extensions.timelimitedchallenge.view.diyimingplus.DiYiMingPlusLevelView", package.seeall)

local DiYiMingPlusLevelView = class("DiYiMingPlusLevelView", XiuMumLevelView)

function DiYiMingPlusLevelView:_getGameView()
	return ViewName.DiYiMingPlusGameView
end

return DiYiMingPlusLevelView
