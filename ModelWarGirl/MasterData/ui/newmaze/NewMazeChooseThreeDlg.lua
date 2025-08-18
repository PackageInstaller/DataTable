-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeChooseThreeDlg.lua

local ResNewMazeTreasure = require("ClientData/ResNewMazeTreasure")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local ResNewMaze = require("ClientData/ResNewMaze")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local NewMazeGridCard = require("UI/NewMaze/NewMazeGridCard")
local NewMazeLosderMixin = require("UI/NewMaze/NewMazeLosderMixin")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "NewMazeChooseThreeDlg"
local NewMazeChooseThreeDlg = Class(strClassName, UIControls.Window)

MixinClass(NewMazeChooseThreeDlg, NewMazeLosderMixin)

function NewMazeChooseThreeDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function NewMazeChooseThreeDlg:initUI()
	self.chooseThreeCardPanel = UIControls.Image(self, "MainInfoPanel/ChooseThreeCardPanel")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/StoreInfoPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.losderPanel = UIControls.Panel(self, "MainInfoPanel/LosderPanel")
	self.textRule = UIControls.Label(self, "MainInfoPanel/StoreInfoPanel/TextRule")
	self.textTitle = UIControls.Label(self, "MainInfoPanel/TextTitle")
	self.awardCellList = {}
end

function NewMazeChooseThreeDlg:setData(awardList, notifyType, awardType)
	self.notifyType = notifyType
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj and self.actObj:isValid() then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	self.awardList = awardList
	self.awardType = self.awardType or self.awardList[1].type
	self.miscData = self.actObj.actData.miscData

	if self.awardType then
		if self.awardType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
			self.titleStr = ResNewMazeDisplay[13060011].desc
			self.ruleStr = ResNewMazeDisplay[13060010].desc
		elseif self.awardType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic then
			local relicId = self.awardList[1].id

			if ResNewMazeRelic[relicId] and ResNewMazeRelic[relicId].hero_exclusive_id then
				self.titleStr = ResNewMazeDisplay[13060056].desc
				self.ruleStr = ResNewMazeDisplay[13060054].desc
			else
				self.titleStr = ResNewMazeDisplay[13060012].desc
				self.ruleStr = ResNewMazeDisplay[13060053].desc
			end
		elseif self.awardType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo then
			self.titleStr = ResNewMazeDisplay[13060013].desc
			self.ruleStr = ResNewMazeDisplay[13060055].desc
		elseif self.awardType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Coin then
			self.titleStr = ResNewMazeDisplay[13060059].desc
			self.ruleStr = ResNewMazeDisplay[13060058].desc
		end
	end

	self.textTitle:setText(self.titleStr or "")
	self.textRule:setText(self.ruleStr or "")

	for i, itemData in ipairs(self.awardList or {}) do
		local item = self.awardCellList[i]

		if self.awardCellList[i] == nil then
			item = NewMazeGridCard(self, "MainInfoPanel/ChooseThreeCardPanel", "System/Rogue/BtnGridRogueCard", 0, 0, true)
		end

		local awardIndex = i

		item:setData(itemData, Const.NEW_MAZE_TREASURE_CARD, awardIndex)

		item.chooseClick = Slot(self.chooseClick, self)
		self.awardCellList[i] = item
	end

	self:refreshFettersUI()
end

function NewMazeChooseThreeDlg:flyImageToUI()
	local iconPath = "Atlas/CommonAtlas/IconAtlas/MazeBuffAtlas/03"
	local iconName = "4031"
	local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

	if mainDlg then
		mainDlg:refreshUI()

		local originUI, targetUI

		if self.curChooseItem then
			for i, itemData in ipairs(self.awardList or {}) do
				if self.curChooseItem.type == itemData.type and self.curChooseItem.id == itemData.id then
					originUI = self.awardCellList[i]
				end
			end

			if self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
				targetUI = mainDlg.btnHero

				local hero = BaseObject.GetObject(self.curChooseItem.id)
				local iconHeroPath = hero:getIconPath()

				iconPath = iconHeroPath[1]
				iconName = iconHeroPath[2]
			elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic then
				targetUI = mainDlg.btnHallow
				iconPath = ResNewMazeRelic[self.curChooseItem.id].icon_path
				iconName = ResNewMazeRelic[self.curChooseItem.id].icon_name
			elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo then
				targetUI = mainDlg.btnHalo
				iconPath = ResNewMazeHalo[self.curChooseItem.id].icon_path
				iconName = ResNewMazeHalo[self.curChooseItem.id].icon_name
			elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Coin then
				targetUI = mainDlg.btnGold

				local itemId = self.newMazeData.miscData.coin_item_id
				local item = BaseObject.GetObject(itemId)
				local iconItemPath = item:getIconPath()

				iconPath = iconItemPath[1]
				iconName = iconItemPath[2]
			end
		end

		FlyIconUtils.setFlyImagetoUI(originUI, targetUI, iconPath, iconName, 1)
	end
end

function NewMazeChooseThreeDlg:chooseClick()
	if self.curChooseItem.index then
		for i, cell in ipairs(self.awardCellList or {}) do
			cell.imgSel:setVisible(self.curChooseItem.index == i)
		end
	end
end

function NewMazeChooseThreeDlg:onBtnConfirmClick()
	if self.curChooseItem then
		RPC.newMazeMultiAwardSelect(self.actObj.opId, self.curChooseItem.index)
	else
		MsgManager.notice(Lang.get(65462))
	end
end

local CanvasType = typeof(UnityEngine.Canvas)

function NewMazeChooseThreeDlg:setCanvasSorting()
	local go = self.losderPanel:getGameObject()
	local canvs = go:GetComponent(CanvasType)

	if canvs then
		canvs.overrideSorting = true
		canvs.sortingOrder = 44
	end
end

function NewMazeChooseThreeDlg:onClosePanel()
	local randomDetailDlg = UIManager.tryGetUI("newMazeRandomDetailDlg")

	if randomDetailDlg then
		randomDetailDlg:refreshUI(true)
		randomDetailDlg:playShowAni()
	elseif self.notifyType and self.notifyType == Const.NEW_MAZE_MULTI_AWARD_NOTIFY_TYPE.Feature then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:refreshFettersUI()
		end
	else
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			RPC.newMazeLayerNextReq(actObj.opId)
		end
	end

	self:setVisible(false)
end

return NewMazeChooseThreeDlg
