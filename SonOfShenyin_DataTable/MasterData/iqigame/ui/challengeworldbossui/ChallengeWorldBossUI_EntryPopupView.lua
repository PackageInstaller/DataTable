-- chunkname: @IQIGame\\UI\\ChallengeWorldBossUI\\ChallengeWorldBossUI_EntryPopupView.lua

local View = {}

function View.New(view)
	local obj = Clone(View)

	obj:__Init(view)

	return obj
end

function View:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "CloseBtn", self.__OnCloseBtnClickEventHandler)
end

function View:__OnCloseBtnClickEventHandler()
	self:Hide()
end

function View:Show(entryCid)
	self.gameObject:SetActive(true)

	local skillDescription = CfgSkillDescriptionTable[entryCid]

	self.NameText:GetComponent("Text").text = skillDescription.EffectName
	self.DescribeText:GetComponent("Text").text = skillDescription.Describe
end

function View:Hide()
	self.gameObject:SetActive(false)
end

function View:Dispose()
	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return View
