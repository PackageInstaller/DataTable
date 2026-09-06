-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/remembertheater/view/RememberTheaterRightView.lua

module("logic.extensions.remembertheater.view.RememberTheaterRightView", package.seeall)

local RememberTheaterRightView = class("RememberTheaterRightView", TableViewComponent)

RememberTheaterRightView.ItemType = {
	Other = 2,
	My = 1
}

function RememberTheaterRightView:ctor()
	RememberTheaterRightView.super.ctor(self)

	self._prize = {}
	self._curContent = 0
	self._curTableId = 1
	self._isEnterFrist = true
end

function RememberTheaterRightView:buildUI()
	RememberTheaterRightView.super.buildUI(self)

	self._itemMy = self:getGo("item_my")

	self._itemMy:SetActive(false)

	self._itemOther = self:getGo("item_other")

	self._itemOther:SetActive(false)

	self._prizeBtnGo = self:getGo("btnReward")
	self._prizeBtn = self:getBtn("btnReward")
	self._item1Go = self:getGo("item_1")
	self._item1ReceiveGo = self:getGo("item_1/receive")
	self._item1Img = self:getGo("item_1/con")
	self._item1Effect = self:getGo("item_1/effect")
	self._item2Go = self:getGo("item_2")
	self._item2ReceiveGo = self:getGo("item_2/receive")
	self._item2Img = self:getGo("item_2/con")
	self._item2Effect = self:getGo("item_2/effect")
	self._emptyTips = self:getGo("emptyTips")
end

function RememberTheaterRightView:destroyUI()
	RememberTheaterRightView.super.destroyUI(self)
end

function RememberTheaterRightView:bindEvents()
	RememberTheaterRightView.super.bindEvents(self)
	self._prizeBtn:AddClickListener(self._onPrizeBtnClick, self)
end

function RememberTheaterRightView:unbindEvents()
	RememberTheaterRightView.super.unbindEvents(self)
	self._prizeBtn:RemoveClickListener()
end

function RememberTheaterRightView:onEnter()
	RememberTheaterRightView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RememberTheaterChangePage, self._refreshRight, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._PM_ActivitySummaryGetTaskInfo, self)

	self._isEnterFrist = true
	self._curTableId = 1

	local summaryId = 17042

	self._isEnterFrist = true

	OpSummaryModel.instance:sendGetAllTask(summaryId)
end

function RememberTheaterRightView:onExit()
	RememberTheaterRightView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RememberTheaterChangePage, self._refreshRight, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._PM_ActivitySummaryGetTaskInfo, self)
	removetimer(self._showNextChat, self)
	MaterialMgr.resetAll(self._item1Img)
	MaterialMgr.resetAll(self._item2Img)

	if self._effectHandler1 then
		UIEffectManager.instance:stopEffect(self._effectHandler1)
	end

	if self._effectHandler2 then
		UIEffectManager.instance:stopEffect(self._effectHandler2)
	end
end

function RememberTheaterRightView:_getPath()
	return {
		cellPath = "item_my",
		viewPath = "chatView"
	}
end

function RememberTheaterRightView:_cellAtIndex(view, idx)
	local cell
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	if not cell then
		cell = view:AddChild(self:_getPrefabByTag(tag), tag)

		self:initCell(cell)
	end

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function RememberTheaterRightView:_updateCell(view, cell, data)
	local content = goutil.findChildTextComponent(cell.gameObject, "ImgC_ContentBg/TxtC_Content")
	local headIcon = goutil.findChild(cell.gameObject, "Nego_Icon/ImgC_Icon")

	content.text = data.content

	local iconPath = GameUrl.getCharacterIconUrl(data.headIcon)

	uGuiUtil.setSpriteToImage(headIcon, nil, iconPath)
end

function RememberTheaterRightView:_clearTableview(cell)
	local headIcon = goutil.findChild(cell.gameObject, "Nego_Icon/ImgC_Icon")
end

function RememberTheaterRightView:_refreshRight(id)
	self._emptyTips:SetActive(false)

	self._storyIndex = 1

	removetimer(self._showNextChat, self)

	self._curTableId = id
	self._isRead = RememberTheaterModel.instance:getIsChapterRead(id)

	RememberTheaterModel.instance:setIsChapterRead(id)

	self._curViewDatas = {}
	self._curStoryDatas = {}

	if self._isRead then
		self._curViewDatas = RememberTheaterConfig.instance:getStoryCfgByTableId(id)
	else
		self._curStoryDatas = RememberTheaterConfig.instance:getStoryCfgByTableId(id)

		settimer(1, self._showNextChat, self, isRepeat)
		self:_showNextChat()
	end

	self:_showPrize(self._isRead)
	self:reloadData()
end

