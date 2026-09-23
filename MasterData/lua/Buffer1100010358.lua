-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010358 = oo.class(BuffBase)
function Buffer1100010358:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010358:OnCreate(caster, target)
	-- 8740
	local c136 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,1)
	-- 1100010358
	self:AddAttrPercent(BufferEffect[1100010358], self.caster, target or self.owner, nil,"hit",0.2*c136)
end
