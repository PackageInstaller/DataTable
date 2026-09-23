-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603300302 = oo.class(BuffBase)
function Buffer603300302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603300302:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 8772
	local c772 = SkillApi:GetCount(self, self.caster, target or self.owner,4,603300301)
	-- 8773
	local c773 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,47801)
	-- 4603301
	self:AddAttr(BufferEffect[4603301], self.caster, self.creater, nil, "attack",(0.03+math.floor(c773)*0.01)*c15*c772)
	-- 4603311
	self:AddAttr(BufferEffect[4603311], self.caster, self.card, nil, "attack",-(0.03+math.floor(c773)*0.01)*c15*c772)
end
