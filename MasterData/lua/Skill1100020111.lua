-- 每6次使用大招并造成伤害后时，行动提前100%（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020111 = oo.class(SkillBase)
function Skill1100020111:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100020111:OnActionOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100020113
	self:OwnerAddBuffCount(SkillEffect[1100020113], caster, self.card, data, 1100020113,1,30)
end
-- 行动结束2
function Skill1100020111:OnActionOver2(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100020114
	local dzcishu = SkillApi:GetCount(self, caster, target,1,1100020113)
	-- 1100020116
	if SkillJudger:Greater(self, caster, self.card, true,dzcishu,5) then
	else
		return
	end
	-- 1100020111
	self:AddProgress(SkillEffect[1100020111], caster, self.card, data, 1000)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020118
	self:DelBufferForce(SkillEffect[1100020118], caster, self.card, data, 1100020113)
end
