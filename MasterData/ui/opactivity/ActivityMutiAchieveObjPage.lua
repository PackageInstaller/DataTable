-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMutiAchieveObjPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResColor = require("ClientData/ResColor")
local ActivityMutiAchieveCell = Class("ActivityMutiAchieveCell", UIControls.ScrollViewLoopCell)
local SOURCEIMG_PATH = "Atlas/ActivityAtlas/ActivityAtlas01"

function ActivityMutiAchieveCell:ctor()
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

	self.textState = UIControls.Panel(self, "Bg/TextState")

	if UIControls.checkControlFunc(self, "Bg/TextLimit") then
		self.textLimit = UIControls.Label(self, "Bg/TextLimit")
	end

	if UIControls.checkControlFunc(self, "Bg/DateTypePanel") then
		self.dateTypePanel = UIControls.Panel(self, "Bg/DateTypePanel")
		self.imgDailyType = UIControls.Image(self, "Bg/DateTypePanel")
	end

	if UIControls.checkControlFunc(self, "Bg/OtherTypePanel") then
		self.otherTypePanel = UIControls.Panel(self, "Bg/OtherTypePanel")
		self.imgOtherType = UIControls.Image(self, "Bg/OtherTypePanel")
	end

	if UIControls.checkControlFunc(self, "Bg/DailyPanel") then
		self.dailyPanel = UIControls.Panel(self, "Bg/DailyPanel")
		self.refreshTime = UIControls.Label(self, "Bg/DailyPanel/TextTime")
		self.dailyState = UIControls.Label(self, "Bg/DailyPanel/TextState")
	end

	if UIControls.checkControlFunc(self, "Bg/LuckycatsPanel") then
		self.panelRound = UIControls.Panel(self, "Bg/LuckycatsPanel")
	end

	self.items = {}
	self.curPanelPath = "NmlPanel"
	self.isNextToGet = false
	self.stateUIs = {}
	self.grids = {}
end

function ActivityMutiAchieveCell:setData(info)
	for _, gridItem in ipairs(self.grids) do
		gridItem:destroy()
	end

	self.grids = {}
	self.data = info.data
	self.state = info.state
	self.progress = info.progress
	self.opId = info.opId
	self.actType = self.data.type
	self.actData = info.actData
	self.miscData = ResOpActivityAchieveMisc[self.data.detail_id][self.actType]

	ClientUtils.CreateBonusGrid(self, self.grids, "Bg/GridAward", info.data.award, true, nil, true)
	self:_refrehState()

	if self.panelRound then
		self.panelRound:setVisible(self.miscData.max_round and self.miscData.max_round > 1)
	end
end

function ActivityMutiAchieveCell:_refrehState()
	local _pro = 0
	local _rou = 0
	local roundMax = self.miscData.max_round

	if self.progress ~= nil then
		_rou = self.progress.round
	end

	local _pro, maxPro = self.actData:getAchieveShowProgress(self.data)

	self.btnConfirm.finish = false

	if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceSel")
		self.btnGo:setVisible(false)
		self.sliderBar:setVisible(true)
		self.btnConfirm:setVisible(true)

		if self.textLimit then
			self.textLimit:setVisible(true)
		end

		self.textState:setVisible(false)

		if self.actType == Const.ACTIVITY_TYPE_PLAY_NODE then
			_pro = 1
		end

		if self.imgOtherType then
			self.imgOtherType:setImage(self.mParent.cellAtlas, "BgChallenge01")
		end

		if self.imgDailyType then
			self.imgDailyType:setImage(self.mParent.cellAtlas, "BgEveryDay01")
		end
	elseif self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceNml")
		self.btnGo:setVisible(true)
		self.sliderBar:setVisible(true)
		self.btnConfirm:setVisible(false)

		if self.textLimit then
			self.textLimit:setVisible(true)
		end

		self.textState:setVisible(false)

		if self.imgOtherType then
			self.imgOtherType:setImage(self.mParent.cellAtlas, "BgChallenge01")
		end

		if self.imgDailyType then
			self.imgDailyType:setImage(self.mParent.cellAtlas, "BgEveryDay01")
		end
	else
		self.imgBg:setImage(self.mParent.cellAtlas, "BgActivityAchiDiceDis")
		self.btnGo:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.textState:setVisible(true)
		self.sliderBar:setVisible(false)

		if self.textLimit then
			self.textLimit:setFontColor(ResColor.GREYMIDDLE)
			self.textLimit:setVisible(false)
		end

		self.btnConfirm.finish = true

		if self.imgOtherType then
			self.imgOtherType:setImage(self.mParent.cellAtlas, "BgChallenge02")
		end

		if self.imgDailyType then
			self.imgDailyType:setImage(self.mParent.cellAtlas, "BgEveryDay02")
		end
	end

	self.textRule:setText(self.data.desc_name)
	self.textBarpPogress:setText(_pro .. "/" .. maxPro)
	self.sliderBar:setValue(_pro / maxPro)

	if self.textLimit then
		self.textLimit:setText(utils.format(Lang.get(30598), _rou, roundMax))
	end

	if self.dateTypePanel and self.otherTypePanel then
		self.dateTypePanel:setVisible(self.miscData.refresh_time ~= nil)
		self.otherTypePanel:setVisible(self.miscData.refresh_time == nil)
	end

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

	if self.refreshTime and self.miscData.refresh_time ~= nil then
		local nextRestTime = self.actData:getNextResetTime(self.actType)

		if nextRestTime and nextRestTime ~= 0 and self.state == Const.ACT_ACHIEVE_STATE_GOT and _rou < roundMax then
			self.dailyPanel:setVisible(true)
			self.btnGo:setVisible(false)
			self.btnConfirm:setVisible(false)
			self.textState:setVisible(false)

			local curTime = ClientUtils.getServerTime()

			if curTime <= nextRestTime then
				local countTime = nextRestTime - curTime

				ClientTimerManager.AddSecondFormatTickUI(self.refreshTime, countTime, false, Lang.get(48670), Slot(self.resetTimeOver, self))
			else
				self:resetTimeOver()
			end
		else
			self.dailyPanel:setVisible(false)
		end
	else
		self.dailyPanel:setVisible(false)
	end
