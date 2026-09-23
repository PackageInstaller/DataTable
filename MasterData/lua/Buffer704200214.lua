-- 增幅吸收
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704200214 = oo.class(BuffBase)
function Buffer704200214:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704200214:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 704200214
	self:AddAttr(BufferEffect[704200214], self.caster, self.card, nil, "attack",math.floor(math.min(c765*0.013/2,2000)))
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 704200224
	self:AddValue(BufferEffect[704200224], self.caster, self.card, nil, "dmg7042",c765*0.26)
end
