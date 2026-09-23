-- 缇尔锋
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601502 = oo.class(SkillBase)
function Skill4601502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4601502:OnBefourHurt(caster, target, data)
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
	-- 4601502
	self:AddTempAttr(SkillEffect[4601502], caster, caster, data, "damage",0.2)
end
-- 攻击结束
function Skill4601502:OnAttackOver(caster, target, data)
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
	-- 4601512
	if self:Rand(5000) then
		self:BeatBack(SkillEffect[4601512], caster, self.card, data, nill,7)
	end
end
-- 行动结束
function Skill4601502:OnActionOver(caster, target, data)
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
	-- 4601522
	self:AddBuffCount(SkillEffect[4601522], caster, self.card, data, 4601502,1,999)
end
