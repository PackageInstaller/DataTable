-- 雙重免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer983630211 = oo.class(BuffBase)
function Buffer983630211:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer983630211:OnRoundBegin(caster, target)
	-- 983630211
	self:ImmuneBufferGroup(BufferEffect[983630211], self.caster, target or self.owner, nil,1)
	-- 983630201
	self:ImmuneBuffID(BufferEffect[983630201], self.caster, target or self.owner, nil,1001)
	-- 983630202
	self:ImmuneBuffID(BufferEffect[983630202], self.caster, target or self.owner, nil,1002)
	-- 983630203
	self:ImmuneBuffID(BufferEffect[983630203], self.caster, target or self.owner, nil,1003)
end
