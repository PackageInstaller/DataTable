-- chunkname: @IQIGame\\UI\\Battle\\BattleSkillNotifyView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnTimelineStopped(playableDirector)
		self:__OnTimelineCompleted(playableDirector)
	end

	self.playableDirector = self.gameObject:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	self.playableDirector.stopped = self.playableDirector.stopped + self.delegateOnTimelineStopped
end

function m:Show(skillCid)
	local skillConfig = CfgSkillTable[skillCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(skillConfig.Icon), self.skillIcon:GetComponent("Image"))
	LuaUtility.SetText(self.skillName, skillConfig.Name)

	local cfgId = skillConfig.SkillShowType

	if skillConfig.TimelineID == 0 or skillConfig.TimelineID == nil then
		self:Hide()

		return
	end

	if cfgId == nil or cfgId == 0 then
		cfgId = BattleConstant.NormalSkillShowTypeCfgID
	end

	LuaUtility.SetText(self.skillType, BattleUIApi:GetSKillNotifySkillTypeTips(cfgId))
	self.gameObject:SetActive(true)
	self.playableDirector:Play()
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	self.playableDirector.stopped = self.playableDirector.stopped - self.delegateOnTimelineStopped
	self.playableDirector = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:__OnTimelineCompleted()
	self.gameObject:SetActive(false)
end

return m
