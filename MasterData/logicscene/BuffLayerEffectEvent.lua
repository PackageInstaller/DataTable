-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectEvent.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectEvent", package.seeall)

local BuffLayerEffectEvent = class("BuffLayerEffectEvent", BuffLayerEffectBase)

function BuffLayerEffectEvent:addLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectEvent:removeLayerNum()
	self:_updateBuffLayers()
end

function BuffLayerEffectEvent:onBuffBegin()
	self:_updateBuffLayers()
end

function BuffLayerEffectEvent:_updateBuffLayers()
	GlobalDispatcher:dispatch(GlobalNotify.BuffLayerNumChange, self.buff)
end

return BuffLayerEffectEvent
