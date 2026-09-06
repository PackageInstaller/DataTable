-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesAdd2Queue.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesAdd2Queue", package.seeall)

local TripleMacthesAdd2Queue = class("TripleMacthesAdd2Queue")

function TripleMacthesAdd2Queue:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesAdd2Queue:onEnter()
	if TripleMacthesGameModel.instance:getActions():GetSize() == 2 then
		TripleMacthesGameModel.instance:removePreRemoveCell()

		local cell = TripleMacthesGameModel.instance:getActions():Get(1)

		if TripleMacthesGameModel.instance:_isSpecial(cell._type) then
			TripleMachesGameController.instance:specialState()
		elseif TripleMacthesGameModel.instance:isStoodType(cell._type) or cell._type == SxGameCellType.Empty or TripleMacthesGameModel.instance:isIce(cell._x, cell._y) == true then
			TripleMacthesGameModel.instance:removeAction()
			TripleMachesGameController.instance:defaultState()
		else
			TripleMachesGameController.instance:viewSwap()
		end
	elseif TripleMacthesGameModel.instance:getActions():GetSize() == 1 then
		TripleMacthesGameModel.instance:removePreRemoveCell()

		local cell = TripleMacthesGameModel.instance:getActions():Get(0)

		if TripleMacthesGameModel.instance:_isSpecial(cell._type) then
			TripleMachesGameController.instance:specialState()
		elseif TripleMacthesGameModel.instance:isStoodType(cell._type) or cell._type == SxGameCellType.Empty or TripleMacthesGameModel.instance:isIce(cell._x, cell._y) == true then
			TripleMacthesGameModel.instance:removeAction()
			TripleMachesGameController.instance:defaultState()
		end
	end
end

function TripleMacthesAdd2Queue:onExit()
	return
end

return TripleMacthesAdd2Queue
