-- chunkname: @modules/logic/fight/view/preview/SkillEditorSkillSelectOutline.lua

module("modules.logic.fight.view.preview.SkillEditorSkillSelectOutline", package.seeall)

local SkillEditorSkillSelectOutline = class("SkillEditorSkillSelectOutline", BaseView)
local BuffOutlinePath = "buff/buff_outline"

function SkillEditorSkillSelectOutline:onInitView()
	self._effectWrapDict = {}
	self._enableOutline = false
end

function SkillEditorSkillSelectOutline:addEvents()
	self.addEventCb(self, SkillEditorMgr.instance, SkillEditorMgr.OnSelectEntity, self._onSelectEntity, self)
	self.addEventCb(self, SkillEditorMgr.instance, SkillEditorMgr.OnClickOutline, self._onClickOutline, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
end

function SkillEditorSkillSelectOutline:removeEvents()
	self.removeEventCb(self, SkillEditorMgr.instance, SkillEditorMgr.OnSelectEntity, self._onSelectEntity, self)
	self.removeEventCb(self, SkillEditorMgr.instance, SkillEditorMgr.OnClickOutline, self._onClickOutline, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	self.removeEventCb(self, FightController.instance, FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
end

function SkillEditorSkillSelectOutline:_beforeEntityDestroy(entity)
	local entityId = entity and entity.id
	local effectWrap = entityId and self._effectWrapDict[entityId]

	if effectWrap then
		self._effectWrapDict[entityId] = nil
	end
end

function SkillEditorSkillSelectOutline:_onClickOutline()
	self._enableOutline = not self._enableOutline

	if self._enableOutline then
		self:_updateOutline()
	else
		for oneEntityId, effectWrap in pairs(self._effectWrapDict) do
			if not gohelper.isNil(effectWrap.containerGO) then
				effectWrap:setActive(false)
			else
				FightRenderOrderMgr.instance:onRemoveEffectWrap(oneEntityId, effectWrap)

				self._effectWrapDict[oneEntityId] = nil
			end
		end
	end
end

function SkillEditorSkillSelectOutline:_onSpineLoaded(side, entityId)
	TaskDispatcher.cancelTask(self._refreshOnLoad, self)
	TaskDispatcher.runDelay(self._refreshOnLoad, self, 0.1)
end

function SkillEditorSkillSelectOutline:_refreshOnLoad(side, entityId)
	for _, effectWrap in pairs(self._effectWrapDict) do
		if not gohelper.isNil(effectWrap.containerGO) and effectWrap.containerGO.activeSelf then
			effectWrap:setActive(false)
			effectWrap:setActive(true)
		end
	end
end

function SkillEditorSkillSelectOutline:_onSelectEntity(side, entityId)
	if not self._enableOutline then
		return
	end

	if side ~= FightEnum.EntitySide.EnemySide then
		return
	end

	self:_updateOutline()
end

function SkillEditorSkillSelectOutline:_updateOutline()
	local entityMgr = FightGameMgr.entityMgr
	local entityId = entityMgr:getEntityByPosId(SceneTag.UnitMonster, SkillEditorView.selectPosId[FightEnum.EntitySide.EnemySide]).id
	local entity = FightHelper.getEntity(entityId)
	local effectWrap = self._effectWrapDict[entityId]

	if not effectWrap then
		local entity = FightHelper.getEntity(entityId)

		if entity and entity.effect then
			local effectWrap = entity.effect:addHangEffect(BuffOutlinePath, ModuleEnum.SpineHangPointRoot, nil, nil, nil, true)

			effectWrap:setLocalPos(0, 0, 0)

			self._effectWrapDict[entityId] = effectWrap

			FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)
		end
	end

	for oneEntityId, effectWrap in pairs(self._effectWrapDict) do
		if not gohelper.isNil(effectWrap.containerGO) then
			effectWrap:setActive(oneEntityId == entityId)
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(oneEntityId, effectWrap)

			self._effectWrapDict[entityId] = nil
		end
	end
end

return SkillEditorSkillSelectOutline
