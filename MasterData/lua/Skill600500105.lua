-- 轮切
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600500105 = oo.class(SkillBase)
function Skill600500105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600500105:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 攻击结束
function Skill600500105:OnAttackOver(caster, target, data)
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
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 600500103
	if SkillJudger:Greater(self, caster, target, true,count12,0) then
		-- 600500112
		self:DelBufferGroup(SkillEffect[600500112], caster, target, data, 2,2)
	else
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
		-- 600500122
		self:AddProgress(SkillEffect[600500122], caster, target, data, -100)
	end
end
