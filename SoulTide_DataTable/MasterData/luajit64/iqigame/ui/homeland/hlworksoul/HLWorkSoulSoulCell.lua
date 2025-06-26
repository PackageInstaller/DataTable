-- chunkname: @IQIGame\\UI\\HomeLand\\HLWorkSoul\\HLWorkSoulSoulCell.lua

local HLWorkSoulSoulCell = {}

function HLWorkSoulSoulCell.New(go, mainView)
	local o = Clone(HLWorkSoulSoulCell)

	o:Initialize(go, mainView)

	return o
end

function HLWorkSoulSoulCell:Initialize(go, mainView)
	self.View = go
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfFavorLv = self.goFavorLv:GetComponent("Text")
	self.tfMood = self.goMood:GetComponent("Text")
	self.imgMoodIcon = self.goMoodIcon:GetComponent("Image")
	self.imgHead = self.goIcon:GetComponent("Image")
	self.btnMood = self.goBtnMood:GetComponent("Button")
	self.btnRecommend = self.goBtnRecommend:GetComponent("Button")

	function self.onClickBtnRecommendDelegate()
		self:OnClickBtnRecommend()
	end

	function self.onClickBtnMoodDelegate()
		self:OnClickBtnMood()
	end

	self.goWorkingTag:GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("tagWorkingTxt")
	self.goExploringTag:GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("tagExploringTxt")

	self:AddListener()
end

function HLWorkSoulSoulCell:Refresh(soulData, affairData)
	self.soulData = soulData
	self.affairData = affairData

	self:RefreshMisc()
end

function HLWorkSoulSoulCell:OnHide()
	return
end

function HLWorkSoulSoulCell:OnDestroy()
	self.mainView = nil

	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function HLWorkSoulSoulCell:AddListener()
	self.btnMood.onClick:AddListener(self.onClickBtnMoodDelegate)
	self.btnRecommend.onClick:AddListener(self.onClickBtnRecommendDelegate)
end

function HLWorkSoulSoulCell:RemoveListener()
	self.btnMood.onClick:RemoveListener(self.onClickBtnMoodDelegate)
	self.btnRecommend.onClick:RemoveListener(self.onClickBtnRecommendDelegate)
end

function HLWorkSoulSoulCell:OnClickBtnMood()
	UIModule.Open(Constant.UIControllerName.GirlMoodUI, Constant.UILayer.UI, self.soulData)
end

function HLWorkSoulSoulCell:OnClickBtnRecommend()
	self.mainView:ShowTip()
end

function HLWorkSoulSoulCell:RefreshMisc()
	local path = UIGlobalApi.GetImagePath(self.soulData:GetCfgSoulRes2D().HomelandWorkListImage)

	AssetUtil.LoadImage(self, path, self.imgHead)

	local state = SoulModule.GetMoodState(self.soulData.soulCid, self.soulData.mood)

	self.tfMood.text = HomeLandWorkSoulUIApi:GetString("moodTxt", self.soulData.mood)

	AssetUtil.LoadImage(self, GirlMoodUINoticeUIApi:GetString("StatePath", state), self.imgMoodIcon)

	self.tfFavorLv.text = HomeLandWorkSoulUIApi:GetString("favorLvTxt", self.soulData.favorLv)

	self.goWorkingTag.transform.parent.gameObject:SetActive(self.soulData.workStatus == Constant.Soul.WorkStatusWorking)
	self.goExploringTag.transform.parent.gameObject:SetActive(false)

	local isRecommend = false

	for i, v in pairs(self.affairData.cfgAffairData.RecommendSoul) do
		if v == self.soulData.soulCid then
			isRecommend = true

			break
		end
	end

	self.goBtnRecommend:SetActive(isRecommend)
end

function HLWorkSoulSoulCell:SetSignSelectedVisible(vs)
	self.goSignSelected:SetActive(vs)
end

return HLWorkSoulSoulCell
