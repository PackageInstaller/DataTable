-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337103 = oo.class(BuffBase)
function Buffer337103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337103:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337103
	self:AddMaxHpPercent(BufferEffect[337103], self.caster, target or self.owner, nil,0.6,math.floor(c765*0.06))
end
