-- chunkname: @IQIGame\\UI\\DetailsPreview\\RolePreviewDetailsView.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local rolePreviewDetailsView_info = require("IQIGame.UI.DetailsPreview.RolePreviewDetailsView_Info")
local rolePreviewDetailsView_personality = require("IQIGame.UI.DetailsPreview.RolePreviewDetailsView_Personality")
local RolePreviewDetailsView_BaseSkill = require("IQIGame/UI/DetailsPreview/RolePreviewDetailsView_BaseSkill")
local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
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

	self.roleDisplayView = CommonRoleDisplayView.New(self.roleDisplayViewRoot, Constant.DynamicSkinShowPosition.DetailsPreviewUI)

	function self.DelegateOnGetPreviewHeroDataReuslt(previewHeroData)
		self:OnGetPreviewHeroDataReuslt(previewHeroData)
	end

	self:InitTabList()
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(roleCid)
	self.roleCid = roleCid

	LuaUtility.SetGameObjectShow(self.RoleInfoPanel, false)
	LuaUtility.SetGameObjectShow(self.PersonalityPanel, false)
	LuaUtility.SetGameObjectShow(self.BaseSkillInfoPanel, false)
	LuaUtility.SetGameObjectShow(self.tabListRoot, false)
	LuaUtility.SetGameObjectShow(self.roleDisplayViewRoot, false)
	self:__OnGetPreviewHeroData()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	EventDispatcher.RemoveEventListener(EventID.GetPreviewHeroDataReuslt, self.DelegateOnGetPreviewHeroDataReuslt)
	self.roleDisplayView:Dispose()
	self:RemoveListeners()
	self.tableList:Dispose()

	self.tableList = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:InitTabList()
	self.tableList = UITabList.Create()

	self.tableList:AddTableItem(self.infoTabItem, function()
		return rolePreviewDetailsView_info.New(self.RoleInfoPanel)
	end, function(_isOn, _view)
		self:OnToggleValueChange(_isOn, _view)
	end, self.InfoPanelShow)
	self.tableList:AddTableItem(self.baseSkillTabItem, function()
		return RolePreviewDetailsView_BaseSkill.New(self.BaseSkillInfoPanel)
	end, function(_isOn, _view)
		self:OnToggleValueChange(_isOn, _view)
	end)
	self.tableList:AddTableItem(self.personalityTabItem, function()
		return rolePreviewDetailsView_personality.New(self.PersonalityPanel, self)
	end, function(_isOn, _view)
		self:OnToggleValueChange(_isOn, _view)
	end, self.PersonalityPanelShow)
end

function m:OnToggleValueChange(_isOn, _view)
	if self.tableList.selectIndex < 3 then
		if self.__previewHeroData.Min ~= nil then
			local skinCid = self.__previewHeroData.Min:GetCurrentSkinCid()

			self.roleDisplayView:Show(skinCid)
		else
			self.roleDisplayView:Hide()
		end
	else
		self.roleDisplayView:Hide()
	end

	if _isOn then
		_view:Show()
		_view:SetData(self.__previewHeroData)
	else
		_view:Hide()
	end
end

function m:InfoPanelShow()
	return
end

function m:PersonalityPanelShow()
	return
end

function m:__OnGetPreviewHeroData()
	self.__previewHeroData = {}

	EventDispatcher.AddEventListener(EventID.GetPreviewHeroDataReuslt, self.DelegateOnGetPreviewHeroDataReuslt)
	RoleDevelopmentModule.PreviewHeroMax(self.roleCid, 1, 0)
	RoleDevelopmentModule.PreviewHeroMax(self.roleCid, CfgHeroTable[self.roleCid].MaxLv, CfgHeroTable[self.roleCid].MaxBreakLv)
end

function m:OnGetPreviewHeroDataReuslt(previewHeroData)
	if previewHeroData.cid ~= self.roleCid then
		return
	end

	if previewHeroData.lv == 1 then
		self.__previewHeroData.Min = previewHeroData
	else
		self.__previewHeroData.Max = previewHeroData
	end

	if self.__previewHeroData.Min == nil then
		return
	end

	if self.__previewHeroData.Max == nil then
		return
	end

	EventDispatcher.RemoveEventListener(EventID.GetPreviewHeroDataReuslt, self.DelegateOnGetPreviewHeroDataReuslt)
	LuaUtility.SetGameObjectShow(self.tabListRoot, true)
	self.roleDisplayView:Hide()
	self.tableList:ChangeSelectIndex(1)
end

function m:PersonalityClick(state)
	LuaUtility.SetGameObjectShow(self.tabListRoot, not state)
	self.mainView:SetReturnBtnState(not state)
end

return m
