-- 防护泡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4403203 = oo.class(SkillBase)
function Skill4403203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4403203:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8626
	local count626 = SkillApi:SkillLevel(self, caster, target,3,4032003)
	-- 4403203
	if self:Rand(4000) then
		local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[4403203], caster, target, data, math.floor(2170+(count626+1)/2),2)
		end
	end
end
