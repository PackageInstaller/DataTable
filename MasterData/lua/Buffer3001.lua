-- 戰術嘲諷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3001 = oo.class(BuffBase)
function Buffer3001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3001:OnCreate(caster, target)
	-- 3001
	self:Sneer(BufferEffect[3001], self.caster, target or self.owner, nil,nil)
end
