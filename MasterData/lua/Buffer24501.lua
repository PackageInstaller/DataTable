-- 行動提前
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24501 = oo.class(BuffBase)
function Buffer24501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer24501:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 24501
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddProgress(BufferEffect[24501], self.caster, target, nil, 100)
	end
	-- 24504
	self:DelBufferTypeForce(BufferEffect[24504], self.caster, self.card, nil, 24501)
end
