-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainStageAwardBox.lua

local ResRandClient = require("ClientData/ResRandClient")
local EventConst = require("EventConst")
local GridHookContainerChild = require("UI/Common/Grid/GridHookContainerChild")
local RookieFocusChild = require("Logic/Beginner/RookieFocusChild")
local MainStagePreviewDepositPanel = require("UI/MainState/PlayEntry/Main/MainStagePreviewDepositPanel")
local NewAwardPreviewPanel = require("UI/MainState/PlayEntry/Main/NewAwardPreviewPanel")
local strClassName = "MainStageAwardBox"
local MainStageAwardBox = Class(strClassName, UIControls.Window)
local OPEN_VOCAL_ID = 2

function MainStageAwardBox:ctor()
	self:initUI()
end

function MainStageAwardBox:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	if CurAvatar and CurAvatar.beginnerLoseMarked then
		self.panelLoseMarked = RookieFocusChild(self, "BtnGet", "System/PlayerGuide/HighLightPanel", 0, 0)

		self.panelLoseMarked:addRedDotHint({
			UIConst.RD_HINT_BEGINNER_HOOK
		})
		self.panelLoseMarked:focus(self.btnGet:getComObj().transform, Const.BEGINNER_LOSE_NOTICE[2])
	end

	self.cellsAward = {}

	local cellAwardPath = "BgPanel/SpeedPanel/Speed"

	for i = 1, 3 do
		local path = cellAwardPath .. i
		local cell = UIControls.Panel(self, path)

		cell.txtAward = UIControls.Label(self, path .. "/TextNum")
		cell.imgIcon = UIControls.Image(self, path .. "/Icon")
		self.cellsAward[i] = cell
	end

	self.gridsItemAward = {}
	self.panelAward = UIControls.Panel(self, "BgPanel/AwardPanel")
	self.panelNone = UIControls.Panel(self, "BgPanel/NoContent")
	self.textTime = UIControls.Label(self, "BgPanel/AwardPanel/TextTime")
	self.txtTimeDesc = UIControls.Label(self, "BgPanel/AwardPanel/TextDec")
	self.panelHookActivity = UIControls.Panel(self, "PreviewPanel")
	self.panelBg = UIControls.Panel(self, "BgPanel")
	self.panelTitle = UIControls.Panel(self, "BgTitle")
	self.textHookActivity = UIControls.Label(self, "PreviewPanel/BgDes/Text")
	self.iconHookActivity = UIControls.Image(self, "PreviewPanel/IconPreview")
	self.gridsHookActivity = {}
	self.panelMainStagePreviewDeposit = MainStagePreviewDepositPanel(self, "BgPanel/PreviewPanel")
	self.textActivityTime = UIControls.Label(self, "PreviewPanel/TextTime")

	self:checkPreViewDeposit()
end

function MainStageAwardBox:onOpen()
	MainStageAwardBox.super.onOpen(self)
	self:update()
	self:checkHookActivityBg()
	CueManager.playGroupVocal(OPEN_VOCAL_ID)
end

function MainStageAwardBox:checkPreViewDeposit()
	local nextRandAwardInfo = CurAvatar:getNextRandomAwardInfo()

	if nextRandAwardInfo then
		self.panelMainStagePreviewDeposit:setNextRandAwardInfo(nextRandAwardInfo)
	end

	self.panelNewAwardPreview = NewAwardPreviewPanel(self, "PreviewInfoPanel")
end

function MainStageAwardBox:changeNewAwardPreivewPanelShow(isShowPreviewPanel)
	self.isShowPreviewPanel = isShowPreviewPanel

	self.panelBg:setVisible(not self.isShowPreviewPanel)
	self.panelTitle:setVisible(not self.isShowPreviewPanel)
	self.panelNewAwardPreview:setVisible(self.isShowPreviewPanel)

	if not self.isShowPreviewPanel then
		self:checkHookActivity()
	else
		self.panelHookActivity:setVisible(false)
	end
