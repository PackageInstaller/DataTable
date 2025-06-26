-- chunkname: @IQIGame\\UI\\ActivitySign\\DayCell.lua

local DayCell = {}
local DayTemplateCell = require("IQIGame.UI.ActivitySign.DayTemplateCell")

function DayCell.New(view, mainView)
	local obj = Clone(DayCell)

	obj:Init(view, mainView)

	return obj
end

function DayCell:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end
end

function DayCell:Refresh(curYear, curMonth, curDay, day, dayWeek)
	self.curYear = curYear
	self.curMonth = curMonth
	self.curDay = curDay
	self.day = day
	self.dayWeek = dayWeek
	self.isSign = SignInModule.CheckIsSign(self.day)
	self.cfgSignInData = SignInModule.GetCfgSignData(self.curYear, self.curMonth, self.day)

	self:LoadCellTemplate()

	self.lastCfgSignInData = self.cfgSignInData

	self:OnAddListener()
end

function DayCell:OnHide()
	self:OnRemoveListener()
end

function DayCell:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.mainView = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function DayCell:OnAddListener()
	self:OnRemoveListener()
end

function DayCell:OnRemoveListener()
	return
end

function DayCell:OnClickBtnSelf()
	self.mainView:OnClickDayCell(self)
end

function DayCell:OnLoadSuccess(assetName, asset, duration, userData)
	local template = UnityEngine.Object.Instantiate(asset)

	template.transform:SetParent(self.View.transform, false)

	self.templateCell = DayTemplateCell.New(template)

	self:RefreshCell()
end

function DayCell:SetActive(vs)
	if self.templateCell ~= nil then
		self.templateCell:SetActive(vs)
	end
end

function DayCell:SetSignSelectActive(vs)
	if self.templateCell ~= nil then
		self.templateCell:SetSignSelectActive(vs)
	end
end

function DayCell:SetParentActive(vs)
	self.View.transform.parent.gameObject:SetActive(vs)
end

function DayCell:LoadCellTemplate()
	if self.templateCell ~= nil then
		if self.cfgSignInData.Id ~= self.lastCfgSignInData.Id then
			self.templateCell:Destroy()
			AssetUtil.LoadAsset(self, UIGlobalApi.GetPrefabRoot(self.cfgSignInData.BackGround), self.OnLoadSuccess)

			return
		end
	else
		AssetUtil.LoadAsset(self, UIGlobalApi.GetPrefabRoot(self.cfgSignInData.BackGround), self.OnLoadSuccess)

		return
	end

	self:RefreshCell()
end

function DayCell:RefreshCell()
	self.templateCell:Refresh(self.cfgSignInData, self.curMonth, self.curDay, self.day, self.onClickBtnSelfDelegate)

	if self.curDay == self.day then
		self:OnClickBtnSelf()
	end
end

return DayCell
