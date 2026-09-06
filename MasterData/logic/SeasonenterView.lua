-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonenterView.lua

module("logic.extensions.season.view.SeasonenterView", package.seeall)

local SeasonenterView = class("SeasonenterView", ViewComponent)

SeasonenterView.enterEffectPath = {
	"20221028/sjhx_jm/fx_ui_sjhx_jm",
	"20230120/sjhx_s2jm/fx_ui_sjhx_s2jm",
	"20230120/sjhx_s2jm/fx_ui_sjhx_s2jm"
}
SeasonenterView.hexinEffectPath = {
	"effect/prefabs/story/saiji/zhumianban/fx_ui_saiji_hexin.prefab",
	"effect/prefabs/story/saiji/zhumianban/fx_ui_saiji_hexin2.prefab",
	"effect/prefabs/story/saiji/zhumianban/fx_ui_saiji_hexin3.prefab"
}
SeasonenterView.petPosAndScale = {
	{
		0.68,
		-1.58,
		1
	},
	{
		0.5,
		-1.4,
		1.02
	},
	{
		0.5,
		-1.4,
		1.02
	}
}

function SeasonenterView:ctor()
	SeasonenterView.super.ctor(self)
end

function SeasonenterView:unbindEvents()
	SeasonenterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnReview)
	GameUtil.rmClickHandler(self.btnEnter)
	GameUtil.rmClickHandler(self.btnRank)
	GameUtil.rmClickHandler(self.btnPaint)
	GameUtil.rmClickHandler(self.btnPassport)
	GameUtil.rmClickHandler(self.enter)
	GameUtil.rmClickHandler(self._btnGroup)
end

function SeasonenterView:bindEvents()
	SeasonenterView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self.onTipClick, self)
	GameUtil.addClickHandler(self.btnReview, self.onReviewClick, self)
	GameUtil.addClickHandler(self.btnEnter, self.onEnterClick, self)
	GameUtil.addClickHandler(self.btnRank, self.onRankClick, self)
	GameUtil.addClickHandler(self.btnPaint, self.onPaintClick, self)
	GameUtil.addClickHandler(self.btnPassport, self.onPassportClick, self)
	GameUtil.addClickHandler(self.enter, self.playOpenEff, self)
	GameUtil.addClickHandler(self._btnGroup, self.onEnterClick, self)
end

function SeasonenterView:buildUI()
	SeasonenterView.super.buildUI(self)

	self.bg = self:getGo("bg")
	self.main = self:getGo("main")
	self.mainUi = self:getGo("mainUi")
	self.guide_highlight = self:getGo("guide_highlight")
	self.enter = self:getGo("guide_highlight/enter")
	self.goldEffParent = self:getGo("main/goldEffParent")
	self.leftTop = self:getGo("mainUi/leftTop")
	self.txtTime = self:getTxt("mainUi/openTime/txt")
	self.txtProgress = self:getTxt("mainUi/progress/txtProgress")
	self.btnClose = self:getGo("mainUi/leftTop/btnClose")
	self.btnTip = self:getGo("mainUi/leftTop/btnTip")
	self.btnReview = self:getGo("mainUi/btnReview")
	self.btnEnter = self:getGo("mainUi/btnEnter")
	self.btnRank = self:getGo("mainUi/btnRank")
	self.btnPaint = self:getGo("mainUi/btnPaint")
	self.btnPassport = self:getGo("mainUi/btnPassport")
	self.name = self:getGo("main/name")
	self.pet = self:getGo("main/pet/con")
	self._btnPassportRP = self:getGo("mainUi/btnPassport/redpoint")
	self._txtNum = self:getTxt("mainUi/btnPaint/txtNum")
	self._groupInfo = self:getGo("mainUi/groupInfo")
	self._headIcon1 = self:getGo("mainUi/groupInfo/info1/headIcon")
	self._readyGo1 = self:getGo("mainUi/groupInfo/info1/readyGo")
	self._txtName1 = self:getTxt("mainUi/groupInfo/info1/txtName")
	self._headIcon2 = self:getGo("mainUi/groupInfo/info2/headIcon")
	self._readyGo2 = self:getGo("mainUi/groupInfo/info2/readyGo")
	self._txtName2 = self:getTxt("mainUi/groupInfo/info2/txtName")
	self._btnGroup = self:getGo("mainUi/groupInfo/btnClick")
	self._inviteTable = self:getGo("mainUi/inviteTable/tableview")
	self._inviteCell = self:getGo("mainUi/inviteCell")
