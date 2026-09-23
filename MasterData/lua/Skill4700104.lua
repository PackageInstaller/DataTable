-- 雷霆宙域
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700104 = oo.class(SkillBase)
function Skill4700104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4700104:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4700106
	self:CallSkillEx(SkillEffect[4700106], caster, self.card, data, 700100501)
end
-- 回合开始处理完成后
function Skill4700104:OnAfterRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8457
	local count57 = SkillApi:BuffCount(self, caster, target,3,3,700100301)
	-- 8161
	if SkillJudger:Greater(self, caster, self.card, true,count57,0) then
	else
		return
	end
	-- 4700104
	if self:Rand(8000) then
		self:CallOwnerSkill(SkillEffect[4700104], caster, caster, data, 700100404)
	end
end
