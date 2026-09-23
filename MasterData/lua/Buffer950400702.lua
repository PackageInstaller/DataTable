-- 自檢模式
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer950400702 = oo.class(BuffBase)
function Buffer950400702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer950400702:OnCreate(caster, target)
	-- 950400702
	self:AddAttr(BufferEffect[950400702], self.caster, self.card, nil, "bedamage",-0.03*self.nCount)
	-- 950400703
	self:AddAttr(BufferEffect[950400703], self.caster, self.card, nil, "resist",0.03*self.nCount)
end
