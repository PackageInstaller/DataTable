-- 修復增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3301 = oo.class(BuffBase)
function Buffer3301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3301:OnCreate(caster, target)
	-- 3301
	self:AddAttr(BufferEffect[3301], self.caster, target or self.owner, nil,"cure",0.1)
end
