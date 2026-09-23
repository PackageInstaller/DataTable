-- 使用非傷害技能後，下次攻擊必定暴擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040051 = oo.class(BuffBase)
function Buffer1000040051:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000040051:OnCreate(caster, target)
	-- 1000040051
	self:AddAttr(BufferEffect[1000040051], self.caster, self.card, nil, "crit",0.2)
end
