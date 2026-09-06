-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameAdd2Queue.lua

module("logic.extensions.sxgame.view.state.SxGameAdd2Queue", package.seeall)

local SxGameAdd2Queue = class("SxGameAdd2Queue")

function SxGameAdd2Queue:ctor(stateName)
	self._stateName = stateName
end

function SxGameAdd2Queue:onEnter()
	if SxGameModel.instance:getActions():GetSize() == 2 then
		SxGameModel.instance:removePreRemoveCell()

		local cell = SxGameModel.instance:getActions():Get(1)

		if SxGameModel.instance:_isSpecial(cell._type) then
			SxGameController.instance:specialState()
		elseif SxGameModel.instance:isStoodType(cell._type) or cell._type == SxGameCellType.Empty or SxGameModel.instance:isIce(cell._x, cell._y) == true then
			SxGameModel.instance:removeAction()
			SxGameController.instance:defaultState()
		else
			SxGameController.instance:viewSwap()
		end
	elseif SxGameModel.instance:getActions():GetSize() == 1 then
		SxGameModel.instance:removePreRemoveCell()

		local cell = SxGameModel.instance:getActions():Get(0)

		if SxGameModel.instance:_isSpecial(cell._type) then
			SxGameController.instance:specialState()
		elseif SxGameModel.instance:isStoodType(cell._type) or cell._type == SxGameCellType.Empty or SxGameModel.instance:isIce(cell._x, cell._y) == true then
			SxGameModel.instance:removeAction()
			SxGameController.instance:defaultState()
		end
	end
end

function SxGameAdd2Queue:onExit()
	return
end

return SxGameAdd2Queue
