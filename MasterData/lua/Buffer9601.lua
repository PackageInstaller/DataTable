-- 物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9601 = oo.class(BuffBase)
function Buffer9601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer9601:OnRemoveBuff(caster, target)
	-- 8458
	local c58 = SkillApi:GetCount(self, self.caster, target or self.owner,3,2309)
	-- 8613
	if SkillJudger:Less(self, self.caster, self.card, true,c58,1) then
	else
		return
	end
	-- 8459
	local c59 = SkillApi:GetCount(self, self.caster, target or self.owner,3,2209)
	-- 8614
	if SkillJudger:Less(self, self.caster, self.card, true,c59,1) then
	else
		return
	end
	-- 9404
	self:OwnerAddBuff(BufferEffect[9404], self.caster, self.card, nil, 9401)
end
-- 伤害前
function Buffer9601:OnBefourHurt(caster, target)
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
	-- 8220
	if SkillJudger:IsDamageType(self, self.caster, target, true,1) then
	else
		return
	end
	-- 9601
	self:AddTempAttr(BufferEffect[9601], self.caster, self.caster, nil, "damage",-math.min(self.nCount*0.05+0.2,0.7))
end
