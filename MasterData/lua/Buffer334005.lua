-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334005 = oo.class(BuffBase)
function Buffer334005:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334005:OnCreate(caster, target)
	-- 334005
	self:AddAttr(BufferEffect[334005], self.caster, target or self.owner, nil,"becure",0.30)
end
