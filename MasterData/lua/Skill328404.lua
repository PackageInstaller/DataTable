-- 托尔天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328404 = oo.class(SkillBase)
function Skill328404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill328404:OnAfterHurt(caster, target, data)
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
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 328404
	self:AddUplimitBuff(SkillEffect[328404], caster, self.card, data, 3,3,328404,1,328404)
end
-- 行动结束2
function Skill328404:OnActionOver2(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8135
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 328411
	self:DelBufferTypeForce(SkillEffect[328411], caster, self.card, data, 328401)
end
