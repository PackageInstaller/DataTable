-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020261 = oo.class(BuffBase)
function Buffer1100020261:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020261:OnCreate(caster, target)
	-- 1100020261
	self:AddAttrPercent(BufferEffect[1100020261], self.caster, target or self.owner, nil,"defense",0.1)
end
