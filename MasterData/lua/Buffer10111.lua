-- 堅毅不倒-等級2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10111 = oo.class(BuffBase)
function Buffer10111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10111:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4121
	self:AddAttrPercent(BufferEffect[4121], self.caster, target or self.owner, nil,"defense",0.1)
end