function RememberTheaterRightView:_onReloadFinish()
	if self._curViewDatas and #self._curViewDatas > 1 then
		self:moveCellToCenter(#self._curViewDatas)
	end
end

function RememberTheaterRightView:_getCellTag(data)
	if data.position == 1 then
		return RememberTheaterRightView.ItemType.My
	elseif data.position == 2 then
		return RememberTheaterRightView.ItemType.Other
	end

	return nil
end

function RememberTheaterRightView:_getPrefabByTag(tag)
	if tag == RememberTheaterRightView.ItemType.My then
		return self._itemMy
	elseif tag == RememberTheaterRightView.ItemType.Other then
		return self._itemOther
	end

	return nil
end

function RememberTheaterRightView:_showNextChat()
	if self._curStoryDatas and self._curStoryDatas[self._storyIndex] then
		local lastChat = self._curStoryDatas[self._storyIndex]

		self._storyIndex = self._storyIndex + 1

		table.insert(self._curViewDatas, lastChat)
		self:reloadData()

		if not self._curStoryDatas[self._storyIndex] then
			self:_showPrize(true)
		end
	else
		removetimer(self._showNextChat, self)
	end

	if self._curViewDatas and #self._curViewDatas > 1 then
		self:moveCellToCenter(#self._curViewDatas)
	end
end

function RememberTheaterRightView:_showPrize(status)
	if RememberTheaterModel.instance:getIsGetPrize(self._curTableId) then
		self._prizeBtnGo:SetActive(false)
		self._item1ReceiveGo:SetActive(true)
		self._item2ReceiveGo:SetActive(true)
	else
		self._prizeBtnGo:SetActive(status)
		self._item1ReceiveGo:SetActive(false)
		self._item2ReceiveGo:SetActive(false)
	end

	self:_setReward()
	self._item1Go:SetActive(status)
	self._item2Go:SetActive(status)
end

function RememberTheaterRightView:_onPrizeBtnClick()
	if RememberTheaterModel.instance:getIsGetPrize(self._curTableId) then
		return
	end

	local cfg = RememberTheaterConfig.instance:getTabCfg(self._curTableId)
	local params = string.split(cfg.taskParams, ",")
	local taskPlanId = checknumber(params[1])
	local id = checknumber(params[2])

	ActivitySummaryAgent.instance:sendPM_ActivitySummaryGainTaskPrizeReq(taskPlanId, id)
end

function RememberTheaterRightView:_setReward()
	local cfg = RememberTheaterConfig.instance:getTabCfg(self._curTableId)
	local params = string.split(cfg.taskParams, ",")
	local taskPlanId = checknumber(params[1])
	local id = checknumber(params[2])
	local prizeCfg = OperationSummaryConfig.instance:getTaskDetailsCfgById(taskPlanId, id)
	local prizeParams = string.split(prizeCfg.prize, "#")
	local isCanGain = RememberTheaterModel.instance:isCanGainPrize(self._curTableId)
	local effName = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

	self._effectHandler1 = self:_setRewardItem(self._item1Img, self._item1Effect, prizeParams[1], isCanGain, self._effectHandler1, effName)
	self._effectHandler2 = self:_setRewardItem(self._item2Img, self._item2Effect, prizeParams[2], isCanGain, self._effectHandler2, effName)
end

function RememberTheaterRightView:_PM_ActivitySummaryGetTaskInfo()
	if self._isEnterFrist then
		if not RememberTheaterModel.instance:isLockChapter(self._curTableId) then
			self:_refreshRight(self._curTableId)
		else
			self._curViewDatas = {}

			self:reloadData()
			self._emptyTips:SetActive(true)
			self._item1Go:SetActive(false)
			self._item2Go:SetActive(false)
			self._prizeBtnGo:SetActive(false)
		end

		self._isEnterFrist = false
	elseif self._curTableId then
		self:_showPrize(true)
	end
end

function RememberTheaterRightView:_setRewardItem(itemGo, effectGo, param, isCanGain, effectHandler, effName)
	MaterialMgr.resetAll(itemGo)

	if effectHandler then
		UIEffectManager.instance:stopEffect(effectHandler)

		effectHandler = nil
	end

	if param then
		if isCanGain then
			effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

			effectHandler:setParent(effectGo.transform)
			effectHandler:setLocalPos(0, 0, 0)
			effectHandler:setScale(1)
		elseif effectHandler then
			UIEffectManager.instance:stopEffect(effectHandler)

			effectHandler = nil
		end

		local proxy = MaterialMgr.setCellByCfg(param, itemGo)

		if proxy then
			if isCanGain then
				proxy.binder:setCallBack(function()
					self:_onPrizeBtnClick()
				end)
			else
				proxy.binder:setCallBack(nil)
			end

			proxy.binder:setAutoTips(not isCanGain)
		end
	end

	return effectHandler
end

return RememberTheaterRightView
