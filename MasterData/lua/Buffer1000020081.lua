-- 50%自身耐久的護盾,持續3回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020081 = oo.class(BuffBase)
function Buffer1000020081:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020081:OnCreate(caster, target)
	-- 1000020081
	self:AddShield(BufferEffect[1000020081], self.caster, self.card, nil, 1,0.5)
end
