-- chunkname: @modules/logic/gm/controller/GMFightController.lua

module("modules.logic.gm.controller.GMFightController", package.seeall)

local GMFightController = class("GMFightController", BaseController)

function GMFightController:ctor()
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, self._onExitScene, self)
end

function GMFightController:_onExitScene()
	self.buffTypeId = nil
end

function GMFightController:startStatBuffType(buffTypeId)
	self.buffTypeId = buffTypeId

	local entityMgr = FightGameMgr.entityMgr
	local enemyList = entityMgr:getTagList(SceneTag.UnitMonster)

	for _, entity in ipairs(enemyList) do
		self:addStatBuffTypeByEntity(entity)
	end

	local playerList = entityMgr:getTagList(SceneTag.UnitPlayer)

	for _, entity in ipairs(playerList) do
		self:addStatBuffTypeByEntity(entity)
	end
end

function GMFightController:addStatBuffTypeByEntity(entity)
	local nameUi = entity.nameUI

	if nameUi then
		local containerGo = nameUi:getGO()
		local comp = MonoHelper.addLuaComOnceToGo(containerGo, FightGmNameUIComp, entity)

		comp:startStatBuffType(self.buffTypeId)
	end
end

function GMFightController:stopStatBuffType()
	self.buffTypeId = nil

	local entityMgr = FightGameMgr.entityMgr
	local enemyList = entityMgr:getTagList(SceneTag.UnitMonster)

	for _, entity in ipairs(enemyList) do
		self:stopStatBuffTypeByEntity(entity)
	end

	local playerList = entityMgr:getTagList(SceneTag.UnitPlayer)

	for _, entity in ipairs(playerList) do
		self:stopStatBuffTypeByEntity(entity)
	end
end

function GMFightController:stopStatBuffTypeByEntity(entity)
	local nameUi = entity.nameUI

	if nameUi then
		local containerGo = nameUi:getGO()
		local comp = MonoHelper.getLuaComFromGo(containerGo, FightGmNameUIComp)

		if comp then
			comp:stopStatBuffType()
		end
	end
end

function GMFightController:statingBuffType()
	return self.buffTypeId ~= nil
end

GMFightController.instance = GMFightController.New()

return GMFightController
