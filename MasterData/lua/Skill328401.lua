-- 托尔天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328401 = oo.class(SkillBase)
function Skill328401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill328401:OnAfterHurt(caster, target, data)
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
	-- 328401
	self:AddUplimitBuff(SkillEffect[328401], caster, self.card, data, 3,3,328401,1,328401)
end
-- 行动结束2
function Skill328401:OnActionOver2(caster, target, data)
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
