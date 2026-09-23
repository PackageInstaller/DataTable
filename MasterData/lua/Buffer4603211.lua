-- 仇念
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603211 = oo.class(BuffBase)
function Buffer4603211:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603211:OnCreate(caster, target)
	-- 8774
	local c774 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,46032)
	-- 4603211
	self:AddAttr(BufferEffect[4603211], self.caster, self.card, nil, "attack",60*self.nCount*c774)
	-- 4603221
	self:AddAttr(BufferEffect[4603221], self.caster, self.card, nil, "crit",(0.01+math.floor((c774-1)/2)/100)*self.nCount)
end
