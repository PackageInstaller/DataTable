-- 增幅吸收
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704200211 = oo.class(BuffBase)
function Buffer704200211:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704200211:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 704200211
	self:AddAttr(BufferEffect[704200211], self.caster, self.card, nil, "attack",math.floor(math.min(c765*0.007/2,2000)))
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 704200221
	self:AddValue(BufferEffect[704200221], self.caster, self.card, nil, "dmg7042",c765*0.14)
end
