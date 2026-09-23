-- 堅毅不倒-等級4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10113 = oo.class(BuffBase)
function Buffer10113:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10113:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4123
	self:AddAttrPercent(BufferEffect[4123], self.caster, target or self.owner, nil,"defense",0.2)
end
