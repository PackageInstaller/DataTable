-- 第6章小怪被动5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008034 = oo.class(SkillBase)
function Skill110008034:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill110008034:OnBefourHurt(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 110008034
	self:AddTempAttr(SkillEffect[110008034], caster, self.card, data, "bedamage2",0.3)
end
