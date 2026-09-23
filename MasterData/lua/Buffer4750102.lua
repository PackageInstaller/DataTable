-- 弱點集中
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4750102 = oo.class(BuffBase)
function Buffer4750102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer4750102:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4750102
	self:DelBufferForce(BufferEffect[4750102], self.caster, self.card, nil, 4750101)
end
-- 创建时
function Buffer4750102:OnCreate(caster, target)
	-- 4750101
	self:AddAttr(BufferEffect[4750101], self.caster, self.card, nil, "bedamage",0.02*self.nCount)
end
