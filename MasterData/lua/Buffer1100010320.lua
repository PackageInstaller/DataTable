-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010320 = oo.class(BuffBase)
function Buffer1100010320:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010320:OnCreate(caster, target)
	-- 1100010320
	self:AddAttrPercent(BufferEffect[1100010320], self.caster, self.card, nil, "defense",0.1)
end
