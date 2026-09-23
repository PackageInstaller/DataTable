-- 大招词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000050090 = oo.class(SkillBase)
function Skill1000050090:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1000050090:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1000050022
	if SkillJudger:HasBuff(self, caster, target, true,1,1000050021) then
	else
		return
	end
	-- 1000050090
	self:AddBuffCount(SkillEffect[1000050090], caster, target, data, 1000050091,1,5)
end
