-- 修復增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3305 = oo.class(BuffBase)
function Buffer3305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3305:OnCreate(caster, target)
	-- 3305
	self:AddAttr(BufferEffect[3305], self.caster, target or self.owner, nil,"cure",0.5)
end
