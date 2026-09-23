-- 強化劑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4304304 = oo.class(BuffBase)
function Buffer4304304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4304304:OnCreate(caster, target)
	-- 4911
	self:AddAttr(BufferEffect[4911], self.caster, target or self.owner, nil,"bedamage",-0.07)
	-- 4311
	self:AddAttr(BufferEffect[4311], self.caster, target or self.owner, nil,"crit_rate",0.07)
	-- 4402
	self:AddAttr(BufferEffect[4402], self.caster, target or self.owner, nil,"crit",0.1)
end
