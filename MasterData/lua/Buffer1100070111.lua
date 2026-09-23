-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070111 = oo.class(BuffBase)
function Buffer1100070111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070111:OnCreate(caster, target)
	-- 4007
	self:AddAttrPercent(BufferEffect[4007], self.caster, target or self.owner, nil,"attack",0.35)
	-- 4210
	self:AddAttr(BufferEffect[4210], self.caster, target or self.owner, nil,"speed",50)
end
