-- 爆裂護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer802700301 = oo.class(BuffBase)
function Buffer802700301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer802700301:OnRemoveBuff(caster, target)
	-- 8475
	local c75 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"attack")
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 802700301
	self:AddHp(BufferEffect[802700301], self.caster, self.caster, nil, -c75)
end
-- 创建时
function Buffer802700301:OnCreate(caster, target)
	-- 2115
	self:AddShield(BufferEffect[2115], self.caster, target or self.owner, nil,1,0.16)
end
