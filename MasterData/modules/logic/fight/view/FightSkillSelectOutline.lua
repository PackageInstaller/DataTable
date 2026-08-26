-- chunkname: @modules/logic/fight/view/FightSkillSelectOutline.lua

module("modules.logic.fight.view.FightSkillSelectOutline", package.seeall)

local FightSkillSelectOutline = class("FightSkillSelectOutline", BaseView)
local KeyWord = "_OutlineWidth"
local BuffOutlinePath = "buff/buff_outline"

function FightSkillSelectOutline:onInitView()
	return
end

function FightSkillSelectOutline:onOpen()
	self._effectWrapDict = {}
	self._matDict = self:getUserDataTb_()
end

function FightSkillSelectOutline:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.AutoToSelectSkillTarget, self._hideOutlineEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.SelectSkillTarget, self._onSelectSkillTarget, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function FightSkillSelectOutline:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self.removeEventCb(self, FightController.instance, FightEvent.AutoToSelectSkillTarget, self._hideOutlineEffect, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SelectSkillTarget, self._onSelectSkillTarget, self)
	self.removeEventCb(self, FightController.instance, FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function FightSkillSelectOutline:onDestroyView()
	return
end

function FightSkillSelectOutline:onStageChange(stageType)
	if stageType == FightStageMgr.StageType.Play then
		self:_hideOutlineEffect()
	end
end

function FightSkillSelectOutline:_onSkillPlayStart()
	self:_hideOutlineEffect()
end

function FightSkillSelectOutline:_onCameraFocusChanged(isFocus)
	if isFocus then
		self:_hideOutlineEffect()
	else
		self:_onSelectSkillTarget(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function FightSkillSelectOutline:onOpenView(viewName)
	if viewName == ViewName.FightEnemyActionView then
		self:_hideOutlineEffect()
	end
end

function FightSkillSelectOutline:onCloseView(viewName)
	if viewName == ViewName.FightEnemyActionView then
		self:_onSelectSkillTarget(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function FightSkillSelectOutline:_beforeEntityDestroy(entity)
	local entityId = entity and entity.id
	local effectWrap = entityId and self._effectWrapDict[entityId]

	if effectWrap then
		self._effectWrapDict[entityId] = nil
	end
end

function FightSkillSelectOutline:_hideOutlineEffect()
	for oneEntityId, effectWrap in pairs(self._effectWrapDict) do
		if not gohelper.isNil(effectWrap.containerGO) then
			effectWrap:setActive(false)
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(oneEntityId, effectWrap)

			self._effectWrapDict[oneEntityId] = nil
		end
	end
end

function FightSkillSelectOutline:_onSelectSkillTarget(entityId)
	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local effectWrap = self._effectWrapDict[entityId]

	if not effectWrap then
		local entity = FightHelper.getEntity(entityId)

		if entity and entity.effect then
			local effectWrap = entity.effect:addHangEffect(BuffOutlinePath, ModuleEnum.SpineHangPointRoot, nil, nil, nil, true)

			effectWrap:setLocalPos(0, 0, 0)

			if gohelper.isNil(effectWrap.effectGO) then
				effectWrap:setCallback(function()
					self:_setOutlineWidth(entityId)
				end)
			else
				self:_setOutlineWidth(entityId)
			end

			self._effectWrapDict[entityId] = effectWrap

			FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)
		end
	end

	for oneEntityId, effectWrap in pairs(self._effectWrapDict) do
		if not gohelper.isNil(effectWrap.containerGO) then
			effectWrap:setActive(oneEntityId == entityId)

			if oneEntityId == entityId then
				self:_setOutlineWidth(oneEntityId)
			end
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(oneEntityId, effectWrap)

			self._effectWrapDict[entityId] = nil
		end
	end
end

function FightSkillSelectOutline:_setOutlineWidth(entityId)
	local mat = self._matDict[entityId]

	if not mat then
		local effectWrap = self._effectWrapDict[entityId]

		if effectWrap and not gohelper.isNil(effectWrap.effectGO) then
			local renderer = gohelper.findChildComponent(effectWrap.effectGO, "diamond/root/diamond", typeof(UnityEngine.Renderer))

			if renderer then
				mat = renderer.material

				if renderer.material then
					self._matDict[entityId] = mat
					self._defaultOutlineWidth = self._defaultOutlineWidth or mat:GetFloat(KeyWord)
				else
					logError("outline material not found")
				end
			else
				logError("outline render not found")
			end
		end
	end

	if mat then
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if entityMO then
			::label_15_0::

			local var_15_0 = entityMO.skin

			if entityMO.skin then
				local skinCO = lua_monster_skin.configDict[entityMO.skin]
				local value = skinCO and skinCO.outlineWidth

				if value and value > 0 then
					mat:SetFloat(KeyWord, value)
				else
					mat:SetFloat(KeyWord, self._defaultOutlineWidth)
				end
			end
		end
	end
end

return FightSkillSelectOutline
