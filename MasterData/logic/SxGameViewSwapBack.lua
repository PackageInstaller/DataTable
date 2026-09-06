-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameViewSwapBack.lua

module("logic.extensions.sxgame.view.state.SxGameViewSwapBack", package.seeall)

local SxGameViewSwapBack = class("SxGameViewSwapBack")

function SxGameViewSwapBack:ctor(stateName)
	self._stateName = stateName
end

function SxGameViewSwapBack:onEnter()
	SxGameModel.instance:exchangeAction()
	GlobalDispatcher:dispatch(GlobalNotify.SwapView, true)
	printInfo("回退！！！！")
end

function SxGameViewSwapBack:onExit()
	return
end

return SxGameViewSwapBack
