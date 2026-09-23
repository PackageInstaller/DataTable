-- 暴虐虫洞被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101501 = oo.class(SkillBase)
function Skill980101501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101501:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101501
	local targets = SkillFilter:Group(self, caster, target, 4,5)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101501], caster, target, data, 980101501)
	end
end
-- 攻击结束
function Skill980101501:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 980101502
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[980101502], caster, caster, data, 980101502)
	end
end
