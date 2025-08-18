-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayMainDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivitySeasonBPMisc = require("ClientData/ResOpActivitySeasonBPMisc")
local ResOpActivitySeasonBPPreviewShow = require("ClientData/ResOpActivitySeasonBPPreviewShow")
local ResOpActivityeAutoOpen = require("ClientData/ResOpActivityeAutoOpen")
local ResOpActivitySeasonBPShow = require("ClientData/ResOpActivitySeasonBPShow")
local SeasonPlayMainPanel = require("UI/OpActivity/SeasonPlay/SeasonPlayMainPanel")
local SeaSonPlayMainBtn = Class("SeaSonPlayMainBtn", UIControls.Button)

function SeaSonPlayMainBtn:ctor(...)
	self:initUI()
end

function SeaSonPlayMainBtn:initUI(...)
	self.txtName = UIControls.Label(self, self.mPath .. "/TxtName")
	self.icon = UIControls.Image(self, self.mPath .. "/Icon")
	self.txtName = UIControls.Label(self, self.mPath .. "/TxtName")

	self:addEventClick(Slot(self.onBtnPlayClick, self))

	self.iconNewSel = UIControls.Panel(self, self.mPath .. "/IconNew")
	self.iconNewOpen = UIControls.Panel(self, self.mPath .. "/IconNewOpen")
	self.timeUpPanel = UIControls.Panel(self, self.mPath .. "/TimeUpPanel")
end

function SeaSonPlayMainBtn:setType(type)
	self.type = type

	local data = CurAvatar:getSeasonPlaySubDataByType(self.type, self.mParent.actObj)

	if not data or #data == 0 or self.mParent.actObj.curState == Const.OPACT_STATE_FREEZE then
		self:setVisible(false)

		return
	else
		self:setVisible(not self.mParent.isInOld)
	end

	self.resData = CurAvatar:getSeaSonPlayEntranceResDataByType(self.type)

	if self.resData then
		self.txtName:setText(self.resData.desc)

		if self.resData.icon_path then
			self.icon:setImage(self.resData.icon_path, self.resData.icon_name)
		end
	end

	if CurAvatar:checkSeasonPlayCanGetRedDotByType(self.type) then
		self.iconNewSel:setVisible(true)
	else
		self.iconNewSel:setVisible(false)
		self.iconNewOpen:setVisible(CurAvatar:checkSeasonPlayNewOpenRedDotByType(self.type))
		self.timeUpPanel:setVisible(CurAvatar:checkSeasonPlayTimeUpRedDotByType(self.type))
	end
end

function SeaSonPlayMainBtn:onBtnPlayClick()
	local ui = UIManager.getUI("seasonPlayListDlg", true)

	ui:setType(self.type)

	if self.mParent.seasonPlayMainPanel then
		ui:setEndFlyObj(self.mParent.seasonPlayMainPanel.lvUpAni)
	end
end

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local SeasonPlayMainDlg = Class("SeasonPlayMainDlg", UIControls.Window)

MixinClass(SeasonPlayMainDlg, ActivityPanelMixin)

function SeasonPlayMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnPlayChallenge = SeaSonPlayMainBtn(self, "MainInfoPanel/BtnPlay01")
	self.btnPlayWEEK = SeaSonPlayMainBtn(self, "MainInfoPanel/BtnPlay02")
	self.btnPlayOpact = SeaSonPlayMainBtn(self, "MainInfoPanel/BtnPlay03")
	self.btnDraw = UIControls.Button(self, "MainInfoPanel/BtnShop")

	self.btnDraw:addEventClick(self.onBtnDrawClick)

	self.txtBtnDrawName = UIControls.Label(self, "MainInfoPanel/BtnShop/TxtName")
	self.iconBtnDraw = UIControls.Image(self, "MainInfoPanel/BtnShop/Icon")
	self.redDotDraw = UIControls.RedDot(self, "MainInfoPanel/BtnShop/IconNew")
	self.txtTime = UIControls.Label(self, "MainInfoPanel/TimePanel/TxtTime")
	self.imgPlayPreview = UIControls.Image(self, "MainInfoPanel/PlayPreview")
	self.txtPreviewName = UIControls.Label(self, "MainInfoPanel/PlayPreview/TxtName")
	self.playPreview = UIControls.Button(self, "MainInfoPanel/BtnChange")

	self.playPreview:addEventClick(self.onPlayPreviewClick)

	self.mainInfoPanel = UIControls.RawImage(self, "MainInfoPanel")

	local panelPath = "System/SeasonPlay/SeasonInfoPanel01"

	if self.clientTemplateData and self.clientTemplateData.template_path then
		panelPath = self.clientTemplateData.template_path
	end

	self.seasonPlayMainPanel = SeasonPlayMainPanel(self, "MainInfoPanel/SeasonInfoNode", panelPath)

	self.seasonPlayMainPanel:setVisible(true)

	self.btnChangeSeason = UIControls.Button(self, "MainInfoPanel/BtnChange")

	self.btnChangeSeason:addEventClick(self.onBtnChangeSeasonClick)

	self.uiAniPanel = UIControls.UIAni(self, "")

	self.uiAniPanel:addEventFinish(self.onchangeSeason)

	self.txtBtnChangeName = UIControls.Label(self, "MainInfoPanel/BtnChange/TxtName")
	self.iconBtnChangeNew = UIControls.Image(self, "MainInfoPanel/BtnChange/IconNew")
end

function SeasonPlayMainDlg:_setData(...)
	if self.actObj then
		self.openActObject = self.actObj

		self:setData(self.actObj.actId)
	end
end

function SeasonPlayMainDlg:setData(actId)
	self.actId = actId or self.actId
	self.nowTotalAddCount = 0

	self:setMainActData()
	self:setOtherShow()
end

