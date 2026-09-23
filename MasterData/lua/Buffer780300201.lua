-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780300201 = oo.class(BuffBase)
function Buffer780300201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer780300201:OnRoundBegin(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8803
	local c803 = SkillApi:GetAttr(self, self.caster, target or self.owner,1,"hp")
	-- 780300201
	self:AddHp(BufferEffect[780300201], self.caster, self.caster, nil, -c803*0.2)
end
