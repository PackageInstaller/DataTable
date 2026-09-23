-- 肉鸽虫洞阵营角色施加弱化效果时，伤害增加3%，最多100层
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100050012 = oo.class(SkillBase)
function Skill1100050012:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill1100050012:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100050011
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true,3) then
	else
		return
	end
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 1100050013
	self:OwnerAddBuffCount(SkillEffect[1100050013], caster, self.card, data, 1100050012,1,100)
end
