-- 機動增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer911900501 = oo.class(BuffBase)
function Buffer911900501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer911900501:OnCreate(caster, target)
	-- 8420
	local c20 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"speed")
	-- 911900501
	self:AddAttr(BufferEffect[911900501], self.caster, target or self.owner, nil,"speed",c20)
end
