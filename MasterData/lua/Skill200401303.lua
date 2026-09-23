-- 主旋赋格（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200401303 = oo.class(SkillBase)
function Skill200401303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200401303:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	-- 8825
	if SkillJudger:TargetIndex(self, caster, self.card, true,1) then
	else
		return
	end
	-- 200400303
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[200400303], caster, target, data, 4505)
	end
end
-- 攻击结束
function Skill200401303:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 999999994
	self:AddProgress(SkillEffect[999999994], caster, target, data, -1000)
end
