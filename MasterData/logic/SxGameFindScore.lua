-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameFindScore.lua

module("logic.extensions.sxgame.view.state.SxGameFindScore", package.seeall)

local SxGameFindScore = class("SxGameFindScore")

function SxGameFindScore:ctor(stateName)
	self._stateName = stateName
end

function SxGameFindScore:onEnter()
	local cellMo

	self._actionArray = SxGameModel.instance:getActions()

	if self._actionArray:GetSize() == 2 then
		local preCell = self._actionArray:Get(0)
		local afterCell = self._actionArray:Get(1)

		SxGameModel.instance:clearOperate()
		SxGameModel.instance:clearNeedResetCell()

		local canRemovePre, p_s, p_c1, p_c2, p_tl5 = SxGameModel.instance:checkDataByPoints(preCell._x, preCell._y)
		local afterRemovePre, a_s, a_c1, a_c2, a_tl5 = SxGameModel.instance:checkDataByPoints(afterCell._x, afterCell._y)

		SxGameModel.instance:clearAllIce()

		if p_s then
			cellMo = SxGameCellMO.New()
			cellMo._type = SxGameModel.instance:getRemoveCreateItem(p_c1, p_c2, p_tl5)
			cellMo._x = preCell._x
			cellMo._y = preCell._y

			cellMo:initCell()
			SxGameModel.instance:addSpecial(cellMo)
		end

		if a_s then
			cellMo = SxGameCellMO.New()
			cellMo._type = SxGameModel.instance:getRemoveCreateItem(a_c1, a_c2, a_tl5)
			cellMo._x = afterCell._x
			cellMo._y = afterCell._y

			cellMo:initCell()
			SxGameModel.instance:addSpecial(cellMo)
		end

		if canRemovePre or afterRemovePre then
			settimer(0.1, self._scoreAction, self, false)
		else
			settimer(0.1, self._backFunc, self, false)
		end
	else
		SxGameController.instance:defaultState()
	end
end

function SxGameFindScore:_backFunc()
	SxGameController.instance:viewSwapBack()
end

function SxGameFindScore:_scoreAction()
	GlobalDispatcher:dispatch(GlobalNotify.NextStep)
	SxGameController.instance:scoreAction()
end

function SxGameFindScore:_specialScoreAction()
	SxGameController.instance:scoreAction()
end

function SxGameFindScore:onExit()
	return
end

return SxGameFindScore
