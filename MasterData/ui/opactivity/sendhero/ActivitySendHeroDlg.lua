-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SendHero\\ActivitySendHeroDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ActivitySendHeroBuildingChooseCell = Class("ActivitySendHeroBuildingChooseCell", UIControls.Child)

function ActivitySendHeroBuildingChooseCell:ctor()
	self:initUI()
end

function ActivitySendHeroBuildingChooseCell:initUI()
	self.textName = UIControls.Label(self, "TxtBuildingName")
	self.textLevel = UIControls.Label(self, "TxtBuildingLv")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.iconNew = UIControls.Panel(self, "IconNew")
end

function ActivitySendHeroBuildingChooseCell:initData(buildingData)
	self.buildingData = buildingData
end

function ActivitySendHeroBuildingChooseCell:setData(level)
	self.nowLevelData = self.buildingData[level]

	if self.nowLevelData then
		self.textName:setText(self.nowLevelData.name)
		self.textLevel:setText(self.nowLevelData.lv_desc)

		if self.mParent.actObj:inOpenState() and self.mParent.actObj.actData:canBuildingLvUp(self.nowLevelData.id) then
			self.iconNew:setVisible(true)
		else
			self.iconNew:setVisible(false)
		end
	else
		self.textLevel:setText(level or 0)
	end
end

function ActivitySendHeroBuildingChooseCell:setSelect(isSeleted)
	self.btnSensor:setEnable(not isSeleted)

	if self.buildingData[0].btn_icon_path then
		if isSeleted then
			self.btnSensor:setImage(self.buildingData[0].btn_icon_path, self.buildingData[0].btn_icon .. "02")
		else
			self.btnSensor:setImage(self.buildingData[0].btn_icon_path, self.buildingData[0].btn_icon .. "01")
		end
	end
end

function ActivitySendHeroBuildingChooseCell:onSensorClick()
	self.mParent:onBuildingSelect(self)
end

local strClassName = "ActivitySendHeroDlg"
local ActivitySendHeroDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySendHeroDlg, ActivityPanelMixin)

function ActivitySendHeroDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.textTime = UIControls.Label(self, "MainInfoPanel/BuildingChoosePanel/TxtTime")
	self.textRule = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/TxtDes")
	self.aniInfo = UIControls.UIAni(self, "MainInfoPanel")
	self.panelBuildInfo = UIControls.Panel(self, "MainInfoPanel/BuildingInfoPanel")
	self.bgBuild = UIControls.Image(self, "MainInfoPanel/BuildingInfoPanel/BgBuilding")
	self.nameBuild = UIControls.Image(self, "MainInfoPanel/BuildingInfoPanel/BuildingDesPanel/TxtBuidingName")
	self.selPanelBuild = UIControls.Panel(self, "MainInfoPanel/BuildingInfoPanel/BuildingDesPanel/BuildingLvPanel")
	self.bgBuildDesc = UIControls.Image(self, "MainInfoPanel/BuildingInfoPanel/BuildingDesPanel/BuildingLvPanel/ImgDec")
	self.textBuildLv = UIControls.Label(self, "MainInfoPanel/BuildingInfoPanel/BuildingDesPanel/BuildingLvPanel/TxtLv")
	self.textBuildDesc = UIControls.Label(self, "MainInfoPanel/BuildingInfoPanel/BuildingDesPanel/BuildingLvPanel/TxtDes")
	self.efxBuildMax = UIControls.Panel(self, "MainInfoPanel/BuildingInfoPanel/BuildingDesPanel/BuildingLvPanel/EfxPanel")
	self.btnBuildToDispatch = UIControls.Button(self, "MainInfoPanel/BuildingInfoPanel/ResultInfoPanel/BtnSubmit")

	self.btnBuildToDispatch:addEventClick(self.onBuildToDispatch)

	self.newPanelBuildToDispatch = UIControls.Panel(self, "MainInfoPanel/BuildingInfoPanel/ResultInfoPanel/BtnSubmit/Content/IconNew")
	self.buildAwardGrids = {}
	self.buildListCells = {}
	self.panelBuildMax = UIControls.Panel(self, "MainInfoPanel/BuildingInfoPanel/ResultInfoPanel/ImgMax")
	self.btnShowDispatch = UIControls.Button(self, "MainInfoPanel/BuildingChoosePanel/BtnDispatch")

	self.btnShowDispatch:addEventClick(self.onShowDispatchClick)

	self.iconNewDispatch = UIControls.Panel(self, "MainInfoPanel/BuildingChoosePanel/BtnDispatch/IconNew")
	self.btnShowBuild = UIControls.Button(self, "MainInfoPanel/BuildingChoosePanel/BtnBuilding")

	self.btnShowBuild:addEventClick(self.onShowBuildClick)

	self.iconNewBuilding = UIControls.Panel(self, "MainInfoPanel/BuildingChoosePanel/BtnBuilding/IconNew")
	self.panelDispatch = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel")
	self.btnHeroUpTips = UIControls.Button(self, "MainInfoPanel/DispatchInfoPanel/HeroPanel/TxtTitle/BtnTips")

	self.btnHeroUpTips:addEventClick(self.onHeroUpTipsClick)

	self.baseBonusGrids = {}
	self.buildBonusGrids = {}
	self.imgHeroAddStar = UIControls.Image(self, "MainInfoPanel/DispatchInfoPanel/HeroPanel/BgBuff/ImgStar")
	self.textHeroAddNotice = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/HeroPanel/BgBuff/TxtBuff")
	self.panelNoHero = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/HeroPanel/NoHeroPanel")
	self.panelHeroBuff = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/HeroPanel/BgBuff")
	self.panelNoDispatch = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/BgDispatchTime")
	self.textDispatchTimeDesc = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/BgDispatchTime/TxtDispatchTime")
	self.panelInDispatch = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/BgDispatchHigh")
	self.panelDispatchRound = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/BgRound")
	self.textDispatchRound = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/BgRound/TxtRound")
	self.panelDispatchDis = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchDis")
	self.btnDispatchDis = UIControls.Button(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchDis/BtnDispatchDis")

	self.btnDispatchDis:addEventClick(self.onDispatchDisClick)

	self.panelDispatchNml = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchNml")
	self.btnDispatch = UIControls.Button(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchNml/BtnDispatch")

	self.btnDispatch:addEventClick(self.onDispatchClick)

	self.newBtnDispatch = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchNml/BtnDispatch/Content/IconNew")
	self.panelDispatchRunning = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchHigh")
	self.textDispatchTime = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchHigh/BgTime/TxtTime")
	self.btnSpeedUp = UIControls.Button(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchHigh/BtnSpeedUp")

	self.btnSpeedUp:addEventClick(self.onSpeedUpClick)

	self.panelDispatchFinish = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchFinish")
	self.btnShowDispatchAward = UIControls.Button(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/DispatchFinish/BtnDispatch")

	self.btnShowDispatchAward:addEventClick(self.onShowDispatchAwardClick)

	self.miscData = self.actObj.actData.miscData
	self.buildingLevelData = self.actObj.actData.buildingLevelData

	for index = 1, #self.buildingLevelData do
		local newCell = ActivitySendHeroBuildingChooseCell(self, "MainInfoPanel/BuildingInfoPanel/BuildingList", "System/Activity/ActivityDispatch/BuildingChooseCell")

		newCell:setVisible(true)
		newCell:initData(self.buildingLevelData[index])
		table.insert(self.buildListCells, newCell)
	end

	self.baseItems = {}

	local awardData = ResRandClient[self.miscData.dispatch_award]
	local awardIds = awardData.show_ids or {}
	local awardNums = awardData.show_nums or {}
	local awardFlags = awardData.show_flag or {}

	for index, id in ipairs(awardIds) do
		local newItem = BaseObject.GetObject(id, awardNums[index] or 1)

		newItem.awardFlag = awardFlags[index]

		table.insert(self.baseItems, newItem)
	end
end

function ActivitySendHeroDlg:_setData()
	self.textDispatchTimeDesc:setText(self.miscData.dispatch_time_desc or "")

	self.showBuilding = false

	self.btnShowBuild:setEnable(true)
	self.btnShowDispatch:setEnable(false)
	self:refreshData()
end

function ActivitySendHeroDlg:onBuildingSelect(cell)
	self.selectBuild = cell.nowLevelData.id

	self:refreshBuildingPanel()
end

function ActivitySendHeroDlg:refreshBuildingPanel()
	for index, cell in ipairs(self.buildListCells) do
		cell:setData(self.actObj.actData:getBuildingLevel(index))
	end

	if not self.selectBuild then
		self.selectBuild = 1
	end

	for index, cell in ipairs(self.buildListCells) do
		cell:setSelect(index == self.selectBuild)
	end

	local selectData = self.buildingLevelData[self.selectBuild]
	local nowLevel = self.actObj.actData:getBuildingLevel(self.selectBuild)
	local nowLevelData = selectData[nowLevel]

	if selectData[0].icon_path then
		self.bgBuild:setImage("Atlas/" .. selectData[0].icon_path, selectData[0].icon)
		self.nameBuild:setImage("Atlas/" .. selectData[0].name_icon_path, selectData[0].name_icon)
	end

	self.textBuildLv:setText(nowLevel)
	self.bgBuildDesc:setImage("Atlas/ActivityAtlas/ActivityDispatchAtlas/ActivityDispatchAtlas1", "BgExplore0" .. nowLevel + 1)
	self.textBuildDesc:setText(nowLevelData.desc)
	self.efxBuildMax:setVisible(selectData[nowLevel + 1] == nil)
	self.panelBuildMax:setVisible(selectData[nowLevel + 1] == nil)
	self.btnBuildToDispatch:setVisible(selectData[nowLevel + 1] ~= nil)

	if self.actObj:inOpenState() and self.actObj.actData:canBuildingLvUp(self.selectBuild) then
		self.newPanelBuildToDispatch:setVisible(true)
	else
		self.newPanelBuildToDispatch:setVisible(false)
	end

	local buildingItems = {}

	for level, nowInfo in pairs(selectData) do
		if level <= nowLevel and nowInfo.award then
			local awardData = ResRandClient[nowInfo.award]
			local awardIds = awardData.show_ids or {}
			local awardNums = awardData.show_nums or {}
			local awardFlags = awardData.show_flag or {}

			for index, id in ipairs(awardIds) do
				local hasItem = false

				for _, obj in ipairs(buildingItems) do
					if obj.id == id then
						hasItem = true
						obj.num = obj.num + (awardNums[index] or 1)

						break
					end
				end

				if not hasItem then
					local newItem = BaseObject.GetObject(id, awardNums[index] or 1)

					newItem.awardFlag = awardFlags[index]

					table.insert(buildingItems, newItem)
				end
			end
		end
	end

	table.sort(buildingItems, utils.getSortingFunc("awardFlag", true))
	ClientUtils.CreateBonusGridByItems(self, self.buildAwardGrids, "MainInfoPanel/BuildingInfoPanel/ResultInfoPanel/AwardPanel", buildingItems)
end

function ActivitySendHeroDlg:refreshDispatchPanel()
	local needHeroId = self.miscData.hero_id
	local hero = CurAvatar:getHeroMaxStarHero(needHeroId)
	local heroStartData = self.actObj.actData.heroStarBonusData

	self.heroItems = {}

	for _, baseItem in ipairs(self.baseItems) do
		table.insert(self.heroItems, baseItem)
	end

	local curStarData

	if hero then
		local curStar = 0

		for star, starData in pairs(heroStartData) do
			if star <= hero.star and curStar < star then
				curStar = star
				curStarData = starData
			end
		end
	end

	if curStarData then
		self.panelNoHero:setVisible(false)
		self.panelHeroBuff:setVisible(true)

		local value = curStarData.bonus - 10000
		local valueStr = value / 100 .. "%"

		self.textHeroAddNotice:setText(string.format(self.miscData.hero_up_desc, valueStr))

		local starPath = hero:getLargeStarPath()

		if starPath then
			self.imgHeroAddStar:setImage(starPath[1], starPath[2])
		end

		for _, item in ipairs(self.baseItems) do
			local newItem = BaseObject.GetObject(item.id, item.num * value * 0.0001)

			newItem.awardFlag = 19

			table.insert(self.heroItems, newItem)
		end
	else
		self.panelNoHero:setVisible(true)
		self.panelHeroBuff:setVisible(false)
	end

	local serverData = self.actObj.actData.serverData
	local hasCount = serverData.dispatchCount or 0

	self.textDispatchRound:setText(string.format(self.miscData.dispatch_num_desc, hasCount))

	if hasCount > 0 then
		self.textDispatchRound:setFontColor(ResColor.BLACK)
	else
		self.textDispatchRound:setFontColor(ResColor.RED)
	end

	ClientTimerManager.RemoveSecondTickUI(self.textDispatchTime)

	local sendState = self.actObj.actData:getSendState()

	if sendState[1] == 0 then
		self.panelInDispatch:setVisible(true)
		self.panelNoDispatch:setVisible(false)
		self.panelDispatchRound:setVisible(true)
		self.panelDispatchFinish:setVisible(true)
		self.panelDispatchRunning:setVisible(false)
		self.panelDispatchNml:setVisible(false)
		self.panelDispatchDis:setVisible(false)
	elseif sendState[1] == 1 then
		self.panelInDispatch:setVisible(true)
		self.panelNoDispatch:setVisible(false)
		self.panelDispatchRound:setVisible(true)
		self.panelDispatchFinish:setVisible(false)
		self.panelDispatchRunning:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.textDispatchTime, sendState[2], nil, self.miscData.distapch_count_down_desc, Slot(self.refreshData, self))
		self.panelDispatchNml:setVisible(false)
		self.panelDispatchDis:setVisible(false)
	else
		self.panelInDispatch:setVisible(false)
		self.panelDispatchFinish:setVisible(false)
		self.panelDispatchRunning:setVisible(false)

		if self.actObj:inOpenState() then
			self.panelNoDispatch:setVisible(true)
			self.panelDispatchRound:setVisible(true)

			if hasCount > 0 then
				self.panelDispatchNml:setVisible(true)
				self.newBtnDispatch:setVisible(true)
				self.panelDispatchDis:setVisible(false)
			else
				self.panelDispatchNml:setVisible(false)
				self.panelDispatchDis:setVisible(true)
			end
		else
			self.panelNoDispatch:setVisible(false)
			self.panelDispatchRound:setVisible(false)
			self.panelDispatchNml:setVisible(true)
			self.newBtnDispatch:setVisible(false)
		end
	end

	ClientUtils.CreateBonusGridByItems(self, self.baseBonusGrids, "MainInfoPanel/DispatchInfoPanel/BaseAwardPanel/ItemPanel", self.heroItems)

	local buildingItems = {}

	for buildingId, info in ipairs(self.buildingLevelData) do
		local nowLevel = self.actObj.actData:getBuildingLevel(buildingId)

		for level, nowInfo in pairs(info) do
			if level <= nowLevel and nowInfo.award then
				local awardData = ResRandClient[nowInfo.award]
				local awardIds = awardData.show_ids or {}
				local awardNums = awardData.show_nums or {}
				local awardFlags = awardData.show_flag or {}

				for index, id in ipairs(awardIds) do
					local hasItem = false

					for _, obj in ipairs(buildingItems) do
						if obj.id == id then
							hasItem = true
							obj.num = obj.num + (awardNums[index] or 1)

							break
						end
					end

					if not hasItem then
						local newItem = BaseObject.GetObject(id, awardNums[index] or 1)

						newItem.awardFlag = awardFlags[index]

						table.insert(buildingItems, newItem)
					end
				end
			end
		end
	end

	table.sort(buildingItems, utils.getSortingFunc("awardFlag", true))
	ClientUtils.CreateBonusGridByItems(self, self.buildBonusGrids, "MainInfoPanel/DispatchInfoPanel/BuildingAwardPanel/ItemPanel/Content", buildingItems)
end

function ActivitySendHeroDlg:onShowDispatchClick()
	self.showBuilding = false

	self.btnShowBuild:setEnable(true)
	self.btnShowDispatch:setEnable(false)
	self.aniInfo:startAni("ShowDispatchPanel")
	self:refreshDispatchPanel()
end

function ActivitySendHeroDlg:onShowBuildClick()
	self.showBuilding = true

	self.btnShowBuild:setEnable(false)
	self.btnShowDispatch:setEnable(true)
	self.aniInfo:startAni("ShowBuildingPanel")
	self:refreshBuildingPanel()
end

function ActivitySendHeroDlg:onDispatchClick()
	CurAvatar:activityRPC(Functor(RPC.opActHomeDispatch, self.actObj.opId), self.actObj.opId)
end

function ActivitySendHeroDlg:onSpeedUpClick()
	local speedItemId = self.miscData.speed_item_id
	local speedItemNum = self.miscData.speed_item_num or 1

	ClientUtils.checkMoneyChange(speedItemId, speedItemNum, Functor(UIManager.showConfirmWithId, self.miscData.speed_up_confirm_id, Slot(self._realSpeedUp, self)))
end

function ActivitySendHeroDlg:_realSpeedUp()
	RPC.opActHomeDispatchSpeedUp(self.actObj.opId)
end

function ActivitySendHeroDlg:onShowDispatchAwardClick()
	RPC.opActHomeDispatchGetAward(self.actObj.opId)
end

function ActivitySendHeroDlg:onHeroUpTipsClick()
	UIManager.getUI("activitySendHeroUpTipsDlg", true):onShowActivity({
		self.actObj.clientTemplateData,
		self.actObj
	})
end

function ActivitySendHeroDlg:onBuildToDispatch()
	if self.actObj:inOpenState() then
		local ui = UIManager.getUI("activitySendHeroBuidingDlg", true)

		ui:onShowActivity({
			self.actObj.clientTemplateData,
			self.actObj
		})
		ui:onShowBuilding(self.selectBuild)
	else
		MsgManager.notice(Lang.get(1870))
	end
end

function ActivitySendHeroDlg:onDispatchDisClick()
	MsgManager.clientNotice(self.miscData.no_count_notice)
end

function ActivitySendHeroDlg:onBtnClose()
	self:setVisible(false)
end

function ActivitySendHeroDlg:refreshData()
	if self.showBuilding then
		self:refreshBuildingPanel()
	else
		self:refreshDispatchPanel()
	end

	if self.actObj.actData:checkDispatchNew() then
		self.iconNewDispatch:setVisible(true)
	else
		self.iconNewDispatch:setVisible(false)
	end

	if self.actObj.actData:checkBuildingNew() then
		self.iconNewBuilding:setVisible(true)
	else
		self.iconNewBuilding:setVisible(false)
	end

	local ui = UIManager.tryGetUI("activitySendHeroBuidingDlg")

	if ui then
		ui:updateActivityData()
	end
end

function ActivitySendHeroDlg:updateActivityData()
	self:refreshData()
end

function ActivitySendHeroDlg:updateRelatedActivityData()
	self:refreshData()
end

return ActivitySendHeroDlg
