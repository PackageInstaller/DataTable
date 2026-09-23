-- 永恒之枪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702602 = oo.class(SkillBase)
function Skill4702602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4702602:OnBefourHurt(caster, target, data)
	-- 4702642
	self:tFunc_4702642_4702622(caster, target, data)
	self:tFunc_4702642_4702632(caster, target, data)
end
-- 攻击结束
function Skill4702602:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4702612
	if self:Rand(2000) then
		self:OwnerAddBuffCount(SkillEffect[4702612], caster, self.card, data, 702600204,1,10)
	end
end
function Skill4702602:tFunc_4702642_4702632(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 4702632
	self:AddTempAttr(SkillEffect[4702632], caster, target, data, "defense",count23*0.15)
end
function Skill4702602:tFunc_4702642_4702622(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 4702622
	self:AddTempAttr(SkillEffect[4702622], caster, caster, data, "attack",count23*0.4)
end
