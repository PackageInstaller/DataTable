-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectBase.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectBase", package.seeall)

local BuffLayerEffectBase = class("BuffLayerEffectBase")

function BuffLayerEffectBase:ctor(buff)
	self.buff = buff
end

function BuffLayerEffectBase:addLayerNum()
	return
end

function BuffLayerEffectBase:removeLayerNum()
	return
end

function BuffLayerEffectBase:onBuffBegin()
	return
end

function BuffLayerEffectBase:onBuffEnd()
	return
end

function BuffLayerEffectBase:BuffLayerEffectBase()
	return
end

function BuffLayerEffectBase:onEffectLoaded(eff)
	self._effect = eff
end

return BuffLayerEffectBase