end

function SeasonenterView:onExit()
	SeasonenterView.super.onExit(self)
	GameUtil.SetActive(self.main, false)
	GameUtil.SetActive(self.mainUi, false)
	GameUtil.SetActive(self.guide_highlight, false)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self.handleSeasonInfoUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self.storyEnd, self)
	RedPointController.instance:unregRedPoint(self._btnPassportRP)
	UIEffectManager.instance:stopEffect(self._openEff)
	UIEffectManager.instance:stopEffect(self._blackEff)
	UIEffectManager.instance:stopEffect(self._goldEff)
	uGuiUtil.clearImage(self.name.gameObject)

	if self.petPhoto then
		self.petPhoto:clear()
	end

	removetimer(self.onTimer, self)
	removetimer(self._refreshTimer, self)
	HeadItemController.instance:resetHeadCell(self._headIcon1)
	HeadItemController.instance:resetHeadCell(self._headIcon2)
end

function SeasonenterView:onEnter()
	SeasonenterView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonInfoUpdate, self.handleSeasonInfoUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self.storyEnd, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVEGroupInfoRes, self._PM_SMGVEGroupInfoRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVESuccessCreateGroupRes, self.onRefreshGroupUI, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVEGroupDisbandRes, self.onRefreshGroupUI, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVESuccessCreateGVERoomRes, self._PM_NotifySMGVESuccessCreateGVERoomRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVEOpReadyRes, self._PM_NotifySMGVEOpReadyRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVEHandleGroupInviteRes, self._PM_SMGVEHandleGroupInviteRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVEReceiveGroupInviteRes, self._PM_NotifySMGVEReceiveGroupInviteRes, self)
	RedPointController.instance:regRedPoint(self._btnPassportRP, "c11", 379)

	local seasonId = SeasonModel.instance:getSeasonId()

	SeasonController.instance:sendGetSeasonInfo(seasonId)
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInfoReq()
	self:updateInActBtns()

	self._inviteList = ScrollerList.create(self._inviteTable, self._inviteCell, GameUtil.handler(self._updateInviteCell, self), GameUtil.handler(self._clearInviteCell, self))
	self._timerMap = {}
	self._inviteListData = {}
	self._isWaitEnterForm = false

	settimer(1, self._refreshTimer, self, true)
end

function SeasonenterView:updateInActBtns()
	local isInActTime = SeasonConfig.instance:isInActTime()

	GameUtil.SetActive(self.btnEnter, isInActTime)
	GameUtil.SetActive(self.btnPaint, isInActTime)
	GameUtil.SetActive(self.btnPassport, isInActTime)

	local pos = GameUtil.getLocalPos(self.btnRank.gameObject)

	if not isInActTime then
		GameUtil.setLocalPos(self.btnRank.gameObject, 553, pos.y, pos.z)
	else
		GameUtil.setLocalPos(self.btnRank.gameObject, 455, pos.y, pos.z)
	end
end

function SeasonenterView:handleSeasonInfoUpdate()
	local seasonId = SeasonModel.instance:getSeasonId()
	local data = SeasonModel.instance:getSeasonInfoData(seasonId)

	if data then
		if data.isFirstTime then
			self:startOpenAnim()
		else
			self:onRefreshUI()
		end
	end
end

