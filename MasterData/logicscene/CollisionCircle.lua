-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/collisions/CollisionCircle.lua

module("logicscene.scene.battle.skills.collisions.CollisionCircle", package.seeall)

local CollisionCircle = class("CollisionCircle", CollisionBase)

function CollisionCircle:ctor(collisionCo, skill, idx)
	CollisionCircle.super.ctor(self, collisionCo, skill, idx)
end

return CollisionCircle
