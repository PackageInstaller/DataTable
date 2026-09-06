-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationFindScore.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationFindScore", package.seeall)

local ThreeEliminationFindScore = class("ThreeEliminationFindScore")

function ThreeEliminationFindScore:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationFindScore:onEnter()
	local cellMo

	self._actionArray = ThreeEliminationModel.instance:getActions()
	self._mapCells = ThreeEliminationModel.instance:getGameMapArr()
	self._activityId = ThreeEliminationModel.instance:getActivityId()

	if self._actionArray:GetSize() == 2 then
		local preCell = self._actionArray:Get(0)
		local afterCell = self._actionArray:Get(1)

		ThreeEliminationModel.instance:clearOperate()
		ThreeEliminationModel.instance:clearNeedResetCell()

		local canRemovePre, afterRemovePre, hasDestroy, isBlock = false, false, false, false

		if preCell._type == SxGameCellType.Destroy and afterCell._type == SxGameCellType.Destroy then
			-- block empty
		elseif preCell._type == SxGameCellType.Destroy then
			local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, afterCell._type)

			if cfg.evolvedId > 0 then
				ThreeEliminationModel.instance:AddRemoveOp(afterCell._x, afterCell._y, -1, -1, true)
				ThreeEliminationModel.instance:addRemoveByStep(afterCell._type, 1)

				hasDestroy = true
			else
				isBlock = true

				FloatWordMgr.instance:show(lang("最高品质的已自动上阵"))
			end
		elseif afterCell._type == SxGameCellType.Destroy then
			local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, preCell._type)

			if cfg.evolvedId > 0 then
				ThreeEliminationModel.instance:AddRemoveOp(preCell._x, preCell._y, -1, -1, true)
				ThreeEliminationModel.instance:addRemoveByStep(preCell._type, 1)

				hasDestroy = true
			else
				isBlock = true

				FloatWordMgr.instance:show(lang("最高品质的已自动上阵"))
			end
		else
			local removeCountPre, removeCountAfter, needCreatePre, needCreateAfter

			canRemovePre, removeCountPre, needCreatePre = ThreeEliminationModel.instance:checkDataByPoints(preCell._x, preCell._y)
			afterRemovePre, removeCountAfter, needCreateAfter = ThreeEliminationModel.instance:checkDataByPoints(afterCell._x, afterCell._y)

			if needCreatePre == true then
				ThreeEliminationModel.instance:addRemoveByStep(self._mapCells[preCell._y][preCell._x]._type, removeCountPre)

				cellMo = ThreeEliminationCellMO.New()

				local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, self._mapCells[preCell._y][preCell._x]._type)

				cellMo._type = cfg.evolvedId > 0 and cfg.evolvedId or self._mapCells[preCell._y][preCell._x]._type
				cellMo._x = preCell._x
				cellMo._y = preCell._y

				cellMo:initCell()
				ThreeEliminationModel.instance:addSpecial(cellMo)
			end

			if needCreateAfter == true then
				ThreeEliminationModel.instance:addRemoveByStep(self._mapCells[afterCell._y][afterCell._x]._type, removeCountAfter)

				cellMo = ThreeEliminationCellMO.New()

				local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, self._mapCells[afterCell._y][afterCell._x]._type)

				cellMo._type = cfg.evolvedId > 0 and cfg.evolvedId or self._mapCells[afterCell._y][afterCell._x]._type
				cellMo._x = afterCell._x
				cellMo._y = afterCell._y

				cellMo:initCell()
				ThreeEliminationModel.instance:addSpecial(cellMo)
			end
		end

		if canRemovePre or afterRemovePre or hasDestroy then
			settimer(0.1, self._scoreAction, self, false)
		elseif not isBlock then
			settimer(0.1, self._moveEndFunc, self, false)
		else
			settimer(0.1, self._moveBackFunc, self, false)
		end
	else
		ThreeEliminationController.instance:defaultState()
	end
end

function ThreeEliminationFindScore:_moveBackFunc()
	ThreeEliminationModel.instance:removeAction()
	ThreeEliminationController.instance:defaultState()
end

function ThreeEliminationFindScore:_moveEndFunc()
	GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesComboFish, ThreeEliminationModel.instance:getCombo())
	ThreeEliminationModel.instance:removeAction()
	ThreeEliminationController.instance:defaultState()
end

function ThreeEliminationFindScore:_scoreAction()
	GlobalDispatcher:dispatch(GlobalNotify.NextStep)
end

function ThreeEliminationFindScore:_specialScoreAction()
	ThreeEliminationController.instance:scoreAction()
end

function ThreeEliminationFindScore:onExit()
	return
end

return ThreeEliminationFindScore
