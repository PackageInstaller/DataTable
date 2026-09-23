-- 全体
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932600401 = oo.class(SkillBase)
function Skill932600401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill932600401:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill932600401:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 932600401
	self:AddBuffCount(SkillEffect[932600401], caster, self.card, data, 932600401,1,3)
end
-- 攻击结束
function Skill932600401:OnAttackOver(caster, target, data)
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
	-- 8655
	local count655 = SkillApi:GetCount(self, caster, target,3,932600401)
	-- 8861
	if SkillJudger:GreaterEqual(self, caster, target, true,count655,3) then
	else
		return
	end
	-- 932600402
	self:AddProgress(SkillEffect[932600402], caster, target, data, -300)
	-- 932600403
	self:DelBufferForce(SkillEffect[932600403], caster, self.card, data, 932600401,3)
end
