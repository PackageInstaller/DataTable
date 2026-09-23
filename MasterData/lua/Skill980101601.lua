-- 暴虐灭刃被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101601 = oo.class(SkillBase)
function Skill980101601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101601
	local targets = SkillFilter:Group(self, caster, target, 4,6)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101601], caster, target, data, 980101601)
	end
end
-- 行动结束
function Skill980101601:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8239
	if SkillJudger:IsCasterMech(self, caster, self.card, true,6) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 980101602
	self:AddBuff(SkillEffect[980101602], caster, caster, data, 980101602)
end
