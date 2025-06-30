-- chunkname: @IQIGame\\UI\\HomeLandFishChooseUI.lua

local HomeLandFishChooseUI = {
	ample = true,
	openType = 1,
	autoFishing = false,
	fishBaitItems = {},
	fishBaitPool = {},
	fishRodItems = {},
	fishRodPool = {}
}

HomeLandFishChooseUI = Base:Extend("HomeLandFishChooseUI", "IQIGame.Onigao.UI.HomeLandFishChooseUI", HomeLandFishChooseUI)

local FishChooseBaitCell = require("IQIGame.UI.Fishing.FishChooseBaitCell")
local FishChooseRodCell = require("IQIGame.UI.Fishing.FishChooseRodCell")

function HomeLandFishChooseUI:OnInit()
	UGUIUtil.SetText(self.TextHaveNone, HomeLandFishChooseUIApi:GetString("TextHaveNone"))
	UGUIUtil.SetText(self.BtnFishTenLabel, HomeLandFishChooseUIApi:GetString("BtnFishTenLabel"))
	UGUIUtil.SetText(self.BtnFishTenLabelEng, HomeLandFishChooseUIApi:GetString("BtnFishTenLabelEng"))
	UGUIUtil.SetText(self.BtnFishHundredLabel, HomeLandFishChooseUIApi:GetString("BtnFishHundredLabel"))
	UGUIUtil.SetText(self.BtnFishHundredLabelEng, HomeLandFishChooseUIApi:GetString("BtnFishHundredLabelEng"))

	self.ItemCell = ItemCell.New(self.SpendItem)
	self.scrollAreaBait = self.ScrollAreaBaitView:GetComponent("ScrollAreaList")

	function self.scrollAreaBait.onSelectedCell(cell)
		self:OnSelectedBaitCell(cell)
	end

	function self.scrollAreaBait.onRenderCell(cell)
		self:OnRenderBaitCell(cell)
	end

	self.scrollAreaRod = self.ScrollAreaRod:GetComponent("ScrollAreaList")

	function self.scrollAreaRod.onSelectedCell(cell)
		self:OnSelectedRodCell(cell)
	end

	function self.scrollAreaRod.onRenderCell(cell)
		self:OnRenderRodCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnFish()
		self:OnBtnFish()
	end

	function self.delegateBtnTen()
		self:OnBtnTen()
	end

	function self.delegateBtnHundred()
		self:OnBtnHundred()
	end

	function self.delegateBtnAutoFish()
		self:OnBtnAutoFish()
	end
end

function HomeLandFishChooseUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandFishChooseUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandFishChooseUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandFishChooseUI:GetBGM(userData)
	return nil
end

function HomeLandFishChooseUI:OnOpen(userData)
	self.openType = userData.OpenType
	self.autoFishing = userData.AutoFishing
	self.selectBait = nil
	self.selectRod = nil

	self:UpDateView()
end

function HomeLandFishChooseUI:OnClose(userData)
	return
end

function HomeLandFishChooseUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnFish:GetComponent("Button").onClick:AddListener(self.delegateBtnFish)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnFishTen:GetComponent("Button").onClick:AddListener(self.delegateBtnTen)
	self.BtnFishHundred:GetComponent("Button").onClick:AddListener(self.delegateBtnHundred)
	self.BtnAutoFish:GetComponent("Button").onClick:AddListener(self.delegateBtnAutoFish)
end

function HomeLandFishChooseUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnFish:GetComponent("Button").onClick:RemoveListener(self.delegateBtnFish)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnFishTen:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTen)
	self.BtnFishHundred:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHundred)
	self.BtnAutoFish:GetComponent("Button").onClick:RemoveListener(self.delegateBtnAutoFish)
end

function HomeLandFishChooseUI:OnPause()
	return
end

function HomeLandFishChooseUI:OnResume()
	return
end

function HomeLandFishChooseUI:OnCover()
	return
end

function HomeLandFishChooseUI:OnReveal()
	return
end

function HomeLandFishChooseUI:OnRefocus(userData)
	return
end

function HomeLandFishChooseUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandFishChooseUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandFishChooseUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandFishChooseUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandFishChooseUI:OnDestroy()
	self.ItemCell:Dispose()

	for i, v in pairs(self.fishBaitPool) do
		v:Dispose()
	end

	for i, v in pairs(self.fishRodPool) do
		v:Dispose()
	end
end

function HomeLandFishChooseUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandFishChooseUI)
end

