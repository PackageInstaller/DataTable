-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/DivineLuciferLevelSelectView.lua

module("logic.extensions.fantian.view.DivineLuciferLevelSelectView", package.seeall)

local DivineLuciferLevelSelectView = class("DivineLuciferLevelSelectView", FantianlevelselectView)

function DivineLuciferLevelSelectView:getItemDesc()
	return "赤焰"
end

function DivineLuciferLevelSelectView:getResultViewName()
	return ViewName.DivineLuciferResultView
end

return DivineLuciferLevelSelectView
