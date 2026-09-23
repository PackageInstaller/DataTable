-- 永恒之枪托尔怪物被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702616 = oo.class(SkillBase)
function Skill4702616:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4702616:OnAfterHurt(caster, target, data)
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
	-- 4702603
	self:HitAddBuff(SkillEffect[4702603], caster, target, data, 3000,5206,2)
end
-- 攻击结束
function Skill4702616:OnAttackOver(caster, target, data)
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
	-- 4702605
	self:OwnerAddBuffCount(SkillEffect[4702605], caster, self.card, data, 702600204,1,10)
end
-- 加buff时
function Skill4702616:OnAddBuff(caster, target, data, buffer)
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
	-- 4702647
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true,3) then
	else
		return
	end
	-- 4702646
	if self:Rand(5000) then
		self:AddProgress(SkillEffect[4702646], caster, self.card, data, 150)
	end
end
