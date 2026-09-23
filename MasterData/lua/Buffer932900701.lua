-- 外殼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932900701 = oo.class(BuffBase)
function Buffer932900701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932900701:OnCreate(caster, target)
	-- 932900701
	self:AddAttr(BufferEffect[932900701], self.caster, self.card, nil, "bedamage",-0.08*self.nCount)
	-- 932900702
	self:AddAttr(BufferEffect[932900702], self.caster, self.card, nil, "resist",0.08*self.nCount)
end
