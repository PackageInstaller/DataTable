-- 鷹之眼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer601500305 = oo.class(BuffBase)
function Buffer601500305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer601500305:OnBefourHurt(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, self.caster, target, true) then
	else
		return
	end
	-- 601500305
	self:AddTempAttr(BufferEffect[601500305], self.caster, self.caster, nil, "damage",0.40*self.nCount)
end
