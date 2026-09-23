-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070082 = oo.class(BuffBase)
function Buffer1100070082:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070082:OnCreate(caster, target)
	-- 4306
	self:AddAttr(BufferEffect[4306], self.caster, target or self.owner, nil,"crit_rate",0.3)
	-- 4408
	self:AddAttr(BufferEffect[4408], self.caster, target or self.owner, nil,"crit",0.5)
end
