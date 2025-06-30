-- chunkname: @IQIGame\\UI\\Lottery\\LotteryMultiPickUpCell.lua

local m = {
	IsChoiceCell = false
}

function m.New(view, isChoiceCell)
	local obj = Clone(m)

	obj:Init(view, isChoiceCell)

	return obj
end

function m:Init(view, isChoiceCell)
	self.View = view
	isChoiceCell = isChoiceCell or false
	self.IsChoiceCell = isChoiceCell

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnLongClickSelf()
		self:OnLongClickSelf()
	end

	self.View:GetComponent(typeof(LongButton)).repeatCall = false

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent(typeof(LongButton)).onLongDownClick:AddListener(self.DelegateOnLongClickSelf)
end

function m:RemoveListeners()
	self.View:GetComponent(typeof(LongButton)).onLongDownClick:RemoveListener(self.DelegateOnLongClickSelf)
end

function m:SetData(cfgLotteryPackUpData, selectIndex)
	self.CfgLotteryPackUpData = cfgLotteryPackUpData

	self.NormalView:SetActive(cfgLotteryPackUpData ~= nil)
	self.EmptyView:SetActive(cfgLotteryPackUpData == nil)
	UGUIUtil.SetTextInChildren(self.EmptyView, tostring(selectIndex))

	if cfgLotteryPackUpData == nil then
		return
	end

	selectIndex = selectIndex or -1

	self.CheckView:SetActive(selectIndex ~= -1 and not self.IsChoiceCell)

	if selectIndex ~= -1 then
		UGUIUtil.SetTextInChildren(self.CheckView, tostring(selectIndex))
	end

	UGUIUtil.SetTextInChildren(self.EmptyView, tostring(selectIndex))

	if self.NameText ~= nil then
		UGUIUtil.SetText(self.NameText, cfgLotteryPackUpData.Name)
	end

	if self.EquipClassIcon ~= nil then
		if cfgLotteryPackUpData.UpType == 2 then
			local itemCid = cfgLotteryPackUpData.UpList[1]
			local cfgItemData = CfgItemTable[itemCid]

			AssetUtil.LoadImage(self, MiscApi:GetString("equipClassIcon", cfgItemData.SubType), self.EquipClassIcon:GetComponent(typeof(UnityEngine.UI.Image)))
		else
			logError("不支持的类型")
		end
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgLotteryPackUpData.Icon), self.Icon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function m:OnLongClickSelf()
	if self.CfgLotteryPackUpData.UpType == 2 then
		local itemCid = self.CfgLotteryPackUpData.UpList[1]
		local cfgItemData = CfgItemTable[itemCid]

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			forShow = true,
			data = {
				cfgItemData
			}
		})
	else
		logError("不支持的类型")
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
