-- chunkname: @IQIGame\\UI\\UserInfo\\ReUserNameView.lua

local ReUserNameView = {
	isEnough = false
}

function ReUserNameView.New(view)
	local obj = Clone(ReUserNameView)

	obj:Init(view)

	return obj
end

function ReUserNameView:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.InputField = self.NameInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	function self.Delegation_OnCloseBtnClick()
		self:Hide()
	end

	function self.Delegation_OnConfirmBtnClick()
		self:OnConfirmBtnClick()
	end

	function self.Delegation_OnInputValueChanged()
		self:OnInputValueChange()
	end

	function self.Delegation_Response_GetReNameResult(code)
		self:Response_GetReNameResult(code)
	end

	self.commonSlotUI = ItemCell.New(self.CommonSlotUI)

	self.commonSlotUI:SetItem(ItemData.CreateByCIDAndNumber(CfgDiscreteDataTable[88].Data[1], 1))
	self:AddListeners()
	self:InitInfo()
end

function ReUserNameView:Dispose()
	self.commonSlotUI:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.InputField = nil
	self.Delegation_OnCloseBtnClick = nil
	self.Delegation_OnConfirmBtnClick = nil
	self.Delegation_OnInputValueChanged = nil
	self.Delegation_Response_GetReNameResult = nil
	self.gameObject = nil
end

function ReUserNameView:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.Delegation_OnCloseBtnClick)
	self.MaskCloseBtn:GetComponent("Button").onClick:AddListener(self.Delegation_OnCloseBtnClick)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.Delegation_OnConfirmBtnClick)
	self.InputField.onValueChanged:AddListener(self.Delegation_OnInputValueChanged)
	EventDispatcher.AddEventListener(EventID.GetRePlayerNameResult, self.Delegation_Response_GetReNameResult)
end

function ReUserNameView:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.Delegation_OnCloseBtnClick)
	self.MaskCloseBtn:GetComponent("Button").onClick:RemoveListener(self.Delegation_OnCloseBtnClick)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.Delegation_OnConfirmBtnClick)
	self.InputField.onValueChanged:RemoveListener(self.Delegation_OnInputValueChanged)
	EventDispatcher.RemoveEventListener(EventID.GetRePlayerNameResult, self.Delegation_Response_GetReNameResult)
end

function ReUserNameView:Show()
	self.gameObject:SetActive(true)
	self:SetData()
end

function ReUserNameView:Hide()
	self.gameObject:SetActive(false)
end

function ReUserNameView:InitInfo()
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, UserInfoApi:GetReNamePanelConfirmBtn())
	UGUIUtil.SetText(self.InputPlaceholder, UserInfoApi:GetReNamePanelInputPlaceholder())
end

function ReUserNameView:SetData()
	self.InputField.text = ""

	local needItemID, needItemCount = self:GetCurChangeNameConsume()
	local itemCount = WarehouseModule.GetItemNumByCfgID(needItemID)

	self.isEnough = needItemCount <= itemCount and true or false

	UGUIUtil.SetText(self.haveNumText, itemCount)
	UGUIUtil.SetText(self.costNumText, needItemCount)
end

function ReUserNameView:OnConfirmBtnClick()
	local newNameStr = self.InputField.text

	if newNameStr == "" or #newNameStr < CfgDiscreteDataTable[45].Data[1] then
		NoticeModule.ShowNotice(21040124)

		return
	end

	if not self.isEnough then
		NoticeModule.ShowNotice(12003)

		return
	end

	NoticeModule.ShowNotice(45017, function()
		local filteredName = FilterName(newNameStr)

		if filteredName ~= newNameStr or filteredName == "" or filteredName == nil then
			NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, UserInfoApi:GetNameUnserviceableText())

			return
		end

		SDKLoginModule.SensitiveWordFilter(filteredName, function(resultStr, isHasSensitive)
			if isHasSensitive then
				NoticeModule.ShowNotice(21045002)

				return
			end

			local data = {}

			data[UserInfoModule.CHANGE_PLAYER_NAME] = resultStr

			UserInfoModule.ChangeUserData(data)
			log("改名功能 - OnConfirmBtnClick：newName={0}", resultStr)
		end)
	end, function()
		return
	end, nil, CfgItemTable[CfgDiscreteDataTable[88].Data[1]].Name)
end

function ReUserNameView:OnInputValueChange()
	self.InputField.text = string.getSubstringByBytes(self.InputField.text, CfgDiscreteDataTable[45].Data[2])
end

function ReUserNameView:Response_GetReNameResult(code)
	if code == 0 then
		log("改名功能 - Response_GetReNameResult：改名成功.")
		self:Hide()
	else
		if code == 11005 then
			-- block empty
		elseif code == 11002 then
			-- block empty
		elseif code == 10026 then
			-- block empty
		end

		log("改名功能 - Response_GetReNameResult：改名失败,errorCode={0}", code)
	end
end

function ReUserNameView:GetCurChangeNameConsume()
	local changeNameNeedID = 0
	local changeNameNeddCount = 0
	local changeCount = PlayerModule.PlayerInfo.baseInfo.changeNameCount + 1
	local discreteDatas = CfgDiscreteDataTable[88].Data

	if changeCount > #discreteDatas / 2 then
		changeNameNeedID = discreteDatas[#discreteDatas - 1]
		changeNameNeddCount = discreteDatas[#discreteDatas]
	else
		for i = 1, #discreteDatas, 2 do
			if changeCount == math.ceil(i / 2) then
				changeNameNeedID = discreteDatas[i]
				changeNameNeddCount = discreteDatas[i + 1]
			end
		end
	end

	return changeNameNeedID, changeNameNeddCount
end

return ReUserNameView
