-- 強制嘲諷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3007 = oo.class(BuffBase)
function Buffer3007:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3007:OnCreate(caster, target)
	-- 3007
	self:Sneer(BufferEffect[3007], self.caster, target or self.owner, nil,nil)
	-- 3002
	self:Silence(BufferEffect[3002], self.caster, target or self.owner, nil,nil)
end
