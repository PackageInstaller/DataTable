-- 強化劑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4304305 = oo.class(BuffBase)
function Buffer4304305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4304305:OnCreate(caster, target)
	-- 4902
	self:AddAttr(BufferEffect[4902], self.caster, target or self.owner, nil,"bedamage",-0.1)
	-- 4302
	self:AddAttr(BufferEffect[4302], self.caster, target or self.owner, nil,"crit_rate",0.1)
	-- 4402
	self:AddAttr(BufferEffect[4402], self.caster, target or self.owner, nil,"crit",0.1)
end
