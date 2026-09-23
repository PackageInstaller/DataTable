-- 心智擾亂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337113 = oo.class(BuffBase)
function Buffer337113:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337113:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337113
	self:AddAttr(BufferEffect[337113], self.caster, target or self.owner, nil,"speed",12*self.nCount)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337123
	self:AddAttr(BufferEffect[337123], self.caster, target or self.owner, nil,"attack",-120*self.nCount)
end
