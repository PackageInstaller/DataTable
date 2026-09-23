-- 聚焦時刻
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6100001 = oo.class(BuffBase)
function Buffer6100001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6100001:OnRoundBegin(caster, target)
	-- 8065
	if SkillJudger:CasterIsSelf(self, self.caster, target, false) then
	else
		return
	end
	-- 6100004
	self:DelBufferForce(BufferEffect[6100004], self.caster, self.card, nil, 6100001)
end
-- 伤害前
function Buffer6100001:OnBefourHurt(caster, target)
	-- 8061
	if SkillJudger:CasterIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 6100003
	self:AddTempAttrPercent(BufferEffect[6100003], self.caster, self.caster, nil, "attack",0.8)
end
-- 创建时
function Buffer6100001:OnCreate(caster, target)
	-- 6100001
	self:AddAttr(BufferEffect[6100001], self.caster, self.card, nil, "damage",0.5)
	-- 6100002
	local targets = SkillFilter:Teammate(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[6100002], self.caster, target, nil, "attack",-0.8)
	end
end
