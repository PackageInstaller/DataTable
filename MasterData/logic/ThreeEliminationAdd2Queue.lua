-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationAdd2Queue.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationAdd2Queue", package.seeall)

local ThreeEliminationAdd2Queue = class("ThreeEliminationAdd2Queue")

function ThreeEliminationAdd2Queue:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationAdd2Queue:onEnter()
	if ThreeEliminationModel.instance:getActions():GetSize() == 2 then
		ThreeEliminationModel.instance:removePreRemoveCell()
		ThreeEliminationModel.instance:removeIncreasePet()

		local cell = ThreeEliminationModel.instance:getActions():Get(1)

		ThreeEliminationController.instance:viewSwap()
	elseif ThreeEliminationModel.instance:getActions():GetSize() == 1 then
		ThreeEliminationModel.instance:removePreRemoveCell()
		ThreeEliminationModel.instance:removeIncreasePet()
	elseif ThreeEliminationModel.instance:getActions():GetSize() == 0 then
		ThreeEliminationModel.instance:removePreRemoveCell()
		ThreeEliminationModel.instance:removeIncreasePet()
		ThreeEliminationModel.instance:removeAction()
		ThreeEliminationController.instance:defaultState()
	end
end

function ThreeEliminationAdd2Queue:onExit()
	return
end

return ThreeEliminationAdd2Queue
