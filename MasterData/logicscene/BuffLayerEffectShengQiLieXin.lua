-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectShengQiLieXin.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectShengQiLieXin", package.seeall)

local BuffLayerEffectShengQiLieXin = class("BuffLayerEffectShengQiLieXin", BuffLayerEffectBase)

function BuffLayerEffectShengQiLieXin:addLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectShengQiLieXin:removeLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectShengQiLieXin:onBuffBegin()
	self:_updateBuffLayers()
end

function BuffLayerEffectShengQiLieXin:onEffectLoaded(eff)
	local effGo = eff.effGo

	if goutil.isNil(effGo) then
		return
	end

	self._effParentsNode = {}

	for i = 1, 3 do
		self._effParentsNode[i] = goutil.findChild(effGo, "buff_center/00" .. i)
	end

	self:_updateBuffLayers()
end

function BuffLayerEffectShengQiLieXin:_updateBuffLayers()
	if not self._effParentsNode then
		return
	end

	for i, v in ipairs(self._effParentsNode) do
		goutil.setActive(v, false)
	end

	local layerNum = self.buff.layerNum

	if layerNum == 1 then
		goutil.setActive(self._effParentsNode[1], true)
	elseif layerNum == 2 then
		goutil.setActive(self._effParentsNode[1], true)
		goutil.setActive(self._effParentsNode[2], true)
	elseif layerNum == 3 then
		goutil.setActive(self._effParentsNode[1], true)
		goutil.setActive(self._effParentsNode[3], true)
	end
end

return BuffLayerEffectShengQiLieXin
