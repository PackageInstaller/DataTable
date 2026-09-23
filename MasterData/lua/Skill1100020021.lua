-- 乐团阵营使用大招后，气象角色永久提高20%攻击力，10速度，之后消耗10np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020021 = oo.class(SkillBase)
function Skill1100020021:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100020021:OnActionOver(caster, target, data)
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
	-- 1100020022
	local targets = SkillFilter:Group(self, caster, target, 3,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[1100020022], caster, target, data, 1100020022)
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
	-- 1100020023
	self:AddNp(SkillEffect[1100020023], caster, self.card, data, -10)
end
