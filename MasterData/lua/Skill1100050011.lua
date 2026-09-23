-- 肉鸽虫洞阵营角色施加弱化效果时，伤害增加2%，最多100层，大招行动后有概率防御下降20%，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100050011 = oo.class(SkillBase)
function Skill1100050011:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill1100050011:OnAddBuff(caster, target, data, buffer)
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
	-- 1100050012
	self:OwnerAddBuffCount(SkillEffect[1100050012], caster, self.card, data, 1100050011,1,100)
end
-- 行动结束
function Skill1100050011:OnActionOver(caster, target, data)
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
	-- 1100050015
	self:AddBuff(SkillEffect[1100050015], caster, self.card, data, 1100050015)
end
