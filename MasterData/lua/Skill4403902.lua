-- 裂空
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4403902 = oo.class(SkillBase)
function Skill4403902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4403902:OnAfterHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 4403902
	if self:Rand(7500) then
		self:AddBuffCount(SkillEffect[4403902], caster, self.card, data, 4403902,1,30)
	end
end
-- 回合开始时
function Skill4403902:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 4403907
	if self:Rand(3000+math.max(math.floor(count7/10)*100,0)) then
		self:AddBuff(SkillEffect[4403907], caster, caster, data, 9038)
	end
end
