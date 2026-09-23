-- SP伊根4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338002 = oo.class(SkillBase)
function Skill338002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill338002:OnAttackOver(caster, target, data)
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
	-- 8620
	local count620 = SkillApi:GetAttr(self, caster, target,3,"hit")
	-- 8739
	local count739 = SkillApi:GetAttr(self, caster, target,2,"hit")
	-- 8951
	if SkillJudger:Greater(self, caster, target, true,count620-count739,0.5) then
	else
		return
	end
	-- 338002
	self:HitAddBuff(SkillEffect[338002], caster, target, data, 2500,1001)
end
-- 攻击结束2
function Skill338002:OnAttackOver2(caster, target, data)
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
	-- 8620
	local count620 = SkillApi:GetAttr(self, caster, target,3,"hit")
	-- 8739
	local count739 = SkillApi:GetAttr(self, caster, target,2,"hit")
	-- 8952
	if SkillJudger:Greater(self, caster, target, true,count620-count739,1) then
	else
		return
	end
	-- 338012
	self:HitAddBuff(SkillEffect[338012], caster, target, data, 2500,1001)
end
