-- chunkname: @modules/logic/versionactivity3_9/hedone/view/entity/HedoneEffectEntity.lua

module("modules.logic.versionactivity3_9.hedone.view.entity.HedoneEffectEntity", package.seeall)

local HedoneEffectEntity = class("HedoneEffectEntity", HedoneBaseEntity)

function HedoneEffectEntity:_doActiveGO()
	local id = self:getId()
	local entityRes = HedoneConfig.instance:getHedoneEffectEntityRes(id)

	if string.nilorempty(entityRes) then
		self._canvasGroup.alpha = 0
	else
		self:refreshScale()
		self:refreshPosition()

		self._canvasGroup.alpha = 1
	end
end

function HedoneEffectEntity:getPrefabResPath()
	local id = self:getId()
	local entityRes = HedoneConfig.instance:getHedoneEffectEntityRes(id)

	if not string.nilorempty(entityRes) then
		return string.format(HedoneGameEnum.Const.EffectResPath, entityRes)
	end
end

return HedoneEffectEntity
