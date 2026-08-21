-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityAchieveMaxRound.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResItem = require("ClientData/ResItem")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResColor = require("ClientData/ResColor")
local ResOpActivityAchieveDetailMisc = require("ClientData/ResOpActivityAchieveDetailMisc")
local ActivityAchiMaxRoundCell = Class("ActivityAchiMaxRoundCell", UIControls.Child)
local SOURCEIMG_PATH = "Atlas/ActivityAtlas/ActivityRoundsTask1"

function ActivityAchiMaxRoundCell:ctor()
	self.aniAchiCell = UIControls.UIAni(self, "")

	self.aniAchiCell:addEventFinish(self._introAnimEnd)

	self.imgBg = UIControls.Image(self, "Bg")
	self.sliderBar = UIControls.Slider(self, "Bg/Slider")
	self.textBarpPogress = UIControls.Label(self, "Bg/Slider/TextProgress")
	self.textRule = UIControls.Label(self, "Bg/TextRule")
	self.btnGo = UIControls.Button(self, "Bg/BtnGo")

	self.btnGo:addEventClick(self.onGoClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.txtState = UIControls.Panel(self, "Bg/TextState")
	self.grids = {}
end

function ActivityAchiMaxRoundCell:setData(achData, opId)
	self.opId = opId
	self.actType = achData.type
	self.achData = achData

	ClientUtils.CreateBonusGrid(self, self.grids, "Bg/GridAward", achData.award, true, nil, true)
	self.textRule:setText(achData.desc_name or "")

	self.miscData = ResOpActivityAchieveMisc[achData.detail_id][self.actType]
	self.detailMiscData = ResOpActivityAchieveDetailMisc[achData.detail_id]

	local gridCfgId = self.miscData and self.miscData.grid_id

	if gridCfgId then
		local resGridData = ResSpecialGridConfig[gridCfgId]

		if resGridData.get_icon_path and resGridData.get_icon_name then
			for i, grid in ipairs(self.grids) do
				grid:changeGetImg(resGridData.get_icon_path, resGridData.get_icon_name)
			end
		end
	end
end

function ActivityAchiMaxRoundCell:setState(cellState, cellProgress, maxRound, nowRound)
	self.nowRound = nowRound
	self.maxRound = maxRound
	self.cellState = cellState

	local isSingleRoundShow = self.detailMiscData and self.detailMiscData.one_round_num

	self.isSingleRoundShow = isSingleRoundShow

	local imgPath = "Atlas/ActivityAtlas/ActivityRoundsTask1"

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[2] then
		imgPath = "Atlas/ActivityAtlas/" .. self.mParent.replaceableCellPath[2]
	end

	if self.nowRound >= self.maxRound or self.cellState == Const.ACT_ACHIEVE_STATE_GOT and not isSingleRoundShow then
		self.imgBg:setImage(imgPath, "BgEntryDis")
		self.btnGo:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.txtState:setVisible(true)
		self.sliderBar:setVisible(false)

		for i, grid in ipairs(self.grids) do
			grid:setGet(true)
		end
	else
		self.txtState:setVisible(false)
		self.sliderBar:setVisible(true)

		local cellProgress = math.min(cellProgress, self.achData.param)

		self.textBarpPogress:setText(cellProgress .. "/" .. self.achData.param)
		self.sliderBar:setValue(cellProgress / self.achData.param)

		if self.cellState == Const.ACT_ACHIEVE_STATE_ENOUGH then
			self.imgBg:setImage(imgPath, "BgEntrySel")
			self.btnGo:setVisible(false)
			self.btnConfirm:setVisible(true)
		else
			self.imgBg:setImage(imgPath, "BgEntryNml")
			self.btnGo:setVisible(true)
			self.btnConfirm:setVisible(false)
		end

		for i, grid in ipairs(self.grids) do
			grid:setGet(false)
		end
	end
end

function ActivityAchiMaxRoundCell:onConfirmClick(sender)
	if self.isSingleRoundShow then
		sender:setVisible(false)
		self.aniAchiCell:startAni("ChangeActivitySpecialTaskCell", true)
	else
		self:_introAnimEnd()
	end
end

function ActivityAchiMaxRoundCell:onGoClick(sender)
	local jumpId = self.miscData.jump_id

	if jumpId then
		JumpGuideManager.jump(jumpId)
	end
end

function ActivityAchiMaxRoundCell:_introAnimEnd()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.achData.index, self.actType), self.opId)
end

local classNameStr = "ActivityAchieveMaxRound"
local ActivityAchieveMaxRound = Class(classNameStr, UIControls.Child)

