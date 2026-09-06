-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameSpecialState.lua

module("logic.extensions.sxgame.view.state.SxGameSpecialState", package.seeall)

local SxGameSpecialState = class("SxGameSpecialState")

function SxGameSpecialState:ctor(stateName)
	self._stateName = stateName
end

function SxGameSpecialState:onEnter()
	self._actionArray = SxGameModel.instance:getActions()

	local count = self._actionArray:GetSize()

	if count > 0 and self._actionArray:Get(count - 1) and self._actionArray:Get(count - 1)._type then
		local type = self._actionArray:Get(count - 1)._type

		if SxGameModel.instance:_isSpecial(type) then
			local action = self._actionArray:Get(count - 1)

			SxGameModel.instance:doSpecial(action._x, action._y)
			settimer(0.1, self._specialScoreAction, self, false)
		else
			SxGameController.instance:defaultState()
		end
	else
		SxGameController.instance:defaultState()
	end
end

function SxGameSpecialState:_specialScoreAction()
	SxGameController.instance:scoreAction()
end

function SxGameSpecialState:onExit()
	return
end

return SxGameSpecialState
