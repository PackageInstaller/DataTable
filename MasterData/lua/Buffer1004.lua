-- 劣化（加強）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1004 = oo.class(BuffBase)
function Buffer1004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer1004:OnAfterRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1004
	self:LimitDamage(BufferEffect[1004], self.caster, target or self.owner, nil,0.15,1.5)
	-- 6115
	self:ImmuneBuffID(BufferEffect[6115], self.caster, target or self.owner, nil,3006)
end
-- 创建时
function Buffer1004:OnCreate(caster, target)
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
	-- 8443
	local c43 = SkillApi:BuffCount(self, self.caster, target or self.owner,1,3,907100202)
	-- 8155
	if SkillJudger:Less(self, self.caster, target, true,c43,1) then
	else
		return
	end
	-- 6201
	self:DelBufferForce(BufferEffect[6201], self.caster, self.card, nil, 3006,1)
end
