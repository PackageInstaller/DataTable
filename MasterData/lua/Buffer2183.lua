-- 荷魯斯護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2183 = oo.class(BuffBase)
function Buffer2183:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer2183:OnRemoveBuff(caster, target)
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 2007
	self:Cure(BufferEffect[2007], self.caster, self.card, nil, 8,0.08)
end
-- 创建时
function Buffer2183:OnCreate(caster, target)
	-- 2109
	self:AddShield(BufferEffect[2109], self.caster, target or self.owner, nil,1,0.10)
end
