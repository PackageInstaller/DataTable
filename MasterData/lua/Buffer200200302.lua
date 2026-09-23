-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200200302 = oo.class(BuffBase)
function Buffer200200302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200200302:OnCreate(caster, target)
	-- 200200302
	self:AddAttr(BufferEffect[200200302], self.caster, target or self.owner, nil,"crit_rate",0.20)
end
