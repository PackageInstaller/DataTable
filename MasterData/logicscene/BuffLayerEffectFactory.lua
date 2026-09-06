-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/layereffects/BuffLayerEffectFactory.lua

module("logicscene.scene.battle.skills.buffs.layereffects.BuffLayerEffectFactory", package.seeall)

local BuffLayerEffectFactory = {}

function BuffLayerEffectFactory.createLayerEffect(layereffects, buff)
	if layereffects == "Tong" then
		return BuffLayerEffectTong.New(buff)
	elseif layereffects == "ZhixuShengLong" then
		return BuffLayerEffectZhixuShengLong.New(buff)
	elseif layereffects == "Shenqinuoya" then
		return BuffLayerEffectShenqinuoya.New(buff)
	elseif layereffects == "ShengQiLieXin" then
		return BuffLayerEffectShengQiLieXin.New(buff)
	elseif layereffects == "GuangLun" then
		return BuffLayerEffectGuangLun.New(buff)
	elseif layereffects == "BuffLayerNumChange" then
		return BuffLayerEffectEvent.New(buff)
	elseif layereffects == "ChangeSkin" then
		return BuffLayerEffectChangeSkin.New(buff)
	end
end

return BuffLayerEffectFactory
