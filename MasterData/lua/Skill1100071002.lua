-- 溯源探查ex技能21
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100071002 = oo.class(SkillBase)
function Skill1100071002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 拉条时
function Skill1100071002:OnAddProgress(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100071003
	if self:Rand(1010) then
		self:AddBuff(SkillEffect[1100071003], caster, self.card, data, 1100071003)
	end
end
