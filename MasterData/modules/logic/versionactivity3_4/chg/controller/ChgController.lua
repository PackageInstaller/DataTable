-- chunkname: @modules/logic/versionactivity3_4/chg/controller/ChgController.lua

module("modules.logic.versionactivity3_4.chg.controller.ChgController", package.seeall)

local ChgController = class("ChgController", BaseController)

function ChgController:onInit()
	self._sys = ChgSysModel.instance
	self._battle = ChgBattleModel.instance

	self:reInit()
end

function ChgController:reInit()
	GameUtil.onDestroyViewMember(self, "_enterFlow")
	GameUtil.onDestroyViewMember(self, "_exitFlow")
end

function ChgController:addConstEvents()
	DungeonController.instance:registerCallback(DungeonEvent.OnRemoveElement, self._onRemoveElement, self)
end

function ChgController:enterGame(elementCo)
	self:restart(elementCo and elementCo.id)
	ViewMgr.instance:openView(ViewName.V3a4_Chg_GameView)
end

function ChgController:restart(elementId)
	elementId = elementId or self._battle:elementId()

	self._battle:restart(elementId)
end

function ChgController:actId()
	return self._sys:actId()
end

function ChgController:taskType()
	return self._sys:taskType()
end

function ChgController:config()
	return self._sys:config()
end

function ChgController:showV3a4_Chg_GameStartView(viewParam)
	ViewMgr.instance:openView(ViewName.V3a4_Chg_GameStartView, viewParam or {})
end

function ChgController:showV3a4_Chg_ResultView(viewParam)
	ViewMgr.instance:openView(ViewName.V3a4_Chg_ResultView, viewParam or {})
end

function ChgController:completeGame(callback, cbObj)
	local elementCo = self._battle:getElementCo()
	local isElementFinished = DungeonModel.instance:isFinishElementList(elementCo)
	local elementId = self._battle:elementId()

	if not isElementFinished then
		DungeonRpc.instance:sendMapElementRequest(elementId, nil, callback, cbObj)
	else
		self:dispatchEvent(ChgEvent.OnGameFinished, elementId)

		if callback then
			callback(cbObj)
		end
	end
end

function ChgController:exitGame()
	self:dispatchEvent(ChgEvent.OnGameFinished)
end

function ChgController:_onRemoveElement(elementId)
	self._battle:onReceiveMapElementReply(elementId)
end

function ChgController:startGuide(guideId)
	assert(guideId)
	self:dispatchEvent(ChgEvent.GuideStart, tostring(guideId))
end

ChgController.instance = ChgController.New()

return ChgController
