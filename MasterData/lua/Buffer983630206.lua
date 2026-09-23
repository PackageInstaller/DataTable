-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer983630206 = oo.class(BuffBase)
function Buffer983630206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer983630206:OnCreate(caster, target)
	-- 8033
	self:AddAttr(BufferEffect[8033], self.caster, target or self.owner, nil,"damage",0.2)
end