function SeasonenterView:startOpenAnim()
	local seasonId = SeasonModel.instance:getSeasonId()
	local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)

	self._curOpenStoryId = cfg.openStoryId

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._curOpenStoryId, StoryModel.StoryType.SCCopy)

	local effParent = self.guide_highlight
	local pathName = "common/fx_ui_zhiyin_quan_03"

	UIEffectManager.instance:stopEffect(self._blackEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._blackEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	self:onRefreshUI()
	GameUtil.SetActive(self.main, false)
	GameUtil.SetActive(self.mainUi, false)
end

function SeasonenterView:storyEnd(storyId, isAllEnd)
	if storyId == self._curOpenStoryId and isAllEnd then
		GameUtil.SetActive(self.guide_highlight, true)
	end
end

function SeasonenterView:playOpenEff()
	GameUtil.SetActive(self.guide_highlight, false)

	local effParent = self.mainGO
	local path = {
		SeasonenterView.hexinEffectPath[SeasonModel.instance:getSeasonId()]
	}

	UIEffectManager.instance:stopEffect(self._openEff)

	if effParent then
		local function finishHandler(handlerTarget, eff)
			SeasonModePveAgent.instance:sendPM_SMPVESeasonInitReq()
			self:onRefreshUI()
		end

		local function loadedHandler(handlerTarget, eff)
			GameUtil.SetActive(self.main, true)
			GameUtil.SetActive(self.goldEffParent, false)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._openEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function SeasonenterView:_refreshInvite()
	if self._viewPresentor.viewName ~= UIStateManager.instance:getTopName() then
		return
	end

	local showList = {}

	for i, v in pairs(self._inviteListData) do
		if ServerTime.now() < v.endShowTime then
			table.insert(showList, v)
		else
			self._inviteListData[i] = nil
		end
	end

	table.sort(showList, function(a, b)
		return a.endShowTime < b.endShowTime
	end)
	self._inviteList:reloadData(showList)

	if #showList > 0 then
		self:_refreshTimer()
	end
end

function SeasonenterView:_refreshTimer()
	for txt, endTime in pairs(self._timerMap or {}) do
		local haveTime = endTime - ServerTime.now()

		if haveTime > 0 then
			txt.text = haveTime
		else
			self:_refreshInvite()

			return
		end
	end
end

function SeasonenterView:_updateInviteCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtTime = goutil.findChildTextComponent(go, "cutdown/txt")
	local btnSure = goutil.findChild(go, "btnSure")
	local btnCancel = goutil.findChild(go, "btnCancel")
	local headIcon = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local invateInfo = data.invateInfo
	local headInfo = data.mo.headInfo

	GameUtil.addClickHandler(btnSure, function()
		self:_onClickAccept(invateInfo.userId)
	end, self)
	GameUtil.addClickHandler(btnCancel, function()
		self:_onClickReject(invateInfo.userId)
	end, self)

	self._timerMap[txtTime] = data.endShowTime

	HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo, false, nil)

	txtName.text = headInfo.userName
	txtLevel.text = headInfo.playerLv
end

function SeasonenterView:_clearInviteCell(cell)
	local go = cell.gameObject
	local txtTime = goutil.findChildTextComponent(go, "cutdown/txt")
	local btnSure = goutil.findChild(go, "btnSure")
	local btnCancel = goutil.findChild(go, "btnCancel")
	local headIcon = goutil.findChild(go, "head")

	HeadItemController.instance:resetHeadCell(headIcon)
	GameUtil.rmClickHandler(btnSure)
	GameUtil.rmClickHandler(btnCancel)

	self._timerMap[txtTime] = nil
end

