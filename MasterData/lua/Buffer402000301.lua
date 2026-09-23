-- 清除紅霧
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402000301 = oo.class(BuffBase)
function Buffer402000301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer402000301:OnCreate(caster, target)
	-- 8454
	local c54 = SkillApi:GetCount(self, self.caster, target or self.owner,3,402000101)
	-- 402000301
	self:LimitDamage(BufferEffect[402000301], self.caster, target or self.owner, nil,1,c54*0.4)
end
