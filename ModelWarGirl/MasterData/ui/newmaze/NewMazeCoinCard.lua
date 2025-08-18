-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeCoinCard.lua

local ResNewMazeDeBuff = require("ClientData/ResNewMazeDeBuff")
local ResNewMazeEnchanter = require("ClientData/ResNewMazeEnchanter")
local strClassName = "NewMazeCoinCard"
local NewMazeCoinCard = Class(strClassName, UIControls.Child)

function NewMazeCoinCard:ctor()
	self:initUI()
end

function NewMazeCoinCard:initUI()
	self.textTitle = UIControls.Label(self, "BgTextTitle/TextTitle")
	self.gridPanel = UIControls.Panel(self, "GridPanel")
	self.panelExtra = UIControls.Panel(self, "InfoPanel")
	self.imgBg = UIControls.Image(self, "Bg")
	self.panelBuff = UIControls.Panel(self, "InfoPanel/BuffPanel")
	self.imgBuffIcon = UIControls.Image(self, "InfoPanel/BuffPanel/IconBuff")
	self.textBuffDesc = UIControls.Label(self, "InfoPanel/BuffPanel/BgTextDec/TextBuff")
	self.panelSolder = UIControls.Panel(self, "InfoPanel/EnchantPanel")
	self.imgSolderIcon = UIControls.Image(self, "InfoPanel/EnchantPanel/IconEnchant")
	self.textSolderDesc = UIControls.Label(self, "InfoPanel/EnchantPanel/BgTextDec/TextEnchant")
	self.panelSolderEnchanter = UIControls.Panel(self, "InfoPanel/EnchantPanel/Img")
end

function NewMazeCoinCard:getIconPath()
	return self.iconPath
end

function NewMazeCoinCard:setData(itemId, num, itemType)
	if itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Buff then
		self.panelExtra:setVisible(true)
		self.panelBuff:setVisible(true)
		self.panelSolder:setVisible(false)

		self.resData = ResNewMazeDeBuff[itemId]

		self.imgBuffIcon:setImage(self.resData.icon_path, self.resData.icon_name)
		self.textBuffDesc:setText(self.resData.buff_desc)
		self.textTitle:setText(self.resData.buff_name)

		self.iconPath = {
			self.resData.icon_path,
			self.resData.icon_name
		}
	elseif itemType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Solder then
		self.panelExtra:setVisible(true)
		self.panelBuff:setVisible(false)
		self.panelSolder:setVisible(true)

		self.resData = ResNewMazeEnchanter[itemId]

		self.panelSolderEnchanter:setVisible(self.resData.type == 1)
		self.imgSolderIcon:setImage(self.resData.iconPath, self.resData.icon)
		self.textSolderDesc:setText(self.resData.desc)
		self.textTitle:setText(self.resData.name)

		self.iconPath = {
			self.resData.iconPath,
			self.resData.icon
		}
	else
		self.panelExtra:setVisible(false)

		if self.grid == nil then
			self.grid = UIControls.getGridContainer(self, "GridPanel")
		end

		local coinItem = BaseObject.GetObject(itemId, num)

		self.textTitle:setText(string.format(Lang.get(102593), coinItem.name or ""))
		self.grid:setObj(coinItem)

		self.grid.mDisableWays = true

		self.grid:setVisible(true)

		self.iconPath = coinItem:getIconPath()
	end
end

function NewMazeCoinCard:setItemQuality(quality)
	if quality == 1 then
		self.imgBg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder02", "BgGoldCardBlue")
	elseif quality == 2 then
		self.imgBg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder02", "BgGoldCardYellow")
	else
		self.imgBg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder02", "BgGoldCardPink")
	end
end

local CanvasType = typeof(UnityEngine.Canvas)

function NewMazeCoinCard:setCanvasSorting()
	local gridPanelObj = self.gridPanel:getGameObject()
	local gridPanelCanvs = gridPanelObj:GetComponent(CanvasType)

	if gridPanelCanvs then
		gridPanelCanvs.overrideSorting = true
		gridPanelCanvs.sortingOrder = 41
	end
end

return NewMazeCoinCard
