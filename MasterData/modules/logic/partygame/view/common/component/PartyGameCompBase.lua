-- chunkname: @modules/logic/partygame/view/common/component/PartyGameCompBase.lua

module("modules.logic.partygame.view.common.component.PartyGameCompBase", package.seeall)

local PartyGameCompBase = class("PartyGameCompBase", LuaCompBase)

function PartyGameCompBase:ctor(param)
	self.dataParam = param
end

function PartyGameCompBase:init(viewGO)
	self.viewGO = viewGO
	self.curGame = PartyGameController.instance:getCurPartyGame()
	self.gameInterfaceBaseCS = PartyGame.Runtime.GameLogic.GameInterfaceBase

	self:onInit()
end

function PartyGameCompBase:addEventListeners()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.updateView, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.PartyLittleGameEnd, self.updateView, self)
	self:onAddListeners()
end

function PartyGameCompBase:removeEventListeners()
	self:onRemoveListeners()
end

function PartyGameCompBase:updateView(logicFrame)
	if self.curGame == nil then
		return
	end

	self:onViewUpdate(logicFrame)
end

function PartyGameCompBase:setIsShow(v)
	gohelper.setActive(self.viewGO, v)
end

function PartyGameCompBase:setData(data, ...)
	self.data = data

	self:onSetData(data, ...)
	self:onViewUpdate()
end

function PartyGameCompBase:onInit()
	return
end

function PartyGameCompBase:onAddListeners()
	return
end

function PartyGameCompBase:onRemoveListeners()
	return
end

function PartyGameCompBase:onSetData(data)
	return
end

function PartyGameCompBase:onViewUpdate(logicFrame)
	return
end

return PartyGameCompBase
