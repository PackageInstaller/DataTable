-- 狮子座狂暴形态主天赋被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984210602 = oo.class(SkillBase)
function Skill984210602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill984210602:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 9727
	local count816 = SkillApi:GetAttr(self, caster, target,1,"defense")
	-- 8459
	local count59 = SkillApi:GetAttr(self, caster, target,2,"defense")
	-- 984210601
	self:AddTempAttr(SkillEffect[984210601], caster, self.card, data, "attack",math.max((count816-count59)*10,0))
end
