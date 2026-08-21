-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoRebornPanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local HeroGridBloodCard = require("UI/Maze/HeroGridBloodCard")
local strClassName = "MazeLvInfoRebornPanel"
local MazeLvInfoRebornPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoRebornPanel, MazeNodePanelMixin, true)

function MazeLvInfoRebornPanel:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function MazeLvInfoRebornPanel:initUI(...)
	self.panelHero = UIControls.ScrollViewLoopV(self, "FrontPanel/SelectPanel/HeroList", 0, self.onCellChanged)
	self.panelNoContent = UIControls.Panel(self, "FrontPanel/SelectPanel/NoContent")

	self.btnFunc:setText(Lang.get(1497))

	self.heroCells = {}
	self.choosingHero = nil
end

function MazeLvInfoRebornPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)

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
	self.panelHero:setTotalCount(#self.data)

	if #self.data == 0 then
		self.btnFunc:setText(Lang.get(8))
		self.panelNoContent:setVisible(true)
	end
end

function MazeLvInfoRebornPanel:onBtnFuncClick(...)
	if #self.data == 0 then
		self.mWindow:hide()
		RPC.mazeSelectBranch(self.branchIndex)
	elseif self.choosingHero then
		RPC.mazeSelectBranch(self.branchIndex, self.choosingHero.gid)
		MsgManager.notice(string.format(Lang.get(30587), self.choosingHero.name))
		self.mWindow:hide()
	else
		MsgManager.notice(Lang.get(30588))
	end
end

function MazeLvInfoRebornPanel:selectHeroCell(sender)
	self.choosingHero = sender.hero

	self.btnFunc:setText(Lang.get(1497))

	for _, cell in ipairs(self.heroCells) do
		if cell ~= sender then
			cell:setChooseState(false)
		else
			cell:setChooseState(true)
		end
	end
end

function MazeLvInfoRebornPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeroGridBloodCard(sender, "System/Hero/GridHeroCardBlood", newIdx, 0, 0)

		table.insert(self.heroCells, targetCell)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setHero(self.data[newIdx])

	targetCell.showTips = false
	targetCell.showSelPic = true

	targetCell:setSelectCallback(Slot(self.selectHeroCell, self))
end

return MazeLvInfoRebornPanel
