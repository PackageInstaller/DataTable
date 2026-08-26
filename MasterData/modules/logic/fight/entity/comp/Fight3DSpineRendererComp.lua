-- chunkname: @modules/logic/fight/entity/comp/Fight3DSpineRendererComp.lua

module("modules.logic.fight.entity.comp.Fight3DSpineRendererComp", package.seeall)

local Fight3DSpineRendererComp = class("Fight3DSpineRendererComp", FightBaseClass)
local ShaderColorName = "_ScriptCtrlColor"

function Fight3DSpineRendererComp:onConstructor(entity)
	self.entity = entity
	self.rendererList = nil
	self.materialList = nil
	self.actorMaterialController = nil
	self.replaceMatByPath = {}
	self.color = UnityEngine.Color(1, 1, 1, 1)
	self.tweenComp = self:addComponent(FightTweenComponent)
end

function Fight3DSpineRendererComp:onDestructor()
	if self.materialList then
		for i = 1, #self.materialList do
			local mat = self.materialList[i]

			if not gohelper.isNil(mat) then
				gohelper.destroy(mat)
			end
		end

		self.materialList = nil
	end

	for k, v in pairs(self.replaceMatByPath) do
		if not gohelper.isNil(v) then
			gohelper.destroy(v)
		end
	end

	self.actorMaterialController = nil

	if not gohelper.isNil(self.entity.go) then
		gohelper.removeComponent(self.entity.go, typeof(ZProj.ActorMaterialController))
	end
end

function Fight3DSpineRendererComp:onSkillPlayStart(entity, curSkillId, stepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.uid ~= self.entity.id and FightCardDataHelper.isBigSkill(curSkillId) then
		self.actorMaterialController.isPlaneActive = true
	end
end

function Fight3DSpineRendererComp:onSkillPlayFinish(entity, curSkillId, stepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.uid ~= self.entity.id and FightCardDataHelper.isBigSkill(curSkillId) then
		self.actorMaterialController.isPlaneActive = false
	end
end

function Fight3DSpineRendererComp:onSet3_7BossPlane(isActive)
	self.actorMaterialController.isPlaneActive = isActive
end

function Fight3DSpineRendererComp:initActorMaterialController()
	if not self.actorMaterialController then
		self.actorMaterialController = gohelper.onceAddComponent(self.entity.go, typeof(ZProj.ActorMaterialController))

		self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
		self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
		self:com_registMsg(FightMsgId.Set3_7BossPlane, self.onSet3_7BossPlane)

		self.actorMaterialController.isPlaneActive = false
	end

	self.actorMaterialController.updatePosition = true
	self.actorMaterialController.depthScale = 0.99
	self.actorMaterialController.depthOffset = 0.5
	self.actorMaterialController.cmr = CameraMgr.instance:getUnitCamera()
	self.depthOffset = self.actorMaterialController.depthOffset

	self.actorMaterialController:RefreshMaterials()
end

function Fight3DSpineRendererComp:setSpine(unitSpine)
	local gameObject = unitSpine:getSpineGO()

	if not gohelper.isNil(gameObject) then
		self.spineGameObject = gameObject
		self.rendererList = gameObject:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer), true)
		self.materialList = {}

		for i = 0, self.rendererList.Length - 1 do
			local renderer = self.rendererList[i]

			if not gohelper.isNil(renderer) then
				for index = 0, renderer.materials.Length - 1 do
					table.insert(self.materialList, renderer.materials[index])
				end
			end
		end
	end

	self:initActorMaterialController()
	self:setAlpha(self.color.a)
end

function Fight3DSpineRendererComp:setMat(path, matName)
	if not self.spineGameObject then
		return
	end

	local gameObject = gohelper.findChild(self.spineGameObject, path)

	if not gohelper.isNil(gameObject) then
		local renderer = gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))

		if not gohelper.isNil(renderer) then
			local tab = {}

			tab.path = path
			tab.renderer = renderer

			self:com_loadAsset(matName, self.onSetMatLoaded, tab)
		end
	end
end

function Fight3DSpineRendererComp:onSetMatLoaded(success, assetItem, tab)
	if not success then
		return
	end

	local mat = UnityEngine.Object.Instantiate(assetItem:GetResource())

	if not gohelper.isNil(tab.renderer) then
		tab.renderer.material = mat
		self.replaceMatByPath[tab.path] = mat
	end
end

function Fight3DSpineRendererComp:hasSkeletonAnim()
	return true
end

function Fight3DSpineRendererComp:getReplaceMat()
	return self.materialList and self.materialList[1]
end

function Fight3DSpineRendererComp:getCloneOriginMat()
	return self.materialList and self.materialList[1]
end

function Fight3DSpineRendererComp:getSpineRenderMat()
	return self.materialList and self.materialList[1]
end

function Fight3DSpineRendererComp:replaceSpineMat(mat)
	return
end

function Fight3DSpineRendererComp:resetSpineMat()
	return
end

function Fight3DSpineRendererComp:setAlpha(alpha, duration)
	if not self.materialList then
		self.color.a = alpha

		return
	end

	self.tweenComp:DOTweenFloat(self.color.a, alpha, duration or 0, self._frameCallback, self._finishCallback, self)
end

function Fight3DSpineRendererComp:_frameCallback(alpha)
	self.color.a = alpha

	for i = 1, #self.materialList do
		self.materialList[i]:SetColor(ShaderColorName, self.color)
	end
end

function Fight3DSpineRendererComp:_finishCallback()
	return
end

return Fight3DSpineRendererComp