MixinClass(ActivityAchieveMaxRound, ActivityPanelMixin)

function ActivityAchieveMaxRound:initUI()
	if not self.cells then
		self.cells = {}
		self.grids = {}
		self.textTime = UIControls.Label(self, "BgTime/TextTime")
		self.textRule = UIControls.Label(self, "BgDes/TextDes")
		self.sliderBar = UIControls.Slider(self, "Slider")
		self.textBarpPogress = UIControls.Label(self, "SliderNum")
		self.btnFinalBonus = UIControls.Button(self, "BtnConfirm")

		self.btnFinalBonus:addEventClick(self.onGetFinalBonus)

		self.iconNew = UIControls.Panel(self, "BtnConfirm/IconNew")
		self.txtState = UIControls.Panel(self, "TextState")
		self.efx = UIControls.LazyEffectPlayer(self, "Efx")
		self.slot4finalBonus = Slot(self.afterFinalBonus, self)
	end
end

function ActivityAchieveMaxRound:_setData(pageData)
	local detailData = {}

	for actType, cData in pairs(self.actObj.actData.clientData) do
		if cData[1] then
			table.insert(detailData, cData[1])
		end
	end

	table.sort(detailData, function(a, b)
		if a.show_priority and b.show_priority and a.show_priority ~= b.show_priority then
			return a.show_priority < b.show_priority
		end

		return a.type < b.type
	end)

	local path = "System/Activity/ActivitySpecialTask/ActivitySpecialTaskCell2"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		path = "System/Activity/" .. self.replaceableCellPath[1]
	end

	for index = #self.cells + 1, #detailData do
		local targetCell = ActivityAchiMaxRoundCell(self, "ContentList/Content", path)

		self.cells[index] = targetCell
	end

	for index, cell in ipairs(self.cells) do
		local achData = detailData[index]

		if achData then
			cell:setVisible(true)
			cell:setData(achData, self.actObj.opId)
		else
			cell:setVisible(false)
		end
	end

	self.maxRound = self.actObj.actData.totalMaxRound or 1

	ClientUtils.CreateBonusGrid(self, self.grids, "GridAward", self.actObj.actData.finalBonus, true, nil, true)
	self.btnFinalBonus:setVisible(true)
end

function ActivityAchieveMaxRound:_onShow()
	local actData = self.actObj.actData
	local nowRound = actData.totalRound or 0

	for idx, cell in ipairs(self.cells) do
		local state = actData:getAchieveState(cell.actType, cell.achData.index)
		local nowProgress = actData:getAchieveProgress(cell.actType)

		cell:setState(state, nowProgress, self.maxRound, nowRound)
	end

	self.sliderBar:setValue(nowRound / self.maxRound)

	if actData.oneRoundPro then
		self.textBarpPogress:setText(nowRound * actData.oneRoundPro .. "/" .. self.maxRound * actData.oneRoundPro)
	else
		self.textBarpPogress:setText(nowRound .. "/" .. self.maxRound)
	end

	if actData.finalBonus then
		for index, grid in ipairs(self.grids) do
			grid:setGet(actData.gotFinalAward == 1)
		end

		self.btnFinalBonus:setVisible(actData.gotFinalAward ~= 1)
		self.txtState:setVisible(actData.gotFinalAward == 1)
	end

	if nowRound >= self.maxRound and actData.gotFinalAward ~= 1 then
		self.btnFinalBonus:setEnable(true)
		self.iconNew:setVisible(true)
	else
		self.btnFinalBonus:setEnable(false)
		self.iconNew:setVisible(false)
	end
end

function ActivityAchieveMaxRound:onActivityDataRefresh(actObj)
	self:_onShow()
end

function ActivityAchieveMaxRound:onGetFinalBonus()
	self.finalBonusFlag = true

	CurAvatar:activityRPC(Functor(RPC.opActAchieveFinalAward, self.actObj.opId), self.actObj.opId)
end

function ActivityAchieveMaxRound:onGetActivityBonus(bonusFunc)
	if self.finalBonusFlag == true and self.actObj.templateData.lock_act_id then
		bonusFunc(self.slot4finalBonus)

		self.finalBonusFlag = false
	else
		bonusFunc()
	end
end

function ActivityAchieveMaxRound:afterFinalBonus()
	self.efx:setVisible(true)
	self.efx:playEffect()

	local mainUI = UIManager.getUI("activityMainDlg", nil, false)

	if mainUI then
		mainUI:changePageToAnotherAct(self.actObj.actId, self.actObj.templateData.lock_act_id[1])
	end
end

return ActivityAchieveMaxRound
