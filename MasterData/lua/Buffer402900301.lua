-- 獲得同步率
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402900301 = oo.class(BuffBase)
function Buffer402900301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer402900301:OnCreate(caster, target)
	-- 402900301
	self:AddSp(BufferEffect[402900301], self.caster, target or self.owner, nil,50)
end
