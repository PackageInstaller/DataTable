-- 修復增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer321401 = oo.class(BuffBase)
function Buffer321401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer321401:OnCreate(caster, target)
	-- 321401
	self:AddAttr(BufferEffect[321401], self.caster, target or self.owner, nil,"cure",0.1)
end
