-- 當角色擁有普攻增傷時，可以概率觸發反擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040150 = oo.class(BuffBase)
function Buffer1000040150:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000040150:OnBefourHurt(caster, target)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, self.caster, target, true) then
	else
		return
	end
	-- 1000040150
	self:AddTempAttrPercent(BufferEffect[1000040150], self.caster, self.card, nil, "damage",0.26)
end
