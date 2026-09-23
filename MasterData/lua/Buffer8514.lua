-- 被汲取機動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer8514 = oo.class(BuffBase)
function Buffer8514:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer8514:OnCreate(caster, target)
	-- 8410
	local sd1 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"sd1")
	-- 8514
	self:AddAttr(BufferEffect[8514], self.caster, target or self.owner, nil,"speed",-sd1*0.2)
end
