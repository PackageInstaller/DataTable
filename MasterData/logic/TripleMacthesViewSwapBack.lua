-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesViewSwapBack.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesViewSwapBack", package.seeall)

local TripleMacthesViewSwapBack = class("TripleMacthesViewSwapBack")

function TripleMacthesViewSwapBack:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesViewSwapBack:onEnter()
	TripleMacthesGameModel.instance:exchangeAction()
	GlobalDispatcher:dispatch(GlobalNotify.SwapView, true)
	printInfo("回退！！！！")
end

function TripleMacthesViewSwapBack:onExit()
	return
end

return TripleMacthesViewSwapBack
