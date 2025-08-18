-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityAchieveStagePage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResItem = require("ClientData/ResItem")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResColor = require("ClientData/ResColor")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ActivityAchieveStagePanel = Class("ActivityAchieveStagePanel", UIControls.Panel)
local SOURCEIMG_PATH = "Atlas/ActivityAtlas/AcivityKRProgressAtlas"

function ActivityAchieveStagePanel:ctor()
	self.txtProgress = UIControls.Label(self, self.mPath .. "/TextEng")
	self.txtNum = UIControls.Label(self, self.mPath .. "/TextProgress")
	self.txtEng = UIControls.Label(self, self.mPath .. "/TextEng")
	self.imgAward = UIControls.Image(self, self.mPath .. "/IconAward")
	self.panelNew = UIControls.Panel(self, self.mPath .. "/IconNew")
	self.imgBg = UIControls.Image(self, self.mPath)
	self.btnSensor = UIControls.Button(self, self.mPath .. "/BtnGet")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.btnItem = UIControls.Button(self, self.mPath .. "/IconAward")

	self.btnItem:addEventClick(self.onBtnItemClick)
end

local function getNumShortStr(num)
	if num >= 1000 then
		return num / 1000 .. "K"
	else
		return num
	end
end

function ActivityAchieveStagePanel:setData(info)
	self.data = info.data
	self.state = info.state
	self.miscInfo = info.miscInfo
	self.opId = info.opId
	self.actType = self.data.type

	local levelStr = ClientUtils.parseStageToLevelStr(self.data.param)

	self.txtProgress:setText(string.format(Lang.get(30569), levelStr))

	local items = ClientUtils.getObjectByRandId(self.data.award)

	if items and #items > 0 then
		self.item = items[1]

		local path = items[1]:getIconPath()

		self.imgAward:setImage(path[1], path[2])
		self.txtNum:setText("×" .. getNumShortStr(items[1].num))
	end

	self:refreshUI()
end

function ActivityAchieveStagePanel:refreshUI(...)
	local iconName = "BgTargetDis"
	local colorName = "GREYLIGHT"

	self.btnSensor:setVisible(false)
	self.imgAward:setImageGray(true)
	self.panelNew:setVisible(false)

	if self.state == 2 then
		iconName = "BgTargetUnlock"
		colorName = "WHITE"

		self.btnSensor:setVisible(true)
		self.imgAward:setImageGray(false)
		self.panelNew:setVisible(true)
	elseif self.state == 3 then
		iconName = "BgTargetLock"
		colorName = "QUALITYPURPLE"

		self.imgAward:setImageGray(false)
	end

	self.txtEng:setFontColor(ResColor[colorName])
	self.txtProgress:setFontColor(ResColor[colorName])
	self.txtNum:setFontColor(ResColor[colorName])
	self.imgBg:setImage(SOURCEIMG_PATH, iconName)
end

function ActivityAchieveStagePanel:flyShow(...)
	FlyIconUtils.setFlyUItoUI(self.imgAward, self.mWindow.panelBag, self.item.id, self.item.num)
end

function ActivityAchieveStagePanel:onBtnItemClick(...)
	self.mDisableWays = true

	UIManager.getUI("itemTips"):showObj(self, self.item)
end

function ActivityAchieveStagePanel:onBtnSensorClick(...)
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.data.index, self.actType), self.opId)
	table.insert(self.mParent.preGotCells, self)
end

local classNameStr = "ActivityAchieveStagePage"
local ActivityAchieveStagePage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityAchieveStagePage, ActivityPanelMixin)

function ActivityAchieveStagePage:initUI()
	self.panelBgTime = UIControls.Panel(self, "BgTime")
	self.btnGo = UIControls.Button(self, "BtnGo", "Text")

	self.btnGo:addEventClick(self.onBtnGoClick)

	self.cells = {}
	self.preGotCells = {}

	for i = 1, 6 do
		local panel = ActivityAchieveStagePanel(self, "BtnAward" .. i)

		self.cells[i] = panel
	end

	self.panelBgTime:setVisible(false)
end

function ActivityAchieveStagePage:_setData(pageData)
	local detailData = {}
	local svrData
	local actId = self.actObj.actId
	local activityType

	for actType, cData in pairs(self.actObj.actData.clientData) do
		if not activityType then
			activityType = actType
			self.activityType = actType
			self.miscInfo = ResOpActivityAchieveMisc[actId][activityType]
		end

		for _, data in ipairs(cData) do
			table.insert(detailData, data)
		end
	end

	for _, sData in pairs(self.actObj.actData.serverData) do
		svrData = sData
	end

	self:_setCells(detailData)

	local curData = CurAvatar:getNowStageData()
	local levelText = ClientUtils.getMainStageLevelStr(curData.season, curData.chapter, curData.level)

	self.btnGo:setText(utils.format(Lang.get(52477), levelText))
end

function ActivityAchieveStagePage:_setCells(detailData)
	local actData = self.actObj.actData

	self.achData = {}

	for idx, data in ipairs(detailData) do
		local state = actData:getAchieveState(self.activityType, idx)
		local info = {}

		info.data = data
		info.state = state
		info.miscInfo = self.miscInfo
		info.opId = self.actObj.opId

		table.insert(self.achData, info)
	end

	for i, data in ipairs(self.achData) do
		local panel = self.cells[i]

		if panel then
			panel:setData(data)
		end
	end
end

function ActivityAchieveStagePage:_onShow()
	return
end

function ActivityAchieveStagePage:onActivityDataRefresh(actObj)
	self:_setData()
end

function ActivityAchieveStagePage:onGetActivityBonus(callback)
	callback(Slot(self.awardGetShowCB, self))
end

function ActivityAchieveStagePage:awardGetShowCB(...)
	if #self.preGotCells > 0 then
		for i, cell in ipairs(self.preGotCells) do
			cell:flyShow()
		end

		self.preGotCells = {}
	end
end

function ActivityAchieveStagePage:onBtnGoClick(...)
	local nextStage = CurAvatar:getNextMainStageInfo()
	local nowStage = CurAvatar:getNowStageData()

	if nextStage == nil then
		MsgManager.notice(Lang.get(30522))
	elseif nextStage.idx == nowStage.idx then
		UIManager.getUI("stageInfoDlg", true)
	else
		if nowStage.chapter == 1 and not self:_isSubpackageReady() then
			return
		end

		RPC.stageUnlockNext()
	end
end

return ActivityAchieveStagePage
