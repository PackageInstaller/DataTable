-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectZhixuShengLong.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectZhixuShengLong", package.seeall)

local BuffLayerEffectZhixuShengLong = class("BuffLayerEffectZhixuShengLong", BuffLayerEffectBase)

function BuffLayerEffectZhixuShengLong:addLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectZhixuShengLong:removeLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectZhixuShengLong:onBuffBegin()
	local unit = self.buff:getUnit()

	unit.spine:addListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	self:_updateBuffLayers()
end

function BuffLayerEffectZhixuShengLong:onBuffEnd()
	local unit = self.buff:getUnit()

	unit.spine:removeListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)

	if self._layerEffsNode then
		for i = 1, #self._layerEffsNode do
			Spine.Unity.BoneFollower.StopFollow(self._layerEffsNode[i])
		end

		self._layerEffsNode = nil
	end

	self._bones = nil
end

function BuffLayerEffectZhixuShengLong:onEffectLoaded(eff)
	local effGo = eff.effGo

	if goutil.isNil(effGo) then
		return
	end

	self._layerEffsNode = {}

	for i = 1, 10 do
		local go = goutil.findChild(effGo, "00" .. i)

		if not go then
			break
		end

		self._layerEffsNode[i] = go
	end

	self:_refreshBuffLayers()
	self:_updateBuffLayers()
end

function BuffLayerEffectZhixuShengLong:_onSpineLoaded()
	self:_refreshBuffLayers()
	self:_updateBuffLayers()
end

function BuffLayerEffectZhixuShengLong:_refreshBuffLayers()
	local skeletonAnim = self.buff:getUnit().spine:getSkeletonAnimation()

	self._bones = {}

	if self._layerEffsNode and not goutil.isNil(skeletonAnim) and not goutil.isNil(skeletonAnim.Skeleton) then
		for i = 1, #self._layerEffsNode do
			local boneName = "hunhuan_0" .. i

			self._bones[i] = skeletonAnim.Skeleton:FindBone(boneName) ~= nil

			if not self._bones[i] then
				boneName = "huanhuan_0" .. i
				self._bones[i] = skeletonAnim.Skeleton:FindBone("huanhuan_0" .. i) ~= nil
			end

			if self._bones[i] then
				Spine.Unity.BoneFollower.BeginFollow(self._layerEffsNode[i], skeletonAnim.transform, 0, 0, boneName, 0, 0, 0, true, true, true, true, 0, 0, true, false, false, false)
			else
				Spine.Unity.BoneFollower.StopFollow(self._layerEffsNode[i])
			end
		end
	end
end

function BuffLayerEffectZhixuShengLong:_updateBuffLayers()
	if not self._layerEffsNode then
		return
	end

	local layerNum = self.buff.layerNum

	for i = 1, layerNum do
		goutil.setActive(self._layerEffsNode[i], self._bones ~= nil and self._bones[i] == true)
	end

	for i = layerNum + 1, #self._layerEffsNode do
		goutil.setActive(self._layerEffsNode[i], false)
	end
end

return BuffLayerEffectZhixuShengLong
