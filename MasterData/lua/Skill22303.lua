-- 物伤I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22303 = oo.class(SkillBase)
function Skill22303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill22303:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 22303
	self:AddTempAttr(SkillEffect[22303], caster, self.card, data, "damage",0.30)
end
