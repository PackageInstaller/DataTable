-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectGuangLun.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectGuangLun", package.seeall)

local BuffLayerEffectGuangLun = class("BuffLayerEffectGuangLun", BuffLayerEffectBase)

function BuffLayerEffectGuangLun:addLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectGuangLun:removeLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectGuangLun:onBuffBegin()
	self:_updateBuffLayers()
end

function BuffLayerEffectGuangLun:onEffectLoaded(eff)
	local effGo = eff.effGo

	if goutil.isNil(effGo) then
		return
	end

	self._effParentsNode = {}
	self._layerEffsNode = {}

	for i = 1, 100 do
		local num = goutil.findChild(effGo, "num" .. i)

		if num then
			self._layerEffsNode[i] = num
		end

		local go = goutil.findChild(effGo, "a" .. i)

		if go then
			table.insert(self._effParentsNode, go)
		else
			break
		end
	end

	self:_updateBuffLayers()
end

function BuffLayerEffectGuangLun:_updateBuffLayers()
	if not self._effParentsNode then
		return
	end

	local layerNum = self.buff.layerNum

	for i, v in ipairs(self._effParentsNode) do
		GameUtil.SetActive(v, i <= layerNum)
	end

	for i, v in pairs(self._layerEffsNode) do
		GameUtil.SetActive(v, i == layerNum)
	end
end

return BuffLayerEffectGuangLun
