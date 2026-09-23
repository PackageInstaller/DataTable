-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337105 = oo.class(BuffBase)
function Buffer337105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337105:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337105
	self:AddMaxHpPercent(BufferEffect[337105], self.caster, target or self.owner, nil,1,math.floor(c765*0.1))
end
