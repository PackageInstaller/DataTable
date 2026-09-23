-- 增幅吸收
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704200213 = oo.class(BuffBase)
function Buffer704200213:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704200213:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 704200213
	self:AddAttr(BufferEffect[704200213], self.caster, self.card, nil, "attack",math.floor(math.min(c765*0.011/2,2000)))
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 704200223
	self:AddValue(BufferEffect[704200223], self.caster, self.card, nil, "dmg7042",c765*0.22)
end
