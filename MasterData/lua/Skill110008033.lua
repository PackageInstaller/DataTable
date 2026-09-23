-- 第6章小怪被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008033 = oo.class(SkillBase)
function Skill110008033:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill110008033:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 110008033
	self:AddBuff(SkillEffect[110008033], caster, caster, data, 110008033)
end
