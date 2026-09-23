-- 續行
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6111 = oo.class(BuffBase)
function Buffer6111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer6111:OnAfterHurt(caster, target)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 8632
	if SkillJudger:Less(self, self.caster, self.card, true,c116,2) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1061
	self:SetValue(BufferEffect[1061], self.caster, self.card, nil, "L6111",1)
end
-- 回合开始时
function Buffer6111:OnRoundBegin(caster, target)
	-- 6109
	self:ImmuneDeath(BufferEffect[6109], self.caster, target or self.owner, nil,nil)
end
-- 行动结束2
function Buffer6111:OnActionOver2(caster, target)
	-- 1062
	local L6111 = SkillApi:GetValue(self, self.caster, target or self.owner,3,"L6111")
	-- 1063
	if SkillJudger:Greater(self, self.caster, self.card, true,L6111,0) then
	else
		return
	end
	-- 1064
	self:DelBufferForce(BufferEffect[1064], self.caster, self.card, nil, 6111)
	-- 1066
	self:OwnerAddBuffCount(BufferEffect[1066], self.caster, self.card, nil, 304800101,-5,8)
	-- 1065
	self:SetValue(BufferEffect[1065], self.caster, self.card, nil, "L6111",0)
end
