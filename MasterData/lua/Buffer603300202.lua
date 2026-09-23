-- 金翼信標
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603300202 = oo.class(BuffBase)
function Buffer603300202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603300202:OnCreate(caster, target)
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 603300212
	self:AddAttr(BufferEffect[603300212], self.caster, self.creater, nil, "crit",c771*0.15)
end
-- 回合结束时
function Buffer603300202:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 603300202
	self:AddProgress(BufferEffect[603300202], self.caster, self.creater, nil, 250)
end
