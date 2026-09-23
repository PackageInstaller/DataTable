-- 乐团阵营使用大招后，不朽角色永久提高20%攻击力，20%暴击伤害，之后消耗10np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020011 = oo.class(SkillBase)
function Skill1100020011:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100020011:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8231
	if SkillJudger:IsCasterMech(self, caster, self.card, true,2) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100020012
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[1100020012], caster, target, data, 1100020012)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8231
	if SkillJudger:IsCasterMech(self, caster, self.card, true,2) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100020013
	self:AddNp(SkillEffect[1100020013], caster, self.card, data, -10)
end
