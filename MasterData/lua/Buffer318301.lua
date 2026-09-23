-- 轉化攻擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318301 = oo.class(BuffBase)
function Buffer318301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318301:OnCreate(caster, target)
	-- 1023
	local dmg3 = SkillApi:GetValue(self, self.caster, target or self.owner,3,"dmg3")
	-- 318301
	self:AddAttr(BufferEffect[318301], self.caster, target or self.owner, nil,"attack",dmg3*0.04)
end
