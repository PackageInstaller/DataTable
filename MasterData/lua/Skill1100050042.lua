-- 肉鸽虫洞阵营角色施加持续伤害效果时，敌方承受伤害增加2%，最多100层
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100050042 = oo.class(SkillBase)
function Skill1100050042:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill1100050042:OnAddBuff(caster, target, data, buffer)
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
	-- 1100050041
	if SkillJudger:IsCtrlBuffType(buffer or self, caster, target, true,1) then
	else
		return
	end
	-- 1100050043
	self:OwnerAddBuffCount(SkillEffect[1100050043], caster, target, data, 1100050043,1,100)
end
