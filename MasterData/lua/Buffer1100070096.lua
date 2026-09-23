-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070096 = oo.class(BuffBase)
function Buffer1100070096:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070096:OnCreate(caster, target)
	-- 5507
	self:AddAttr(BufferEffect[5507], self.caster, target or self.owner, nil,"hit",-0.5)
	-- 5607
	self:AddAttr(BufferEffect[5607], self.caster, target or self.owner, nil,"resist",-0.5)
end
