-- 傷害提高
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer983630218 = oo.class(BuffBase)
function Buffer983630218:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer983630218:OnCreate(caster, target)
	-- 300110301
	self:AddAttr(BufferEffect[300110301], self.caster, target or self.owner, nil,"crit_rate",1)
end
