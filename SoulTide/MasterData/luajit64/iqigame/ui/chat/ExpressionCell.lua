-- chunkname: @IQIGame\\UI\\Chat\\ExpressionCell.lua

local ExpressionCell = {
	_isUsed = false,
	cellView = {}
}

function ExpressionCell.PackageOrReuseView(ui, itemCellPrefab, parentCell)
	if ui == nil or itemCellPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ExpressionCell == nil then
		ui.__SUB_UI_MAP_ExpressionCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ExpressionCell
	local itemCell

	if subUIMap[itemCellPrefab:GetInstanceID()] ~= nil then
		itemCell = subUIMap[itemCellPrefab:GetInstanceID()]
	else
		itemCell = ExpressionCell:New(itemCellPrefab, parentCell)
		subUIMap[itemCellPrefab:GetInstanceID()] = itemCell
	end

	return itemCell
end

function ExpressionCell:New(itemCellPrefab, parentCell)
	local itemCell = Clone(self)

	itemCell._isUsed = true

	local chatMsgCell = itemCellPrefab

	itemCell.cellView = {}
	itemCell.cellObj = chatMsgCell

	LuaCodeInterface.BindOutlet(itemCell.cellObj, itemCell.cellView)

	function itemCell.DelegateOnClickHandler()
		itemCell:OnClickHandler()
	end

	itemCell.cellObj:GetComponent("Button").onClick:AddListener(itemCell.DelegateOnClickHandler)

	return itemCell
end

function ExpressionCell:SetItem(CfgChatEmoticonData)
	self._cfgChatEmoticonData = CfgChatEmoticonData

	local resPath = UIGlobalApi.ImagePath .. CfgChatEmoticonData.Emoticons .. "0" .. CfgChatEmoticonData.startIndex .. ".png"

	AssetUtil.LoadAsset(self, resPath, self.OnLoadSucceed, self.OnLoadFailed, {
		iconUI = self.cellView.expressionCell,
		emoticonData = self._cfgChatEmoticonData
	})
end

function ExpressionCell:OnClickHandler()
	EventDispatcher.Dispatch(EventID.SelectExpression, self._cfgChatEmoticonData.Id)

	local expression = ""
	local CommonExpression = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.CommonExpression_key)

	if CommonExpression ~= "" then
		local expressionList = string.split(CommonExpression, "|")
		local isHasSameExpression = false

		for i = 1, #expressionList do
			if tonumber(expressionList[i]) == self._cfgChatEmoticonData.Id then
				isHasSameExpression = true

				break
			end
		end

		if isHasSameExpression == false then
			for i = #expressionList, 1, -1 do
				if expressionList[i] == "" then
					table.remove(expressionList, i)
				end
			end

			if #expressionList >= 8 then
				table.remove(expressionList, 0)
			end

			for i = 1, #expressionList do
				expression = expression .. expressionList[i] .. "|"
			end

			expression = expression .. self._cfgChatEmoticonData.Id .. "|"
		end
	else
		expression = self._cfgChatEmoticonData.Id .. "|"
	end

	if expression ~= "" then
		PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.CommonExpression_key, expression)
	end
end

function ExpressionCell:Clear()
	AssetUtil.UnloadAsset(self)
	self.cellObj:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHandler)
	LuaCodeInterface.ClearOutlet(self.cellObj, self.cellView)
	UnityEngine.Object.Destroy(self.cellObj)

	self.cellObj = nil
	self.cellView = nil
	self._isUsed = false
end

function ExpressionCell:OnLoadSucceed(assetName, asset, duration, iconData)
	local imgIcon = iconData.iconUI:GetComponent("Image")

	imgIcon.sprite = LuaCodeInterface.ToSprite(asset)

	local sequenceComponent = iconData.iconUI:GetComponent("FrameSequenceComponent")

	sequenceComponent.relativePath = iconData.emoticonData.Emoticons
	sequenceComponent.startNumber = iconData.emoticonData.startIndex
	sequenceComponent.imageCount = iconData.emoticonData.totalNum

	sequenceComponent:Play()
end

function ExpressionCell:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return ExpressionCell
