-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer999999990 = oo.class(BuffBase)
function Buffer999999990:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer999999990:OnCreate(caster, target)
	-- 999999990
	self:AddAttr(BufferEffect[999999990], self.caster, target or self.owner, nil,"crit_rate",0.5)
end
