-- 开局时全体气象角色行动提前10%（白色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020180 = oo.class(SkillBase)
function Skill1100020180:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020180:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 1100020180
	self:AddProgress(SkillEffect[1100020180], caster, caster, data, 100)
end
