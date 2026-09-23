-- 機動和行動同步率增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23701 = oo.class(BuffBase)
function Buffer23701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer23701:OnActionBegin(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 23711
	self:AddSp(BufferEffect[23711], self.caster, self.caster, nil, 4)
end
-- 创建时
function Buffer23701:OnCreate(caster, target)
	-- 23701
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[23701], self.caster, target, nil, "speed",4)
	end
end
