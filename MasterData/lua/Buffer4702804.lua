-- 意志
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4702804 = oo.class(BuffBase)
function Buffer4702804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4702804:OnBefourHurt(caster, target)
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
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 4702804
	self:AddTempAttr(BufferEffect[4702804], self.caster, self.card, nil, "damage",0.05*self.nCount)
end
-- 创建时
function Buffer4702804:OnCreate(caster, target)
	-- 8473
	local c73 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,3279)
	-- 4702805
	self:AddAttr(BufferEffect[4702805], self.caster, self.card, nil, "hit",0.02*self.nCount*c73)
	-- 8473
	local c73 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,3279)
	-- 4702806
	self:AddAttr(BufferEffect[4702806], self.caster, self.card, nil, "speed",2*self.nCount*c73)
end
