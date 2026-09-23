-- 戰鬥開始後，我方造成的追擊傷害提升100%，持續1場戰鬥
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070140 = oo.class(BuffBase)
function Buffer1000070140:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000070140:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8248
	if SkillJudger:IsBeatAgain(self, self.caster, target, true) then
	else
		return
	end
	-- 1000070140
	self:AddTempAttrPercent(BufferEffect[1000070140], self.caster, self.card, nil, "damage",1.2)
end
