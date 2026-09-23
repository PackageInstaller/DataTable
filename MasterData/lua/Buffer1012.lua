-- 傷害引爆（把自己的存儲傷害給目標）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1012 = oo.class(BuffBase)
function Buffer1012:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1012:OnCreate(caster, target)
	-- 1019
	local dmg2 = SkillApi:GetValue(self, self.caster, target or self.owner,1,"dmg2")
	-- 1018
	self:AddHp(BufferEffect[1018], self.caster, target or self.owner, nil,-dmg2*1.5)
	-- 1020
	self:DelValue(BufferEffect[1020], self.caster, self.caster, nil, "dmg2")
end
