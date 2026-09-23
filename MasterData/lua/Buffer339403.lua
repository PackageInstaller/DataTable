-- 免疫傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer339403 = oo.class(BuffBase)
function Buffer339403:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer339403:OnRoundBegin(caster, target)
	-- 6108
	self:ImmuneDamage(BufferEffect[6108], self.caster, target or self.owner, nil,nil)
end
-- 创建时
function Buffer339403:OnCreate(caster, target)
	-- 6108
	self:ImmuneDamage(BufferEffect[6108], self.caster, target or self.owner, nil,nil)
end
