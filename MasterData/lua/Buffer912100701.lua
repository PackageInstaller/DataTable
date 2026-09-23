-- 釣魚佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer912100701 = oo.class(BuffBase)
function Buffer912100701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer912100701:OnCreate(caster, target)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, self.caster, target or self.owner,nil)
	-- 912100701
	self:AddAttr(BufferEffect[912100701], self.caster, target or self.owner, nil,"damage",math.floor((angler2/10000)*0.05))
end
