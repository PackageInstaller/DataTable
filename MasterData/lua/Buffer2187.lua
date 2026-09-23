-- 荷魯斯護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2187 = oo.class(BuffBase)
function Buffer2187:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer2187:OnRemoveBuff(caster, target)
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 2008
	self:Cure(BufferEffect[2008], self.caster, self.card, nil, 8,0.15)
end
-- 创建时
function Buffer2187:OnCreate(caster, target)
	-- 2116
	self:AddShield(BufferEffect[2116], self.caster, target or self.owner, nil,1,0.17)
end
