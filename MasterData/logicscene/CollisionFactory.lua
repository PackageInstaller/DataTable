-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/collisions/CollisionFactory.lua

module("logicscene.scene.battle.skills.collisions.CollisionFactory", package.seeall)

local CollisionFactory = {}

function CollisionFactory.createCollision(skill, collisionCo)
	return CollisionCircle.New(collisionCo, skill)
end

return CollisionFactory
