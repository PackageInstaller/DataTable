-- 堅毅不倒-等級1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10110 = oo.class(BuffBase)
function Buffer10110:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10110:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4120
	self:AddAttrPercent(BufferEffect[4120], self.caster, target or self.owner, nil,"defense",0.05)
end
