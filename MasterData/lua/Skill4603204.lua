-- 赫格尼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603204 = oo.class(SkillBase)
function Skill4603204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4603204:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603213
	self:AddBuff(SkillEffect[4603213], caster, self.card, data, 603210401)
end
-- 治疗时
function Skill4603204:OnCure(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603201
	self:OwnerAddBuffCount(SkillEffect[4603201], caster, self.card, data, 4603201,1,10)
end
-- 回合开始时
function Skill4603204:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603216
	self:DelBufferForce(SkillEffect[4603216], caster, self.card, data, 4603215)
end
