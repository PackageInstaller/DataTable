-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\HeroStarUpFastDlg.lua

local StarUpFastCell = require("UI/Hero/StarUp/StarUpFastCell")
local strClassName = "HeroStarUpFastDlg"
local HeroStarUpFastDlg = Class(strClassName, UIControls.Window)

function HeroStarUpFastDlg:ctor()
	self:initUI()
end

function HeroStarUpFastDlg:initUI()
	self.cells = {}
	self.heroSelect = {}
	self.scrollStarUpFast = UIControls.ScrollViewLoopV(self, "BgPanel/HeroStarUpFastList")

	self.scrollStarUpFast:addEventCellChanged(self.onStarUpFastChanged)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.imgTitle = UIControls.Image(self, "BgPanel/ImgTitle")
end

function HeroStarUpFastDlg:initHeroList(isIntel)
	self.isIntel = isIntel

	if not self.isIntel then
		self.scrollDataList = CurAvatar:getFastStarUpHeroList()

		self.imgTitle:setImage("Atlas/HeroStarUpAtlas/HeroStarUpAtlas", "TxtReplacement")
	else
		self.imgTitle:setImage("Atlas/HeroStarUpAtlas/HeroStarUpAtlas", "TxtReplacement2")

		if #CurAvatar:getIntelStarUpHeroList() > 0 then
			self.scrollDataList = CurAvatar:getIntelStarUpHeroList()
		else
			self.scrollDataList = CurAvatar:getSuperIntelStarUpHeroList()
		end
	end

	self:initSelectMax()
	self.scrollStarUpFast:setTotalCount(#self.scrollDataList)
end

function HeroStarUpFastDlg:initSelectMax()
	for _, data in ipairs(self.scrollDataList) do
		self.heroSelect[data.hero.gid] = data
	end
end

function HeroStarUpFastDlg:onStarUpFastChanged(sender, targetCell, newIdx)
	targetCell = targetCell or StarUpFastCell(sender, "System/StarUp/StarUpFastCell", newIdx)

	if not self.scrollDataList or #self.scrollDataList == 0 then
		return
	end

	if self.scrollDataList[newIdx] ~= nil then
		targetCell:setData(self.scrollDataList[newIdx], newIdx)
		targetCell:setSelectCallback(Slot(self.cellChangeSelected, self))
	end

	self.cells[newIdx] = targetCell
end

local function _sortByStar(a, b)
	return a.star > b.star
end

function HeroStarUpFastDlg:onBtnConfirmClick()
	if not self.isIntel then
		self:realConfirm()
	else
		local function yesFunc()
			self:realConfirm()
		end

		local msgContent = Lang.get(30396)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, -1)
	end
end

function HeroStarUpFastDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroStarUpFastDlg:realConfirm()
	if self.closing then
		return
	end

	if utils.getTableElemCount(self.heroSelect) == 0 then
		MsgManager.clientNotice(165)

		return
	end

	local eatedHeros = {}
	local starUpHeros = {}
	local starUpInfos = {}

	for _, fastCell in pairs(self.heroSelect) do
		local materialGids = {}

		for _, materialHero in ipairs(fastCell.materials) do
			table.insert(materialGids, materialHero.gid)
			table.insert(eatedHeros, materialHero)
		end

		table.insert(starUpHeros, fastCell.hero)

		local starUpInfo = {}

		starUpInfo.hero_gid = fastCell.hero.gid

		if self.isIntel then
			starUpInfo.same_camp_gid = materialGids
		else
			starUpInfo.same_gid = materialGids
		end

		starUpInfo.star = fastCell.hero.star + 1

		table.insert(starUpInfos, starUpInfo)
	end

	RPC.heroStarUpBatch(starUpInfos)
	CurAvatar:setMaterialHerosEated(eatedHeros)

	self.closing = true

	table.sort(starUpHeros, _sortByStar)

	CurAvatar.cacheFastStarUpHero = starUpHeros[1]
end

function HeroStarUpFastDlg:cellChangeSelected(sender)
	if self.heroSelect[sender.hero.gid] then
		self.heroSelect[sender.hero.gid] = nil
	else
		self.heroSelect[sender.hero.gid] = sender
	end

	self.scrollStarUpFast:setTotalCount(#self.scrollDataList)
end

return HeroStarUpFastDlg
