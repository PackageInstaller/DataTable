-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070081 = oo.class(BuffBase)
function Buffer1100070081:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070081:OnCreate(caster, target)
	-- 4106
	self:AddAttrPercent(BufferEffect[4106], self.caster, target or self.owner, nil,"defense",0.3)
	-- 4006
	self:AddAttrPercent(BufferEffect[4006], self.caster, target or self.owner, nil,"attack",0.3)
end
