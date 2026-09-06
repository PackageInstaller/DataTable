-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameContinueFindScore.lua

module("logic.extensions.sxgame.view.state.SxGameContinueFindScore", package.seeall)

local SxGameContinueFindScore = class("SxGameContinueFindScore")

function SxGameContinueFindScore:ctor(stateName)
	self._stateName = stateName
end

function SxGameContinueFindScore:onEnter()
	SxGameModel.instance:clearOperate()
	SxGameModel.instance:clearNeedResetCell()
	SxGameModel.instance:clearAllIce()

	if SxGameModel.instance:checkRemoveDataAll() then
		SxGameModel.instance:setCombo()
		GlobalDispatcher:dispatch(GlobalNotify.RemoveCell)
		GlobalDispatcher:dispatch(GlobalNotify.Combo)
	else
		GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesComboFish, SxGameModel.instance:getCombo())
		SxGameModel.instance:comBoFish()
		SxGameController.instance:defaultState()
	end
end

function SxGameContinueFindScore:onExit()
	return
end

return SxGameContinueFindScore
