-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompSpineEffect.lua

module("logicscene.scene.unit.component.battle.UnitCompSpineEffect", package.seeall)

local mountPointName = {}

mountPointName[GameEnum.MountPointType.Head] = "head"
mountPointName[GameEnum.MountPointType.Center] = "center"
mountPointName[GameEnum.MountPointType.Foot] = "foot"
mountPointName[GameEnum.MountPointType.Front] = "front"

local UnitCompSpineEffect = class("UnitCompSpineEffect", UnitComponentBase)

function UnitCompSpineEffect:ctor(unit)
	UnitCompSpineEffect.super.ctor(self, unit)

	self._effects = {}
end

function UnitCompSpineEffect:_loadConfig()
	self._effCos = {}

	local spineEff = string.split(self._unit.spineEff, ":")

	if spineEff and #spineEff > 0 then
		for _, v in ipairs(spineEff) do
			local cfg = BattleConfig.instance:getSpineEffCo(checknumber(v))

			if cfg then
				local effCo = {}

				effCo.resPath = "effect/prefabs/" .. cfg.effectPath .. ".prefab"
				effCo.bonePoint = cfg.bone

				local offset = string.split(cfg.offset, ",")

				effCo.offset = offset and #offset >= 3 and {
					checknumber(offset[1]),
					checknumber(offset[2]),
					checknumber(offset[3])
				} or {
					0,
					0,
					0
				}
				effCo.duration = -1
				effCo.bonePoint = k
				effCo.flipWithRotate = true

				table.insert(self._effCos, effCo)
			end
		end
	end
end

function UnitCompSpineEffect:createEffects()
	self:_loadConfig()

	self._effects = {}

	for k, v in pairs(self._effCos) do
		local effectIns = GameEffectManager.instance:playEffect(v.resPath, true, 0, 0, 0, 0, nil, function(target, eff)
			eff.effCo = v

			target:updateEffectPos(eff.effCo, eff)
			target:updateEffectOrder(eff)
		end, self)

		table.insert(self._effects, effectIns)
	end
end

function UnitCompSpineEffect:updateEffectPos(effCo, eff)
	goutil.addChildToParent(eff.effGo, self._unit.go)
	GoUtil.StartFollowBone(eff.effGo, self._unit.go, effCo.bonePoint)
end

function UnitCompSpineEffect:updateEffectOrder(eff)
	if self._unit.posRow ~= -1 and eff and eff.effGo then
		local order = BattleEffectOrderCtrl.getOrderByPosIndex(self._unit.posRow)

		if order then
			eff:setSortingOrderGreatZero(order)
		end
	end
end

function UnitCompSpineEffect:updateEffectLayer(eff)
	local unitLayer = self._unit.go.layer

	if eff then
		if not eff.effGo then
			local effGo
			local active = unitLayer ~= SceneLayer.SkillAnimation_Value and unitLayer ~= SceneLayer.SkillEffects_Value and unitLayer ~= SceneLayer.SkillEffects_II_Value

			if effGo then
				if active and effGo.layer ~= unitLayer then
					Framework.GameObjectUtil.SetLayerRecursively(effGo, unitLayer)
				elseif not active and effGo.layer ~= SceneLayer.Invisible_Value then
					Framework.GameObjectUtil.SetLayerRecursively(effGo, SceneLayer.Invisible_Value)
				end
			end
		end
	end
end

function UnitCompSpineEffect:update()
	if not self._effects then
		return
	end

	for _, v in ipairs(self._effects) do
		self:updateEffectOrder(v)
		self:updateEffectLayer(v)
	end
end

function UnitCompSpineEffect:onDestroy()
	if not self._effects then
		return
	end

	for _, v in ipairs(self._effects) do
		GameEffectManager.instance.stopEffect(v)
	end

	self._effects = nil
end

return UnitCompSpineEffect
