-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawNewbieLightChooseHeroDlg.lua

local Hero = require("Common/Object/Hero")
local DrawNewbieLightChooseHeroDlg = Class("DrawNewbieLightChooseHeroDlg", UIControls.Window)
local ChooseHeroCell = Class("NewbieLightChooseHeroCell", UIControls.Child)

function ChooseHeroCell:ctor(...)
	self:initUI()
end

function ChooseHeroCell:initUI(...)
	self.rootBtn = UIControls.Button(self, "BgCheck")

	self.rootBtn:addEventClick(self._onClickRoot)

	self.heroCellPanel = UIControls.Panel(self, "HeroPanel")
	self.chosenPanel = UIControls.Panel(self, "ChosenPanel")
	self.firstCheckTxt = UIControls.Label(self, "BgCheck/IconCheck/Bg/Text1")
	self.heroCheckTxt = UIControls.Label(self, "BgCheck/IconCheck/Bg/Text2")
	self.checkPanel = UIControls.Panel(self, "BgCheck/IconCheck")
end

function ChooseHeroCell:setHeroCell(isFirst, heroId)
	self.firstCheckTxt:setVisible(isFirst)
	self.heroCellPanel:setVisible(not isFirst)
	self.heroCheckTxt:setVisible(not isFirst)

	if not isFirst and heroId then
		self.heroGrid = UIControls.HeroGridChild(self, "HeroPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
		self.heroGrid.mEnableTips = true
		self.heroGrid.isShowPreviewTips = true

		local hero = Hero({
			resid = heroId
		})

		self.heroGrid:setObj(hero)
	end

	self.heroId = heroId

	local isSelected = utils.tableIsContainsElement(self.mParent.selectedHero, heroId)

	self.chosenPanel:setVisible(isSelected)
	self.checkPanel:setVisible(self.heroId == self.mParent.curSelectHeroId)
end

function ChooseHeroCell:_onClickRoot(...)
	if not self.chosenPanel:getVisible() and self.mParent.curSelectHeroId ~= self.heroId then
		self.mParent.curSelectHeroId = self.heroId

		for i, cell in ipairs(self.mParent.heroCells) do
			local isSelected = self.mParent.curSelectHeroId == cell.heroId

			cell.checkPanel:setVisible(isSelected)
		end
	end
end

function DrawNewbieLightChooseHeroDlg:ctor(...)
	self:initUI()
end

function DrawNewbieLightChooseHeroDlg:initUI(...)
	self.confirmBtn = UIControls.Button(self, "Bg/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickConfirm)

	self.upPanel = UIControls.Panel(self, "Bg/UpPanel")
	self.coreUpPanel = UIControls.Panel(self, "Bg/CoreUpPanel")
	self.heroCells = {}
	self.cellMountPath = "Bg/HeroChooseList/Content"
	self.slotOfRealConfirm = Slot(self._realConfirm, self)
end

function DrawNewbieLightChooseHeroDlg:initHeroChooseData(actObj, groupId, heroId)
	self.actObj = actObj
	self.groupId = groupId
	self.curSelectHeroId = heroId
	self.isMainUp = actObj.actData:isMainUpHeroGroup(groupId)
	self.heroIdList = actObj.actData:getAllSelectHeroIds(groupId)
	self.selectedHero = actObj.actData:getAllUpHeros()

	if heroId and heroId ~= 0 and utils.tableIsContainsElement(self.selectedHero, heroId) then
		for i, v in pairs(self.selectedHero) do
			if v == heroId then
				table.remove(self.selectedHero, i)
			end
		end
	end

	for i = 1, #self.heroIdList do
		local cell = self.heroCells[i]

		cell = cell or ChooseHeroCell(self, self.cellMountPath, "System/HeroPool/BtnGroupChooseHero2", 0, 0, true)

		local heroId = self.heroIdList[i]

		cell:setHeroCell(false, heroId)

		self.heroCells[i] = cell
	end

	self.upPanel:setVisible(not self.isMainUp)
	self.coreUpPanel:setVisible(self.isMainUp)
end

function DrawNewbieLightChooseHeroDlg:_onClickConfirm(...)
	if self.curSelectHeroId then
		-- block empty
	else
		MsgManager.notice(Lang.get(92478))

		return
	end

	self:_realConfirm()
end

function DrawNewbieLightChooseHeroDlg:_realConfirm()
	local selectHeroId = self.curSelectHeroId
	local opId, groupId, index = self.actObj.actData:getRandReplaceGroupAndIndex(self.groupId, selectHeroId)

	if opId then
		RPC.opActRandReplaceSet(opId, groupId, index)
		self:setVisible(false)
	end
end

return DrawNewbieLightChooseHeroDlg
