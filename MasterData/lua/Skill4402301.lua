-- 炙夏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4402301 = oo.class(SkillBase)
function Skill4402301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4402301:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4402301
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4402301], caster, target, data, 4402301)
	end
end
-- 伤害前
function Skill4402301:OnBefourHurt(caster, target, data)
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
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
	-- 4402321
	self:AddTempAttr(SkillEffect[4402321], caster, target, data, "defense",-100)
end
