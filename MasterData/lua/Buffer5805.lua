-- 傷害弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5805 = oo.class(BuffBase)
function Buffer5805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5805:OnCreate(caster, target)
	-- 5805
	self:AddAttr(BufferEffect[5805], self.caster, target or self.owner, nil,"damage",-0.25)
end
