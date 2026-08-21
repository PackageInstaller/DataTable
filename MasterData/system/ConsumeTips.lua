-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\ConsumeTips.lua

local UserData = require("Helper/UserData")
local ResItem = require("ClientData/ResItem")
local ConsumeTips = {}
local self = ConsumeTips
local DIAMOND_EVENT_CONTENT = {
	[Const.CONSUME_DIAMOND_SHOP_ITEM] = Lang.get(36297),
	[Const.CONSUME_DIAMOND_REFRESH_SHOP] = Lang.get(36298),
	[Const.CONSUME_DIAMOND_BUY_FISHBONE] = Lang.get(36299),
	[Const.CONSUME_DIAMOND_REFRESH_PHOTOTASK] = Lang.get(36300),
	[Const.CONSUME_DIAMOND_UPGRADE_BAG] = Lang.get(36301),
	[Const.CONSUME_DIAMOND_CHANGE_NAME] = Lang.get(36302),
	[Const.CONSUME_DIAMOND_RESET_LEVEL] = "キャラレベルのリセット",
	[Const.CONSUME_DIAMOND_RESET_STEP] = "スキルのリセット",
	[Const.CONSUME_DIAMOND_RESET_ALL] = "リセット"
}
local CALLBACK_TYPE = {
	DIAMOND = 1,
	DRAWCARD = 2
}

function ConsumeTips.init()
	ConsumeTips._callbackDict = {}
end

function ConsumeTips.showTipsDiamond(cost, constEvent, time, confirmCallback, cancelCallback)
	if not RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		if confirmCallback ~= nil then
			confirmCallback()
		end

		return
	else
		ConsumeTips._setCallback(CALLBACK_TYPE.DIAMOND, confirmCallback, cancelCallback)

		local nowTime = ClientUtils.getServerTime()
		local recordTime = UserData.loadCommonData("consumetips" .. constEvent)

		if recordTime ~= nil then
			recordTime = tonumber(recordTime)
		end

		local item_name = DIAMOND_EVENT_CONTENT[constEvent]

		if recordTime == nil or recordTime < nowTime then
			local message = string.format(Lang.get(36303), cost, item_name, time)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "ヒント", message, Slot(self._diamondComfirm, constEvent), Slot(self._diamondCancel, constEvent), nil, Lang.get(50621), "キャンセル")
			UIManager.getUI("confirmui", true, true):showToggle(Lang.get(36304), false)
		else
			ConsumeTips._diamondComfirm(constEvent, true)
		end
	end
end

function ConsumeTips.showTipsDrawCrad(drawTime, drawCost, needItemId, confirmCallback, cancelCallback, drawType)
	if not RegionUtils.isKR() and not RegionUtils.isJP() then
		if confirmCallback ~= nil then
			confirmCallback()
		end

		return
	else
		if drawType == Const.DrawTypeNewbie then
			if confirmCallback ~= nil then
				confirmCallback()
			end

			return
		end

		if CurAvatar.roleCreatedCallback ~= nil then
			if confirmCallback ~= nil then
				confirmCallback()
			end

			return
		end

		local drawCradCancelCallback

		if cancelCallback ~= nil then
			drawCradCancelCallback = cancelCallback
		else
			drawCradCancelCallback = Functor(self._drawCardCanelCallback, self, drawType)
		end

		ConsumeTips._setCallback(CALLBACK_TYPE.DRAWCARD, confirmCallback, drawCradCancelCallback)

		local itemid, number, message

		if drawCost == Const.DrawCostTypeConsume then
			itemid = Const.MONEY_ID_DIAMOND
			number = drawTime == 1 and 300 or 2700
		elseif drawCost == Const.DrawCostTypeNone then
			number = nil
		elseif drawCost == Const.DrawCostTypeItem then
			itemid = needItemId
			number = drawTime
		end

		if RegionUtils.isJP() then
			if number ~= nil then
				message = string.format(Lang.get(36305), ResItem[itemid].name, number, drawTime)
			else
				message = string.format(Lang.get(36306), drawTime)
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "ヒント", message, self._drawcardComfirm, self._drawcardCancel, nil, Lang.get(50621), "キャンセル")
		elseif RegionUtils.isKR() then
			if number ~= nil then
				message = string.format(Lang.get(46039), ResItem[itemid].name, number, drawTime)
			else
				message = string.format(Lang.get(46040), drawTime)
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), message, self._drawcardComfirm, self._drawcardCancel, nil, Lang.get(50621), Lang.get(7))
		end
	end
end

function ConsumeTips:_drawCardCanelCallback(drawType)
	local drawTypeUI

	drawTypeUI = drawType == Const.DrawTypeLightDark and "drawCardOptLightDlg" or "drawCardOperateDlg"

	CueManager.stopVocal()

	local optDlg = UIManager.getUI(drawTypeUI, nil, false)

	if optDlg then
		optDlg:setVisible(false)
	end
end

function ConsumeTips._diamondComfirm(constEvent, tipsNoShow)
	if tipsNoShow == nil then
		ConsumeTips._recordToggleState(constEvent)
	end

	ConsumeTips._callCallback(CALLBACK_TYPE.DIAMOND, 1)
end

function ConsumeTips._diamondCancel(constEvent, tipsNoShow)
	if tipsNoShow == nil then
		ConsumeTips._recordToggleState(constEvent)
	end

	ConsumeTips._callCallback(CALLBACK_TYPE.DIAMOND, 2)
end

function ConsumeTips._drawcardComfirm()
	ConsumeTips._callCallback(CALLBACK_TYPE.DRAWCARD, 1)
end

function ConsumeTips._drawcardCancel()
	ConsumeTips._callCallback(CALLBACK_TYPE.DRAWCARD, 2)
end

function ConsumeTips._setCallback(event, confirmCallback, cancelCallback)
	ConsumeTips._callbackDict[event] = {
		confirmCallback,
		cancelCallback
	}
end

function ConsumeTips._callCallback(event, index, ...)
	local callback = ConsumeTips._callbackDict[event][index]

	if callback ~= nil then
		callback(...)
	end

	ConsumeTips._removeCallback(event)
end

function ConsumeTips._removeCallback(event)
	ConsumeTips._callbackDict[event] = nil
end

function ConsumeTips._recordToggleState(constEvent)
	if UIManager.getUI("confirmui") and UIManager.getUI("confirmui").attentionSwitch:isOn() then
		local nextDayTime = ClientUtils.getServerTimeNextDay()

		UserData.saveCommonData("consumetips" .. constEvent, nextDayTime)
	end
end

ConsumeTips.init()

return ConsumeTips
