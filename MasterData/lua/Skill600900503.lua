-- 开刃追击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600900503 = oo.class(SkillBase)
function Skill600900503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600900503:DoSkill(caster, target, data)
	-- 8648
	local count648 = SkillApi:BuffCount(self, caster, target,2,4,328801)
	-- 8850
	if SkillJudger:Greater(self, caster, target, true,count648,0) then
		-- 12010
		self.order = self.order + 1
		self:DamageLight(SkillEffect[12010], caster, target, data, 2,1)
	else
		-- 12001
		self.order = self.order + 1
		self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	end
end
