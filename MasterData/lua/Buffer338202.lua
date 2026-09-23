-- 燃起薪火
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer338202 = oo.class(BuffBase)
function Buffer338202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer338202:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, self.caster, target, true,10) then
	else
		return
	end
	-- 338212
	self:AddTempAttr(BufferEffect[338212], self.caster, self.card, nil, "damage",0.04*self.nCount)
end
-- 创建时
function Buffer338202:OnCreate(caster, target)
	-- 338202
	self:AddAttr(BufferEffect[338202], self.caster, self.card, nil, "damage",0.02*self.nCount)
end
