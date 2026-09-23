-- 電磁守護
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer801400201 = oo.class(BuffBase)
function Buffer801400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer801400201:OnActionOver(caster, target)
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
	-- 8445
	local c45 = SkillApi:BuffCount(self, self.caster, target or self.owner,1,3,3009)
	-- 801400204
	if SkillJudger:Greater(self, self.caster, target, true,c45,0) then
		-- 801400203
		self:OwnerAddBuff(BufferEffect[801400203], self.caster, self.caster, nil, 801400301)
	else
		-- 801400201
		self:HitAddBuff(BufferEffect[801400201], self.caster, self.caster, nil, 4000,3009,3)
	end
end
-- 创建时
function Buffer801400201:OnCreate(caster, target)
	-- 4904
	self:AddAttr(BufferEffect[4904], self.caster, target or self.owner, nil,"bedamage",-0.2)
end
