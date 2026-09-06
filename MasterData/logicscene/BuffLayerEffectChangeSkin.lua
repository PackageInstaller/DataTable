-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectChangeSkin.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectChangeSkin", package.seeall)

local BuffLayerEffectChangeSkin = class("BuffLayerEffectChangeSkin", BuffLayerEffectBase)

function BuffLayerEffectChangeSkin:addLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectChangeSkin:removeLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectChangeSkin:onBuffBegin()
	local unit = self.buff:getUnit()

	unit.spine:addListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	self:_updateBuffLayers()
end

function BuffLayerEffectChangeSkin:onBuffEnd()
	local unit = self.buff:getUnit()

	unit.spine:removeListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
end

function BuffLayerEffectChangeSkin:onEffectLoaded(eff)
	local effGo = eff.effGo

	if goutil.isNil(effGo) then
		return
	end

	self:_updateBuffLayers()
end

function BuffLayerEffectChangeSkin:_onSpineLoaded()
	self:_updateBuffLayers()
end

function BuffLayerEffectChangeSkin:_updateBuffLayers()
	local unit = self.buff:getUnit()
	local nameList = unit.spine:getSkinNameList()
	local maxLayerNum = 0

	for i, v in ipairs(nameList) do
		local num_str = string.match(v, "%d+")
		local num = checkint(num_str)

		if maxLayerNum < num then
			maxLayerNum = num
		end
	end

	local layerNum = self.buff.layerNum

	layerNum = math.min(maxLayerNum, layerNum)

	unit.spine:changeSkin((checkint(layerNum) >= 1 or nil) and "w" .. checkint(layerNum))
end

return BuffLayerEffectChangeSkin
