-- chunkname: @IQIGame\\UI\\ExpBouns\\TargetCell.lua

local TargetCell = {}

function TargetCell.New(view)
	local obj = Clone(TargetCell)

	obj:Init(view)

	return obj
end

function TargetCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgNum = self.goNum:GetComponent("Image")
	self.btnJump = self.goBtnJump:GetComponent("Button")

	function self.onClickBtnJumpDelegate()
		self:OnClickBtnJump()
	end

	self.goBtnJumpTxt:GetComponent("Text").text = ExpBonusUIApi:GetString("btnJumpTxt")
	self.goTitle1:GetComponent("Text").text = ExpBonusUIApi:GetString("title1")

	UGUIUtil.SetText(self.BtnBuyTxt, ExpBonusUIApi:GetString("BtnBuyTxt"))
	UGUIUtil.SetText(self.BtnFinishTxt, ExpBonusUIApi:GetString("BtnFinishTxt"))
	self:OnAddListener()
end

function TargetCell:Refresh(cfgData, index)
	self.cfgData = cfgData
	self.index = index

	self:RefreshMisc()
	self.BtnJump:SetActive(false)
	self.BtnBuy:SetActive(false)
	self.BtnFinish:SetActive(false)

	if self.cfgData.Id == 1 or self.cfgData.Id == 2 or self.cfgData.Id == 3 then
		self.BtnJump:SetActive(true)
	elseif self.cfgData.Id == 4 then
		self.BtnBuy:SetActive(true)

		local value = CfgDiscreteDataTable[6520070].Data[1]

		UGUIUtil.SetText(self.BtnBuyTxt, ExpBonusUIApi:GetString("BtnBuyTxt", value, CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Name, PlayerModule.PlayerInfo.advanceLevelChaseFlag))
	elseif self.cfgData.Id == 5 then
		self.BtnBuy:SetActive(true)

		local cfgPayData

		for i, v in pairsCfg(CfgPayTable) do
			if v.MallID == self.cfgData.Parameter then
				cfgPayData = v

				break
			end
		end

		UGUIUtil.SetText(self.BtnBuyTxt, ActivityUIApi:GetString("ReplacementBtnBuyLabel", cfgPayData.Amount))
	end
end

function TargetCell:OnHide()
	return
end

function TargetCell:OnDestroy()
	self:OnRemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function TargetCell:OnAddListener()
	self.btnJump.onClick:AddListener(self.onClickBtnJumpDelegate)
end

function TargetCell:OnRemoveListener()
	self.btnJump.onClick:RemoveListener(self.onClickBtnJumpDelegate)
end

function TargetCell:OnClickBtnJump()
	if self.cfgData.FunctionId > 0 then
		JumpModule.Jump(self.cfgData.FunctionId)
	elseif self.cfgData.Id == 3 then
		UIModule.Open(Constant.UIControllerName.RewardLevelsUI, Constant.UILayer.UI)
	elseif self.cfgData.Id == 4 then
		if not PlayerModule.PlayerInfo.advanceLevelChaseFlag then
			local value = CfgDiscreteDataTable[6520070].Data[1]

			NoticeModule.ShowNotice(21045037, function()
				local value = CfgDiscreteDataTable[6520070].Data[1]

				if value > PlayerModule.PlayerInfo.baseInfo.payPoint then
					NoticeModule.ShowNotice(21045039)

					return
				end

				net_player.buyAdvanceLevelChase()
			end, nil, self, value)
		end
	elseif self.cfgData.Id == 5 then
		UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
			mallCid = self.cfgData.Parameter
		})
	end
end

function TargetCell:RefreshMisc()
	self.goTitle2:GetComponent("Text").text = ExpBonusUIApi:GetString("title2", self.cfgData.Name)
	self.goDesc:GetComponent("Text").text = ExpBonusUIApi:GetString("desc3", self.cfgData.Desc)

	local path = ExpBonusUIApi:GetString("numIcon", self.index)

	AssetUtil.LoadImage(self, path, self.imgNum)
end

return TargetCell
