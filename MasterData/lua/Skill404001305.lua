-- 坍缩炸弹（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill404001305 = oo.class(SkillBase)
function Skill404001305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill404001305:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 伤害前
function Skill404001305:OnBefourHurt(caster, target, data)
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
	-- 404001303
	if self:Rand(4000) then
		self:AddProgress(SkillEffect[404001303], caster, target, data, -300)
		-- 404000304
		self:DelBufferGroup(SkillEffect[404000304], caster, target, data, 2,1)
	end
end
