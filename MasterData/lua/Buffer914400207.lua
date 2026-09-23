-- 擴大賦予
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914400207 = oo.class(BuffBase)
function Buffer914400207:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer914400207:OnStart(caster, target)
	do
		-- 8060
		if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
		else
			return
		end
		-- 914400207
		self:AddSkill(BufferEffect[914400207], self.caster, self.card, nil, 22204)
	end
end
-- 创建时
function Buffer914400207:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914400207
	self:AddSkill(BufferEffect[914400207], self.caster, self.card, nil, 22204)
end
-- 攻击开始
function Buffer914400207:OnAttackBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 914400207
	self:AddSkill(BufferEffect[914400207], self.caster, self.card, nil, 22204)
end
