-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesSpecialState.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesSpecialState", package.seeall)

local TripleMacthesSpecialState = class("TripleMacthesSpecialState")

function TripleMacthesSpecialState:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesSpecialState:onEnter()
	TripleMachesGameController.instance:changeAllEmptyShow(false)

	self._actionArray = TripleMacthesGameModel.instance:getActions()

	local count = self._actionArray:GetSize()

	if count > 0 and self._actionArray:Get(count - 1) and self._actionArray:Get(count - 1)._type then
		local type = self._actionArray:Get(count - 1)._type

		if TripleMacthesGameModel.instance:_isSpecial(type) then
			local action = self._actionArray:Get(count - 1)

			TripleMacthesGameModel.instance:doSpecial(action._x, action._y)
			settimer(0.1, self._specialScoreAction, self, false)
		else
			TripleMachesGameController.instance:defaultState()
		end
	else
		TripleMachesGameController.instance:defaultState()
	end
end

function TripleMacthesSpecialState:_specialScoreAction()
	TripleMachesGameController.instance:scoreAction()
end

function TripleMacthesSpecialState:onExit()
	return
end

return TripleMacthesSpecialState
