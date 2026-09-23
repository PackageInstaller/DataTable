-- 王權號令
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer801000201 = oo.class(BuffBase)
function Buffer801000201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer801000201:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 801000201
	self:AddAttr(BufferEffect[801000201], self.caster, self.creater, nil, "attack",c15*0.40)
end
-- 回合结束时
function Buffer801000201:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 801000202
	self:AddProgress(BufferEffect[801000202], self.caster, self.creater, nil, 400)
end
