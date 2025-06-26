-- chunkname: @IQIGame\\UI\\SoulTalentAttributeUI.lua

local SoulTalentAttributeUI = Base:Extend("SoulTalentAttributeUI", "IQIGame.Onigao.UI.SoulTalentAttributeUI", {
	attIds = {},
	attId2ValueDic = {}
})

function SoulTalentAttributeUI:OnInit()
	self:Initialize()
end

function SoulTalentAttributeUI:GetPreloadAssetPaths()
	return nil
end

function SoulTalentAttributeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulTalentAttributeUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulTalentAttributeUI:OnClose(userData)
	return
end

function SoulTalentAttributeUI:OnPause()
	return
end

function SoulTalentAttributeUI:OnResume()
	return
end

function SoulTalentAttributeUI:OnCover()
	return
end

function SoulTalentAttributeUI:OnReveal()
	return
end

function SoulTalentAttributeUI:OnRefocus(userData)
	return
end

function SoulTalentAttributeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulTalentAttributeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulTalentAttributeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulTalentAttributeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulTalentAttributeUI:Initialize()
	self.scrollList = self.goScrollList:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goBtnTxt:GetComponent("Text").text = SoulTalentAttributeUIApi:GetString("goBtnClose")
	self.goTitle:GetComponent("Text").text = SoulTalentAttributeUIApi:GetString("goTitle")
end

function SoulTalentAttributeUI:Refresh(userData)
	self.soulData = userData

	self:RefreshAtt()
end

function SoulTalentAttributeUI:OnDestroy()
	return
end

function SoulTalentAttributeUI:RefreshAtt()
	self.attIds = {}
	self.attId2ValueDic = {}

	for i, v in pairs(self.soulData.talentCids) do
		local cfgTalentData = CfgSoulTalentTable[v]

		for j, k in pairs(cfgTalentData.AttType) do
			if k ~= 0 then
				if self.attId2ValueDic[k] == nil then
					self.attIds[#self.attIds + 1] = k
					self.attId2ValueDic[k] = cfgTalentData.AttValue[j]
				else
					self.attId2ValueDic[k] = self.attId2ValueDic[k] + cfgTalentData.AttValue[j]
				end
			end
		end
	end

	table.sort(self.attIds, function(a, b)
		return a < b
	end)
	self.scrollList:Refresh(#self.attIds)
end

function SoulTalentAttributeUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function SoulTalentAttributeUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function SoulTalentAttributeUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulTalentAttributeUI)
end

function SoulTalentAttributeUI:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local attId = self.attIds[luaIndex]
	local attValue = self.attId2ValueDic[attId]

	UGUIUtil.SetText(cell.transform:Find("Text_1").gameObject, SoulTalentAttributeUIApi:GetString("goAttName", AttributeModule.GetAttName(attId)))
	UGUIUtil.SetText(cell.transform:Find("Text_2").gameObject, SoulTalentAttributeUIApi:GetString("goAttValue", AttributeModule.GetAttShowValue(attId, attValue)))
end

return SoulTalentAttributeUI
