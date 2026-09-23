-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402000102 = oo.class(BuffBase)
function Buffer402000102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer402000102:OnCreate(caster, target)
	local c53 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,44020)
	local c54 = SkillApi:GetCount(self, self.caster, target or self.owner,3,402000101)
	self:LimitDamage(BufferEffect[402000101], self.caster, target or self.owner, nil,(1+c54)*c54*(1+(c53-1)*0.25)/200,1.5*(1+(c53-1)*0.25))
end
