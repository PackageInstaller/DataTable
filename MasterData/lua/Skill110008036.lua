-- 第6章小怪被动7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008036 = oo.class(SkillBase)
function Skill110008036:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束2
function Skill110008036:OnAttackOver2(caster, target, data)
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
	-- 110008036
	local r = self.card:Rand(3)+1
	if 1 == r then
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
		-- 1100080362
		self:AddBuff(SkillEffect[1100080362], caster, target, data, 1001)
	elseif 2 == r then
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
		-- 1100080363
		self:AddBuff(SkillEffect[1100080363], caster, target, data, 5703)
	elseif 3 == r then
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
		-- 1100080364
		self:AddBuff(SkillEffect[1100080364], caster, target, data, 10933)
	end
end
