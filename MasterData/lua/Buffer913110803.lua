-- 1個強化效果,防禦10%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913110803 = oo.class(BuffBase)
function Buffer913110803:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913110803:OnCreate(caster, target)
	-- 913110803
	self:AddProgress(BufferEffect[913110803], self.caster, self.card, nil, -200)
end
