-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityAchieveDicPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResItem = require("ClientData/ResItem")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResColor = require("ClientData/ResColor")
local ActivityAchiDiceCell = Class("ActivityAchiDiceCell", UIControls.ScrollViewLoopCell)
local SOURCEIMG_PATH = "Atlas/ActivityAtlas/ActivityAtlas01"

function ActivityAchiDiceCell:ctor()
	self.AniAchiCell = UIControls.UIAni(self, "")

	self.AniAchiCell:addEventFinish(self._introAnimEnd)

	self.imgBg = UIControls.Image(self, "Bg")
	self.sliderBar = UIControls.Slider(self, "Bg/Slider")
	self.textBarpPogress = UIControls.Label(self, "Bg/Slider/TextProgress")
	self.textRule = UIControls.Label(self, "Bg/TextRule")
	self.btnGo = UIControls.Button(self, "Bg/BtnGo")

	self.btnGo:addEventClick(self.onGoClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")
	self.btnConfirm.cell = self.AniAchiCell

	self.btnConfirm:addEventClick(self.ConfirmClick)

	self.textState = UIControls.Label(self, "Bg/TextState")
	self.textLimit = UIControls.Label(self, "Bg/TextLimit")
	self.items = {}
	self.curPanelPath = "NmlPanel"
	self.isNextToGet = false
	self.stateUIs = {}
	self.grids = {}
end

function ActivityAchiDiceCell:setData(info)
	for _, gridItem in ipairs(self.grids) do
		gridItem:destroy()
	end

	self.grids = {}
	self.data = info.data
	self.state = info.state
	self.progress = info.progress
	self.opId = info.opId
	self.actType = self.data.type
	self.miscData = ResOpActivityAchieveMisc[self.data.detail_id][self.actType]

	ClientUtils.CreateBonusGrid(self, self.grids, "Bg/GridAward", info.data.award, true, nil, true)
	self:_refrehState()
end

function ActivityAchiDiceCell:_refrehState()
	local _pro = 0
	local _rou = 0
	local roundMax = self.miscData.max_round

	if self.progress ~= nil then
		_pro = self.progress.progress
		_rou = self.progress.round
	end

	self.btnConfirm.finish = false

	if self.state == 2 then
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceSel")
		self.btnGo:setVisible(false)
		self.sliderBar:setVisible(true)
		self.btnConfirm:setVisible(true)
	elseif self.state == 3 then
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceNml")
		self.btnGo:setVisible(true)
		self.sliderBar:setVisible(true)
		self.btnConfirm:setVisible(false)
	else
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceDis")
		self.btnGo:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.textState:setVisible(true)
		self.sliderBar:setVisible(false)
		self.textLimit:setFontColor(ResColor.GREYMIDDLE)

		_rou = roundMax
		self.btnConfirm.finish = true
	end

	self.textRule:setText(self.data.desc_name)
	self.textBarpPogress:setText(_pro .. "/" .. self.data.param)
	self.sliderBar:setValue(_pro / self.data.param)
	self.textLimit:setText(utils.format(Lang.get(30598), _rou, roundMax))

	local gridCfgId = self.miscData and self.miscData.grid_id or nil
	local iconPath, iconName

	if gridCfgId then
		local resGridData = ResSpecialGridConfig[gridCfgId]

		iconPath = resGridData.get_icon_path
		iconName = resGridData.get_icon_name
	end

	for i, grid in ipairs(self.grids) do
		if iconPath then
			grid:changeGetImg(iconPath, iconName)
		end

		grid:setState(false, self.state == 1, true)
	end
end

function ActivityAchiDiceCell:ConfirmClick(sender)
	if sender.finish then
		-- block empty
	else
		sender:setVisible(false)
		sender.cell:startAni("ChangeActivityAchiDiceCell", true)
	end
end

function ActivityAchiDiceCell:onGoClick(sender)
	local jumpId = self.miscData.jump_id

	if jumpId then
		JumpGuideManager.jump(jumpId)
	end
end

function ActivityAchiDiceCell:_introAnimEnd()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.data.index, self.actType), self.opId)
end

local classNameStr = "ActivityAchieveDicPage"
local ActivityAchieveDicPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityAchieveDicPage, ActivityPanelMixin)

function ActivityAchieveDicPage:initUI()
	self.cells = {}
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textRule = UIControls.Label(self, "BgDes/TextDes")
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ContentList", 0, self._onCellChanged)

	if UIControls.checkControlFunc(self, "GetAllPanel") then
		self.receiveAllPanel = UIControls.Panel(self, "GetAllPanel")
		self.btnReceiveAll = UIControls.Button(self, "GetAllPanel/BtnGetAll")

		self.btnReceiveAll:addEventClick(self.onClickBtnReceiveAll)
	end

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.cellAtlas = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
	else
		self.cellAtlas = "Atlas/ActivityAtlas/ActivityAchiDiceAtlas"
	end
end

function ActivityAchieveDicPage:_setData(pageData)
	local detailData = self.actObj.actData:getSortedData()

	self:_setCells(detailData)
	self:refreshBtnReceiveAll()
end

function ActivityAchieveDicPage:_onShow()
	self:refreshScrollItem()
end

function ActivityAchieveDicPage:_setCells(detailData)
	local actData = self.actObj.actData

	self.achData = {}

	for idx, data in ipairs(detailData) do
		local state = actData:getAchieveState(data.type, data.index)
		local info = {}

		info.data = data
		info.state = state
		info.progress = self.actObj.actData.serverData[data.type]
		info.opId = self.actObj.opId

		table.insert(self.achData, info)
	end

	self:refreshScrollItem()
end

function ActivityAchieveDicPage:refreshScrollItem()
	self.scrollItems:setTotalCount(#self.achData, 1)
end

function ActivityAchieveDicPage:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		if self.replaceableCellPath and self.replaceableCellPath[1] then
			targetCell = ActivityAchiDiceCell(sender, "System/Activity/" .. self.replaceableCellPath[1] .. "/ActivityAchiDiceCell", newIdx, 0, 0)
		else
			targetCell = ActivityAchiDiceCell(sender, "System/Activity/ActivityMonopoly/ActivityAchiDiceCell", newIdx, 0, 0)
		end
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	self.cells[newIdx]:setData(self.achData[newIdx])
end

function ActivityAchieveDicPage:onActivityDataRefresh(actObj)
	self:_setData(nil)
end

function ActivityAchieveDicPage:refreshBtnReceiveAll()
	if not self.receiveAllPanel then
		return
	end

	self.receiveAllPanel:setVisible(self.actObj.actData:canGetBonus())
end

function ActivityAchieveDicPage:onClickBtnReceiveAll()
	local opId = self.actObj.opId

	CurAvatar:activityRPC(Functor(RPC.opActAchieveGetAllAward, {
		opId
	}), opId)
end

return ActivityAchieveDicPage
