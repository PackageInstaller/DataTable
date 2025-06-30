-- chunkname: @IQIGame\\UI\\SpecialSpirit\\SpSkillView.lua

local SpSkillView = {}
local SpSkillActiveView = require("IQIGame.UI.SpecialSpirit.SpSkillActiveView")

function SpSkillView.New(view, mainView)
	local obj = Clone(SpSkillView)

	obj:Init(view, mainView)

	return obj
end

function SpSkillView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.skillActiveView = SpSkillActiveView.New(self.goSkillActiveView)
	self.tfNameCur = self.goNameCur:GetComponent("Text")
	self.tfNameNext = self.goNameNext:GetComponent("Text")
	self.tfLvCur = self.goLvCur:GetComponent("Text")
	self.tfLvNext = self.goLvNext:GetComponent("Text")
	self.tfDescCur = self.goDescCur:GetComponent("Text")
	self.tfDescNext = self.goDescNext:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnDescCur = self.goBtnDescCur:GetComponent("Button")
	self.btnDescNext = self.goBtnDescNext:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onSpActiveSuccessDelegate(cfgSpData)
		self:OnSpActiveSuccess(cfgSpData)
	end

	function self.onClickDescCurDelegate()
		self:OnClickDescCur()
	end

	function self.onClickDescNextDelegate()
		self:OnClickDescNext()
	end
end

function SpSkillView:Open(soulData, skillCidIndex)
	self.soulData = soulData
	self.SkillIndex = skillCidIndex
	self.cfgSoulData = self.soulData:GetCfgSoul()

	self.View:SetActive(true)
	self:RefreshDetail()
	self:OnAddListener()
end

function SpSkillView:Close()
	self:OnHide()
	self.skillActiveView:Close()
	self.View:SetActive(false)
end

function SpSkillView:OnHide()
	self:OnRemoveListener()
	self.skillActiveView:OnHide()
	AssetUtil.UnloadAsset(self)
end

function SpSkillView:OnDestroy()
	self.mainView = nil

	self.skillActiveView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SpSkillView:OnAddListener()
	self:OnRemoveListener()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnDescCur.onClick:AddListener(self.onClickDescCurDelegate)
	self.btnDescNext.onClick:AddListener(self.onClickDescNextDelegate)
	EventDispatcher.AddEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SpSkillView:OnRemoveListener()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnDescCur.onClick:RemoveListener(self.onClickDescCurDelegate)
	self.btnDescNext.onClick:RemoveListener(self.onClickDescNextDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SpSkillView:OnClickBtnClose()
	self.mainView:OnSpSkillViewClose()
	self:Close()
end

function SpSkillView:OnSpActiveSuccess(cfgSpData)
	if cfgSpData.Group ~= 1 then
		self:RefreshDetail()
	end
end

function SpSkillView:OnClickDescCur()
	if UIGlobalApi.CheckExistKeywordTag(self.sourceDescCur) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.sourceDescCur,
			self.KeywordTipPoint,
			UGUISide.Top,
			UGUISide.Bottom
		})
	end
end

function SpSkillView:OnClickDescNext()
	if UIGlobalApi.CheckExistKeywordTag(self.sourceDescNext) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.sourceDescNext,
			self.KeywordTipPoint,
			UGUISide.Top,
			UGUISide.Bottom
		})
	end
end

function SpSkillView:RefreshDetail()
	local cfgSpDataCur = self.soulData.CfgSoulSpecialSpirits[self.SkillIndex]
	local cfgSpDataToActive = self.soulData.cfgSoulSpDataSkillToActive[self.SkillIndex]
	local cfgSkillData = self.soulData:GetSpSkillByIndex(self.SkillIndex)
	local cfgStrengthenDataCur, cfgStrengthenDataToActive
	local curLv = 0
	local cfgStrengthDatum = SkillModule.GetStrengthen(cfgSkillData.Id)

	if cfgSpDataCur == nil then
		curLv = #cfgStrengthDatum

		for i, v in ipairs(cfgStrengthDatum) do
			if table.indexOf(self.soulData.activationSkillStrengthen, v.Id) ~= -1 then
				cfgStrengthenDataCur = v
			end
		end

		if cfgStrengthenDataCur == nil then
			cfgStrengthenDataCur = cfgStrengthDatum[1]
		end
	else
		curLv = #cfgStrengthDatum + cfgSpDataCur.Level

		if #cfgSpDataCur.ADDSkillStrengthen > 0 then
			cfgStrengthenDataCur = CfgSkillStrengthenTable[cfgSpDataCur.ADDSkillStrengthen[#cfgSpDataCur.ADDSkillStrengthen]]
		end
	end

	if cfgSpDataToActive ~= nil and #cfgSpDataToActive.ADDSkillStrengthen > 0 then
		cfgStrengthenDataToActive = CfgSkillStrengthenTable[cfgSpDataToActive.ADDSkillStrengthen[#cfgSpDataToActive.ADDSkillStrengthen]]
	end

	self.tfNameCur.text = SpecialSpiritUIApi:GetString("skillViewSkillName", cfgSkillData.Name)
	self.tfLvCur.text = SpecialSpiritUIApi:GetString("skillViewSkillLv", curLv)

	local descCur = cfgSkillData.EffectText

	for i, v in ipairs(SkillModule.GetStrengthen(cfgSkillData.Id)) do
		if table.indexOf(self.soulData.activationSkillStrengthen, v.Id) ~= -1 then
			descCur = v.Describe
		end
	end

	descCur = SkillModule.GetValidSkillDesc(cfgSkillData, descCur)
	self.sourceDescCur = SpecialSpiritUIApi:GetString("skillViewSkillDesc", descCur)
	self.tfDescCur.text = UIGlobalApi.GetTextWithoutKeywordTag(self.sourceDescCur)

	if cfgSpDataToActive ~= nil then
		self.tfNameNext.text = SpecialSpiritUIApi:GetString("skillViewSkillNameNext", self.tfNameCur.text)
		self.sourceDescNext = SpecialSpiritUIApi:GetString("skillViewSkillDescNext", cfgStrengthenDataToActive ~= nil and cfgStrengthenDataToActive.EffectText or "")
		self.tfDescNext.text = UIGlobalApi.GetTextWithoutKeywordTag(self.sourceDescNext)
		self.tfLvNext.text = SpecialSpiritUIApi:GetString("skillViewSkillLvNext", cfgSpDataToActive.Level + #cfgStrengthDatum)
	else
		self.tfNameNext.text = SpecialSpiritUIApi:GetString("skillViewSkillNameNext", self.tfNameCur.text)
		self.sourceDescNext = SpecialSpiritUIApi:GetString("skillViewSkillDescNext", cfgStrengthenDataCur ~= nil and cfgStrengthenDataCur.EffectText or "")
		self.tfDescNext.text = UIGlobalApi.GetTextWithoutKeywordTag(self.sourceDescNext)
		self.tfLvNext.text = SpecialSpiritUIApi:GetString("skillViewSkillLvNext", cfgSpDataCur.Level + #cfgStrengthDatum)
	end

	local addStrengthenCid, addSkillCid = self.soulData:GetFeatureOfNextLvSpirit(self.SkillIndex)

	self.goAddStrengthenBlock:SetActive(addStrengthenCid ~= 0)

	if cfgSpDataToActive ~= nil then
		self.skillActiveView:Open(cfgSpDataToActive, self.soulData)
	else
		self.skillActiveView:Close()
	end
end

return SpSkillView
