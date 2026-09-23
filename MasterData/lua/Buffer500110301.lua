-- 短路
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer500110301 = oo.class(BuffBase)
function Buffer500110301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer500110301:OnCreate(caster, target)
	-- 3201
	self:UnableAddNp(BufferEffect[3201], self.caster, target or self.owner, nil,100)
	-- 3202
	self:UnableAddSP(BufferEffect[3202], self.caster, target or self.owner, nil,100)
	-- 3203
	self:UnableAddXp(BufferEffect[3203], self.caster, target or self.owner, nil,100)
end
