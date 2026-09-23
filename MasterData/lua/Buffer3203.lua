-- 防禦超載
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3203 = oo.class(BuffBase)
function Buffer3203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer3203:OnRoundBegin(caster, target)
	-- 6109
	self:ImmuneDeath(BufferEffect[6109], self.caster, target or self.owner, nil,nil)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
end
-- 创建时
function Buffer3203:OnCreate(caster, target)
	-- 3202
	self:UnableAddSP(BufferEffect[3202], self.caster, target or self.owner, nil,100)
	-- 4906
	self:AddAttr(BufferEffect[4906], self.caster, target or self.owner, nil,"bedamage",-0.3)
	-- 6109
	self:ImmuneDeath(BufferEffect[6109], self.caster, target or self.owner, nil,nil)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
end
