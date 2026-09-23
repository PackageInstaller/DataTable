-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331404 = oo.class(BuffBase)
function Buffer331404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331404:OnCreate(caster, target)
	-- 331404
	self:AddAttr(BufferEffect[331404], self.caster, target or self.owner, nil,"becure",0.16)
end
