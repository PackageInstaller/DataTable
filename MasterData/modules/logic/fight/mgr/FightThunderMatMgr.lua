-- chunkname: @modules/logic/fight/mgr/FightThunderMatMgr.lua

module("modules.logic.fight.mgr.FightThunderMatMgr", package.seeall)

local FightThunderMatMgr = class("FightThunderMatMgr", FightBaseClass)

function FightThunderMatMgr:onConstructor()
	local curScene = GameSceneMgr.instance:getCurScene()

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
end

function FightThunderMatMgr:onLevelLoaded(levelId)
	self._sceneCtrl02Comp = nil

	local sceneContainerGO = GameSceneMgr.instance:getCurScene():getSceneContainerGO()
	local compList = sceneContainerGO:GetComponentsInChildren(typeof(ZProj.SceneCtrl02))

	if compList.Length > 0 then
		self._sceneCtrl02Comp = compList[0]
		self._deadIdDict = {}
		self.eventComp = self:addComponent(FightEventComponent)

		self.eventComp:registEvent(FightController.instance, FightEvent.BeforePlayUniqueSkill, self._beforePlayUniqueSkill, self)
		self.eventComp:registEvent(FightController.instance, FightEvent.AfterPlayUniqueSkill, self._afterPlayUniqueSkill, self)
		self.eventComp:registEvent(FightController.instance, FightEvent.BeforeDeadEffect, self._beforeDeadEffect, self)
		self.eventComp:registEvent(FightController.instance, FightEvent.OnSpineMaterialChange, self._onSpineMaterialChange, self)
		self.eventComp:registEvent(FightController.instance, FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
		self.eventComp:registEvent(FightController.instance, FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
		self.eventComp:registEvent(FightController.instance, FightEvent.PushEndFight, self._onEndFight, self)
		self:_setAllSpineMat()
	elseif self.eventComp then
		self.eventComp:disposeSelf()

		self.eventComp = nil
	end
end

function FightThunderMatMgr:_setAllSpineMat()
	if self._sceneCtrl02Comp then
		local entityList = FightHelper.getAllEntitysContainUnitNpc()

		for _, entity in ipairs(entityList) do
			if entity.spineRenderer then
				local material = entity.spineRenderer:getReplaceMat()

				self._sceneCtrl02Comp:SetSpineMat(tostring(entity.id), material)
			end
		end
	end
end

function FightThunderMatMgr:_onSpineLoaded(unitSpine)
	if self._sceneCtrl02Comp then
		local entity = unitSpine.unitSpawn
		local entityId = entity.id

		if entity.spineRenderer then
			local material = entity.spineRenderer:getReplaceMat()

			self._sceneCtrl02Comp:SetSpineMat(tostring(entityId), material)
		end
	end
end

function FightThunderMatMgr:_beforeEntityDestroy(entity)
	if self._sceneCtrl02Comp and entity and entity.spineRenderer then
		self._sceneCtrl02Comp:SetSpineMat(tostring(entity.id), nil)
	end
end

function FightThunderMatMgr:_onSpineMaterialChange(entityId, material)
	if self._sceneCtrl02Comp and not self._deadIdDict[entityId] then
		self._sceneCtrl02Comp:SetSpineMat(tostring(entityId), material)
	end
end

function FightThunderMatMgr:_beforeDeadEffect(entityId)
	self._deadIdDict[entityId] = true

	self._sceneCtrl02Comp:SetSpineMat(tostring(entityId), nil)
end

function FightThunderMatMgr:_beforePlayUniqueSkill(entityId)
	if self._sceneCtrl02Comp then
		self._sceneCtrl02Comp.enabled = false
	end
end

function FightThunderMatMgr:_afterPlayUniqueSkill(entityId)
	if self._sceneCtrl02Comp then
		self._sceneCtrl02Comp.enabled = true
	end
end

function FightThunderMatMgr:_onEndFight()
	if self._sceneCtrl02Comp then
		self._sceneCtrl02Comp.enabled = false
	end
end

function FightThunderMatMgr:onDestructor()
	return
end

return FightThunderMatMgr
