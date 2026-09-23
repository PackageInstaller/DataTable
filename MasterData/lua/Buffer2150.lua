-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2150 = oo.class(BuffBase)
function Buffer2150:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2150:OnCreate(caster, target)
	-- 2150
	self:AddShield(BufferEffect[2150], self.caster, target or self.owner, nil,1,0.08)
end
