-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/message/BattleMessageUnit.lua

module("logic.battle.message.BattleMessageUnit", package.seeall)

local M = class("BattleMessageUnit", EffectUnitBase)

function M:ctor()
	self.mainGO = goutil.create("BattleMessageUnit", false)
	self._compList = {}

	self:_initComponents()
	self:_notifyComponents(BattleFunctionName.onInit)
end

function M:_initComponents()
	self:_addComponent("loader", EffectCompLoader)
	self:_addComponent("uiProxy", BattleMessageCompUIProxy)
	self:_addComponent("lifeTime", EffectCompLifeTime)
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:getEntityId()
	return self._entityId
end

function M:destroyUnit()
	self.lifeTime:destroyUnit()
end

return M
