-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100060043 = oo.class(BuffBase)
function Buffer1100060043:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100060043:OnCreate(caster, target)
	-- 1100060043
	self:AddTempAttrPercent(BufferEffect[1100060043], self.caster, target or self.owner, nil,"damage",-0.8)
end
