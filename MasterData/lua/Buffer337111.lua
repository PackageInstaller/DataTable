-- 心智擾亂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337111 = oo.class(BuffBase)
function Buffer337111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337111:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337111
	self:AddAttr(BufferEffect[337111], self.caster, target or self.owner, nil,"speed",4*self.nCount)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337121
	self:AddAttr(BufferEffect[337121], self.caster, target or self.owner, nil,"attack",-40*self.nCount)
end
