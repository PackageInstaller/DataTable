-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010310 = oo.class(BuffBase)
function Buffer1100010310:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010310:OnCreate(caster, target)
	-- 1100010310
	self:AddAttr(BufferEffect[1100010310], self.caster, self.card, nil, "crit",0.05*self.nCount)
end
