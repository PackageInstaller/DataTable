-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331405 = oo.class(BuffBase)
function Buffer331405:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331405:OnCreate(caster, target)
	-- 331405
	self:AddAttr(BufferEffect[331405], self.caster, target or self.owner, nil,"becure",0.20)
end
