-- 傷害提高
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer983630207 = oo.class(BuffBase)
function Buffer983630207:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer983630207:OnCreate(caster, target)
	-- 983630207
	self:AddAttr(BufferEffect[983630207], self.caster, self.card, nil, "damage",0.2*self.nCount)
end
