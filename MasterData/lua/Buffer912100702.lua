-- 釣魚佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer912100702 = oo.class(BuffBase)
function Buffer912100702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer912100702:OnCreate(caster, target)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, self.caster, target or self.owner,nil)
	-- 912100702
	self:AddAttr(BufferEffect[912100702], self.caster, target or self.owner, nil,"bedamage",math.floor((angler2/10000)*0.05))
end
