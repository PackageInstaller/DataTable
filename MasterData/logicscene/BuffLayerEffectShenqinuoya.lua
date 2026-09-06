-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectShenqinuoya.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectShenqinuoya", package.seeall)

local BuffLayerEffectShenqinuoya = class("BuffLayerEffectShenqinuoya", BuffLayerEffectBase)

function BuffLayerEffectShenqinuoya:onBuffBegin()
	local unit = self.buff:getUnit()

	unit.spine:addListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	self:_refresh()
end

function BuffLayerEffectShenqinuoya:onBuffEnd()
	local unit = self.buff:getUnit()

	unit.spine:removeListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)

	if not goutil.isNil(self._effGo) then
		Spine.Unity.BoneFollower.StopFollow(self._effGo)
	end

	self._effGo = nil
end

function BuffLayerEffectShenqinuoya:onEffectLoaded(eff)
	local effGo = eff.effGo

	if goutil.isNil(effGo) then
		return
	end

	self._effGo = effGo

	self:_refresh()
end

function BuffLayerEffectShenqinuoya:_onSpineLoaded()
	self:_refresh()
end

function BuffLayerEffectShenqinuoya:_refresh()
	if not self._effGo then
		return
	end

	local skeletonAnim = self.buff:getUnit().spine:getSkeletonAnimation()

	if goutil.isNil(skeletonAnim) then
		return
	end

	local boneName = "jian"
	local bone = skeletonAnim.Skeleton:FindBone(boneName) ~= nil

	if bone then
		local isFlipX = self.buff:getUnit().spine:getDirection() ~= UnitSpineDir.Right

		Spine.Unity.BoneFollower.BeginFollow(self._effGo, skeletonAnim.transform, 0, 0, boneName, 0, 0, 0, true, true, true, true, 0, 0, true, false, false, isFlipX)

		local node = goutil.findChild(self._effGo, "Node")

		if isFlipX then
			Framework.TransformUtil.SetLocalPos(node.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalRotation(node.transform, 37.72506, 14.37116, 94.58358)
		else
			Framework.TransformUtil.SetLocalPos(node.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalRotation(node.transform, 0, 0, 266.4564)
		end
	else
		Spine.Unity.BoneFollower.StopFollow(self._effGo)
	end
end

return BuffLayerEffectShenqinuoya
