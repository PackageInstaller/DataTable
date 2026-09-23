-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334002 = oo.class(BuffBase)
function Buffer334002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334002:OnCreate(caster, target)
	-- 334002
	self:AddAttr(BufferEffect[334002], self.caster, target or self.owner, nil,"becure",0.15)
end
