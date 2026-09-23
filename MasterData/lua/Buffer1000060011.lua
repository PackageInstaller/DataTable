-- +20%效果命中（2級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060011 = oo.class(BuffBase)
function Buffer1000060011:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060011:OnCreate(caster, target)
	-- 1000060011
	self:AddAttr(BufferEffect[1000060011], self.caster, self.card, nil, "hit",0.33)
end
