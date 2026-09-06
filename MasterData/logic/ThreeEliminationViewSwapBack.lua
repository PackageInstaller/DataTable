-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationViewSwapBack.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationViewSwapBack", package.seeall)

local ThreeEliminationViewSwapBack = class("ThreeEliminationViewSwapBack")

function ThreeEliminationViewSwapBack:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationViewSwapBack:onEnter()
	ThreeEliminationModel.instance:exchangeAction()
	GlobalDispatcher:dispatch(GlobalNotify.SwapView, true)
	printInfo("回退！！！！")
end

function ThreeEliminationViewSwapBack:onExit()
	return
end

return ThreeEliminationViewSwapBack
