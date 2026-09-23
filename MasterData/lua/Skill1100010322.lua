-- 自身HP大于80％时，受到攻击时防御增加36％
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010322 = oo.class(SkillBase)
function Skill1100010322:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill1100010322:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8138
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.8) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010322
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[1100010322], caster, self.card, data, 1100010322)
	end
end
