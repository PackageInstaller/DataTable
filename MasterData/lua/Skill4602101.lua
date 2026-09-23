-- 战局感应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4602101 = oo.class(SkillBase)
function Skill4602101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4602101:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4602101
	self:AddTempAttr(SkillEffect[4602101], caster, self.card, data, "damage",0.10)
end
-- 攻击结束2
function Skill4602101:OnAttackOver2(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8146
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.6) then
	else
		return
	end
	-- 4602121
	self:DelBufferTypeForce(SkillEffect[4602121], caster, self.card, data, 4602101)
end
-- 行动结束
function Skill4602101:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8136
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 4602110
	self:AddBuffCount(SkillEffect[4602110], caster, self.card, data, 4602101,1,10)
end
-- 回合开始处理完成后
function Skill4602101:OnAfterRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8146
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.6) then
	else
		return
	end
	-- 4602122
	self:DelBufferTypeForce(SkillEffect[4602122], caster, self.card, data, 4602101)
end
