-- 暴擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603000305 = oo.class(BuffBase)
function Buffer603000305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603000305:OnCreate(caster, target)
	-- 5310
	self:AddAttr(BufferEffect[5310], self.caster, target or self.owner, nil,"crit_rate",-0.5)
end
