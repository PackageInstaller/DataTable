-- 山脈屬性buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101401 = oo.class(BuffBase)
function Buffer980101401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101401:OnCreate(caster, target)
	-- 8743
	local c139 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,4)
	-- 980101401
	self:AddAttr(BufferEffect[980101401], self.caster, target or self.owner, nil,"speed",20*c139)
end
