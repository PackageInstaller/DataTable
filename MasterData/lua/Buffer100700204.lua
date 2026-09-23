-- 內傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100700204 = oo.class(BuffBase)
function Buffer100700204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer100700204:OnActionOver(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8414
	local c14 = SkillApi:GetBeDamage(self, self.caster, target or self.owner,3)
	-- 100700204
	self:AddValue(BufferEffect[100700204], self.caster, self.card, nil, "dmg10070",0.17*c14)
end
-- 创建时
function Buffer100700204:OnCreate(caster, target)
	-- 8418
	local c18 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"defense")
	-- 8779
	local c779 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3387)
	-- 100700206
	self:AddAttr(BufferEffect[100700206], self.caster, self.creater, nil, "defense",math.floor(0.04*c18*c779))
	-- 8418
	local c18 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"defense")
	-- 8779
	local c779 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3387)
	-- 100700207
	self:AddAttr(BufferEffect[100700207], self.caster, self.card, nil, "defense",-math.floor(0.04*c18*c779))
end
