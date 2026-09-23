-- 岚天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330904 = oo.class(SkillBase)
function Skill330904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill330904:OnAttackOver(caster, target, data)
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
	-- 330904
	if self:Rand(8000) then
		local r = self.card:Rand(2)+1
		if 1 == r then
			-- 330911
			self:OwnerAddBuffCount(SkillEffect[330911], caster, self.card, data, 400600101,1,3)
		elseif 2 == r then
			-- 330921
			self:OwnerAddBuffCount(SkillEffect[330921], caster, self.card, data, 400600201,1,3)
		end
	end
end
-- 攻击结束2
function Skill330904:OnAttackOver2(caster, target, data)
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
	-- 330934
	if self:Rand(8000) then
		local r = self.card:Rand(2)+1
		if 1 == r then
			-- 330911
			self:OwnerAddBuffCount(SkillEffect[330911], caster, self.card, data, 400600101,1,3)
		elseif 2 == r then
			-- 330921
			self:OwnerAddBuffCount(SkillEffect[330921], caster, self.card, data, 400600201,1,3)
		end
	end
end
