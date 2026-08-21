-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawGroupChooseHeroDlg.lua

local Hero = require("Common/Object/Hero")
local DrawGroupChooseHeroDlg = Class("DrawGroupChooseHeroDlg", UIControls.Window)
local GroupChooseHeroCell = Class("GroupChooseHeroCell", UIControls.Child)

function GroupChooseHeroCell:ctor(...)
	self:initUI()
end

function GroupChooseHeroCell:initUI(...)
	self.rootBtn = UIControls.Button(self, "BgCheck")

	self.rootBtn:addEventClick(self._onClickRoot)

	self.firstCellPanel = UIControls.Panel(self, "AllPanel")
	self.heroCellPanel = UIControls.Panel(self, "HeroPanel")
	self.firstCheckTxt = UIControls.Label(self, "BgCheck/IconCheck/Bg/Text1")
	self.heroCheckTxt = UIControls.Label(self, "BgCheck/IconCheck/Bg/Text2")
	self.checkPanel = UIControls.Panel(self, "BgCheck/IconCheck")
end

function GroupChooseHeroCell:setHeroCell(isFirst, heroId, idx)
	self.firstCellPanel:setVisible(isFirst)
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

	self.detailIndex = idx
end

function GroupChooseHeroCell:setHeroSelected(idx)
	self.isSelected = self.detailIndex == idx

	self.checkPanel:setVisible(self.isSelected)
end

function GroupChooseHeroCell:_onClickRoot(...)
	if not self.isSelected then
		self.mParent:onSelectHero(self.detailIndex)
	end
end

function DrawGroupChooseHeroDlg:ctor(...)
	self:initUI()
end

function DrawGroupChooseHeroDlg:initUI(...)
	self.confirmBtn = UIControls.Button(self, "Bg/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickConfirm)

	self.heroCells = {}
	self.cellMountPath = "Bg/HeroChooseList/Content"
	self.slotOfRealConfirm = Slot(self._realConfirm, self)
end

function DrawGroupChooseHeroDlg:initHeroChooseData(poolId)
	local actObjs = CurAvatar:getReplacePoolActivity()

	if not actObjs or not actObjs[poolId] then
		return
	end

	local actObj = actObjs[poolId]

	self.opId = actObj.opId
	self.heroIdList = {}

	local detailList = actObj.actData.clientData[poolId]

	for i = 1, #detailList + 1 do
		local cell = GroupChooseHeroCell(self, self.cellMountPath, "System/HeroPool/BtnGroupChooseHero", 0, 0, true)

		if i == 1 then
			cell:setHeroCell(true, nil, 0)
		else
			local heroId = detailList[i - 1].fake_hero_id
			local idx = detailList[i - 1].index

			cell:setHeroCell(false, heroId, idx)

			self.heroIdList[idx] = heroId
		end

		self.heroCells[i] = cell
	end

	local selectIdx = actObj.actData:getNowSelection(poolId)

	self:onSelectHero(selectIdx)
end

function DrawGroupChooseHeroDlg:onSelectHero(idx)
	self.curSelectIdx = idx

	for i, cell in ipairs(self.heroCells) do
		cell:setHeroSelected(idx)
	end
end

function DrawGroupChooseHeroDlg:_onClickConfirm(...)
	local selectHeroId = self.heroIdList[self.curSelectIdx]

	if selectHeroId then
		local isStarMax = CurAvatar:hasMaxStarHeroId(selectHeroId)

		if isStarMax then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(367), self.slotOfRealConfirm, nil)

			return
		end
	end

	self:_realConfirm()
end

function DrawGroupChooseHeroDlg:_realConfirm()
	RPC.opActDrawReplaceChangeIndex(self.opId, self.curSelectIdx)
	self:setVisible(false)
end

return DrawGroupChooseHeroDlg
