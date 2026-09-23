-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100040030 = oo.class(BuffBase)
function Buffer1100040030:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100040030:OnCreate(caster, target)
	-- 1100040030
	self:AddAttr(BufferEffect[1100040030], self.caster, target or self.owner, nil,"crit_rate",0.05*self.nCount)
	-- 1100040031
	self:AddAttr(BufferEffect[1100040031], self.caster, target or self.owner, nil,"crit",0.2*self.nCount)
end
