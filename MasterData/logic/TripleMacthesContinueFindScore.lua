-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesContinueFindScore.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesContinueFindScore", package.seeall)

local TripleMacthesContinueFindScore = class("TripleMacthesContinueFindScore")

function TripleMacthesContinueFindScore:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesContinueFindScore:onEnter()
	TripleMacthesGameModel.instance:clearOperate()
	TripleMacthesGameModel.instance:clearNeedResetCell()
	TripleMacthesGameModel.instance:clearAllIce()

	if TripleMacthesGameModel.instance:checkRemoveDataAll() == true then
		TripleMacthesGameModel.instance:setCombo()

		local hasCheckGroup = {}

		for i, v in pairs(TripleMacthesGameModel.instance:getRemoveGroup()) do
			if not hasCheckGroup[v] then
				hasCheckGroup[v] = true

				if v:hasSpecial() == true then
					local cellMo = SxGameCellMO.New()

					cellMo._type = TripleMacthesGameModel.instance:getRemoveCreateItem(v.maxCount1, v.maxCount2, v.totalNum, v.hasMatx)

					local targetCell = v.mos[1]

					table.insert(cellMo._addType, targetCell._type)

					cellMo._x = targetCell._x
					cellMo._y = targetCell._y

					cellMo:initCell()
					TripleMacthesGameModel.instance:addSpecial(cellMo)
				end
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.RemoveCell)
		GlobalDispatcher:dispatch(GlobalNotify.Combo)
	else
		TripleMacthesGameModel.instance:resetRemoveGroup()
		GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesComboFish, TripleMacthesGameModel.instance:getCombo())
		TripleMacthesGameModel.instance:comBoFish()
		TripleMachesGameController.instance:defaultState()
	end
end

function TripleMacthesContinueFindScore:onExit()
	return
end

return TripleMacthesContinueFindScore
