-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeRandomWinDlg.lua

local HeroGridSolderCard = require("UI/NewMaze/HeroGridSolderCard")
local NewMazeShopHallowCard = require("UI/NewMaze/NewMazeShopHallowCard")
local NewMazeShopHaloCard = require("UI/NewMaze/NewMazeShopHaloCard")
local NewMazeShopHeroCard = require("UI/NewMaze/NewMazeShopHeroCard")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "NewMazeRandomWinDlg"
local NewMazeRandomWinDlg = Class(strClassName, UIControls.Window)

function NewMazeRandomWinDlg:ctor(...)
	self:initUI()
end

function NewMazeRandomWinDlg:initUI()
	self.textDes = UIControls.Label(self, "BgPanel/BgResultDes/TextDes")
	self.awardHeroPanel = UIControls.Panel(self, "BgPanel/AwardHeroPanel")
	self.awardPanel = UIControls.Panel(self, "BgPanel/AwardPanel")
	self.awardHalloOrHaloPanel = UIControls.Panel(self, "BgPanel/AwardHalloOrHaloPanel")
	self.btnResult = UIControls.Button(self, "BgPanel/BtnResult")

	self.btnResult:addEventClick(self.onBtnResultClick)
end

function NewMazeRandomWinDlg:setData(items)
	for i, item in pairs(items) do
		if item.num > 0 then
			self.itemType = item.type
		end
	end

	self.awardHeroPanel:setVisible(self.itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero)
	self.awardPanel:setVisible(self.itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Coin)
	self.awardHalloOrHaloPanel:setVisible(self.itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo or self.itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic)

	if self.itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
		for i, item in pairs(items) do
			if item.num > 0 then
				local heroId = item.id
				local heroCard = NewMazeShopHeroCard(self, "BgPanel/AwardHeroPanel", "System/Common/Grid/GridRogueHeroCard", 0, 0, true)

				heroCard:setData(heroId)
			end
		end

		self.textDes:setText(ResNewMazeDisplay[13060025].desc)
	elseif self.itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic then
		for i, item in pairs(items) do
			if item.num > 0 then
				local hallowCard = NewMazeShopHallowCard(self, "BgPanel/AwardHalloOrHaloPanel", "System/Common/Grid/GridRogueHallowCard", 0, 0, true)

				hallowCard:setData(item.id)
			end
		end

		self.textDes:setText(ResNewMazeDisplay[13060026].desc)
	elseif self.itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo then
		for i, item in pairs(items) do
			if item.num > 0 then
				local haloCard = NewMazeShopHaloCard(self, "BgPanel/AwardHalloOrHaloPanel", "System/Common/Grid/GridRogueHaloCard", 0, 0, true)

				haloCard:setData(item.id)
			end
		end

		self.textDes:setText(ResNewMazeDisplay[13060027].desc)
	else
		for i, item in pairs(items) do
			if item.num > 0 then
				local fakeItem = BaseObject.GetObject(item.id, item.num)
				local itemGrid = UIControls.ItemGridChild(self, "BgPanel/AwardPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)

				itemGrid:setObj(fakeItem)
			end
		end

		self.textDes:setText(ResNewMazeDisplay[13060028].desc)
	end
end

function NewMazeRandomWinDlg:onBtnResultClick()
	local randomDetailDlg = UIManager.tryGetUI("newMazeRandomDetailDlg")

	if randomDetailDlg then
		randomDetailDlg:refreshUI(true)
		randomDetailDlg:playShowAni()
	else
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			RPC.newMazeLayerNextReq(actObj.opId)
		end
	end

	self:setVisible(false)
end

return NewMazeRandomWinDlg
