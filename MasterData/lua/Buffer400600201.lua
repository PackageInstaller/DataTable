-- 疾風
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400600201 = oo.class(BuffBase)
function Buffer400600201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 特殊入场时(复活，召唤，合体)
function Buffer400600201:OnBornSpecial(caster, target)
	-- 8769
	local c769 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,3310)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 400600203
	self:AddAttr(BufferEffect[400600203], self.caster, self.caster, nil, "speed",2*self.nCount*c769)
end
-- 创建时
function Buffer400600201:OnCreate(caster, target)
	-- 400600201
	self:AddAttr(BufferEffect[400600201], self.caster, self.card, nil, "speed",10*self.nCount)
	-- 8769
	local c769 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,3310)
	-- 400600202
	local targets = SkillFilter:Teammate(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[400600202], self.caster, target, nil, "speed",2*self.nCount*c769)
	end
end
