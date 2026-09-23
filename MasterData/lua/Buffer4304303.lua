-- 強化劑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4304303 = oo.class(BuffBase)
function Buffer4304303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4304303:OnCreate(caster, target)
	-- 4911
	self:AddAttr(BufferEffect[4911], self.caster, target or self.owner, nil,"bedamage",-0.07)
	-- 4311
	self:AddAttr(BufferEffect[4311], self.caster, target or self.owner, nil,"crit_rate",0.07)
	-- 4401
	self:AddAttr(BufferEffect[4401], self.caster, target or self.owner, nil,"crit",0.05)
end
