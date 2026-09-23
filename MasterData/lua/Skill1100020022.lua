-- 乐团阵营使用大招后，气象角色永久提高30%攻击力，15速度
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020022 = oo.class(SkillBase)
function Skill1100020022:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100020022:OnActionOver(caster, target, data)
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
	-- 1100020024
	local targets = SkillFilter:Group(self, caster, target, 3,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[1100020024], caster, target, data, 1100020024)
	end
end
