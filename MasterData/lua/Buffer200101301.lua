-- 音律指引
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200101301 = oo.class(BuffBase)
function Buffer200101301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer200101301:OnActionBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 200100305
	if self:Rand(6700) then
		self:AddNp(BufferEffect[200100305], self.caster, self.card, nil, 5)
	end
end
-- 回合开始时
function Buffer200101301:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 200100301
	self:AddSp(BufferEffect[200100301], self.caster, self.card, nil, 10)
end
-- 创建时
function Buffer200101301:OnCreate(caster, target)
	-- 200100201
	self:AddAttrPercent(BufferEffect[200100201], self.caster, target or self.owner, nil,"attack",0.10)
end
-- 攻击结束
function Buffer200101301:OnAttackOver(caster, target)
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
	-- 200100304
	if self:Rand(6700) then
		self:AddNp(BufferEffect[200100304], self.caster, self.card, nil, 5)
	end
end
