-- 傷害引爆（把目標的存儲傷害引爆）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1006 = oo.class(BuffBase)
function Buffer1006:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1006:OnCreate(caster, target)
	-- 1006
	local dmg = SkillApi:GetValue(self, self.caster, target or self.owner,2,"dmg")
	-- 1008
	self:AddHp(BufferEffect[1008], self.caster, target or self.owner, nil,-dmg)
	-- 1007
	self:DelValue(BufferEffect[1007], self.caster, target or self.owner, nil,"dmg")
end
