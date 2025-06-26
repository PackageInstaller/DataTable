-- chunkname: @IQIGame\\UI\\CommonTips\\CommonTipsHelper.lua

local CommonTipsHelper = {}

function CommonTipsHelper.GetTipsOperationButtonsDataByItemData(itemData, clickSuccessAction)
	local result = {}
	local itemCfg = itemData:GetCfg()

	if itemCfg.UseType == Constant.ItemUseType.ManualUse then
		local btnData = {}

		btnData.btnName = CommonTipsApi:GetUserButtonText()

		function btnData.eventHandler()
			CommonTipsHelper.UserItem(itemData, clickSuccessAction)
		end

		table.insert(result, btnData)
	end

	if itemCfg.Sell then
		local btnData = {}

		btnData.btnName = CommonItemTipsUIApi:GetSellButtonText()

		function btnData.eventHandler()
			CommonTipsHelper.SellItem(itemData, clickSuccessAction)
		end

		table.insert(result, btnData)
	end

	return result
end

function CommonTipsHelper.UserItem(itemData, action)
	if itemData.num <= 0 then
		return
	end

	local canUse, errorMsg = ItemModule.CheckCanUse(itemData, 1)

	if not canUse then
		NoticeModule.ShowNoticeNoCallback(21040005, errorMsg)

		return
	end

	if action ~= nil then
		action()
	end

	UIModule.Open(Constant.UIControllerName.UseGiftUI, Constant.UILayer.UI, {
		itemData = itemData
	})
end

function CommonTipsHelper.SellItem(itemData, action)
	logError("出售道具功能逻辑未实现,Tips制作时无出售逻辑")
end

function CommonTipsHelper.CompositeItem()
	return
end

function CommonTipsHelper.CalculationTipsContentPosition(parentRectTrans, contentRectTrans)
	local resultPos = Clone(contentRectTrans.localPosition)
	local sizeDelta = contentRectTrans.sizeDelta
	local inRect, localPoint = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRectTrans, UnityEngine.Input.mousePosition, GameEntry.UICamera, nil)

	if not inRect then
		logError("Tips 计算鼠标点击位置错误，检查预制体父节点是否全屏")

		return Vector3.New(0, 0, 0)
	end

	resultPos.x = localPoint.x - sizeDelta.x / 2 - 50

	if resultPos.x - sizeDelta.x < UnityEngine.Screen.width / 2 * -1 then
		resultPos.x = localPoint.x + sizeDelta.x / 2 + 50
	end

	return resultPos
end

function CommonTipsHelper.CalculationTipsContentPositionByCell(parentRectTrans, itemCell, contentRectTrans)
	local itemCellRT = itemCell.ViewGo:GetComponent("RectTransform")
	local worldPos = Clone(itemCellRT.position)

	worldPos.y = contentRectTrans.position.y

	local screenPos = GameEntry.UICamera:WorldToScreenPoint(worldPos)
	local _, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRectTrans, screenPos, GameEntry.UICamera, nil)
	local sizeDelta = contentRectTrans.sizeDelta

	resultPos.x = resultPos.x + sizeDelta.x / 2 + 50

	if resultPos.x + sizeDelta.x > UnityEngine.Screen.width / 2 then
		resultPos.x = resultPos.x - sizeDelta.x - 100
	end

	return resultPos
end

function CommonTipsHelper.CalculationTipsContentPositionByWorldPosition(worldPosition, contentRectTrans, offsetL, offsetR)
	local worldPos = Clone(worldPosition)

	worldPos.y = contentRectTrans.position.y

	local screenPos = GameEntry.UICamera:WorldToScreenPoint(worldPos)
	local _, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(contentRectTrans.parent, screenPos, GameEntry.UICamera, nil)
	local sizeDelta = contentRectTrans.sizeDelta

	resultPos.x = resultPos.x + sizeDelta.x / 2 + offsetL

	if resultPos.x + sizeDelta.x > UnityEngine.Screen.width / 2 then
		resultPos.x = resultPos.x - sizeDelta.x - offsetR
	end

	return resultPos
end

function CommonTipsHelper.CalculationRTSLocalPositionByWorldPosition(rectTrans, worldPosition, boundingSize, offsetSize)
	local worldPos = Clone(worldPosition)
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(worldPos)
	local _, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTrans.parent, screenPos, GameEntry.UICamera, nil)
	local sizeDelta = rectTrans.sizeDelta
	local widthLimit = boundingSize.x / 2

	resultPos.x = resultPos.x + sizeDelta.x / 2 + offsetSize.x

	if widthLimit < resultPos.x + sizeDelta.x then
		resultPos.x = resultPos.x - sizeDelta.x - offsetSize.y
	end

	local heightLimit = boundingSize.y / 2
	local height = sizeDelta.y / 2

	if resultPos.y > 0 then
		local tmpPosY = resultPos.y + height
		local topDifference = heightLimit - tmpPosY - offsetSize.y

		if topDifference < 0 then
			resultPos.y = resultPos.y + topDifference - offsetSize.y
		end
	elseif resultPos.y < 0 then
		local tmpPosY = resultPos.y - height
		local bottomDifference = tmpPosY + heightLimit + offsetSize.z

		if bottomDifference < 0 then
			resultPos.y = resultPos.y - bottomDifference + offsetSize.z
		end
	end

	return resultPos
end

return CommonTipsHelper
