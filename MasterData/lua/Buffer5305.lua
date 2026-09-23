-- 暴擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5305 = oo.class(BuffBase)
function Buffer5305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5305:OnCreate(caster, target)
	-- 5305
	self:AddAttr(BufferEffect[5305], self.caster, target or self.owner, nil,"crit_rate",-0.25)
end
