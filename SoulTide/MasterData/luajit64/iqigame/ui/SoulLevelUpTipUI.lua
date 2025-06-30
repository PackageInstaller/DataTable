-- chunkname: @IQIGame\\UI\\SoulLevelUpTipUI.lua

local SoulLevelUpTipUI = Base:Extend("SoulLevelUpTipUI", "IQIGame.Onigao.UI.SoulLevelUpTipUI", {
	attCellPool = {}
})

function SoulLevelUpTipUI:OnInit()
	self:Initialize()
end

function SoulLevelUpTipUI:GetPreloadAssetPaths()
	return nil
end

function SoulLevelUpTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulLevelUpTipUI:IsManualShowOnOpen(userData)
	return false
end

function SoulLevelUpTipUI:GetBGM(userData)
	return nil
end

function SoulLevelUpTipUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulLevelUpTipUI:OnClose(userData)
	self:OnHide()
end

function SoulLevelUpTipUI:OnPause()
	return
end

function SoulLevelUpTipUI:OnResume()
	return
end

function SoulLevelUpTipUI:OnCover()
	return
end

function SoulLevelUpTipUI:OnReveal()
	return
end

function SoulLevelUpTipUI:OnRefocus(userData)
	return
end

function SoulLevelUpTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulLevelUpTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulLevelUpTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulLevelUpTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulLevelUpTipUI:Initialize()
	self.tfLvPre = self.goLvPre:GetComponent("Text")
	self.tfLvCur = self.goLvCur:GetComponent("Text")
	self.attCellPool[1] = self.goAttCell
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goLvUpTitle:GetComponent("Text").text = SoulLevelUpTipUIApi:GetString("goLvUpTitle")
	self.goLvUpTitleEng:GetComponent("Text").text = SoulLevelUpTipUIApi:GetString("goLvUpTitleEng")
	self.goAttTitle:GetComponent("Text").text = SoulLevelUpTipUIApi:GetString("goAttTitle")
end

function SoulLevelUpTipUI:Refresh(userData)
	self.soulData = userData[1]
	self.preAtts = userData[2]

	self:RefreshMisc()
	self:RefreshAttBlock()
end

function SoulLevelUpTipUI:OnHide()
	return
end

function SoulLevelUpTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function SoulLevelUpTipUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function SoulLevelUpTipUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function SoulLevelUpTipUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SoulLevelUpTipUI:RefreshMisc()
	self.tfLvPre.text = SoulLevelUpTipUIApi:GetString("goLvPre", SoulModule.lastUpSoulLv)
	self.tfLvCur.text = SoulLevelUpTipUIApi:GetString("goLvCur", self.soulData.lv)
end

function SoulLevelUpTipUI:RefreshAttBlock()
	local uppedAttids = {}

	for i, v in pairs(self.soulData.atts) do
		if v - self.preAtts[i] > 0 then
			uppedAttids[#uppedAttids + 1] = i
		end
	end

	table.sort(uppedAttids, function(a, b)
		return a < b
	end)

	for i, v in ipairs(self.attCellPool) do
		v:SetActive(i <= #uppedAttids)
	end

	for i, v in ipairs(uppedAttids) do
		local attCell = self:GetAttCell(i)
		local tfName = attCell.transform:Find("Sort/Text_01"):GetComponent("Text")
		local tfNameEng = attCell.transform:Find("Sort/Text_02"):GetComponent("Text")
		local tfValuePre = attCell.transform:Find("Text_01"):GetComponent("Text")
		local tfValueCur = attCell.transform:Find("Text_02"):GetComponent("Text")
		local icon = attCell.transform:Find("Icon_01"):GetComponent("Image")

		tfName.text = SoulLevelUpTipUIApi:GetString("goAttName", AttributeModule.GetAttName(v))
		tfNameEng.text = SoulUIApi:GetString("goAttNameEng", v)
		tfValuePre.text = SoulLevelUpTipUIApi:GetString("goAttValuePre", AttributeModule.GetAttShowValue(v, self.preAtts[v]))
		tfValueCur.text = SoulLevelUpTipUIApi:GetString("goAttValueCur", AttributeModule.GetAttShowValue(v, self.soulData.atts[v]))

		AssetUtil.LoadImage(self, SoulUIApi:GetString("soulAttIconPath", v), icon)
	end
end

function SoulLevelUpTipUI:GetAttCell(index)
	local ret = self.attCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttCell)

		ret.transform:SetParent(self.goAttCell.transform.parent, false)

		self.attCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

return SoulLevelUpTipUI
