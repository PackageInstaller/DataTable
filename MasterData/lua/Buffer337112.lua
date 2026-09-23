-- 心智擾亂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337112 = oo.class(BuffBase)
function Buffer337112:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337112:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337112
	self:AddAttr(BufferEffect[337112], self.caster, target or self.owner, nil,"speed",8*self.nCount)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337122
	self:AddAttr(BufferEffect[337122], self.caster, target or self.owner, nil,"attack",-80*self.nCount)
end
