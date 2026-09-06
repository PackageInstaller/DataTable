-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffSkillLocking.lua

module("logicscene.scene.battle.skills.buffs.BuffSkillLocking", package.seeall)

local BuffSkillLocking = class("BuffSkillLocking", BuffBase)
local raceEffectsMap = {
	[GameEnum.RaceType.An] = "common/skill/fx_10002_jinengzhixiangan.prefab",
	[GameEnum.RaceType.Cao] = "common/skill/fx_10002_jinengzhixiangcao.prefab",
	[GameEnum.RaceType.Guang] = "common/skill/fx_10002_jinengzhixiangguang.prefab",
	[GameEnum.RaceType.Huo] = "common/skill/fx_10002_jinengzhixianghuo.prefab",
	[GameEnum.RaceType.Shui] = "common/skill/fx_10002_jinengzhixiangshui.prefab",
	[GameEnum.RaceType.ShenAn] = "common/skill/fx_10002_jinengzhixiangan.prefab",
	[GameEnum.RaceType.ShenCao] = "common/skill/fx_10002_jinengzhixiangcao.prefab",
	[GameEnum.RaceType.ShenGuang] = "common/skill/fx_10002_jinengzhixiangguang.prefab",
	[GameEnum.RaceType.ShenHuo] = "common/skill/fx_10002_jinengzhixianghuo.prefab",
	[GameEnum.RaceType.ShenShui] = "common/skill/fx_10002_jinengzhixiangshui.prefab"
}

function BuffSkillLocking:ctor(buffCo, unit, skill)
	BuffSkillLocking.super.ctor(self, buffCo, unit)

	self._skill = skill
end

function BuffSkillLocking:_buildEffects()
	local raceType = self._unit.battleFlow:getRace(self._unit)

	if raceEffectsMap[raceType] then
		self.sustainEffectCo = {}
		self.sustainEffectCo.path = "effect/prefabs/" .. raceEffectsMap[raceType]
		self.sustainEffectCo.hagPoint = UnitConst.spineHeadPointPath
	end
end

function BuffSkillLocking:onBuffBegin()
	self._unit.attrs:setSkillLocking(true)
	BuffSkillLocking.super.onBuffBegin(self)
end

function BuffSkillLocking:onBuffEnd()
	self._unit.attrs:setSkillLocking(false)
	BuffSkillLocking.super.onBuffEnd(self)
end

function BuffSkillLocking:isDone()
	if not self._skill:isPlaying() then
		return true
	end

	if self._skill:isCollisionEnded() then
		return true
	end
end

function BuffSkillLocking:getBuffId()
	return UnitCompBuffList.SkillLockingId
end

function BuffSkillLocking:isCustomBuff()
	return true
end

return BuffSkillLocking
