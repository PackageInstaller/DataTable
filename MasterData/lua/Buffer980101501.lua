-- 山脈屬性buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101501 = oo.class(BuffBase)
function Buffer980101501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101501:OnCreate(caster, target)
	-- 8744
	local c140 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,5)
	-- 980101501
	self:AddAttr(BufferEffect[980101501], self.caster, target or self.owner, nil,"damage",0.05*c140)
end