end

function ActivityMutiAchieveCell:resetTimeOver()
	self.actData:resetDaily(self.actType)

	if self.actData.actObject then
		self.actData.actObject:checkNew()
	end

	self.mParent:_setData()
end

function ActivityMutiAchieveCell:ConfirmClick(sender)
	if self.miscData.refresh_time ~= nil then
		local nextResetTime = self.actData:getNextResetTime(self.actType)
		local curTime = ClientUtils.getServerTime()

		if nextResetTime and nextResetTime ~= 0 and nextResetTime <= curTime then
			self:resetTimeOver()
			MsgManager.clientNotice(407)

			return nil
		end
	end

	if sender.finish then
		-- block empty
	else
		sender:setVisible(false)
		sender.cell:startAni("ChangeActivityAchiDiceCell", true)
	end
end

function ActivityMutiAchieveCell:onGoClick(sender)
	local jumpId = self.miscData.jump_id

	if jumpId then
		JumpGuideManager.jump(jumpId)
	end
end

function ActivityMutiAchieveCell:_introAnimEnd()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.data.index, self.actType), self.opId)
end

local classNameStr = "ActivityMutiAchieveObjPage"
local ActivityMutiAchieveObjPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityMutiAchieveObjPage, ActivityPanelMixin)

function ActivityMutiAchieveObjPage:ctor()
	self.isInited = false
end

function ActivityMutiAchieveObjPage:initUI()
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

	self.cellPrefabPath = "System/Activity/ActivityMonopoly/ActivityAchiDiceCell"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPrefabPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/ActivityAchiDiceCell"
	end
end

function ActivityMutiAchieveObjPage:_setData()
	self.achieves = {}

	if self.actObj.templateData.relate_act then
		self.achieves = self.actObj.templateData.relate_act
	end

	self.achieveObjs = {
		self.actObj
	}

	for key, value in pairs(self.achieves) do
		CurAvatar:addActivityMutiAchieveRelated(value, "activityMainDlg", self.actObj.actId)

		local actObj = CurAvatar:getActivityObj(value)

		if actObj then
			table.insert(self.achieveObjs, actObj)
		end
	end

	self.achieveCellDatas = {}

	for index, obj in ipairs(self.achieveObjs) do
		local actData = obj.actData
		local showList = actData:getGroupShowAchieveDataList()

		for _, achieveData in ipairs(showList or {}) do
			local state = actData:getAchieveState(achieveData.type, achieveData.index)
			local info = {}

			info.data = achieveData
			info.state = state
			info.progress = actData.serverData[achieveData.type]
			info.opId = obj.opId
			info.actData = actData

			table.insert(self.achieveCellDatas, info)
		end
	end

	if not self.isInited then
		self:sortData(true)
	else
		self:sortData(true)
	end

	self:refreshBtnReceiveAll()

	self.isInited = true
end

function ActivityMutiAchieveObjPage:sortData(isSort)
	if isSort then
		for i, v in ipairs(self.achieveCellDatas or {}) do
			if v.data.show_priority == nil then
				v.data.show_priority = 999
			end

			if v.state == 2 then
				v.sort = 1
			elseif v.state == 3 then
				v.sort = 2
			else
				v.sort = 3
			end
		end

		table.sort(self.achieveCellDatas, function(a, b)
			if a.sort ~= b.sort then
				return a.sort < b.sort
			elseif a.data.show_priority ~= b.data.show_priority then
				return a.data.show_priority < b.data.show_priority
			elseif a.data.type ~= b.data.type then
				return a.data.type < b.data.type
			else
				return a.data.index < b.data.index
			end
		end)
	end

	self.scrollItems:setTotalCount(#self.achieveCellDatas)
end

function ActivityMutiAchieveObjPage:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityMutiAchieveCell(sender, self.cellPrefabPath, newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	self.cells[newIdx]:setData(self.achieveCellDatas[newIdx])
end

function ActivityMutiAchieveObjPage:onActivityDataRefresh(actObj)
	self:_setData()
end

function ActivityMutiAchieveObjPage:_onShow()
	self:_setData()
end

function ActivityMutiAchieveObjPage:refreshBtnReceiveAll()
	if not self.receiveAllPanel then
		return
	end

	local hasBonus = false

	for index, obj in ipairs(self.achieveObjs) do
		local actData = obj.actData

		if actData:canGetBonus() then
			hasBonus = true

			break
		end
	end

	self.receiveAllPanel:setVisible(hasBonus)
end

function ActivityMutiAchieveObjPage:onClickBtnReceiveAll()
	local hasBonusAct = {}

	for index, obj in ipairs(self.achieveObjs) do
		local actData = obj.actData

		if actData:canGetBonus() then
			table.insert(hasBonusAct, obj.opId)
		end
	end

	CurAvatar:activityRPC(Functor(RPC.opActAchieveGetAllAward, hasBonusAct), self.actObj.opId)
end

return ActivityMutiAchieveObjPage
