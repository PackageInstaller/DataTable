-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffVigourMax.lua

module("logicscene.scene.battle.skills.buffs.BuffVigourMax", package.seeall)

local BuffVigourMax = class("BuffVigourMax", BuffBase)

function BuffVigourMax:_buildEffects()
	self.sustainEffectCo = {}
	self.sustainEffectCo.path = CommonResPath.VigoutMaxBuffEff
	self.sustainEffectCo.hagPoint = UnitConst.spineFootPointPath
end

function BuffVigourMax:getBuffId()
	return UnitCompBuffList.ViourMaxId
end

function BuffVigourMax:isCustomBuff()
	return true
end

return BuffVigourMax
