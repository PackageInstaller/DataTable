-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200015 = oo.class(BuffBase)
function Buffer6200015:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6200015:OnCreate(caster, target)
	-- 4127
	self:AddAttr(BufferEffect[4127], self.caster, target or self.owner, nil,"attack",100*self.nCount)
end
