-- 沙海幻季瑞尔新被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932900703 = oo.class(SkillBase)
function Skill932900703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill932900703:OnBefourHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 932900720
	self:AddTempAttr(SkillEffect[932900720], caster, self.card, data, "bedamage2",math.min(math.max((count7-count8)*0.02,-0.8),1))
end
-- 入场时
function Skill932900703:OnBorn(caster, target, data)
	-- 932900721
	self:LimitAddStep(SkillEffect[932900721], caster, target, data, 40)
end
