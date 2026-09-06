-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/UnitNotifyExtend.lua

module("logicscene.scene.unit.UnitNotifyExtend", package.seeall)

UnitNotifyExtend = {}

function UnitNotifyExtend.extend()
	UnitNotify.SpineEvent = 101
	UnitNotify.UnitLoaded = 102
	UnitNotify.UnitMainPlayerLoaded = 104
	UnitNotify.UnitBulletEffectLoaded = 105
	UnitNotify.UnitBulletHitTarget = 106
	UnitNotify.UnitPropertyChanged = 107
	UnitNotify.UnitDead = 108
	UnitNotify.BuffEffectLoaded = 109
	UnitNotify.UnitBloodUIHide = 110
end

return UnitNotifyExtend
