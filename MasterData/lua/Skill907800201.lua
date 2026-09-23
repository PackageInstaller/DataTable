-- 重力压制
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907800201 = oo.class(SkillBase)
function Skill907800201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907800201:DoSkill(caster, target, data)
	-- 12207
	self.order = self.order + 1
	local targets = SkillFilter:Different(self, caster, target, 4,3)
	for i,target in ipairs(targets) do
		-- 12208
		local targets = SkillFilter:Row(self, caster, target, 2)
		for i,target in ipairs(targets) do
			self:DamageLight(SkillEffect[12208], caster, target, data, 1,1)
		end
		-- 12209
		self:AddOrder(SkillEffect[12209], caster, target, data, nil)
		-- 8331
		self:AddValue(SkillEffect[8331], caster, target, data, "suaijian",1)
	end
end
-- 伤害后
function Skill907800201:OnAfterHurt(caster, target, data)
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
	-- 907800201
	self:HitAddBuff(SkillEffect[907800201], caster, target, data, 10000,5204,2)
end
