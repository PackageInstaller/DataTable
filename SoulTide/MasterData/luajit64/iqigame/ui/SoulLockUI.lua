-- chunkname: @IQIGame\\UI\\SoulLockUI.lua

local SoulLockUI = Base:Extend("SoulLockUI", "IQIGame.Onigao.UI.SoulLockUI", {
	detailCells = {},
	cfgSkillGroupDatum = {}
})
local GroupDetailCell = require("IQIGame.UI.SoulLock.GroupDetailCell")

function SoulLockUI:OnInit()
	self:Initialize()
end

function SoulLockUI:GetPreloadAssetPaths()
	return nil
end

function SoulLockUI:GetOpenPreloadAssetPaths(userData)
	self.soulData = userData
	self.cfgSoulData = self.soulData:GetCfgSoul()
	self.cfgSkillGroupDatum = {}

	for i, v in ipairs(self.cfgSoulData.DefaultSkill) do
		self.cfgSkillGroupDatum[i] = CfgSkillGroupTable[v]
	end

	local ret = {}

	ret[#ret + 1] = UIGlobalApi.ImagePath .. self.soulData:GetCfgSoulRes2D().SoulSoulImage

	return ret
end

function SoulLockUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulLockUI:OnClose(userData)
	self:OnHide()
end

function SoulLockUI:OnPause()
	return
end

function SoulLockUI:OnResume()
	return
end

function SoulLockUI:OnCover()
	return
end

function SoulLockUI:OnReveal()
	return
end

function SoulLockUI:OnRefocus(userData)
	return
end

function SoulLockUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulLockUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulLockUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulLockUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulLockUI:Initialize()
	self.tfSoulName = self.goSoulName:GetComponent("Text")
	self.tfSoulTitle = self.goSoulTitle:GetComponent("Text")
	self.tfSoulDesc = self.goSoulDesc:GetComponent("Text")
	self.tfCvName = self.goCv:GetComponent("Text")
	self.tfNameEng = self.goSoulNameEng:GetComponent("Text")

	for i = 1, 2 do
		local go = self.goToggleRoot.transform:Find("Mould_" .. i).gameObject

		self.detailCells[i] = GroupDetailCell.New(go)
	end

	self.btnHide = self.goBtnHide:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnHideDelegate()
		self:OnClickBtnHide()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onScaleGestureDelegate(gesture)
		self:OnScaleGesture(gesture)
	end

	function self.onTapGestureDelegate(gesture)
		self:OnTapGesture(gesture)
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulLockUIApi:GetString("goBtnClose")
	self.goStoryTitle:GetComponent("Text").text = SoulLockUIApi:GetString("goStoryTitle")
	self.goCvDesc:GetComponent("Text").text = SoulLockUIApi:GetString("cvDesc")
end

function SoulLockUI:Refresh(userData)
	self.isLocking = false

	self:RefreshDetail()
	self:RefreshDetailCells()
end

function SoulLockUI:OnHide()
	if self.isLocking then
		LuaCodeInterface.SetEventSystemEnabled("SoulLock", true)
	end

	self.isLocking = false

	for i, v in pairs(self.detailCells) do
		v:OnHide()
	end
end

function SoulLockUI:OnDestroy()
	for i, v in pairs(self.detailCells) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
end

function SoulLockUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnHide.onClick:AddListener(self.onClickBtnHideDelegate)

	GameEntry.Input.ScaleGesture.StateUpdated = GameEntry.Input.ScaleGesture.StateUpdated + self.onScaleGestureDelegate
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + self.onTapGestureDelegate
end

function SoulLockUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnHide.onClick:RemoveListener(self.onClickBtnHideDelegate)

	GameEntry.Input.ScaleGesture.StateUpdated = GameEntry.Input.ScaleGesture.StateUpdated - self.onScaleGestureDelegate
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated - self.onTapGestureDelegate
end

function SoulLockUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulLockUI)
end

function SoulLockUI:OnLoadHeadSuccess(assetName, asset, duration, userData)
	self.goHead = UnityEngine.Object.Instantiate(asset)
	self.oldScale = self.goHead.transform.localScale

	self.goHead.transform:SetParent(self.goHeadParent.transform, false)
end

function SoulLockUI:OnClickBtnShow()
	self:SetPartVisible(true)

	if self.isLocking then
		LuaCodeInterface.SetEventSystemEnabled("SoulLock", true)
	end

	self.isLocking = false
end

function SoulLockUI:OnClickBtnHide()
	self:SetPartVisible(false)

	if self.isLocking == false then
		LuaCodeInterface.SetEventSystemEnabled("SoulLock", false)
	end

	self.isLocking = true
end

function SoulLockUI:OnScaleGesture(gesture)
	if LuaCodeInterface.GameObjIsDestroy(self.goHead) or self.headShowing then
		return
	end

	if gesture.State == DigitalRubyShared.GestureRecognizerState.Executing then
		local scale = math.min(self.goHead.transform.localScale.x * gesture.ScaleMultiplier, 1.25)

		scale = math.max(scale, 0.66)
		self.goHead.transform.localScale = Vector2.New(scale, scale)
	end
end

function SoulLockUI:OnTapGesture(gesture)
	if LuaCodeInterface.GameObjIsDestroy(self.goHead) or self.headShowing then
		return
	end

	if gesture.State == DigitalRubyShared.GestureRecognizerState.Ended then
		self:OnClickBtnShow()
	end
end

function SoulLockUI:RefreshDetail()
	self.tfSoulName.text = SoulLockUIApi:GetString("goSoulName", self.cfgSoulData.Name)
	self.tfNameEng.text = SoulLockUIApi:GetString("goSoulNameEng", self.cfgSoulData.EnglishName)
	self.tfSoulTitle.text = SoulLockUIApi:GetString("goSoulTitle", self.cfgSoulData.SoulDescribe)
	self.tfSoulDesc.text = SoulLockUIApi:GetString("goSoulDesc", self.cfgSoulData.SoulPresent)
	self.tfCvName.text = SoulLockUIApi:GetString("goCvName", self.cfgSoulData.CVName)

	local isHide = self.cfgSoulData.HideCVName or false

	self.cvNode:SetActive(not isHide)

	if not LuaCodeInterface.GameObjIsDestroy(self.goHead) then
		UnityEngine.GameObject.Destroy(self.goHead)
	end

	AssetUtil.LoadAsset(self, UIGlobalApi.GetSoulPortraitPath(self.soulData.soulCid, self.soulData:GetCfgSoulRes2D().Id), self.OnLoadHeadSuccess)
end

function SoulLockUI:RefreshDetailCells()
	for i, v in ipairs(self.detailCells) do
		local cfgSkillGroupData = self.cfgSkillGroupDatum[i]

		v:Refresh(i, self.soulData, cfgSkillGroupData)
	end
end

function SoulLockUI:SetPartVisible(vs)
	self.goPart1:SetActive(vs)
	self.goPart2:SetActive(vs)
	self.goPart3:SetActive(vs)

	self.headShowing = vs

	if not LuaCodeInterface.GameObjIsDestroy(self.goHead) then
		self.goHead.transform.localScale = self.oldScale
	end
end

return SoulLockUI
