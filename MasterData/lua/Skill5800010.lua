-- 世界boss词条buff7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800010 = oo.class(SkillBase)
function Skill5800010:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill5800010:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4402306
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4402306], caster, target, data, 4402304)
	end
end
-- 伤害前
function Skill5800010:OnBefourHurt(caster, target, data)
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8155
	if SkillJudger:IsProgressLess(self, caster, target, true,500) then
	else
		return
	end
	-- 8155
	if SkillJudger:IsProgressLess(self, caster, target, true,500) then
	else
		return
	end
	-- 4402326
	self:AddTempAttr(SkillEffect[4402326], caster, target, data, "defense",-300)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8832
	if SkillJudger:IsProgressLess(self, caster, target, true,10) then
	else
		return
	end
	-- 4402332
	self:AddTempAttr(SkillEffect[4402332], caster, target, data, "bedamage",0.3)
end
