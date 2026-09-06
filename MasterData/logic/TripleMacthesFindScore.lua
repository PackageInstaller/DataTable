-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesFindScore.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesFindScore", package.seeall)

local TripleMacthesFindScore = class("TripleMacthesFindScore")

function TripleMacthesFindScore:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesFindScore:onEnter()
	TripleMachesGameController.instance:changeAllEmptyShow(false)

	local cellMo

	self._actionArray = TripleMacthesGameModel.instance:getActions()

	if self._actionArray:GetSize() == 2 then
		local preCell = self._actionArray:Get(0)
		local afterCell = self._actionArray:Get(1)
		local matCells = TripleMacthesGameModel.instance:getGameMapArr()

		TripleMacthesGameModel.instance:clearOperate()
		TripleMacthesGameModel.instance:clearNeedResetCell()

		local canRemovePre, p_s, p_c1, p_c2, p_tl5, p_matx = TripleMacthesGameModel.instance:checkDataByPoints(preCell._x, preCell._y)
		local afterRemovePre, a_s, a_c1, a_c2, a_tl5, a_matx = TripleMacthesGameModel.instance:checkDataByPoints(afterCell._x, afterCell._y)

		TripleMacthesGameModel.instance:clearAllIce()

		if p_s then
			cellMo = SxGameCellMO.New()
			cellMo._type = TripleMacthesGameModel.instance:getRemoveCreateItem(p_c1, p_c2, p_tl5, p_matx)

			table.insert(cellMo._addType, matCells[preCell._y][preCell._x]._type)

			cellMo._x = preCell._x
			cellMo._y = preCell._y

			cellMo:initCell()
			TripleMacthesGameModel.instance:addSpecial(cellMo)
		end

		if a_s then
			cellMo = SxGameCellMO.New()
			cellMo._type = TripleMacthesGameModel.instance:getRemoveCreateItem(a_c1, a_c2, a_tl5, a_matx)

			table.insert(cellMo._addType, matCells[afterCell._y][afterCell._x]._type)

			cellMo._x = afterCell._x
			cellMo._y = afterCell._y

			cellMo:initCell()
			TripleMacthesGameModel.instance:addSpecial(cellMo)
		end

		if canRemovePre or afterRemovePre then
			settimer(0.1, self._scoreAction, self, false)
		else
			settimer(0.1, self._backFunc, self, false)
		end
	else
		TripleMachesGameController.instance:defaultState()
	end
end

function TripleMacthesFindScore:_backFunc()
	TripleMachesGameController.instance:viewSwapBack()
end

function TripleMacthesFindScore:_scoreAction()
	GlobalDispatcher:dispatch(GlobalNotify.NextStep)
	TripleMachesGameController.instance:scoreAction()
end

function TripleMacthesFindScore:_specialScoreAction()
	TripleMachesGameController.instance:scoreAction()
end

function TripleMacthesFindScore:onExit()
	return
end

return TripleMacthesFindScore
