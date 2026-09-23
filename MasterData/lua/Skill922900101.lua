-- 元素冲撞
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922900101 = oo.class(SkillBase)
function Skill922900101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill922900101:DoSkill(caster, target, data)
	-- 12306
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 12303
		self.order = self.order + 1
		local targets = SkillFilter:Different(self, caster, target, 4,1)
		for i,target in ipairs(targets) do
			-- 12002
			self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
		end
	elseif 2 == r then
		-- 12304
		self.order = self.order + 1
		local targets = SkillFilter:Different(self, caster, target, 4,2)
		for i,target in ipairs(targets) do
			-- 12002
			self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
		end
	elseif 3 == r then
		-- 12305
		self.order = self.order + 1
		local targets = SkillFilter:Different(self, caster, target, 4,3)
		for i,target in ipairs(targets) do
			-- 12002
			self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
		end
	end
end
-- 攻击结束
function Skill922900101:OnAttackOver(caster, target, data)
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
	-- 922900101
	self:DelBufferGroup(SkillEffect[922900101], caster, target, data, 2,2)
end
