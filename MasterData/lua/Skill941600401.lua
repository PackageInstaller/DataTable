-- 大型造物1 4技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941600401 = oo.class(SkillBase)
function Skill941600401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill941600401:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill941600401:OnAttackOver(caster, target, data)
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
	-- 941600401
	self:OwnerAddBuffCount(SkillEffect[941600401], caster, target, data, 941600401,1,8)
end
-- 行动结束
function Skill941600401:OnActionOver(caster, target, data)
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
	-- 941600406
	local countzhuoshao = SkillApi:GetCount(self, caster, target,3,941600401)
	-- 941600407
	if SkillJudger:GreaterEqual(self, caster, target, true,countzhuoshao,8) then
	else
		return
	end
	-- 941600403
	self:BeatBack(SkillEffect[941600403], caster, target, data, 941600201)
	-- 941600404
	self:DelBufferForce(SkillEffect[941600404], caster, self.card, data, 941600401)
end
