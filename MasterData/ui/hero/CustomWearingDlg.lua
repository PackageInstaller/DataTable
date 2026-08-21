-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\CustomWearingDlg.lua

local BtnSuitChosen = require("UI/Hero/BtnSuitChosen")
local BtnSuitInfo = require("UI/Hero/BtnSuitInfo")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResRaiders = require("ClientData/ResRaiders")
local strClassName = "CustomWearingDlg"
local CustomWearingDlg = Class(strClassName, UIControls.Window)

function CustomWearingDlg:ctor()
	self:initUI()
end

function CustomWearingDlg:initUI()
	self.btnWearing = UIControls.Button(self, "Bg/BtnWearing")

	self.btnWearing:addEventClick(self.onBtnWearingClick)

	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.txtNumCount = UIControls.Label(self, "Bg/SuitChosenPanel/TxtBg/TxtNumCount")
	self.btnTips = UIControls.Button(self, "Bg/TextTitle/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.bgSuit4 = UIControls.Button(self, "Bg/SuitListPanel/BgSuit4")

	self.bgSuit4:addEventClick(self.onBgSuitClick)

	self.bgSuit2 = UIControls.Button(self, "Bg/SuitListPanel/BgSuit2")

	self.bgSuit2:addEventClick(self.onBgSuitClick)

	self.btnCleanAll = UIControls.Button(self, "Bg/SuitChosenPanel/TxtBg/BtnCleanAll")

	self.btnCleanAll:addEventClick(self.onBtnCleanAllClick)

	self.bgSuitList = {
		self.bgSuit2,
		self.bgSuit4
	}
	self.txtEmpty = UIControls.Label(self, "Bg/SuitChosenPanel/TxtEmpty")
	self.recSuitImgList = {}
	self.recSuitPanelList = {}

	for i = 1, 3 do
		local panelRecSuit = UIControls.Panel(self, "Bg/PreferSuit/Suit0" .. i)
		local imgSuit = UIControls.Image(self, "Bg/PreferSuit/Suit0" .. i .. "/IconSuit")

		self.recSuitImgList[i] = imgSuit
		self.recSuitPanelList[i] = panelRecSuit
	end

	self.btnSuitChosenList = {}
	self.suitHaveDefineDic = {}
	self.cells = {}
	self.scrollSuitInfoCell = UIControls.ScrollViewLoopV(self, "Bg/SuitListPanel/SuitList")

	self.scrollSuitInfoCell:addEventCellChanged(self.onSuitInfoCellChanged)
end

function CustomWearingDlg:onSuitInfoCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or BtnSuitInfo(sender, "System/Bag/BtnSuitInfo", newIdx)

	if not self.suitInfoDataList or #self.suitInfoDataList == 0 then
		return
	end

	if self.suitInfoDataList[newIdx] ~= nil then
		targetCell:setSuitInfoCellData(self.suitInfoDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

function CustomWearingDlg:setCustomWearingShow(hero, callBack, bagWearDic)
	self.hero = hero
	self.callBack = callBack
	self.bagWearDic = bagWearDic

	local bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = CurAvatar:getBagEquipMaxRank(self.hero, self.bagWearDic, self.hero.id)
	local banType = self.hero:getEquipBanPropType()

	self.bagEquipMaxSuitRankDic = bagEquipMaxRankDic[banType]

	for i, _ in ipairs(self.recSuitImgList) do
		self.recSuitPanelList[i]:setVisible(false)
	end

	if ResRaiders[self.hero.id] and ResRaiders[self.hero.id].recommend and #ResRaiders[self.hero.id].recommend > 0 and ResRaiders[self.hero.id].recommend[1].suit then
		for i, suitId in ipairs(ResRaiders[self.hero.id].recommend[1].suit) do
			if ResEquipSuit[suitId] then
				self.recSuitPanelList[i]:setVisible(true)
				self.recSuitImgList[i]:setImage(UIConst.COMMON_ICON_PATH .. ResEquipSuit[suitId].iconPath, ResEquipSuit[suitId].icon)
			end
		end
	end

	self.selectedSuits = {}

	self:onBgSuitClick(self.bgSuit4)
	self:refreshDetailInfo()
end

function CustomWearingDlg:refreshDetailInfo()
	self.txtNumCount:setText(string.format("(%s/6)", 6 - self:getRemainSuitCount()))

	for i, suitId in ipairs(self.selectedSuits) do
		if not self.btnSuitChosenList[i] then
			self.btnSuitChosenList[i] = BtnSuitChosen(self, "Bg/SuitChosenPanel", "System/Bag/BtnSuitChosen", 0, 0, true)
		end

		self.btnSuitChosenList[i]:setVisible(true)
		self.btnSuitChosenList[i]:setSuitId(suitId, i, self.suitHaveDefineDic[suitId])
	end

	for i = #self.selectedSuits + 1, #self.btnSuitChosenList do
		self.btnSuitChosenList[i]:setVisible(false)
	end

	self.txtEmpty:setVisible(#self.selectedSuits == 0)
end

function CustomWearingDlg:getRemainSuitCount()
	local remainCnt = 6

	for _, suitId in ipairs(self.selectedSuits) do
		remainCnt = remainCnt - ResEquipSuit[suitId].need_num
	end

	return remainCnt
end

function CustomWearingDlg:getSelectSuitCount()
	local selectedSuitCnt = {}

	for _, suitId in ipairs(self.selectedSuits) do
		selectedSuitCnt[suitId] = (selectedSuitCnt[suitId] or 0) + ResEquipSuit[suitId].need_num
	end

	return selectedSuitCnt
end

function CustomWearingDlg:delSelectedSuit(idx)
	if #self.selectedSuits > 0 then
		table.remove(self.selectedSuits, idx)
	end

	self:refreshSuitInfoDataList()
	self:refreshDetailInfo()
end

function CustomWearingDlg:onBtnCleanAllClick()
	self.selectedSuits = {}

	self:refreshSuitInfoDataList()
	self:refreshDetailInfo()
end

function CustomWearingDlg:addSelectedSuit(suitId)
	table.insert(self.selectedSuits, suitId)

	if #self.selectedSuits == 1 and self:getRemainSuitCount() == 2 then
		self:onBgSuitClick(self.bgSuit2)
		self:refreshDetailInfo()
	else
		self:refreshSuitInfoDataList()
		self:refreshDetailInfo()
	end
end

function CustomWearingDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_STAR_REVERT)
end

function CustomWearingDlg:onBtnWearingClick()
	if #self.selectedSuits == 0 then
		MsgManager.clientNotice(640)

		return
	end

	if self.callBack then
		local suitIds = {}

		for i, suitId in ipairs(self.selectedSuits) do
			suitIds[i] = suitId
		end

		self.callBack(suitIds)
		self:setVisible(false)
	end
end

function CustomWearingDlg:onBtnDenyClick()
	self:setVisible(false)
end

function CustomWearingDlg:onBgSuitClick(sender)
	for _, bgSuit in ipairs(self.bgSuitList) do
		bgSuit:setEnable(sender ~= bgSuit)

		if sender == bgSuit then
			if bgSuit == self.bgSuit2 then
				self.curSuitInfo = 2
			elseif bgSuit == self.bgSuit4 then
				self.curSuitInfo = 4
			end
		end
	end

	self:refreshSuitInfoDataList()
end

function CustomWearingDlg:canSuitCoexistWithSelected(suitId)
	local suitIds = {}

	for _, _suitId in ipairs(self.selectedSuits) do
		table.insert(suitIds, _suitId)
	end

	table.insert(suitIds, suitId)

	for idx, id in ipairs(suitIds) do
		if suitIds[idx + 1] and not CurAvatar:canSuitCoexist({
			id,
			suitIds[idx + 1]
		}, self.bagEquipMaxSuitRankDic) then
			return false
		end
	end

	return CurAvatar:canSuitCoexist(suitIds, self.bagEquipMaxSuitRankDic)
end

local function _sortSuitInfoByStatus(a, b)
	if a.status ~= b.status then
		return a.status < b.status
	else
		return a.resData.suit_id < b.resData.suit_id
	end
end

function CustomWearingDlg:refreshSuitInfoDataList()
	local suitInfoList = CurAvatar:getSuitInfoList(self.hero, self.curSuitInfo, self.bagWearDic)
	local selectedSuitCnt = self:getSelectSuitCount()

	for _, suitInfo in ipairs(suitInfoList) do
		if suitInfo.isHaveDefine ~= 0 then
			self.suitHaveDefineDic[suitInfo.resData.suit_id] = suitInfo.isHaveDefine
		end

		if suitInfo.resData.need_num <= self:getRemainSuitCount() then
			if suitInfo.posCount - (selectedSuitCnt[suitInfo.resData.suit_id] or 0) >= ResEquipSuit[suitInfo.resData.suit_id].need_num and self:canSuitCoexistWithSelected(suitInfo.resData.suit_id) then
				suitInfo.status = Const.CUSTOM_SUIT_INFO_STATUS_ACTIVE
			else
				suitInfo.status = Const.CUSTOM_SUIT_INFO_STATUS_NO_ENOUGH
			end
		else
			suitInfo.status = Const.CUSTOM_SUIT_INFO_STATUS_SEL_MAX
		end
	end

	self.suitInfoDataList = suitInfoList

	table.sort(self.suitInfoDataList, _sortSuitInfoByStatus)
	self.scrollSuitInfoCell:setTotalCount(#self.suitInfoDataList)
end

return CustomWearingDlg
