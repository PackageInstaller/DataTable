-- 积雾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4402004 = oo.class(SkillBase)
function Skill4402004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4402004:OnAttackOver(caster, target, data)
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
	-- 4402004
	self:OwnerAddBuffCount(SkillEffect[4402004], caster, caster, data, 402000101,1,6)
end
-- 回合开始处理完成后
function Skill4402004:OnAfterRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8489
	local count89 = SkillApi:GetCount(self, caster, target,1,402000101)
	-- 8184
	if SkillJudger:Greater(self, caster, target, true,count89,0) then
	else
		return
	end
	-- 4402006
	self:OwnerAddBuffCount(SkillEffect[4402006], caster, caster, data, 402000101,-1,5)
end
