-- 同步率超載
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3202 = oo.class(BuffBase)
function Buffer3202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3202:OnCreate(caster, target)
	-- 3202
	self:UnableAddSP(BufferEffect[3202], self.caster, target or self.owner, nil,100)
end
