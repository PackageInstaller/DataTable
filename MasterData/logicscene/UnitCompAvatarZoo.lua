-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/animation/UnitCompAvatarZoo.lua

module("logicscene.scene.unit.component.animation.UnitCompAvatarZoo", package.seeall)

local UnitCompAvatarZoo = class("UnitCompAvatarZoo", UnitCompAvatarPet)

function UnitCompAvatarZoo:getAvatarType()
	return AvatarCreateType.Zoo
end

return UnitCompAvatarZoo