function HomeLandFishChooseUI:UpDateView()
	UGUIUtil.SetText(self.PanelTitle, HomeLandFishChooseUIApi:GetString("PanelTitle", self.openType))
	UGUIUtil.SetText(self.BtnFishLabel, HomeLandFishChooseUIApi:GetString("BtnFishLabel", self.openType))
	UGUIUtil.SetText(self.BtnFishLabelEng, HomeLandFishChooseUIApi:GetString("BtnFishLabelEng", self.openType))

	if self.openType == 1 then
		self.fishBaitItems = FishingModule.GetFishItems({
			Constant.ItemTab.BAIT
		}, {
			Constant.ItemSubType.Fish_Bait
		})
		self.fishRodItems = FishingModule.GetFishItems({
			Constant.ItemTab.FISHING_GEAR
		}, {
			Constant.ItemSubType.Fish_Rod
		})
	elseif self.openType == 2 then
		self.fishBaitItems = FishingModule.GetFishItems({
			Constant.ItemTab.FISHING_GEAR
		}, {
			Constant.ItemSubType.Fish_Net,
			Constant.ItemSubType.Fish_Spear,
			Constant.ItemSubType.Fish_Torpedo
		})
		self.fishRodItems = {}
	end

	self.scrollAreaBait:Refresh(#self.fishBaitItems)
	self.scrollAreaRod:Refresh(#self.fishRodItems)
	self.BtnFish:SetActive(not self.autoFishing)
	self.BtnAutoFish:SetActive(self.openType == 1 and self.autoFishing)
	self.BtnFishTen:SetActive(self.openType == 2)
	self.BtnFishHundred:SetActive(self.openType == 2)

	local have = #self.fishBaitItems > 0

	self.HaveNone:SetActive(not have)
	self.ScrollAreaBaitView:SetActive(have)
	self.RodView:SetActive(self.openType == 1)
	self.ToolMsgView:SetActive(self.openType == 2 and have)
	self.TextAutoFish:SetActive(self.autoFishing)
	self:ShowSelectBaitMsg()
end

function HomeLandFishChooseUI:OnSelectedBaitCell(cell)
	self.selectBait = self.fishBaitItems[cell.index + 1]

	for i, v in pairs(self.fishBaitPool) do
		if v.View:GetInstanceID() == cell.gameObject:GetInstanceID() then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	self:ShowSelectBaitMsg()
end

function HomeLandFishChooseUI:OnRenderBaitCell(cell)
	local data = self.fishBaitItems[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.fishBaitPool[instanceID]

	if renderCell == nil then
		renderCell = FishChooseBaitCell.New(cell.gameObject)
		self.fishBaitPool[instanceID] = renderCell
	end

	renderCell:SetData(data)

	if self.selectBait ~= nil then
		if self.selectBait.id == data.id then
			renderCell:SetSelect(true)
		else
			renderCell:SetSelect(false)
		end
	else
		self.selectBait = data

		renderCell:SetSelect(true)
	end
end

function HomeLandFishChooseUI:OnSelectedRodCell(cell)
	self.selectRod = self.fishRodItems[cell.index + 1]

	for i, v in pairs(self.fishRodPool) do
		if v.View:GetInstanceID() == cell.gameObject:GetInstanceID() then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end
end

function HomeLandFishChooseUI:OnRenderRodCell(cell)
	local data = self.fishRodItems[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.fishRodPool[instanceID]

	if renderCell == nil then
		renderCell = FishChooseRodCell.New(cell.gameObject)
		self.fishRodPool[instanceID] = renderCell
	end

	renderCell:SetData(data)

	if self.selectRod ~= nil then
		if self.selectRod.id == data.id then
			renderCell:SetSelect(true)
		else
			renderCell:SetSelect(false)
		end
	else
		self.selectRod = data

		renderCell:SetSelect(true)
	end
end

function HomeLandFishChooseUI:ShowSelectBaitMsg()
	self.ample = true

	local baitID, spendItemID, spendNum
	local showLabel = false

	if self.selectBait then
		UGUIUtil.SetText(self.ToolDes, self.selectBait:GetCfg().Describe)

		local cfgBait

		for i, v in pairsCfg(CfgFishingGearListTable) do
			if v.ItemID == self.selectBait.cid then
				cfgBait = v

				break
			end
		end

		if #cfgBait.CostItem > 1 then
			local needItemID = cfgBait.CostItem[1]
			local needNum = cfgBait.CostItem[2]
			local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)

			self.ItemCell:SetItemByCID(needItemID)
			self.ItemCell:SetCustomNum(haveNum, needNum)

			self.ample = needNum <= haveNum
			baitID = cfgBait.ItemID
			spendItemID = needItemID
			spendNum = needNum
		end

		showLabel = true
	end

	self:ShowBtnLabel(showLabel, baitID, spendItemID, spendNum)
end

function HomeLandFishChooseUI:ShowBtnLabel(showLabel, baitID, spendItemID, spendNum)
	self.NeedTips:SetActive(self.openType == 2 and showLabel)
	self.NeedTenTips:SetActive(self.openType == 2 and showLabel)
	self.NeedHundredTips:SetActive(self.openType == 2 and showLabel)

	if showLabel then
		local baitName = ""
		local needName = ""
		local needNum = 0
		local haveNum = 0
		local haveBait = 0

		if baitID then
			baitName = CfgItemTable[baitID].Name
			haveBait = WarehouseModule.GetItemNumByCfgID(baitID)
		end

		if spendItemID then
			needName = CfgItemTable[spendItemID].Name
			haveNum = WarehouseModule.GetItemNumByCfgID(spendItemID)
		end

		if spendNum then
			needNum = spendNum
		end

		UGUIUtil.SetText(self.NeedTips, HomeLandFishChooseUIApi:GetString("NeedTips", baitName, 1, needName, needNum, haveBait >= 1, needNum <= haveNum))
		UGUIUtil.SetText(self.NeedTenTips, HomeLandFishChooseUIApi:GetString("NeedTips", baitName, 10, needName, needNum * 10, haveBait >= 10, haveNum >= needNum * 10))
		UGUIUtil.SetText(self.NeedHundredTips, HomeLandFishChooseUIApi:GetString("NeedTips", baitName, 100, needName, needNum * 100, haveBait >= 100, haveNum >= needNum * 100))
	end
end

function HomeLandFishChooseUI:CheckAmple(num)
	local ample = true

	if self.selectBait then
		local haveItem = num <= self.selectBait.num
		local cfgBait

		for i, v in pairsCfg(CfgFishingGearListTable) do
			if v.ItemID == self.selectBait.cid then
				cfgBait = v

				break
			end
		end

		if #cfgBait.CostItem > 1 then
			local needItemID = cfgBait.CostItem[1]
			local needNum = cfgBait.CostItem[2] * num
			local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)

			ample = needNum <= haveNum and haveItem
		end
	end

	return ample
end

function HomeLandFishChooseUI:OnBtnFish()
	if self.openType == 1 then
		if self.selectRod and self.selectBait then
			FishingModule.Fishing(self.selectRod.id, self.selectBait.cid)
		end
	elseif self.selectBait then
		if self.ample == false then
			NoticeModule.ShowNotice(21040078)

			return
		end

		EventDispatcher.Dispatch(EventID.PlayFishEffectEvent, self.selectBait.cid, 1)
	end

	self:OnBtnClose()
end

function HomeLandFishChooseUI:OnBtnTen()
	if self.selectBait then
		local ample = self:CheckAmple(10)

		if ample == false then
			NoticeModule.ShowNotice(21040078)

			return
		end

		EventDispatcher.Dispatch(EventID.PlayFishEffectEvent, self.selectBait.cid, 10)
	end

	self:OnBtnClose()
end

function HomeLandFishChooseUI:OnBtnHundred()
	if self.selectBait then
		local ample = self:CheckAmple(100)

		if ample == false then
			NoticeModule.ShowNotice(21040078)

			return
		end

		EventDispatcher.Dispatch(EventID.PlayFishEffectEvent, self.selectBait.cid, 100)
	end

	self:OnBtnClose()
end

function HomeLandFishChooseUI:OnBtnAutoFish()
	if not FishingModule.fishingData.state then
		if FishingModule.isAutoFish then
			NoticeModule.ShowNotice(21042048)

			return
		end

		if self.selectRod and self.selectBait then
			local haveRodNum = self.selectRod:GetLeftUseCount()
			local haveBaitNum = self.selectBait.num
			local minNum = math.min(haveRodNum, haveBaitNum)
			local num = CfgDiscreteDataTable[6520098].Data[1]
			local sec = num * minNum

			NoticeModule.ShowNotice(21042047, function()
				FishingModule.AutomaticFishing(self.selectRod.id, self.selectBait.cid)
				self:OnBtnClose()
			end, nil, self, GetFormatTime(sec))
		end
	end
end

return HomeLandFishChooseUI
