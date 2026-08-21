-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeRebornDlg.lua

local HeroGridBloodCard = require("UI/Maze/HeroGridBloodCard")
local ResMazeMisc = require("ClientData/ResMazeMisc")
local ResColor = require("ClientData/ResColor")
local strClassName = "MazeRebornDlg"
local MazeRebornDlg = Class(strClassName, UIControls.Window)
local REBORN_ITEM_ID = ResMazeMisc[1].relive_gid
local ICON_PATH = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas"

function MazeRebornDlg:ctor(...)
	self:initUI()
	self:initData()
	self:refreshItem()
end

function MazeRebornDlg:initUI(...)
	self.imgIcon = UIControls.Image(self, "BgPanel/CostPanel/Icon")

	self.imgIcon:setImage(ICON_PATH, "IconMazeReborn")

	self.txtNumTotal = UIControls.Label(self, "BgPanel/CostPanel/TextNumTotal")
	self.txtNum = UIControls.Label(self, "BgPanel/CostPanel/TextNum")
	self.panelEmptyTip = UIControls.Panel(self, "BgPanel/NoContent")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelHero = UIControls.ScrollViewLoopV(self, "BgPanel/HeroList", 0, self.onCellChanged)
end

function MazeRebornDlg:initData(...)
	self.data = {}

	for _, hero in ipairs(CurAvatar.mazeData.record) do
		local mHero = CurAvatar.heroDic[hero.gid]

		if mHero and not mHero:isFullHp() then
			table.insert(self.data, CurAvatar.heroDic[hero.gid])
		end
	end

	table.sort(self.data, function(v1, v2)
		if v1.mazeHp ~= v2.mazeHp then
			return v1.mazeHp < v2.mazeHp
		elseif v1.step ~= v2.step then
			return v1.step > v2.step
		elseif v1.level ~= v2.level then
			return v1.level > v2.level
		else
			return v1.quality > v2.quality
		end
	end)

	if #self.data == 0 then
		self.panelEmptyTip:setVisible(true)
	else
		self.panelHero:setTotalCount(#self.data)
		self.panelEmptyTip:setVisible(false)
	end
end

function MazeRebornDlg:refreshItem(...)
	self.itemCount = CurAvatar:getItemNumById(REBORN_ITEM_ID)

	self.txtNumTotal:setText(self.itemCount)
	self.txtNum:setText(1)

	if self.itemCount <= 0 then
		self.txtNumTotal:setFontColor(ResColor.RED)
	end
end

function MazeRebornDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeroGridBloodCard(sender, "System/Hero/GridHeroCardBlood", newIdx, 0, 0)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setHero(self.data[newIdx])

	targetCell.showTips = false
	targetCell.showSelPic = true
end

function MazeRebornDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function MazeRebornDlg:onBtnConfirmClick(...)
	if #self.data > 0 then
		if self.itemCount > 0 then
			RPC.mazeRelive(CurAvatar.mazeData.maze_id)
			MsgManager.notice(Lang.get(30593))
			self:setVisible(false)
		else
			local fakeItem = BaseObject.GetObject(REBORN_ITEM_ID)

			UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem)
		end
	else
		MsgManager.notice(Lang.get(30594))
		self:setVisible(false)
	end
end

return MazeRebornDlg
