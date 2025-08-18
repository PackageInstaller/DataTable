-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCareerChooseHeroDlg.lua

local Hero = require("Common/Object/Hero")
local ResHero = require("ClientData/ResHero")
local CareerCell = Class("CareerCell", UIControls.Child)

function CareerCell:ctor(...)
	self:initUI()
end

function CareerCell:initUI(...)
	self.bgSellect = UIControls.Panel(self, "BgSellect")
	self.icon = UIControls.Image(self, "Icon")
	self.careerCell = UIControls.Button(self, "")

	self.careerCell:addEventClick(self.onCareerCellClick)
end

function CareerCell:setData(careerId)
	self.careerId = careerId

	self.bgSellect:setVisible(self.mParent.curSelectCareer == careerId)
	self.icon:setImage("Atlas/HeroPoolAtlas/HeroPoolNewcomerUpAtlas", "IconCareer0" .. careerId)
end

function CareerCell:onCareerCellClick()
	if self.mParent.curSelectCareer ~= self.careerId then
		self.mParent.curSelectCareer = self.careerId

		for i, cell in pairs(self.mParent.careerCells) do
			cell.bgSellect:setVisible(cell.careerId == self.careerId)
		end

		self.mParent.careerText:setText(Const.CAREER_CONFIG[self.careerId].des)
	end
end

local CareerChooseHeroCell = Class("CareerChooseHeroCell", UIControls.Child)

function CareerChooseHeroCell:ctor(...)
	self:initUI()
end

function CareerChooseHeroCell:initUI(...)
	self.rootBtn = UIControls.Button(self, "BgCheck")

	self.rootBtn:addEventClick(self._onClickRoot)

	self.firstCellPanel = UIControls.Panel(self, "AllPanel")
	self.heroCellPanel = UIControls.Panel(self, "HeroPanel")
	self.firstCheckTxt = UIControls.Label(self, "BgCheck/IconCheck/Bg/Text1")
	self.heroCheckTxt = UIControls.Label(self, "BgCheck/IconCheck/Bg/Text2")
	self.checkPanel = UIControls.Panel(self, "BgCheck/IconCheck")
end

function CareerChooseHeroCell:setHeroCell(isFirst, heroId, idx)
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

	self.heroId = heroId
end

function CareerChooseHeroCell:_onClickRoot(...)
	if self.mParent.curSelectHeroId ~= self.heroId then
		self.mParent.curSelectHeroId = self.heroId

		for i, cell in pairs(self.mParent.heroCells) do
			cell.checkPanel:setVisible(cell.heroId == self.heroId)
		end
	end
end

local DrawCareerChooseHeroDlg = Class("DrawCareerChooseHeroDlg", UIControls.Window)

function DrawCareerChooseHeroDlg:ctor(...)
	self:initUI()
end

function DrawCareerChooseHeroDlg:initUI(...)
	self.confirmBtn = UIControls.Button(self, "Bg/HeroChoosePanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickConfirm)

	self.btnBack = UIControls.Button(self, "Bg/HeroChoosePanel/BtnBack")

	self.btnBack:addEventClick(self.onBtnBackClick)

	self.btnNext = UIControls.Button(self, "Bg/CareerChoosePanel/BtnNext")

	self.btnNext:addEventClick(self.onBtnNextClick)

	self.heroChoosePanel = UIControls.Panel(self, "Bg/HeroChoosePanel")
	self.careerChoosePanel = UIControls.Panel(self, "Bg/CareerChoosePanel")
	self.careerText = UIControls.Label(self, "Bg/CareerChoosePanel/TextDes")
	self.heroCells = {}
	self.careerCells = {}
	self.cellMountPath = "Bg/HeroChooseList/Content"
	self.slotOfRealConfirm = Slot(self._realConfirm, self)
end

function DrawCareerChooseHeroDlg:setData(actObj)
	self.actObj = actObj
	self.careerList = {}
	self.unlockCareer = self.actObj.actData:getUnlockCareer()

	for career = 1, 5 do
		if not utils.tableIsContainsElement(self.unlockCareer, career) then
			table.insert(self.careerList, career)
		end
	end

	self.curSelectCareer = self.careerList[1]

	self:refreshCareerInfo()
end

function DrawCareerChooseHeroDlg:refreshCareerInfo()
	self.careerChoosePanel:setVisible(true)
	self.heroChoosePanel:setVisible(false)

	for i, career in ipairs(self.careerList) do
		local cell = self.careerCells[career]

		cell = cell or CareerCell(self, "Bg/CareerChoosePanel/CareerChooseList", "System/HeroPool/CareerCell", 0, 0, true)

		cell:setData(career)

		self.careerCells[career] = cell
	end

	self.careerText:setText(Const.CAREER_CONFIG[self.curSelectCareer].des)
end

function DrawCareerChooseHeroDlg:refreshHeroChooseData()
	self.careerChoosePanel:setVisible(false)
	self.heroChoosePanel:setVisible(true)

	self.heroIdList = self.actObj.actData:getAllSelectHeroIds(self.curSelectCareer)

	for i = 1, #self.heroIdList do
		local cell = self.heroCells[i]

		cell = cell or CareerChooseHeroCell(self, "Bg/HeroChoosePanel/HeroChooseList/Content", "System/HeroPool/BtnGroupChooseHero", 0, 0, true)

		local heroId = self.heroIdList[i]

		cell:setHeroCell(false, heroId)

		self.heroCells[i] = cell
	end
end

function DrawCareerChooseHeroDlg:onBtnNextClick()
	self:refreshHeroChooseData()
end

function DrawCareerChooseHeroDlg:onBtnBackClick()
	self:refreshCareerInfo()
end

function DrawCareerChooseHeroDlg:_onClickConfirm(...)
	local selectHeroId = self.curSelectHeroId

	if selectHeroId then
		local isStarMax = CurAvatar:hasMaxStarHeroId(selectHeroId)

		if isStarMax then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(367), self.slotOfRealConfirm, nil)

			return
		end
	else
		MsgManager.notice(Lang.get(92478))

		return
	end

	self:_realConfirm()
end

function DrawCareerChooseHeroDlg:_realConfirm()
	local str = string.format(ClientUtils.getClientNotice(754), ResHero[self.curSelectHeroId].hero_name)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", str, Slot(self._sendSetHeroRpc, self), nil)
end

function DrawCareerChooseHeroDlg:_sendSetHeroRpc()
	local selectHeroId = self.curSelectHeroId
	local opId, groupId, index = self.actObj.actData:getRandReplaceGroupAndIndex(self.curSelectCareer, selectHeroId)

	if opId then
		RPC.opActRandReplaceSet(opId, groupId, index)
		self:setVisible(false)
	end
end

return DrawCareerChooseHeroDlg
