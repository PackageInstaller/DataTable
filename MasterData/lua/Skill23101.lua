-- 余震I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23101 = oo.class(SkillBase)
function Skill23101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill23101:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8447
	local count47 = SkillApi:GetOverDamageTotal(self, caster, target,2)
	-- 8402
	local count2 = SkillApi:LiveCount(self, caster, target,2)
	-- 23101
	local targets = SkillFilter:All(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[23101], caster, target, data, -count47/math.max(1,count2)*0.5)
	end
	-- 231010
	self:ShowTips(SkillEffect[231010], caster, self.card, data, 2,"满溢",true,231010)
end
