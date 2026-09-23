-- 溢出護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2701 = oo.class(BuffBase)
function Buffer2701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2701:OnCreate(caster, target)
	-- 8442
	local c42 = SkillApi:GetCureHp(self, self.caster, target or self.owner,2)
	-- 2701
	self:AddShieldValue(BufferEffect[2701], self.caster, target or self.owner, nil,c42)
end
