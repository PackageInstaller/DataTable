-- 水巨人被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923100401 = oo.class(SkillBase)
function Skill923100401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923100401:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill923100401:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 923100401
	if self:Rand(3500) then
		local targets = SkillFilter:MaxAttr(self, caster, target, 1,"attack",1)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[923100401], caster, target, data, 923100101)
		end
	end
end
