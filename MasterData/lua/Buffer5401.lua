-- 暴傷弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5401 = oo.class(BuffBase)
function Buffer5401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5401:OnCreate(caster, target)
	-- 5401
	self:AddAttr(BufferEffect[5401], self.caster, target or self.owner, nil,"crit",-0.05)
end
