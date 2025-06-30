-- chunkname: @IQIGame\\UI\\DetailsPreview\\RolePreviewDetailsView_BaseSkillDetailView.lua

local m = {}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnCloseBtnClick()
		self:OnClose()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtnClick)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtnClick)
end

function m:SetData(Data, warlockData)
	self.Data = Data

	local skillCfg = CfgUtil.GetCfgSkillDataWithID(self.Data.skillCid)
	local skillLevelCfg = CfgUtil.GetCfgSkillLevelDataWithID(self.Data.skillCid)
	local currentLevelSkillCfg = skillLevelCfg[self.Data.lv + self.Data.extLv]
	local cd, energy, cost = CfgUtil.GetSkillCD_Eg_Ct(warlockData, self.Data.skillCid, self.Data.lv + self.Data.extLv)

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(skillCfg.Icon), self.SkillIcon:GetComponent("Image"))

	local skillElement = CfgSkillDetailTable[skillCfg.Id].Element

	LuaUtility.SetGameObjectShow(self.elementImg, skillElement ~= 0)

	if skillElement ~= 0 then
		LuaUtility.LoadImage(self, RoleDevelopmentApi:GetSkillElementImgPath(skillElement), self.elementImg:GetComponent("Image"))
	end

	LuaUtility.SetText(self.textName, skillCfg.Name)
	LuaUtility.SetText(self.textLevel, string.format("%s", self.Data.lv + self.Data.extLv))
	LuaUtility.SetText(self.textSkillType, RoleDevelopmentApi:GetSkillType(skillCfg.SkillType))
	LuaUtility.SetText(self.textDescription, currentLevelSkillCfg.SkillTips)
	LuaUtility.SetText(self.textSpecialEffect, currentLevelSkillCfg.SkillSpecialEffect)
	LuaUtility.SetText(self.textSkillStory, currentLevelSkillCfg.SkillStory)
	LuaUtility.SetText(self.textCoolDown, cd)
	LuaUtility.SetText(self.energyNumText, energy)

	if skillCfg.SkillRangeID ~= 0 then
		local imageRangePath = UIGlobalApi.GetImagePath(CfgUtil.GetCfgSkillRangeWithID(skillCfg.SkillRangeID).SkillRangeImg)

		LuaUtility.LoadImage(self, imageRangePath, self.imageRange:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.imageRange, true)
	else
		LuaUtility.SetGameObjectShow(self.imageRange, false)
	end
end

function m:OnClose()
	self.mainView:CloseSkillDetailPanel()
	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
