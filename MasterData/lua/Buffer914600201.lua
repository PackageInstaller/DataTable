-- 914600201_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914600201 = oo.class(BuffBase)
function Buffer914600201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer914600201:OnCreate(caster, target)
	-- 8405
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	-- 2160
	self:AddShield(BufferEffect[2160], self.caster, target or self.owner, nil,1,(0.1+(1-c5)*0.3))
end
