-- 防护加身
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill326003 = oo.class(SkillBase)
function Skill326003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill326003:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8626
	local count626 = SkillApi:SkillLevel(self, caster, target,3,4032003)
	-- 326003
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[326003], caster, self.card, data, math.floor(2170+(count626+1)/2),2)
	end
end