function SeasonenterView:onRefreshUI()
	GameUtil.SetActive(self.blackMask, false)
	GameUtil.SetActive(self.main, true)
	GameUtil.SetActive(self.mainUi, true)
	GameUtil.SetActive(self.guide_highlight, false)
	GameUtil.SetActive(self.goldEffParent, true)

	local effParent = self.goldEffParent
	local pathName = SeasonenterView.enterEffectPath[SeasonModel.instance:getSeasonId()]

	UIEffectManager.instance:stopEffect(self._goldEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._goldEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	local data = SeasonModel.instance:getSeasonInfoData(SeasonModel.instance:getSeasonId()) or {}

	self.txtProgress.text = "<color=#6CEF89FF>" .. string.format("%.2f%%", checknumber(data.gamePercent)) .. "</color>"

	local seasonId = SeasonModel.instance:getSeasonId()
	local cfg = SeasonConfig.instance:getSeasonConfig() or {}

	self.timeEndStamp = GameUtil.string2time(cfg.endTime or "")

	uGuiUtil.setSpriteToImage(self.name.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("season", cfg.imgTitle), function()
		self.name.gameObject:GetComponent("Image"):SetNativeSize()
	end)

	self.raceId = SeasonConfig.instance:getCommonValue("BOSS_GUIDE_SKINID", true)

	local rawImg = self.pet:GetComponent(typeof(UnityEngine.UI.RawImage))
	local temp = rawImg.material

	self.petPhoto = PetPhotoShow.Get(self.pet)

	self.petPhoto:showPetEffect(self.raceId, true, 2.4)

	local petLoaclPosAndScale = SeasonenterView.petPosAndScale[seasonId]

	self.petPhoto:setPetLocalPosAndScale(petLoaclPosAndScale[1], petLoaclPosAndScale[2], petLoaclPosAndScale[3])

	rawImg.material = temp
	self._txtNum.text = checknumber(data.nowFragmentNum) .. "/" .. checknumber(data.maxFragmentNum)

	removetimer(self.onTimer, self)
	settimer(1, self.onTimer, self, true)
	self:onTimer()
end

function SeasonenterView:onRefreshGroupUI()
	HeadItemController.instance:resetHeadCell(self._headIcon1)
	HeadItemController.instance:resetHeadCell(self._headIcon2)

	if SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_GROUPING then
		GameUtil.SetActive(self._groupInfo, true)

		local groupInfo = SeasonModel.instance:getGroupInfo()

		HeadItemController.instance:setHeadCellByInfo(self._headIcon1, RoleModel.instance:getHeadInfo(), false)
		HeadItemController.instance:setHeadCellByInfo(self._headIcon2, groupInfo.headInfo, false)

		self._txtName1.text = RoleModel.instance:getUserName()
		self._txtName2.text = groupInfo.headInfo.userName

		GameUtil.SetActive(self._readyGo1, groupInfo.ready)
		GameUtil.SetActive(self._readyGo2, groupInfo.opReady)
	else
		GameUtil.SetActive(self._groupInfo, false)
	end

	self:_refreshInvite()
end

function SeasonenterView:onTimer()
	local leftTime = checknumber(self.timeEndStamp) - ServerTime.now()

	leftTime = leftTime >= 0 and leftTime or 0

	if leftTime == 0 then
		self.txtTime.text = lang("剩余时间：已结束")
	else
		local timeStr = GameUtil.FormatTimeSymbol(leftTime)

		self.txtTime.text = langPara("剩余时间：%s", timeStr)
	end
end

function SeasonenterView:onTipClick()
	TipsFacade.instance:openRulesView("seasonenterview")
end

function SeasonenterView:onReviewClick()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.SeasonReview)
	UIStateManager.instance:push(ViewName.SeasonInfoView)
end

function SeasonenterView:onEnterClick()
	if SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_FREE or SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_GROUPING then
		UIStateManager.instance:push(ViewName.SeasonFormTeamView)
	else
		SurveyController.instance:reportBehavior(SurveyBehaviorID.SeasonEnter)
		SeasonController.instance:enterSeasonTilingScene()
	end
end

function SeasonenterView:onRankClick()
	local seasonId = SeasonModel.instance:getSeasonId()

	UIStateManager.instance:push(ViewName.SeasonRankMainView, seasonId)
end

function SeasonenterView:onPaintClick()
	local seasonId = SeasonModel.instance:getSeasonId()

	UIStateManager.instance:push(ViewName.SeasonPaintView, seasonId)
end

function SeasonenterView:onPassportClick()
	UIStateManager.instance:push(ViewName.SeasonPassPortTabView)
end

function SeasonenterView:_onClickAccept(userId)
	self._isWaitEnterForm = true
	self._inviteListData[userId] = nil

	SeasonModePvePlusAgent.instance:sendPM_SMGVEHandleGroupInviteReq(userId, 1)
end

function SeasonenterView:_onClickReject(userId)
	self._inviteListData[userId] = nil

	SeasonModePvePlusAgent.instance:sendPM_SMGVEHandleGroupInviteReq(userId, 0)
end

function SeasonenterView:_PM_SMGVEGroupInfoRes()
	self:onRefreshGroupUI()
end

function SeasonenterView:_PM_NotifySMGVESuccessCreateGVERoomRes()
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInfoReq()
end

function SeasonenterView:_PM_NotifySMGVEOpReadyRes()
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInfoReq()
end

function SeasonenterView:_PM_NotifySMGVEReceiveGroupInviteRes(msg)
	local invateInfo = msg.invite
	local mo = FriendModel.instance:getFriendMo(invateInfo.userId)

	if not mo then
		return
	end

	SeasonController.instance:tryUnregPopupMsg(mo.headInfo.userId)

	self._inviteListData[mo.headInfo.userId] = {
		invateInfo = invateInfo,
		endShowTime = ServerTime.now() + 20,
		mo = mo
	}

	self:_refreshInvite()

	if self._isWaitEnterForm == true then
		UIStateManager.instance:push(ViewName.SeasonFormTeamView)
	end

	self._isWaitEnterForm = false
end

function SeasonenterView:_PM_SMGVEHandleGroupInviteRes()
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInfoReq()
end

return SeasonenterView
