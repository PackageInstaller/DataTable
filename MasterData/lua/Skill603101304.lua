-- 提泽纳（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603101304 = oo.class(SkillBase)
function Skill603101304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603101304:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 攻击结束
function Skill603101304:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603101304
	self:HitAddBuffCount(SkillEffect[603101304], caster, target, data, 10000,603100101,2,999)
	-- 603101313
	self:AddProgress(SkillEffect[603101313], caster, target, data, -200)
	-- 8722
	local count722 = SkillApi:GetCount(self, caster, target,2,603100101)
	-- 603101321
	self:LimitDamage(SkillEffect[603101321], caster, target, data, 1.1,0.75*count722)
	-- 603101322
	self:DelBufferForce(SkillEffect[603101322], caster, target, data, 603100101)
end
