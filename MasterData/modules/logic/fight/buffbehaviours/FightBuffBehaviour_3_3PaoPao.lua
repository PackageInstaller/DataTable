-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_3_3PaoPao.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_3_3PaoPao", package.seeall)

local FightBuffBehaviour_3_3PaoPao = class("FightBuffBehaviour_3_3PaoPao", FightBuffBehaviourBase)

function FightBuffBehaviour_3_3PaoPao:onAddBuff(entityId, buffId, buffMo)
	self.buffId = buffId
	self.entityId = entityId
	self.entityMo = FightDataHelper.entityMgr:getById(entityId)

	local entity = FightHelper.getEntity(self.entityId)

	if not entity then
		self:listenSpineLoaded()

		return
	end

	if entity.spine then
		local spineGo = entity.spine:getSpineGO()

		if gohelper.isNil(spineGo) then
			self:listenSpineLoaded()

			return
		end

		self:doLogic()
	end
end

function FightBuffBehaviour_3_3PaoPao:listenSpineLoaded()
	self.addEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
end

function FightBuffBehaviour_3_3PaoPao:onSpineLoaded(spine)
	local entity = spine and spine.entity
	local entityId = entity and entity.id

	if entityId ~= self.entityId then
		return
	end

	self.removeEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
	self:doLogic()
end

function FightBuffBehaviour_3_3PaoPao:doLogic()
	self.entity = FightHelper.getEntity(self.entityId)

	local paramList = FightStrUtil.instance:getSplitCache(self.co.param, "#")

	self.effectRes = paramList[1]
	self.effectHang = paramList[2]
	self.textureName = paramList[3]
	self.texturePath = string.format("effects/dynamic/textures/%s.png", self.textureName)

	self:loadTexture()
	self:addEffect()
end

function FightBuffBehaviour_3_3PaoPao:onEntityEffectLoaded(entityId, effectWrap)
	if entityId ~= self.entityId then
		return
	end

	if self.effectWrap ~= effectWrap then
		return
	end

	self.removeEventCb(self, FightController.instance, FightEvent.EntityEffectLoaded, self.onEntityEffectLoaded, self)
	self:tryReplaceTexture()
end

function FightBuffBehaviour_3_3PaoPao:addEffect()
	self.effectWrap = self.entity.effect:addHangEffect(self.effectRes, self.effectHang)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.effectWrap)
	self.effectWrap:setLocalPos(0, 0, 0)
	self.entity.buff:addLoopBuff(self.effectWrap)

	if self:checkEffectLoaded() then
		self:tryReplaceTexture()
	else
		self.addEventCb(self, FightController.instance, FightEvent.EntityEffectLoaded, self.onEntityEffectLoaded, self)
	end
end

function FightBuffBehaviour_3_3PaoPao:loadTexture()
	self.textureLoader = MultiAbLoader.New()

	self.textureLoader:addPath(self.texturePath)
	self.textureLoader:startLoad(self.onLoadedTextureDone, self)
end

function FightBuffBehaviour_3_3PaoPao:onLoadedTextureDone()
	local assetItem = self.textureLoader:getAssetItem(self.texturePath)

	self.texture = assetItem and assetItem:GetResource()

	self:tryReplaceTexture()
end

function FightBuffBehaviour_3_3PaoPao:checkEffectLoaded()
	if not self.effectWrap then
		return
	end

	local effectGo = self.effectWrap.effectGO

	if gohelper.isNil(effectGo) then
		return
	end

	return true
end

local TextureId = UnityEngine.Shader.PropertyToID("_SubTex")

function FightBuffBehaviour_3_3PaoPao:tryReplaceTexture()
	if not self:checkEffectLoaded() then
		return
	end

	if gohelper.isNil(self.texture) then
		return
	end

	local effectGo = self.effectWrap.effectGO
	local textureGo = gohelper.findChild(effectGo, "root/l_mask1")
	local render = effectGo and textureGo:GetComponent(gohelper.Type_Render)
	local mat = render and render.material

	if mat then
		mat:SetTexture(TextureId, self.texture)
	end
end

function FightBuffBehaviour_3_3PaoPao:onUpdateBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_3_3PaoPao:onRemoveBuff(entityId, buffId, buffMo)
	self:clear()
end

function FightBuffBehaviour_3_3PaoPao:clear()
	if self.effectWrap and self.entity then
		self.entity.buff:removeLoopBuff(self.effectWrap)
		self.entity.effect:removeEffect(self.effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.effectWrap)
	end

	self.effectWrap = nil
	self.entity = nil

	if self.textureLoader then
		self.textureLoader:dispose()

		self.textureLoader = nil
	end
end

function FightBuffBehaviour_3_3PaoPao:onDestroy()
	self:clear()
	FightBuffBehaviour_3_3PaoPao.super.onDestroy(self)
end

return FightBuffBehaviour_3_3PaoPao
