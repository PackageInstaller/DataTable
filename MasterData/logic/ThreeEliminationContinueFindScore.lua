-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationContinueFindScore.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationContinueFindScore", package.seeall)

local ThreeEliminationContinueFindScore = class("ThreeEliminationContinueFindScore")

function ThreeEliminationContinueFindScore:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationContinueFindScore:onEnter()
	ThreeEliminationModel.instance:clearOperate()
	ThreeEliminationModel.instance:clearNeedResetCell()

	self._activityId = ThreeEliminationModel.instance:getActivityId()
	self._mapCells = ThreeEliminationModel.instance:getGameMapArr()

	local hasRemove, needCreate = ThreeEliminationModel.instance:checkRemoveDataAll(self._activityId)

	for i, mo in ipairs(needCreate) do
		local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, self._mapCells[mo._y][mo._x]._type)

		cellMo = ThreeEliminationCellMO.New()
		cellMo._type = cfg.evolvedId > 0 and cfg.evolvedId or self._mapCells[mo._y][mo._x]._type
		cellMo._x = mo._x
		cellMo._y = mo._y

		cellMo:initCell()
		ThreeEliminationModel.instance:addSpecial(cellMo)
	end

	if hasRemove == true then
		ThreeEliminationModel.instance:setCombo()
		GlobalDispatcher:dispatch(GlobalNotify.ThreeEliminationContinue)
		GlobalDispatcher:dispatch(GlobalNotify.Combo)
	else
		GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesComboFish, ThreeEliminationModel.instance:getCombo())
		ThreeEliminationModel.instance:comBoFish()
		ThreeEliminationController.instance:defaultState()
	end
end

function ThreeEliminationContinueFindScore:onExit()
	return
end

return ThreeEliminationContinueFindScore
