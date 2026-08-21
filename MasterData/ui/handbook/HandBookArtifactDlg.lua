-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookArtifactDlg.lua

local ARTIFACT_SELL_FILTER_MAP = {
	{
		title = Lang.get(372),
		data = {
			{
				Lang.get(30303),
				"quality",
				2
			},
			{
				Lang.get(30304),
				"quality",
				3
			},
			{
				Lang.get(30305),
				"quality",
				4
			},
			{
				Lang.get(52362),
				"quality",
				5
			}
		}
	},
	{
		title = Lang.get(374),
		data = {
			{
				string.format(Lang.get(32775), Const.CAREER_CONFIG[1].name),
				"career",
				1
			},
			{
				string.format(Lang.get(32775), Const.CAREER_CONFIG[2].name),
				"career",
				2
			},
			{
				string.format(Lang.get(32775), Const.CAREER_CONFIG[3].name),
				"career",
				3
			},
			{
				string.format(Lang.get(32775), Const.CAREER_CONFIG[4].name),
				"career",
				4
			},
			{
				string.format(Lang.get(32775), Const.CAREER_CONFIG[5].name),
				"career",
				5
			},
			{
				Const.CAREER_CONFIG[6].name,
				"career",
				6
			}
		}
	}
}
local HandBookArtifactGrid = require("UI/HandBook/HandBookArtifactGrid")
local HandBookArtifactInfoChild = require("UI/HandBook/HandBookArtifactInfoChild")
local strClassName = "HandBookArtifactDlg"
local HandBookArtifactDlg = Class(strClassName, UIControls.Window)

function HandBookArtifactDlg:ctor()
	self:initUI()
end

function HandBookArtifactDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnListCustom = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnListCustom")

	self.btnListCustom:addEventClick(self.onBtnListCustomClick)

	self.scrollGrid = UIControls.ScrollViewLoopV(self, "MainInfoPanel/BadgeListScroll", 0, self._initItem)
	self.artifactGrids = {}
	self.btnGrowth = UIControls.Button(self, "BtnGrowth")

	self.btnGrowth:addEventClick(self.onBtnGrowthClick)

	self.animatorBtnSwitch = UIControls.Panel(self, "MainInfoPanel/BtnGrowth/Img")

	self.animatorBtnSwitch:playAnimator("BtnSwitchOff")

	self.isShowGrowth = false
	self.artifactItemList = CurAvatar:getHandBookArtifactList(self.isShowGrowth)
	self.idGrowthestArtifactDic = CurAvatar:getIdGrowthestArtifactDic()
	self.uiAni = UIControls.UIAni(self, "MainInfoPanel/BadgeListScroll")

	self.uiAni:addEventAnimateCue(self.switchGrowthCue)

	self.filterList = self.artifactItemList

	self.scrollGrid:setTotalCount(#self.filterList)
	self:selectArtifact(self.artifactGrids[1])
end

function HandBookArtifactDlg:onOpen()
	HandBookArtifactDlg.super.onOpen(self)

	if self.isShowGrowth then
		self:switchGrowthCue(nil, "ChangeHandBookBadgeList")
	end
end

function HandBookArtifactDlg:switchGrowthCue(aniCom, eventKey)
	if eventKey == "ChangeHandBookBadgeList" then
		self.idGrowthestArtifactDic = CurAvatar:getIdGrowthestArtifactDic()
		self.artifactItemList = CurAvatar:getHandBookArtifactList(self.isShowGrowth)

		if self.filterCheckFunc then
			self:filterArtifact(self.filterCheckFunc, self.toggleGroupTypeFilter, true)
		else
			self.filterList = self.artifactItemList

			self.scrollGrid:setTotalCount(#self.filterList)
		end

		for _, artifact in ipairs(self.filterList) do
			if artifact.id == self.selectId then
				self.singleArtifactChild:setArtifact(artifact)

				break
			end
		end
	end
end

function HandBookArtifactDlg:onBtnGrowthClick()
	self.isShowGrowth = not self.isShowGrowth

	if not self.isShowGrowth then
		self.animatorBtnSwitch:playAnimator("BtnSwitchSetOff")
		self.uiAni:startAni("ChangeHandBookBadgeList", true)
	else
		self.animatorBtnSwitch:playAnimator("BtnSwitchSetOn")
		self.uiAni:startAni("ChangeHandBookBadgeList", true)
	end
end

function HandBookArtifactDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_ARTIFACT)
end

function HandBookArtifactDlg:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or HandBookArtifactGrid(sender, "System/Common/Grid/GridBadgeItem", newIdx)

	if not self.filterList or #self.filterList == 0 then
		return
	end

	if self.filterList[newIdx] ~= nil then
		targetCell:setArtifact(self.filterList[newIdx])

		targetCell.mEnableTips = false
		targetCell.mEventClick = Slot(self.selectArtifact, self)

		local beSelected = self.selectId and self.selectId == self.filterList[newIdx].id

		targetCell.btnSensor:setEnable(not beSelected)
		targetCell.imgSelect2:setVisible(beSelected)
	end

	self.artifactGrids[newIdx] = targetCell
end

function HandBookArtifactDlg:selectArtifact(sender)
	self.selectId = sender.object.id

	sender.btnSensor:setEnable(false)
	sender.imgSelect2:setVisible(true)

	if not self.singleArtifactChild then
		self.singleArtifactChild = HandBookArtifactInfoChild(self, "MainInfoPanel", "System/HandBook/BadgeInfoPanel", 0, 0, true)
	end

	self.singleArtifactChild:setArtifact(sender.object)
	self.scrollGrid:setTotalCount(#self.filterList)
end

function HandBookArtifactDlg:onBtnListCustomClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:setIsHaveAll(true)
		siftBoxDlg:initFilterInfo(ARTIFACT_SELL_FILTER_MAP, self.toggleGroupTypeFilter, Slot(self.filterArtifact, self))
		siftBoxDlg:setTitle(Lang.get(1050))
	end
end

function HandBookArtifactDlg:filterArtifact(filterCheckFunc, toggleGroupTypeFilter, forSwitchGrowth)
	self.filterCheckFunc = filterCheckFunc
	self.toggleGroupTypeFilter = toggleGroupTypeFilter

	local tempFilterList = {}

	for _, hero in ipairs(self.artifactItemList) do
		if self.filterCheckFunc(hero) then
			table.insert(tempFilterList, hero)
		end
	end

	if #tempFilterList == 0 then
		MsgManager.clientNotice(Const.HANDBOOK_NOT_FILETER_ARTIFACT_NOTICE)

		return
	end

	self.filterList = tempFilterList

	if forSwitchGrowth then
		self.scrollGrid:setTotalCount(#self.filterList)
	else
		self.scrollGrid:setTotalCount(#self.filterList, 1)
	end

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function HandBookArtifactDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HandBookArtifactDlg
