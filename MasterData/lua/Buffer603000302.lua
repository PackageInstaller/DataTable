-- 暴擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603000302 = oo.class(BuffBase)
function Buffer603000302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603000302:OnCreate(caster, target)
	-- 5304
	self:AddAttr(BufferEffect[5304], self.caster, target or self.owner, nil,"crit_rate",-0.2)
end
