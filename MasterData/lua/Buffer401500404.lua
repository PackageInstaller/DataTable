-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer401500404 = oo.class(BuffBase)
function Buffer401500404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer401500404:OnCreate(caster, target)
	local c65 = SkillApi:GetBeDamageLight(self, self.caster, target or self.owner,3)
	self:AddHp(BufferEffect[401500404], self.caster, self.card, nil, math.floor(-c65*0.9))
end
