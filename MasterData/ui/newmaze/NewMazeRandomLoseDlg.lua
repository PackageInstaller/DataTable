-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeRandomLoseDlg.lua

local HeroGridSolderCard = require("UI/NewMaze/HeroGridSolderCard")
local DebuffGrid = require("UI/NewMaze/DebuffGrid")
local DebuffTipsInfoPanel = require("UI/NewMaze/DebuffTipsInfoPanel")
local NewMazeShopHeroCard = require("UI/NewMaze/NewMazeShopHeroCard")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "NewMazeRandomLoseDlg"
local NewMazeRandomLoseDlg = Class(strClassName, UIControls.Window)

function NewMazeRandomLoseDlg:ctor(...)
	self:initUI()
end

function NewMazeRandomLoseDlg:initUI()
	self.textDes = UIControls.Label(self, "BgPanel/BgResultDes/TextDes")
	self.btnResult = UIControls.Button(self, "BgPanel/BtnResult", "Text")

	self.btnResult:addEventClick(self.onBtnResultClick)

	self.awardEmptyPanel = UIControls.Panel(self, "BgPanel/AwardEmptyPanel")
	self.awardPanel = UIControls.Panel(self, "BgPanel/AwardPanel")
	self.awardHeroPanel = UIControls.Panel(self, "BgPanel/AwardHeroPanel")
	self.awardDeBuffPanel = UIControls.Panel(self, "BgPanel/AwardDeBuffPanel")
	self.deBuffTipsPanel = UIControls.Panel(self, "BgPanel/AwardDeBuffPanel/DeBuffTipsPanel")
	self.uIClickThrough = UIControls.Button(self, "BgPanel/AwardDeBuffPanel/DeBuffTipsPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)
end

function NewMazeRandomLoseDlg:setData(items)
	local itemGetNum = 0
	local itemLoseId

	for i, item in pairs(items) do
		if item.num > 0 then
			itemGetNum = itemGetNum + 1
		else
			itemLoseId = item.id
		end
	end

	local actObj = CurAvatar:getNewMazeActivity()

	if not actObj or actObj.actData.randEventRemainTimes and actObj.actData.randEventRemainTimes > 0 then
		-- block empty
	else
		self.btnResult:setText(ResNewMazeDisplay[13060057].desc)
	end

	if itemGetNum == 0 then
		self.awardEmptyPanel:setVisible(true)
		self.awardPanel:setVisible(false)
		self.awardHeroPanel:setVisible(false)
		self.awardDeBuffPanel:setVisible(false)
		self.textDes:setText(ResNewMazeDisplay[13060030].desc)

		if itemLoseId then
			self.textDes:setText(ResNewMazeDisplay[13060031].desc)
		end
	else
		self.textDes:setText(ResNewMazeDisplay[13060029].desc)
		self.awardEmptyPanel:setVisible(false)

		for i, item in pairs(items) do
			if item.num > 0 then
				if item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
					local heroId = item.id

					self.awardHeroPanel:setVisible(true)

					local heroCard = NewMazeShopHeroCard(self, "BgPanel/AwardHeroPanel", "System/Common/Grid/GridRogueHeroCard", 0, 0, true)

					heroCard:setData(heroId)
				elseif item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Buff then
					self.awardDeBuffPanel:setVisible(true)

					local buffGrid = DebuffGrid(self, "BgPanel/AwardDeBuffPanel/DeBuffPanel", "System/Common/Grid/GridDeBuff", 0, 0, true)

					buffGrid:setData(item.id)
					buffGrid:setClickCallBack(Slot(self.onClickDebuff, self))

					self.debuffTipsInfoPanel = DebuffTipsInfoPanel(self, "BgPanel/AwardDeBuffPanel/DeBuffTipsPanel", "System/Common/Tips/DeBuffTipsInfoPanel")
				else
					self.awardPanel:setVisible(true)

					local fakeItem = BaseObject.GetObject(item.id, item.num)
					local itemGrid = UIControls.ItemGridChild(self, "BgPanel/AwardPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)

					itemGrid:setObj(fakeItem)
				end
			end
		end
	end
end

function NewMazeRandomLoseDlg:onClickDebuff(grid)
	self.debuffTipsInfoPanel:setData(grid.buffId)
	self.debuffTipsInfoPanel:setVisible(true)
	self.deBuffTipsPanel:setVisible(true)
end

function NewMazeRandomLoseDlg:onUIClickThroughClick()
	self.debuffTipsInfoPanel:setVisible(false)
	self.deBuffTipsPanel:setVisible(false)
end

function NewMazeRandomLoseDlg:onBtnResultClick()
	local randomDetailDlg = UIManager.tryGetUI("newMazeRandomDetailDlg")

	if randomDetailDlg then
		randomDetailDlg:refreshUI(false)
		randomDetailDlg:playShowAni()
	else
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			RPC.newMazeLayerNextReq(actObj.opId)
		end
	end

	self:setVisible(false)
end

return NewMazeRandomLoseDlg
