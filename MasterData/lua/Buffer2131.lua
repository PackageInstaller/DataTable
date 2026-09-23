-- 耀光盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2131 = oo.class(BuffBase)
function Buffer2131:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer2131:OnRoundBegin(caster, target)
	-- 6103
	self:ImmuneBuffQuality(BufferEffect[6103], self.caster, target or self.owner, nil,2)
end
-- 创建时
function Buffer2131:OnCreate(caster, target)
	-- 2111
	self:AddShield(BufferEffect[2111], self.caster, target or self.owner, nil,1,0.12)
	-- 6103
	self:ImmuneBuffQuality(BufferEffect[6103], self.caster, target or self.owner, nil,2)
end
