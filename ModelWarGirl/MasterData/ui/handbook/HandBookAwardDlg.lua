-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookAwardDlg.lua

local HandBookTotalAwardPanel = require("UI/HandBook/HandBookTotalAwardPanel")
local HandBookAwardCell = require("UI/HandBook/HandBookAwardCell")
local strClassName = "HandBookAwardDlg"
local HandBookAwardDlg = Class(strClassName, UIControls.Window)

function HandBookAwardDlg:ctor()
	self:initUI()
end

function HandBookAwardDlg:initUI()
	self.cellIsPlayingDic = {}
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnTabs = {}
	self.imgTabs = {}
	self.imgTabNews = {}

	for i = 1, 5 do
		local btnTab = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnAward" .. i, "Text")

		btnTab.tabIdx = i

		btnTab:setText(Const.CAMP_CONFIG[i].name)
		btnTab:addEventClick(self.onBtnTabClick)
		table.insert(self.btnTabs, btnTab)

		local imgTab = UIControls.Image(self, "MainInfoPanel/TabPanel/BtnAward" .. i .. "/BgMask/Icon")

		imgTab:setImage("Atlas/HeroAtlas/HeroCardCommonAtlas", "IconGroup0" .. i)
		table.insert(self.imgTabs, imgTab)

		local txtTabEng = UIControls.Label(self, "MainInfoPanel/TabPanel/BtnAward" .. i .. "/TextEngLish")

		txtTabEng:setText(Const.CAMP_CONFIG[i].en_name)

		local imgTabNew = UIControls.Image(self, "MainInfoPanel/TabPanel/BtnAward" .. i .. "/IconNew")

		imgTabNew:setVisible(CurAvatar.handbookAwardCanGet[i] ~= nil)
		table.insert(self.imgTabNews, imgTabNew)
	end

	self.panelTotalAward = HandBookTotalAwardPanel(self, "MainInfoPanel/HandBookTotalAward")
	self.handBookAwardInfo = CurAvatar:getHandBookAwardInfo()

	self:onBtnTabClick(self.btnTabs[1])
end

function HandBookAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HandBookAwardDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_AWARD)
end

function HandBookAwardDlg:onBtnTabClick(sender)
	for tabIdx, btn in ipairs(self.btnTabs) do
		if btn.tabIdx == sender.tabIdx then
			self.btnTabs[tabIdx]:setEnable(false)
		else
			self.btnTabs[tabIdx]:setEnable(true)
		end
	end

	if utils.getTableElemCount(self.cellIsPlayingDic) ~= 0 then
		self.cellIsPlayingDic = {}
		self.handBookAwardInfo = CurAvatar:getHandBookAwardInfo()

		self:refreshHintNew()
	end

	self:showTabAward(sender.tabIdx)
end

function HandBookAwardDlg:showTabAward(page)
	self.curPage = page

	if self.handBookAwardInfo[self.curPage].herosDefine then
		self:setHeroDefineAwardCell(self.handBookAwardInfo[self.curPage].herosDefine)
	end

	if self.handBookAwardInfo[self.curPage].campDefine then
		self.panelTotalAward:setData(self.handBookAwardInfo[self.curPage].campDefine)
		self.panelTotalAward:setVisible(true)
	else
		self.panelTotalAward:setVisible(false)
	end
end

function HandBookAwardDlg:refreshForTotalAwardPanel()
	self.handBookAwardInfo = CurAvatar:getHandBookAwardInfo()

	if self.handBookAwardInfo[self.curPage].campDefine then
		self.panelTotalAward:setData(self.handBookAwardInfo[self.curPage].campDefine)
		self.panelTotalAward:setVisible(true)
	else
		self.panelTotalAward:setVisible(false)
	end

	self:refreshHintNew()
end

function HandBookAwardDlg:refreshShow()
	self.handBookAwardInfo = CurAvatar:getHandBookAwardInfo()

	self:showTabAward(self.curPage)
	self:refreshHintNew()
end

function HandBookAwardDlg:refreshHintNew()
	for i = 1, 5 do
		self.imgTabNews[i]:setVisible(CurAvatar.handbookAwardCanGet[i] ~= nil)
	end
end

function HandBookAwardDlg:setHeroDefineAwardCell(herosDefine)
	self.herosDefine = herosDefine

	if not self.herosDefineCellList then
		self.herosDefineCellList = {}
	end

	local function sortByStatus(a, b)
		if a.status ~= b.status then
			if a.status == Const.TASK_STATUS.COMPLETE or b.status == Const.TASK_STATUS.COMPLETE then
				return a.status == Const.TASK_STATUS.COMPLETE
			else
				return a.status < b.status
			end
		elseif a.index_priority ~= b.index_priority then
			return a.index_priority < b.index_priority
		elseif a.id ~= b.id then
			return a.id < b.id
		end
	end

	table.sort(self.herosDefine, sortByStatus)

	for i, defineInfo in ipairs(self.herosDefine) do
		if not self.herosDefineCellList[i] then
			self.herosDefineCellList[i] = HandBookAwardCell(self, "MainInfoPanel/HandBookAwardList/Viewport/Content", "System/HandBook/HandBookAwardCell", 0, 0, true)
		end

		self.herosDefineCellList[i]:setData(defineInfo)
	end

	if #self.herosDefineCellList > #self.herosDefine then
		for i = #self.herosDefine + 1, #self.herosDefineCellList do
			self.herosDefineCellList[i]:destroy()

			self.herosDefineCellList[i] = nil
		end
	end
end

return HandBookAwardDlg
