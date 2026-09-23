-- 角色施放大招後，若該次大招未施放攻擊，則使自身傷害提高10%，持續1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040061 = oo.class(BuffBase)
function Buffer1000040061:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000040061:OnCreate(caster, target)
	-- 1000040061
	self:AddAttrPercent(BufferEffect[1000040061], self.caster, target or self.owner, nil,"defense",-0.16*self.nCount)
end
