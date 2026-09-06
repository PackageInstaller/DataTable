-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffFactory.lua

module("logicscene.scene.battle.skills.buffs.BuffFactory", package.seeall)

local BuffFactory = {}
local buffClsMap = {
	[4866] = BuffInvisible,
	[10380301] = BuffInvisible
}

function BuffFactory.createBuff(buffCo, unit)
	local buffCls = buffClsMap[buffCo.id]

	if buffCls then
		return buffCls.New(buffCo, unit)
	end

	return BuffBase.New(buffCo, unit)
end

return BuffFactory
