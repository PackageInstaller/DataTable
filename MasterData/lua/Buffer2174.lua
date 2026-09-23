-- 防護泡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2174 = oo.class(BuffBase)
function Buffer2174:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer2174:OnRemoveBuff(caster, target)
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 2006
	self:Cure(BufferEffect[2006], self.caster, self.card, nil, 8,0.1)
end
-- 创建时
function Buffer2174:OnCreate(caster, target)
	-- 2814
	self:AddShield(BufferEffect[2814], self.caster, target or self.owner, nil,9,2)
	-- 8467
	local c67 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3261)
	-- 403200301
	self:AddAttrPercent(BufferEffect[403200301], self.caster, target or self.owner, nil,"defense",0.04*c67)
end
