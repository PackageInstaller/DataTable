-- 岁稔技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704300105 = oo.class(SkillBase)
function Skill704300105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704300105:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill704300105:OnActionOver(caster, target, data)
	-- 704300133
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 8200
		if SkillJudger:IsCurrSkill(self, caster, target, true) then
		else
			return
		end
		-- 704300121
		self:HitAddBuff(SkillEffect[704300121], caster, target, data, 7500,5004,2)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 8200
		if SkillJudger:IsCurrSkill(self, caster, target, true) then
		else
			return
		end
		-- 704300122
		self:HitAddBuff(SkillEffect[704300122], caster, target, data, 7500,5104,2)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 8200
		if SkillJudger:IsCurrSkill(self, caster, target, true) then
		else
			return
		end
		-- 704300123
		self:HitAddBuff(SkillEffect[704300123], caster, target, data, 7500,3004,1)
	end
end
