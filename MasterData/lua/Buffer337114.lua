-- 心智擾亂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337114 = oo.class(BuffBase)
function Buffer337114:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337114:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337114
	self:AddAttr(BufferEffect[337114], self.caster, target or self.owner, nil,"speed",16*self.nCount)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337124
	self:AddAttr(BufferEffect[337124], self.caster, target or self.owner, nil,"attack",-160*self.nCount)
end
