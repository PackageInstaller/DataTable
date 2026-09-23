-- 回庇
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3404 = oo.class(BuffBase)
function Buffer3404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer3404:OnRemoveBuff(caster, target)
	-- 3405
	self:MissSurface(BufferEffect[3405], self.caster, self.card, nil, 0)
	-- 100200305
	self:SetValue(BufferEffect[100200305], self.caster, self.card, nil, "sh",0)
end
-- 伤害前
function Buffer3404:OnBefourHurt(caster, target)
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
	-- 100200302
	self:AddValue(BufferEffect[100200302], self.caster, self.card, nil, "sh",1)
	-- 100200303
	local sh = SkillApi:GetValue(self, self.caster, target or self.owner,3,"sh")
	-- 100200304
	if SkillJudger:Greater(self, self.caster, self.card, true,sh,1) then
	else
		return
	end
	-- 100200306
	if SkillJudger:Greater(self, self.caster, self.card, true,self.nCount,0) then
	else
		return
	end
	-- 100200301
	self:OwnerAddBuffCount(BufferEffect[100200301], self.caster, self.card, nil, 3404,-1,2)
end
-- 创建时
function Buffer3404:OnCreate(caster, target)
	-- 3404
	self:MissSurface(BufferEffect[3404], self.caster, self.card, nil, 10000)
end
-- 攻击结束
function Buffer3404:OnAttackOver(caster, target)
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
	-- 100200306
	if SkillJudger:Greater(self, self.caster, self.card, true,self.nCount,0) then
	else
		return
	end
	-- 100200307
	self:OwnerAddBuffCount(BufferEffect[100200307], self.caster, self.card, nil, 3404,-1,2)
	-- 100200305
	self:SetValue(BufferEffect[100200305], self.caster, self.card, nil, "sh",0)
end
