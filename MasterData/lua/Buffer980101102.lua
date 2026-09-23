-- 山脈機制buff2效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101102 = oo.class(BuffBase)
function Buffer980101102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101102:OnCreate(caster, target)
	-- 8747
	local c143 = SkillApi:ClassCount(self, self.caster, target or self.owner,4,1)
	-- 8754
	local c150 = SkillApi:GetAttr(self, self.caster, target or self.owner,1,"defense")
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 980101102
	self:AddHp(BufferEffect[980101102], self.caster, target or self.owner, nil,-(2*c150*c143))
end
