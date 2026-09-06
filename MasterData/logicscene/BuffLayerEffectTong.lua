-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectTong.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectTong", package.seeall)

local BuffLayerEffectTong = class("BuffLayerEffectTong", BuffLayerEffectBase)

function BuffLayerEffectTong:addLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectTong:removeLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectTong:onBuffBegin()
	self:_updateBuffLayers()
end

function BuffLayerEffectTong:onEffectLoaded(eff)
	local effGo = eff.effGo

	if goutil.isNil(effGo) then
		return
	end

	self._effParentsNode = {}
	self._layerEffsNode = {}

	local layerNodeCnt = 0
	local effNodeCnt = 0

	for i = 1, 3 do
		local layerGo = goutil.findChild(effGo, "00" .. i)

		if layerGo then
			layerNodeCnt = layerNodeCnt + 1
			self._effParentsNode[layerNodeCnt] = layerGo

			local layer = 5

			for j = 1, layer do
				local go = goutil.findChild(self._effParentsNode[i], "xingdian0" .. j)

				if go then
					effNodeCnt = effNodeCnt + 1
					self._layerEffsNode[effNodeCnt] = go
				end
			end
		end
	end

	self:_updateBuffLayers()
end

function BuffLayerEffectTong:_updateBuffLayers()
	if not self._effParentsNode then
		return
	end

	local layerNum = self.buff.layerNum
	local index = math.ceil(layerNum / 3)

	for i = 1, index do
		goutil.setActive(self._effParentsNode[i], true)
	end

	for i = index + 1, #self._effParentsNode do
		goutil.setActive(self._effParentsNode[i], false)
	end

	for i = 1, layerNum do
		goutil.setActive(self._layerEffsNode[i], true)
	end

	for i = layerNum + 1, #self._layerEffsNode do
		goutil.setActive(self._layerEffsNode[i], false)
	end
end

return BuffLayerEffectTong
