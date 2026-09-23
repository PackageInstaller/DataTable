-- 983610207_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer983610207 = oo.class(BuffBase)
function Buffer983610207:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer983610207:OnCreate(caster, target)
	-- 4804
	self:AddAttr(BufferEffect[4804], self.caster, target or self.owner, nil,"damage",0.2)
end
