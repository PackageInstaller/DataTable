-- 薄暮西沉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703103 = oo.class(SkillBase)
function Skill4703103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4703103:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703103
	self:OwnerAddBuffCount(SkillEffect[4703103], caster, self.card, data, 4703101,1,5)
end
-- 伤害后
function Skill4703103:OnAfterHurt(caster, target, data)
	-- 4703112
	self:tFunc_4703112_4703107(caster, target, data)
	self:tFunc_4703112_4703108(caster, target, data)
end
-- 攻击结束
function Skill4703103:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 8723
	local count723 = SkillApi:GetCount(self, caster, target,3,4703101)
	-- 8937
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count723,7) then
	else
		return
	end
	-- 4703109
	self:ClosingBuffByID(SkillEffect[4703109], caster, target, data, 1,1003)
	-- 4703110
	self:ClosingBuffByID(SkillEffect[4703110], caster, target, data, 1,1051)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4703103:OnBefourCritHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8723
	local count723 = SkillApi:GetCount(self, caster, target,3,4703101)
	-- 8936
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count723,5) then
	else
		return
	end
	-- 4703106
	self:AddTempAttr(SkillEffect[4703106], caster, self.card, data, "crit_rate",0.15)
end
function Skill4703103:tFunc_4703112_4703107(caster, target, data)
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
	-- 8723
	local count723 = SkillApi:GetCount(self, caster, target,3,4703101)
	-- 8935
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count723,3) then
	else
		return
	end
	-- 4703107
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[4703107], caster, target, data, 1003,1)
	end
end
function Skill4703103:tFunc_4703112_4703108(caster, target, data)
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
	-- 8723
	local count723 = SkillApi:GetCount(self, caster, target,3,4703101)
	-- 8935
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count723,3) then
	else
		return
	end
	-- 4703108
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[4703108], caster, target, data, 1051,1)
	end
end
