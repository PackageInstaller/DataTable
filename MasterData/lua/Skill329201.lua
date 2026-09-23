-- 茶晶天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329201 = oo.class(SkillBase)
function Skill329201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill329201:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8652
	local count652 = SkillApi:SkillLevel(self, caster, target,3,41021)
	-- 329201
	if self:Rand(2000) then
		local targets = SkillFilter:Rand(self, caster, target, 3)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[329201], caster, target, data, 4102100+count652)
		end
	end
end