function SeasonPlayMainDlg:setMainActData(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if CurAvatar.activityObjs and CurAvatar.activityObjs[self.actId] then
		self.actObj = CurAvatar.activityObjs[self.actId]

		self:setMainShow()
		self.seasonPlayMainPanel:setActObj(self.openActObject)

		if self.oldActObj then
			self.oldSeaonPanel:setActObj(self.oldActObj)
		end

		self:setSettleShow()
	end
end

function SeasonPlayMainDlg:setOtherShow(...)
	self:setDrawShow()
	self:setSubShow()
	self:setPreviweShow()
	self:setBgShow()
	self:setPreSeasonShow()
end

function SeasonPlayMainDlg:setPreSeasonShow(...)
	local actObj = CurAvatar:getSeasonPlayFreezeActivity()

	if actObj and actObj.actId ~= self.openActObject.actId then
		if not self.oldActObj then
			self.oldActObj = actObj
		end

		self.btnChangeSeason:setVisible(true)

		if not self.oldSeaonPanel then
			local panelPath = "System/SeasonPlay/SeasonInfoPanel01"

			if actObj.clientTemplateData and actObj.clientTemplateData.template_path then
				panelPath = actObj.clientTemplateData.template_path
			end

			self.oldSeaonPanel = SeasonPlayMainPanel(self, "MainInfoPanel/SeasonInfoNode", panelPath)
		end

		self.oldSeaonPanel:setActObj(actObj)
		self.oldSeaonPanel:setMainShow()

		if self.isInOld then
			self.txtBtnChangeName:setText(Lang.get(111313))
			self.iconBtnChangeNew:setVisible(CurAvatar:checkOpenSeaonPlayRedDot())
		else
			self.iconBtnChangeNew:setVisible(CurAvatar:checkSeasonPlayMainAndRelateDrawRedDot(self.oldActObj))
			self.txtBtnChangeName:setText(Lang.get(110049))
		end
	else
		self.btnChangeSeason:setVisible(false)
	end
end

function SeasonPlayMainDlg:refreshData()
	local ui = UIManager.tryGetUI("seasonPlayListDlg")

	if ui and ui:getVisible() then
		return
	end

	if self.actData then
		local lastData, nowHaveProgress, rate, preRoundProgress, preProgress = self.actData:getNextAchieveInfo(true)
		local maxIndex = 120

		if self.actData.clientData and self.actData.clientData[Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT] then
			maxIndex = #self.actData.clientData[Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT]
		end

		local needProgress = lastData.param - preProgress
		local newIdx

		if maxIndex == lastData.index and needProgress == 0 then
			newIdx = lastData.index
		else
			newIdx = lastData.index - 1
		end

		if self.nowIndex and newIdx > self.nowIndex then
			if self.seasonPlayMainPanel then
				self.nowIndex = newIdx

				self.seasonPlayMainPanel.slider:setValue(1)
				self.seasonPlayMainPanel.lvUpAni:startAni("ShowSeasonLvUp", true)
			end

			self:setOtherShow()
		else
			self:setData()
		end
	end
end

function SeasonPlayMainDlg:saveAddCount(data)
	for k, v in pairs(data or {}) do
		self.nowTotalAddCount = self.nowTotalAddCount + v.count
	end
end

function SeasonPlayMainDlg:checkSeattleLvUpShow(...)
	if self.nowTotalAddCount ~= 0 then
		if self.isInOld then
			if self.oldSeaonPanel then
				self.oldSeaonPanel:checkSeattleLvUpShow(self.nowTotalAddCount)

				self.nowTotalAddCount = 0
			end
		elseif self.seasonPlayMainPanel then
			self.seasonPlayMainPanel:checkSeattleLvUpShow(self.nowTotalAddCount)

			self.nowTotalAddCount = 0
		end
	end
end

function SeasonPlayMainDlg:setSettleShow(...)
	local data = CurAvatar:getOpActSeasonBPPointAdd(self.actObj.opId)
	local showData

	if self.nowTotalAddCount == 0 then
		self:saveAddCount(data)
	end

	for k, v in pairs(data or {}) do
		showData = {
			count = v.count,
			desc = v.desc
		}

		if ResOpActivitySeasonBPMisc[self.actData.actId] then
			showData.itemId = ResOpActivitySeasonBPMisc[self.actData.actId].item_id
		end

		showData.type = k
		showData.opId = self.actObj.opId
	end

	if showData then
		local ui = UIManager.getUI("seasonPlaySettleAwardDlg", true)

		ui:setData(showData)

		if self.seasonPlayMainPanel then
			ui:setEndFlyObj(self.seasonPlayMainPanel.lvUpAni)
		end
	else
		self:checkSeattleLvUpShow()
	end
end

function SeasonPlayMainDlg:setBgShow(...)
	local path = "NoAlpha/SeasonPlay/BgSeasonPlay01"
	local time1 = ClientUtils.getTodayTimeStamp(6, 0, 0)
	local time2 = ClientUtils.getTodayTimeStamp(18, 0, 0)
	local nowTime = ClientUtils.getServerTime()

	if nowTime < time1 or time2 < nowTime then
		path = "NoAlpha/SeasonPlay/BgSeasonPlay02"
	end

	self.mainInfoPanel:setImage(path)
end

function SeasonPlayMainDlg:onStateToFreeze(...)
	local function yesFunc(...)
		if self and self:getVisible() then
			self:setVisible(false)
		end
	end

	UIManager.showConfirmWithId(1150, yesFunc, nil, nil, nil)
end

function SeasonPlayMainDlg:onStateToOver(...)
	if self and self:getVisible() then
		self:setVisible(false)
	end

	MsgManger.notice(Lang.get(32785))
end

function SeasonPlayMainDlg:onGetBpAward(bonus)
	if self and self:getVisible() then
		CurAvatar:onGetBonusNotice("commonBonusDlg", "onShow", bonus)
	end
end

function SeasonPlayMainDlg:setMainShow(...)
	if self.actObj then
		CurAvatar:setCacheActivityBonus(self.actObj.opId, Functor(self.onGetBpAward, self))

		if self.actObj:inFreeze() then
			local leftTime = self.actObj:getRemainOpenTime()

			if leftTime >= 0 then
				ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, false, Lang.get(117170), Slot(self.onStateToOver, self))
			end
		else
			local leftTime = self.actObj.actData:getLeftTimeToFreeze()

			if leftTime >= 0 then
				ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, false, Lang.get(48657), Slot(self.onStateToFreeze, self))
			end
		end

		self.actData = self.actObj.actData

		local lastData, nowHaveProgress, rate, preRoundProgress, preProgress = self.actData:getNextAchieveInfo(true)
		local needProgress = lastData.param - preProgress
		local maxIndex = 120

		if self.actData.clientData and self.actData.clientData[Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT] then
			maxIndex = #self.actData.clientData[Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT]
		end

		if lastData then
			if maxIndex == lastData.index and needProgress == 0 then
				self.nowIndex = lastData.index
			else
				self.nowIndex = lastData.index - 1
			end
		end

		if self.seasonPlayMainPanel then
			self.seasonPlayMainPanel:setMainShow()
		end
	end
