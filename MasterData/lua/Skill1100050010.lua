-- 肉鸽虫洞阵营角色施加弱化效果时，伤害增加1.5%，最多100层,大招行动后有概率防御下降40%，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100050010 = oo.class(SkillBase)
function Skill1100050010:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill1100050010:OnAddBuff(caster, target, data, buffer)
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
	-- 1100050010
	self:OwnerAddBuffCount(SkillEffect[1100050010], caster, self.card, data, 1100050010,1,100)
end
-- 行动结束
function Skill1100050010:OnActionOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100050014
	self:AddBuff(SkillEffect[1100050014], caster, self.card, data, 1100050014)
end
