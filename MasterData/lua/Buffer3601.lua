-- 虛弱
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3601 = oo.class(BuffBase)
function Buffer3601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3601:OnCreate(caster, target)
	-- 3202
	self:UnableAddSP(BufferEffect[3202], self.caster, target or self.owner, nil,100)
	-- 5906
	self:AddAttr(BufferEffect[5906], self.caster, target or self.owner, nil,"bedamage",0.3)
end
