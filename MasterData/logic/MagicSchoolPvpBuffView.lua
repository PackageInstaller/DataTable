-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpBuffView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpBuffView", package.seeall)

local MagicSchoolPvpBuffView = class("MagicSchoolPvpBuffView", ViewComponent)
local ViewState_Ready = 1
local ViewState_SelectBuff = 2
local ViewState_WaitOpponentBuff = 3
local ViewState_WaitMyTeamBuff = 4

function MagicSchoolPvpBuffView:ctor()
	MagicSchoolPvpBuffView.super.ctor(self)
end

function MagicSchoolPvpBuffView:buildUI()
	MagicSchoolPvpBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tagWait = self:getGo("tagWait")
	self._txtWaitTips = self:getTxt("tagWait/txtTips")
	self._txtLeftTime = self:getTxt("buffCol/txtLeftTime")
	self._buffCol = self:getGo("buffCol")
	self._txtBuffCount = self:getTxt("buffCol/txtBuffCount")

	local buffScrCell = self:getGo("buffCol/scrCell")
	local buffScrView = self:getGo("buffCol/scrView")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function MagicSchoolPvpBuffView:bindEvents()
	MagicSchoolPvpBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MagicSchoolPvpBuffView:unbindEvents()
	MagicSchoolPvpBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MagicSchoolPvpBuffView:onEnter()
	MagicSchoolPvpBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)
	self._myCampId = self._subMo:getCampId()
	self._curBossId = self._subMo:getCurBossId()
	self._leftTime = 0
	self._curSelectBuffId = self._subMo:getSelectBuffIdRecord(self._curBossId)
	self._viewState = ViewState_Ready

	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMsPvPStartSelectBuffRes, self._handlePM_NotifyMsPvPStartSelectBuffRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MSPvPSelectBuffRes, self._handlePM_MSPvPSelectBuffRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMsPvPWatchBattleResultRes, self._handlePM_NotifyMsPvPWatchBattleResultRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMsPvPFinishSelectBuffRes, self._handlePM_NotifyMsPvPFinishSelectBuffRes, self)
	self:_onUpdate()
end

function MagicSchoolPvpBuffView:onExit()
	MagicSchoolPvpBuffView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearBuffCol()
end

function MagicSchoolPvpBuffView:_handlePM_NotifyMsPvPStartSelectBuffRes()
	self:_onUpdate()
end

function MagicSchoolPvpBuffView:_handlePM_MSPvPSelectBuffRes(status)
	return
end

function MagicSchoolPvpBuffView:_handlePM_NotifyMsPvPWatchBattleResultRes()
	self:close()
end

function MagicSchoolPvpBuffView:_handlePM_NotifyMsPvPFinishSelectBuffRes(msg)
	return
end

function MagicSchoolPvpBuffView:_onUpdate()
	self._batMsg = self._subMo:getBattleMsg(self._curBossId)

	local nextBossId = self._curBossId + 1

	self._nextRoundTimeStamp = self._subMo:getBossRoundTimeStamp(nextBossId, MagicSchoolPvPEnum.RoundType_Battle)

	if self._batMsg == nil or self._nextRoundTimeStamp <= 0 then
		self._viewState = ViewState_Ready
	elseif self._batMsg then
		if not self._batMsg.userId then
			local userId = 0

			if self._batMsg then
				if not self._batMsg.finishBuffTarget then
					local finishBuffTarget = false
					local isMy = tostring(userId) == tostring(RoleModel.instance:getUserId())

					self._viewState = finishBuffTarget and (isMy and ViewState_SelectBuff or ViewState_WaitMyTeamBuff) or ViewState_WaitOpponentBuff
				end
			end
		end
	end

	self:_onClearBuffCol()
	GameUtil.SetActive(self._tagWait, false)

	if self._viewState == ViewState_Ready then
		self._txtWaitTips.text = "等待其他队友战斗结束"

		GameUtil.SetActive(self._tagWait, true)
	elseif self._viewState == ViewState_SelectBuff then
		self:_showBuffColUI()
	elseif self._viewState == ViewState_WaitOpponentBuff then
		GameUtil.SetActive(self._tagWait, true)
	elseif self._viewState == ViewState_WaitMyTeamBuff then
		GameUtil.SetActive(self._tagWait, true)
	end

	settimer(0.33, self._onTicking, self, true)
	self:_onTicking()
