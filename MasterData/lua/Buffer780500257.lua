-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780500257 = oo.class(BuffBase)
function Buffer780500257:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer780500257:OnCreate(caster, target)
	-- 8790
	local c790 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"sMech")
	-- 780500225
	if SkillJudger:HasBuff(self, self.caster, target, false,1,780500241+c790) then
	else
		return
	end
	-- 780500220
	self:AddBuff(BufferEffect[780500220], self.caster, self.card, nil, 780500298)
end
