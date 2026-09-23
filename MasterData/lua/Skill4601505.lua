-- 缇尔锋
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601505 = oo.class(SkillBase)
function Skill4601505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4601505:OnBefourHurt(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4601505
	self:AddTempAttr(SkillEffect[4601505], caster, caster, data, "damage",0.5)
end
-- 攻击结束
function Skill4601505:OnAttackOver(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 4601515
	if self:Rand(8000) then
		self:BeatBack(SkillEffect[4601515], caster, self.card, data, nill,7)
	end
end
-- 行动结束
function Skill4601505:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 4601525
	self:AddBuffCount(SkillEffect[4601525], caster, self.card, data, 4601505,1,999)
end
