-- 瑞泽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4100701 = oo.class(SkillBase)
function Skill4100701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4100701:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4100701
	self:AddBuffCount(SkillEffect[4100701], caster, self.card, data, 100700101,1,8)
end
-- 死亡时
function Skill4100701:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4100706
	self:DelBufferForce(SkillEffect[4100706], caster, self.card, data, 100700101)
end
-- 回合结束时
function Skill4100701:OnRoundOver(caster, target, data)
	-- 4100707
	self:AddBuffCount(SkillEffect[4100707], caster, self.card, data, 100700101,0,8)
end