end

function MainStageAwardBox:timeDownCallBack(...)
	self.textTime:setText(string.format(Lang.get(30519), math.floor(Const.MAIN_STAGE_DEPOSIT_MAX_TIME / 3600)))
end

function MainStageAwardBox:update()
	self.itemBonus = {}

	local baseAwards = ResRandClient[CurAvatar.mainStageCur.deposit_assgin_award] or {}
	local baseAwardIDs = baseAwards.show_ids or {}
	local baseAwardNums = baseAwards.show_nums or {}
	local bonus = {}

	for index, awardID in ipairs(baseAwardIDs) do
		if awardID == 100001 or awardID == 100004 or awardID == 500000 then
			table.insert(bonus, {
				awardID,
				baseAwardNums[index]
			})
		end
	end

	for i, cell in ipairs(self.cellsAward) do
		local awardID = bonus[i][1]
		local awardNum = bonus[i][2]

		if awardID and awardNum then
			if awardID == Const.MONEY_ID_GOLD then
				awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_GOLD, awardNum)
			elseif awardID == Const.MONEY_ID_HERO_EXP then
				awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_HERO_EXP, awardNum)
			end

			awardNum = math.floor(awardNum * 10)

			cell:setVisible(true)

			local iconPath = BaseObject.getItemIconPath(awardID)

			if iconPath then
				cell.imgIcon:setImage(iconPath[1], iconPath[2])
			end

			cell.txtAward:setText(string.format(Lang.get(30520), ClientUtils.getNumShortStr(awardNum)))
		else
			cell:setVisible(false)
		end
	end

	local awards = CurAvatar:getMainStageHookAward()
	local activityBonus = awards.activityBonus or {}
	local gridStart = 1

	for awardID, awardNum in pairs(awards.base) do
		if awardNum >= 1 then
			local grid = self:getBonusGrid(gridStart)

			if activityBonus[awardID] then
				awardNum = awardNum + activityBonus[awardID][1]

				local actObj = activityBonus[awardID][2]

				grid:setHook(true)

				if actObj and actObj.templateData and actObj.templateData.grid_special_config then
					grid:setHookIcon(actObj.templateData.grid_special_config)
				end

				activityBonus[awardID] = nil
			else
				grid:setHook(false)
			end

			grid:setObj(BaseObject.GetObject(awardID, awardNum))
			grid:setVisible(true)
			table.insert(self.itemBonus, grid.object)

			gridStart = gridStart + 1
		end
	end

	for i, item in ipairs(awards.item) do
		local grid = self:getBonusGrid(gridStart)

		grid:setObj(item)
		table.insert(self.itemBonus, grid.object)
		grid:setVisible(true)

		gridStart = gridStart + 1

		grid:setHook(false)
	end

	for awardID, awardInfo in pairs(activityBonus) do
		local awardNum = awardInfo[1]

		if awardNum > 0 then
			local grid = self:getBonusGrid(gridStart)

			grid:setObj(BaseObject.GetObject(awardID, awardNum))
			grid:setVisible(true)

			local actObj = awardInfo[2]

			grid:setHook(true)

			if actObj and actObj.templateData and actObj.templateData.grid_special_config then
				grid:setHookIcon(actObj.templateData.grid_special_config)
			end

			table.insert(self.itemBonus, grid.object)

			gridStart = gridStart + 1
		end
	end

	self:checkHookActivity()

	for j = gridStart, #self.gridsItemAward do
		local grid = self.gridsItemAward[j]

		grid:setVisible(false)
	end

	if gridStart == 1 then
		self.panelAward:setVisible(false)
		self.panelNone:setVisible(true)
		self.btnGet:setVisible(false)
	else
		self.panelAward:setVisible(true)
		self.panelNone:setVisible(false)
		self.btnGet:setVisible(true)
	end

	if CurAvatar.stageHookAwardGotTime and CurAvatar.stageHookAwardGotTime > 0 then
		ClientTimerManager.AddSecondFormatTickUI(self.textTime, ClientUtils.getServerTime() - CurAvatar.stageHookAwardGotTime, true, Lang.get(48672), Slot(self.timeDownCallBack, self), Const.MAIN_STAGE_DEPOSIT_MAX_TIME)
	else
		self.textTime:setText("")
	end

	self.txtTimeDesc:setText(string.format(Lang.get(48581), math.floor(Const.MAIN_STAGE_DEPOSIT_MAX_TIME / 3600)))
