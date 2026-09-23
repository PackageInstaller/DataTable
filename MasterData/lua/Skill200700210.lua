-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200700210 = oo.class(SkillBase)
function Skill200700210:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200700210:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill200700210:OnActionOver(caster, target, data)
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	local targets = SkillFilter:MinPercentHp(self, caster, target, 3,"hp",1)
	for i,target in ipairs(targets) do
		local count68 = SkillApi:GetAttr(self, caster, target,2,"maxhp")
		local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
		self:EnergyCure(SkillEffect[200700202], caster, target, data, (count68-count67)*0.3)
	end
end
