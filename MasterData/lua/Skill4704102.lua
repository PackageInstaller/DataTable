-- 鸣刀被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704102 = oo.class(SkillBase)
function Skill4704102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4704102:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704101
	self:OwnerAddBuffCount(SkillEffect[4704101], caster, self.card, data, 704100101,1,6)
end
-- 回合开始时
function Skill4704102:OnRoundBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4704112
	if self:Rand(4000) then
		self:OwnerAddBuffCount(SkillEffect[4704112], caster, self.card, data, 704100101,1,6)
	end
end
-- 伤害后
function Skill4704102:OnAfterHurt(caster, target, data)
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
	-- 8703
	local count703 = SkillApi:GetCount(self, caster, target,3,704100101)
	-- 8920
	if SkillJudger:Greater(self, caster, target, true,count703,0) then
	else
		return
	end
	-- 4704121
	self:OwnerAddBuffCount(SkillEffect[4704121], caster, self.card, data, 704100101,-1,6)
	-- 4704131
	self:AddBuff(SkillEffect[4704131], caster, self.card, data, 4704101)
end