end

function MagicSchoolPvpBuffView:_onTicking()
	self._serverTime = ServerTime.now()
	self._leftTime = math.ceil(Mathf.Max(0, self._nextRoundTimeStamp - self._serverTime))

	if self._viewState == ViewState_Ready then
		-- block empty
	elseif self._viewState == ViewState_SelectBuff then
		self._txtLeftTime.text = string.format("剩余选择时间：%s秒", self._leftTime)
	elseif self._viewState == ViewState_WaitOpponentBuff then
		self._txtWaitTips.text = string.format("上一轮未达成目标，本阶段将无法选择，等待对方选择中%s秒...", self._leftTime)
	elseif self._viewState == ViewState_WaitMyTeamBuff then
		self._txtWaitTips.text = string.format("等待队友选择中%s秒...", self._leftTime)
	end
end

function MagicSchoolPvpBuffView:_showBuffColUI()
	GameUtil.SetActive(self._buffCol, true)

	self._withBuffList = self._subMo:getWithBuffList()
	self._activeBuffIds = self._subMo:getSelectedBuffIds()

	local dataList = {}

	for _, buffId in ipairs(self._withBuffList) do
		local data = MagicSchoolConfig.instance:getBuffCfgData(self._activityId, self._myCampId, buffId)

		if data then
			if table.indexof(self._activeBuffIds, buffId) == false then
				table.insert(dataList, data)
			end
		else
			printError(string.format("缺失buff配置 ( activityId:%s, campId:%s, buffId:%s )", self._activityId, self._myCampId, buffId))
		end
	end

	if table.indexof(self._withBuffList, self._curSelectBuffId) == false then
		if #self._withBuffList > 0 then
			self._curSelectBuffId = self._withBuffList[1]

			MagicSchoolPvPController.instance:sendPM_MSPvPSelectBuffReq(self._activityId, self._curSelectBuffId)
		else
			self._curSelectBuffId = 0
		end
	end

	self._buffScrollerList:reloadData(dataList)

	local curSelectCount = self._curSelectBuffId > 0 and 1 or 0

	self._txtBuffCount.text = string.format("当前已选祝福：%s/%s", curSelectCount, 1)
end

function MagicSchoolPvpBuffView:_onClearBuffCol()
	self._buffScrollerList:dispose()
	GameUtil.SetActive(self._buffCol, false)
end

function MagicSchoolPvpBuffView:_updateBuffCell(view, cell, data, tag)
	local buffId = data.buffId
	local isActive = table.indexof(self._activeBuffIds, buffId) ~= false
	local isSelected = self._curSelectBuffId == buffId
	local mainGo = cell.gameObject
	local maskGo = goutil.findChild(mainGo, "mask")
	local icon = goutil.findChild(mainGo, "mask/icon")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local iconTagSelect = goutil.findChild(mainGo, "tagSelect/icon")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtLv = goutil.findChildTextComponent(mainGo, "txtLv")
	local txtDesc = goutil.findChildTextComponent(mainGo, "desc/viewport/content")

	txtName.text = data.name
	txtDesc.text = data.desc

	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)
	GameUtil.SetActive(iconTagSelect, isSelected)
	GameUtil.rmClickHandler(mainGo)

	if self._viewState == ViewState_SelectBuff then
		GameUtil.addClickHandler(mainGo, function()
			if self._curSelectBuffId == buffId then
				return
			end

			self._curSelectBuffId = buffId

			MagicSchoolPvPController.instance:sendPM_MSPvPSelectBuffReq(self._activityId, self._curSelectBuffId)
			self:_showBuffColUI()
		end)
	end

	GameUtil.addClickHandler(maskGo, function()
		MagicSchoolPvPController.instance:openBuffTipsView(self._activityId, self._myCampId, buffId, mainGo)
	end)
end

function MagicSchoolPvpBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")
	local maskGo = goutil.findChild(mainGo, "mask")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
	GameUtil.rmClickHandler(maskGo)
end

return MagicSchoolPvpBuffView
