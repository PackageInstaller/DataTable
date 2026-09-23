-- 暴傷增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980110803 = oo.class(BuffBase)
function Buffer980110803:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980110803:OnCreate(caster, target)
	-- 980110803
	self:AddAttr(BufferEffect[980110803], self.caster, self.card, nil, "crit",0.01*self.nCount)
end
