-- 機動和行動同步率增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23703 = oo.class(BuffBase)
function Buffer23703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer23703:OnActionBegin(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 23713
	self:AddSp(BufferEffect[23713], self.caster, self.caster, nil, 8)
end
-- 创建时
function Buffer23703:OnCreate(caster, target)
	-- 23703
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[23703], self.caster, target, nil, "speed",8)
	end
end
