-- 狮子座普通形态著天赋被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984200601 = oo.class(SkillBase)
function Skill984200601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill984200601:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 984200601
	self:AddTempAttr(SkillEffect[984200601], caster, self.card, data, "bedamage",0.05*count16)
end
-- 入场时
function Skill984200601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984200603
	self:AddBuff(SkillEffect[984200603], caster, self.card, data, 980100607)
end
