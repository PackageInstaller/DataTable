-- 協擊賦予
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914300206 = oo.class(BuffBase)
function Buffer914300206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer914300206:OnStart(caster, target)
	do
		-- 8060
		if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
		else
			return
		end
		-- 914300206
		self:AddSkill(BufferEffect[914300206], self.caster, self.card, nil, 25004)
	end
end
-- 创建时
function Buffer914300206:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914300206
	self:AddSkill(BufferEffect[914300206], self.caster, self.card, nil, 25004)
end
-- 攻击开始
function Buffer914300206:OnAttackBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914300206
	self:AddSkill(BufferEffect[914300206], self.caster, self.card, nil, 25004)
end
