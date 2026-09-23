-- 獲得50同步率
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer999999012 = oo.class(BuffBase)
function Buffer999999012:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer999999012:OnCreate(caster, target)
	-- 999999012
	self:AddSp(BufferEffect[999999012], self.caster, target or self.owner, nil,50)
end
