-- chunkname: @modules/logic/fight/entity/buff/FightHideZongMaoSceneEffect.lua

module("modules.logic.fight.entity.buff.FightHideZongMaoSceneEffect", package.seeall)

local FightHideZongMaoSceneEffect = class("FightHideZongMaoSceneEffect", FightBaseClass)

function FightHideZongMaoSceneEffect:onConstructor(sceneEffect)
	self.tweenComp = self:addComponent(FightTweenComponent)
	self.sceneEffect = sceneEffect
	self.sceneEffectMat = self.sceneEffect:GetComponent(typeof(UnityEngine.MeshRenderer)).material
	self.matKeyId = UnityEngine.Shader.PropertyToID("_SourceColLerp")

	self.tweenComp:DOTweenFloat(0.3, 1, 1, self.onTweenFloat, nil, self)
	self:com_registTimer(self.disposeSelf, 1.1)
end

function FightHideZongMaoSceneEffect:onTweenFloat(value)
	MaterialUtil.setPropValue(self.sceneEffectMat, self.matKeyId, "float", value)
end

function FightHideZongMaoSceneEffect:onDestructor()
	gohelper.destroy(self.sceneEffect)
end

return FightHideZongMaoSceneEffect
