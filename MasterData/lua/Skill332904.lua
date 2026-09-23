-- 幽兰2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332904 = oo.class(SkillBase)
function Skill332904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill332904:OnBefourHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8437
	local count37 = SkillApi:BuffCount(self, caster, target,2,3,3008)
	-- 8120
	if SkillJudger:Greater(self, caster, self.card, true,count37,0) then
	else
		return
	end
	-- 332904
	self:AddTempAttr(SkillEffect[332904], caster, target, data, "bedamage",0.12)
end
