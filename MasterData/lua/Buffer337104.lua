-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337104 = oo.class(BuffBase)
function Buffer337104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337104:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337104
	self:AddMaxHpPercent(BufferEffect[337104], self.caster, target or self.owner, nil,0.8,math.floor(c765*0.08))
end
