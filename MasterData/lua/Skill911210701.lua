-- 克拉肯-狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210701 = oo.class(SkillBase)
function Skill911210701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill911210701:OnDeath(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 911210701
	self:AddBuff(SkillEffect[911210701], caster, self.card, data, 911210701)
end
