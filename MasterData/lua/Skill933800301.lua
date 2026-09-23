-- 小绿被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933800301 = oo.class(SkillBase)
function Skill933800301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill933800301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 933700316
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[933700316], caster, target, data, 933700316)
	end
end
-- 伤害前
function Skill933800301:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 933700315
	self:AddTempAttr(SkillEffect[933700315], caster, self.card, data, "bedamage",0.5)
end
