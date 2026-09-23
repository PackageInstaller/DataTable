-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer101100202 = oo.class(BuffBase)
function Buffer101100202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer101100202:OnCreate(caster, target)
	-- 101100202
	self:AddAttrPercent(BufferEffect[101100202], self.caster, target or self.owner, nil,"defense",0.19)
end
