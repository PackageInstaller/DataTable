-- 燃起薪火
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer338201 = oo.class(BuffBase)
function Buffer338201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer338201:OnBefourHurt(caster, target)
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
	-- 338211
	self:AddTempAttr(BufferEffect[338211], self.caster, self.card, nil, "damage",0.02*self.nCount)
end
-- 创建时
function Buffer338201:OnCreate(caster, target)
	-- 338201
	self:AddAttr(BufferEffect[338201], self.caster, self.card, nil, "damage",0.01*self.nCount)
end