end

function SeasonPlayMainDlg:onBtnDrawClick()
	if self.drawResData then
		CurAvatar:jumpToShowActivity(self.drawResData.relate_act_id)
	end
end

function SeasonPlayMainDlg:onchangeSeason(aniCom, aniName)
	if aniName == "ShowSeasonChange" then
		self.oldSeaonPanel:setVisible(self.isInOld)
		self.seasonPlayMainPanel:setVisible(not self.isInOld)

		local actId

		if self.isInOld then
			self.txtBtnChangeName:setText(Lang.get(111313))

			if self.oldActObj then
				actId = self.oldActObj.actId
			end
		else
			self.iconBtnChangeNew:setVisible(CurAvatar:checkSeasonPlayMainAndRelateDrawRedDot(self.oldActObj))
			self.txtBtnChangeName:setText(Lang.get(110049))

			if self.openActObject then
				actId = self.openActObject.actId
			end
		end

		self:setData(actId)
	end
end

function SeasonPlayMainDlg:onBtnChangeSeasonClick()
	self.isInOld = not self.isInOld

	self.uiAniPanel:startAni("ShowSeasonChange", true)
end

function SeasonPlayMainDlg:setDrawShow(...)
	self.drawResData = CurAvatar:getSeaSonPlayEntranceResDataByType(Const.SEASON_TASK_TYPE_DRAW, self.actObj)

	if self.drawResData then
		local actObj = CurAvatar:getActivityObj(self.drawResData.relate_act_id)

		if actObj and actObj:isOpen() then
			self.btnDraw:setVisible(true)

			if actObj.redDotId then
				self.redDotDraw:addHint({
					actObj.redDotId
				})
			end
		else
			self.btnDraw:setVisible(false)
		end

		self.txtBtnDrawName:setText(self.drawResData.desc)

		if self.drawResData.icon_path then
			self.iconBtnDraw:setImage(self.drawResData.icon_path, self.drawResData.icon_name)
		end
	else
		self.btnDraw:setVisible(false)
	end
end

function SeasonPlayMainDlg:setSubShow(...)
	self.btnPlayOpact:setType(Const.SEASON_TASK_TYPE_OPACT)
	self.btnPlayWEEK:setType(Const.SEASON_TASK_TYPE_WEEK)
	self.btnPlayChallenge:setType(Const.SEASON_TASK_TYPE_CHALLENGE)
end

function SeasonPlayMainDlg:setPreviweShow(...)
	local resData = {}
	local showIndex

	for _, data in ipairs(ResOpActivitySeasonBPPreviewShow) do
		if data.act_id then
			resData[data.act_id] = {}
			resData[data.act_id].time = data.time
			resData[data.act_id].index = _
		end
	end

	for _, data in ipairs(ResOpActivityeAutoOpen) do
		if data.template_id and resData[data.template_id] and resData[data.template_id].time then
			local time = resData[data.template_id].time
			local openTime = ClientUtils.getServerTimeByTimeStr(data.open_time)

			if openTime > ClientUtils.getServerTime() and openTime < ClientUtils.getServerTime() + time * 24 * 3600 then
				showIndex = resData[data.template_id].index

				break
			end
		end
	end

	if showIndex and ResOpActivitySeasonBPPreviewShow[showIndex] then
		self.imgPlayPreview:setVisible(true)

		self.preViewShowData = ResOpActivitySeasonBPPreviewShow[showIndex]

		self.txtPreviewName:setText(self.preViewShowData.name)

		if self.preViewShowData.icon_path then
			self.imgPlayPreview:setImage(self.preViewShowData.icon_path, self.preViewShowData.icon_name)
		end
	else
		self.imgPlayPreview:setVisible(false)
	end
end

function SeasonPlayMainDlg:onPlayPreviewClick()
	if self.preViewShowData then
		MsgManager.notice(self.preViewShowData.desc)
	end
end

function SeasonPlayMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

return SeasonPlayMainDlg
