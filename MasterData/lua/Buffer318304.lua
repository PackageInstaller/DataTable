-- 轉化攻擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318304 = oo.class(BuffBase)
function Buffer318304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318304:OnCreate(caster, target)
	-- 1023
	local dmg3 = SkillApi:GetValue(self, self.caster, target or self.owner,3,"dmg3")
	-- 318304
	self:AddAttr(BufferEffect[318304], self.caster, target or self.owner, nil,"attack",dmg3*0.07)
end
