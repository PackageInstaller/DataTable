-- 暴發
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1030207 = oo.class(BuffBase)
function Buffer1030207:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1030207:OnCreate(caster, target)
	-- 1030207
	self:AddAttr(BufferEffect[1030207], self.caster, target or self.owner, nil,"crit",0.40)
	-- 4305
	self:AddAttr(BufferEffect[4305], self.caster, target or self.owner, nil,"crit_rate",0.25)
end
