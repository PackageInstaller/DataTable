-- 連擊賦予
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914300208 = oo.class(BuffBase)
function Buffer914300208:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer914300208:OnStart(caster, target)
	do
		-- 8060
		if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
		else
			return
		end
		-- 914300208
		self:AddSkill(BufferEffect[914300208], self.caster, self.card, nil, 24404)
	end
end
-- 行动开始
function Buffer914300208:OnActionBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914300208
	self:AddSkill(BufferEffect[914300208], self.caster, self.card, nil, 24404)
end
-- 回合开始时
function Buffer914300208:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914300208
	self:AddSkill(BufferEffect[914300208], self.caster, self.card, nil, 24404)
end
-- 创建时
function Buffer914300208:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914300208
	self:AddSkill(BufferEffect[914300208], self.caster, self.card, nil, 24404)
end
-- 攻击开始
function Buffer914300208:OnAttackBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914300208
	self:AddSkill(BufferEffect[914300208], self.caster, self.card, nil, 24404)
end
