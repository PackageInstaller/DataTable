-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334004 = oo.class(BuffBase)
function Buffer334004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334004:OnCreate(caster, target)
	-- 334004
	self:AddAttr(BufferEffect[334004], self.caster, target or self.owner, nil,"becure",0.25)
end
