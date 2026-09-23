-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983650101 = oo.class(SkillBase)
function Skill983650101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill983650101:OnDeath(caster, target, data)
	-- 110008033
	if SkillJudger:HasBuff(self, caster, target, true,1,983600901) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 110008030
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[110008030], caster, target, data, -count49*0.3)
	end
end
