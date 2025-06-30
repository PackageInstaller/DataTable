-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneSelectCell.lua

local m = {}
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.Index = index

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickQualityBtn()
		self:OnClickQualityBtn()
	end

	function self.DelegateOnClickTypeBtn()
		self:OnClickTypeBtn()
	end

	function self.DelegateOnClickEffectTextKeywordTipBtn()
		self:OnClickEffectTextKeywordTipBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI, false)
	self.Toggle = self.View:GetComponent("Toggle")

	UGUIUtil.SetText(self.EffectLabel, EndlessMazeRuneSelectUIApi:GetString("ToggleEffectLabel"))
	self:AddListeners()
end

function m:AddListeners()
	self.QualityBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQualityBtn)
	self.TypeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTypeBtn)
	self.EffectTextKeywordTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEffectTextKeywordTipBtn)
end

function m:RemoveListeners()
	self.QualityBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQualityBtn)
	self.TypeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTypeBtn)
	self.EffectTextKeywordTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEffectTextKeywordTipBtn)
end

function m:SetData(runeCid)
	self.View:SetActive(runeCid ~= nil)

	if runeCid == nil then
		return
	end

	self.CfgRuneData = CfgRuneTable[runeCid]

	self.RuneCell:SetDataByCfgData(self.CfgRuneData)
	UGUIUtil.SetText(self.NameText, self.CfgRuneData.Name)
	UGUIUtil.SetText(self.EffectText, self.CfgRuneData.Describe)

	local cfgRuneConstituteData = CfgRuneConstituteTable[self.CfgRuneData.TypeConstitute]

	UGUIUtil.SetTextInChildren(self.TypeBtn, cfgRuneConstituteData.Name)

	cfgRuneConstituteData = CfgRuneConstituteTable[self.CfgRuneData.QualityConstitute]

	UGUIUtil.SetTextInChildren(self.QualityBtn, cfgRuneConstituteData.Name)
end

function m:OnClickQualityBtn()
	local partNum = MazeModule.GetEndlessMazeRuneSuitPartCount(self.CfgRuneData.QualityConstitute)

	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneSuitTipUI, Constant.UILayer.Tooltip, {
		suitCid = self.CfgRuneData.QualityConstitute,
		partNum = partNum,
		srcTrans = self.QualityBtn.transform,
		srcSide = UGUISide.TopRight,
		tipSide = UGUISide.TopLeft
	})
end

function m:OnClickTypeBtn()
	local partNum = MazeModule.GetEndlessMazeRuneSuitPartCount(self.CfgRuneData.TypeConstitute)

	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneSuitTipUI, Constant.UILayer.Tooltip, {
		suitCid = self.CfgRuneData.TypeConstitute,
		partNum = partNum,
		srcTrans = self.TypeBtn.transform,
		srcSide = UGUISide.TopRight,
		tipSide = UGUISide.TopLeft
	})
end

function m:OnClickEffectTextKeywordTipBtn()
	if UIGlobalApi.CheckExistKeywordTag(self.CfgRuneData.Describe) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.CfgRuneData.Describe,
			self.KeywordTipPoint,
			UGUISide.Top,
			UGUISide.Bottom
		})
	end
end

function m:Dispose()
	self:RemoveListeners()
	self.RuneCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
