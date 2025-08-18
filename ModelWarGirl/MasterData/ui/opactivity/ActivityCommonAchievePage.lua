-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCommonAchievePage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResItem = require("ClientData/ResItem")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResColor = require("ClientData/ResColor")
local ActivityAchiCommonCell = Class("ActivityAchiCommonCell", UIControls.ScrollViewLoopCell)

function ActivityAchiCommonCell:ctor()
	self.imgBg = UIControls.Image(self, "Bg")
	self.sliderBar = UIControls.Slider(self, "Bg/Slider")
	self.textBarpPogress = UIControls.Label(self, "Bg/Slider/TextProgress")
	self.textRule = UIControls.Label(self, "Bg/TextRule")
	self.btnGo = UIControls.Button(self, "Bg/BtnGo")

	self.btnGo:addEventClick(self.onGoClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.ConfirmClick)

	self.textState = UIControls.Label(self, "Bg/TextState")
	self.grids = {}
end

function ActivityAchiCommonCell:setData(info)
	self.data = info.data
	self.state = info.state
	self.opId = info.opId
	self.actType = self.data.type
	self.miscData = ResOpActivityAchieveMisc[self.data.detail_id][self.actType]

	ClientUtils.CreateBonusGrid(self, self.grids, "Bg/GridAward", info.data.award, true, nil, true)
	self:_refrehState()
end

function ActivityAchiCommonCell:_refrehState()
	local nowPro, maxPro = self.mParent.actData:getAchieveShowProgress(self.data)

	self.btnConfirm.finish = false

	if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceSel")
		self.btnGo:setVisible(false)
		self.sliderBar:setVisible(true)
		self.btnConfirm:setVisible(true)
		self.textState:setVisible(false)
	elseif self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceNml")
		self.btnGo:setVisible(true)
		self.sliderBar:setVisible(true)
		self.btnConfirm:setVisible(false)
		self.textState:setVisible(false)
	else
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceDis")
		self.btnGo:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.textState:setVisible(true)
		self.sliderBar:setVisible(false)

		self.btnConfirm.finish = true
	end

	self.textRule:setText(self.data.desc_name)
	self.textBarpPogress:setText(nowPro .. "/" .. maxPro)
	self.sliderBar:setValue(nowPro / maxPro)

	for i, grid in ipairs(self.grids) do
		grid:setGet(self.state == Const.ACT_ACHIEVE_STATE_GOT)
	end
end

function ActivityAchiCommonCell:ConfirmClick(sender)
	self.btnConfirm:setVisible(false)
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.data.index, self.actType), self.opId)
end

function ActivityAchiCommonCell:onGoClick(sender)
	local jumpId = self.miscData.jump_id

	if jumpId then
		JumpGuideManager.jump(jumpId)
	end
end

local classNameStr = "ActivityCommonAchievePage"
local ActivityCommonAchievePage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityCommonAchievePage, ActivityPanelMixin)

function ActivityCommonAchievePage:initUI()
	self.closeBtn = UIControls.Button(self, "CloseBtn")

	self.closeBtn:addEventClick(self._onClickClose)

	self.cells = {}
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textRule = UIControls.Label(self, "BgDes/TextDes")
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ContentList", 0, self._onCellChanged)

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.cellAtlas = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
	else
		self.cellAtlas = "Atlas/ActivityAtlas/ActivityAchiDiceAtlas"
	end
end

function ActivityCommonAchievePage:_setData(pageData)
	self.actData = self.actObj.actData

	local detailData = self.actData:getSortedData()

	self:_setCells(detailData)
end

function ActivityCommonAchievePage:_setCells(detailData)
	self.achData = {}

	for idx, data in ipairs(detailData) do
		local state = self.actData:getAchieveState(data.type, data.index)
		local info = {}

		info.data = data
		info.state = state
		info.opId = self.actObj.opId

		table.insert(self.achData, info)
	end

	self.scrollItems:setTotalCount(#self.achData, 1)
end

function ActivityCommonAchievePage:_onShow()
	return
end

function ActivityCommonAchievePage:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		if self.replaceableCellPath and self.replaceableCellPath[1] then
			targetCell = ActivityAchiCommonCell(sender, "System/Activity/" .. self.replaceableCellPath[1] .. "/ActivityAchiCommonCell", newIdx, 0, 0)
		else
			targetCell = ActivityAchiCommonCell(sender, "System/Activity/ActivityMonopoly/ActivityAchiCommonCell", newIdx, 0, 0)
		end
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	self.cells[newIdx]:setData(self.achData[newIdx])
end

function ActivityCommonAchievePage:onActivityDataRefresh(actObj)
	self:_setData()
end

function ActivityCommonAchievePage:_onClickClose()
	self.mParent:setVisible(false)
end

return ActivityCommonAchievePage