end

function MainStageAwardBox:checkHookActivityBg()
	local actObj = CurAvatar:getHookActivity()

	if actObj and actObj.clientTemplateData then
		local template_args = actObj.clientTemplateData.template_args

		if template_args and template_args[3] and not self.actFrameCell then
			self.actFrameCell = UIControls.Child(self, "PreviewPanel/FramePanel", "System/Activity/" .. template_args[3])

			self.actFrameCell:setVisible(true)
		end
	end
end

function MainStageAwardBox:checkHookActivity(order)
	if self.isShowPreviewPanel then
		return
	end

	local actObj = CurAvatar:getHookActivity()

	if actObj then
		self.panelHookActivity:setVisible(true)
		self.textHookActivity:setText(actObj.templateData.rule_desc or "")

		local template_args = actObj.clientTemplateData.template_args

		if template_args then
			local randId = tonumber(template_args[1])

			if randId then
				ClientUtils.CreateBonusGrid(self, self.gridsHookActivity, "PreviewPanel/RewardPanel/RewardList", randId, false, 3, true)
			end
		end

		local actClientData = actObj.actData.clientData

		if actClientData then
			local previewIconPath = actClientData.preview_icon_path
			local previewIcon = actClientData.preview_icon_name

			if previewIconPath and previewIcon then
				self.iconHookActivity:setImage(previewIconPath, previewIcon)
			end
		end

		if actObj:inOpenState() then
			ClientTimerManager.AddSecondFormatTickUI(self.textActivityTime, actObj:getRemainOpenTime(), false, Lang.get(54586))
		else
			ClientTimerManager.RemoveSecondTickUI(self.textActivityTime)
			self.textActivityTime:setText(Lang.get(32793))
		end
	else
		self.panelHookActivity:setVisible(false)
	end
end

function MainStageAwardBox:getBonusGrid(order)
	local grid = self.gridsItemAward[order]

	if grid == nil then
		grid = GridHookContainerChild(self, "BgPanel/AwardPanel/AwardList/Content", "System/Common/Grid/GridHookContainer")
		grid.mDisableWays = true
		self.gridsItemAward[order] = grid
	end

	return grid
end

function MainStageAwardBox:onAwardGet()
	local uiObjList = {}

	for _, grid in pairs(self.gridsItemAward) do
		table.insert(uiObjList, {
			grid.object.id,
			grid.grid.imgIcon,
			grid.object.num
		})
	end

	EventCenter.sendEvent(EventConst.MONEY_FLY, UIConst.FLY_MODE_UI_OBJ, uiObjList)
	self:setVisible(false)
	RPC.opActDepositGetAward()
	RPC.depositAwardGet()

	if CurAvatar and CurAvatar.beginnerLoseMarked then
		if CurAvatar:getBeginnerHintLvUpHero(true) then
			RedDotManager.setKeyState(UIConst.RD_HINT_BEGINNER_HOOK, false)
			RedDotManager.setKeyState(UIConst.RD_HINT_BEGINNER_HERO, true)
		else
			CurAvatar:noticeBeginnerHookResult()
		end
	end
end

function MainStageAwardBox:onBtnGetClick(sender)
	CurAvatar:checkItemsFull(self.itemBonus, Slot(self.onAwardGet, self))
end

function MainStageAwardBox:onBtnCloseClick(sender)
	self:setVisible(false)
end

return MainStageAwardBox
