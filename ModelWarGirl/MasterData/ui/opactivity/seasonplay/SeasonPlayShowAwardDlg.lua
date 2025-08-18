-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayShowAwardDlg.lua

local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local SeasonPlayShowAwardCell = Class("SeasonPlayShowAwardCell", UIControls.Child)
local FlyIconUtils = require("UI/Common/FlyIconUtils")

function SeasonPlayShowAwardCell:ctor(...)
	self:initUI()
end

function SeasonPlayShowAwardCell:initUI(...)
	self.gridAward = UIControls.Panel(self, "GridAward")
	self.aniGrid = UIControls.UIAni(self, "")

	self.aniGrid:addEventFinish(self.aniFinishCallBack)

	self.bgGashaponTop = UIControls.Image(self, "BgGashaponTop")
	self.bgGashaponBottom = UIControls.Image(self, "BgGashaponBottom")
	self.bgGashapon = UIControls.Image(self, "BgGashapon")
end

function SeasonPlayShowAwardCell:setData(data)
	self.data = data

	if not self.gridContainer then
		self.gridContainer = UIControls.GridNameContainerChild(self, "GridAward", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)
	end

	self.gridAward:setVisible(true)
	self.gridContainer:setVisible(true)

	self.item = BaseObject.GetObject(self.data.item.id, self.data.item.common_param)

	self.gridContainer:setObj(self.item)

	if self.gridContainer.efx then
		self.gridContainer.efx:setVisible(false)
	end

	local showData = CurAvatar:getItemSeasonDrawShowData(self.data.item.id)

	self.quality = Const.SEASON_DRAW_ITEM_QUALITY_BlUE

	if showData and showData.quality then
		local imgName, imgTName, imgBName

		self.mParent:showCellEfx(self.index, showData.quality)

		local iconPath = "Atlas/SeasonPlayCommon/SeasonPlayCommonAtlas04"

		if showData.quality == Const.SEASON_DRAW_ITEM_QUALITY_YELLOW then
			self.quality = showData.quality
			imgName = "IconSeasonPlay02"
			imgBName = "IconSeasonPlay05"
			imgTName = "IconSeasonPlay08"
		elseif showData.quality == Const.SEASON_DRAW_ITEM_QUALITY_RED then
			self.quality = showData.quality
			imgName = "IconSeasonPlay03"
			imgBName = "IconSeasonPlay06"
			imgTName = "IconSeasonPlay09"
		else
			imgName = "IconSeasonPlay01"
			imgBName = "IconSeasonPlay04"
			imgTName = "IconSeasonPlay07"
		end

		self.bgGashaponTop:setImage(iconPath, imgTName)
		self.bgGashaponBottom:setImage(iconPath, imgBName)
		self.bgGashapon:setImage(iconPath, imgName)
	end

	self:playResetAni()
end

function SeasonPlayShowAwardCell:playCellAni(...)
	if self.quality == Const.SEASON_DRAW_ITEM_QUALITY_RED then
		self.aniGrid:startAni("ShowGridSeasonPlayHighest", true)
	elseif self.quality == Const.SEASON_DRAW_ITEM_QUALITY_YELLOW then
		self.aniGrid:startAni("ShowGridSeasonPlaySpe", true)
	else
		self.aniGrid:startAni("ShowGridSeasonPlay", true)
	end
end

function SeasonPlayShowAwardCell:aniFinishCallBack(animName)
	if animName ~= "ResetGridSeasonPlay" and self.data.change_item and self.data.change_item.id and self.data.change_item.id ~= 0 then
		local item = BaseObject.GetObject(self.data.change_item.id, self.data.change_item.common_param)

		if item then
			self.gridContainer:playTransItemEfx(item)
		end
	end
end

function SeasonPlayShowAwardCell:playResetAni()
	self.aniGrid:startAni("ResetGridSeasonPlay", true)
end

local SeasonPlayShowAwardDlg = Class("SeasonPlayShowAwardDlg", UIControls.Window)
local drawNum = 5

function SeasonPlayShowAwardDlg:ctor(...)
	self:initUI()
end

function SeasonPlayShowAwardDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnAgain = UIControls.Button(self, "BtnPanel/BtnAgain")

	self.btnAgain:addEventClick(self.onBtnAgainClick)

	self.iconBtnAgain = UIControls.Image(self, "BtnPanel/BtnAgain/Icon")
	self.txtNumBtnAgain = UIControls.Label(self, "BtnPanel/BtnAgain/TextNum")
	self.cells = {}
	self.gridSeasonPlay = UIControls.Panel(self, "SeasonPlayListPanel/GridSeasonPlay1")
	self.gridTargets = {}
	self.disableFly = {}

	for index = 1, 5 do
		local path = "SeasonPlayListPanel/GridSeasonPlay" .. index

		self.gridSeasonPlay[index] = UIControls.Panel(self, path)
	end

	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventAnimateCue(self.onAnimateCue)

	self.efxs = {}
