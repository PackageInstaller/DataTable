-- 機動和行動同步率增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23702 = oo.class(BuffBase)
function Buffer23702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer23702:OnActionBegin(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 23712
	self:AddSp(BufferEffect[23712], self.caster, self.caster, nil, 6)
end
-- 创建时
function Buffer23702:OnCreate(caster, target)
	-- 23702
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[23702], self.caster, target, nil, "speed",6)
	end
end
