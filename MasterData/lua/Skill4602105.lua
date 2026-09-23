-- 战局感应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4602105 = oo.class(SkillBase)
function Skill4602105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4602105:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4602105
	self:AddTempAttr(SkillEffect[4602105], caster, self.card, data, "damage",0.30)
end
-- 攻击结束2
function Skill4602105:OnAttackOver2(caster, target, data)
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
function Skill4602105:OnActionOver(caster, target, data)
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
	-- 4602114
	self:AddBuffCount(SkillEffect[4602114], caster, self.card, data, 4602105,1,10)
end
-- 回合开始处理完成后
function Skill4602105:OnAfterRoundBegin(caster, target, data)
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
