-- 攻擊時會比較雙方速度，速度越高傷害越高
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010050 = oo.class(BuffBase)
function Buffer1000010050:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000010050:OnBefourHurt(caster, target)
	-- 8420
	local c20 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"speed")
	-- 8404
	local c4 = SkillApi:GetAttr(self, self.caster, target or self.owner,2,"speed")
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010050
	self:AddTempAttrPercent(BufferEffect[1000010050], self.caster, self.card, nil, "damage",math.max((c20-c4)*0.03,0))
end