end

function SeasonPlayShowAwardDlg:showCellEfx(index, quality)
	if index and self.cells and self.cells[index] and self.efxs[index] then
		if quality == Const.SEASON_DRAW_ITEM_QUALITY_YELLOW then
			self.efxs[index]:playEffectByPath("Effects/UI/efx_ui_SeasonPlayShowAward_Gold.prefab")
		elseif quality == Const.SEASON_DRAW_ITEM_QUALITY_RED then
			self.efxs[index]:playEffectByPath("Effects/UI/efx_ui_SeasonPlayShowAward_Pink.prefab")
		else
			self.efxs[index]:playEffectByPath("Effects/UI/efx_ui_SeasonPlayShowAward_blue.prefab")
		end
	end
end

function SeasonPlayShowAwardDlg:setData(awards)
	local num = 0

	self.gridSeasonPlay1 = UIControls.Panel(self, "SeasonPlayListPanel/GridSeasonPlay1")
	self.awards = awards

	for index, data in ipairs(awards or {}) do
		self.gridSeasonPlay[index]:setVisible(true)

		num = index

		local path = "SeasonPlayListPanel/GridSeasonPlay" .. index

		if not self.cells[index] then
			self.cells[index] = SeasonPlayShowAwardCell(self, path, "System/SeasonPlayCommon/GridSeasonPlayAward")
			self.efxs[index] = UIControls.LazyEffectPlayer(self, path .. "/EfxFlash/Efx")
			self.cells[index].index = index
		end

		self.cells[index]:setVisible(true)
		self.cells[index]:setData(data)
	end

	for index = num + 1, 5 do
		self.gridSeasonPlay[index]:setVisible(false)

		if self.cells[index] then
			self.cells[index]:setVisible(false)
		end
	end

	if num > 1 then
		if self.coinItemId and CurAvatar:getItemNumById(self.coinItemId) >= 5 then
			self.btnAgain:setVisible(true)
		else
			self.btnAgain:setVisible(false)
		end
	else
		self.btnAgain:setVisible(false)
	end

	self.aniSelf:startAni("ShowSeasonPlayResultGridCanvas", true)
end

function SeasonPlayShowAwardDlg:setDrawData(actId, coinItemId)
	self.actId = actId
	self.coinItemId = coinItemId

	local iconData = BaseObject.getItemIconPath(self.coinItemId)

	if iconData then
		self.iconBtnAgain:setImage(iconData[1], iconData[2])
		self.txtNumBtnAgain:setText(drawNum)
	end
end

function SeasonPlayShowAwardDlg:onAnimateCue(aniCom, eventKey)
	if eventKey == "ShowSeasonPlay" then
		for index, data in ipairs(self.awards or {}) do
			self.cells[index]:playCellAni()
		end
	end
end

function SeasonPlayShowAwardDlg:onBtnCloseClick()
	self.aniSelf:startAni("SeasonPlayResultGridCanvas", true)
	self:setVisible(false)
end

function SeasonPlayShowAwardDlg:onBtnAgainClick()
	local isCloseAnimation = CurAvatar:getClientUserData("SeasonDrawMainAnimation")

	if not isCloseAnimation or isCloseAnimation ~= "1" then
		self:setVisible(false)
	end

	DrawCardUtils.realDrawOpActCard(self.actId, drawNum, Const.DrawCostTypeItem, self.coinItemId, drawNum)
end

function SeasonPlayShowAwardDlg:hideBtnAgain(...)
	self.btnAgain:setVisible(false)
end

function SeasonPlayShowAwardDlg:disableFlyConfig(id, state)
	self.disableFly[id] = state
end

function SeasonPlayShowAwardDlg:setSpecialCustomizeFlyConfig(id, targetUIObj)
	self.gridTargets[id] = targetUIObj
end

function SeasonPlayShowAwardDlg:onClose(...)
	for _, grid in ipairs(self.cells or {}) do
		local data = grid.data
		local itemData

		if data.change_item and data.change_item.id ~= 0 then
			itemData = data.change_item
		else
			itemData = data.item
		end

		local itemId = itemData.id
		local itemNum = itemData.common_param

		if not self.disableFly[itemId] and self.gridTargets[itemId] then
			FlyIconUtils.setFlyUItoUI(grid.gridContainer, self.gridTargets[itemId], itemId, itemNum, nil, self.endCB)
		end
	end

	local ui = UIManager.tryGetUI("seasonPlaySkinPoolDlg")

	if ui and ui:getVisible() then
		ui:checkGetSkinShow()
	end

	SeasonPlayShowAwardDlg.super.onClose(self)
end

return SeasonPlayShowAwardDlg
