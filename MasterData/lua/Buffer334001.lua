-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334001 = oo.class(BuffBase)
function Buffer334001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334001:OnCreate(caster, target)
	-- 334001
	self:AddAttr(BufferEffect[334001], self.caster, target or self.owner, nil,"becure",0.1)
end
