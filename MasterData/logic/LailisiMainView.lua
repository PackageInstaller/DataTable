-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiMainView.lua

module("logic.extensions.lailisi.view.LailisiMainView", package.seeall)

local LailisiMainView = class("LailisiMainView", ViewComponent)

function LailisiMainView:ctor()
	LailisiMainView.super.ctor(self)
end

function LailisiMainView:unbindEvents()
	LailisiMainView.super.unbindEvents(self)
	self._btnChanllge:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._petName:RemoveClickListener()
end

function LailisiMainView:bindEvents()
	LailisiMainView.super.bindEvents(self)
	self._btnChanllge:AddClickListener(self._onClickChallenge, self)
	self._btnClose:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._petName:AddClickListener(self._onClickPetAttr, self)
end

function LailisiMainView:onExit()
	LailisiMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LailisiMain, self._refresh, self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.resetAll(self._rareGo)
	RedPointController.instance:unregRedPoint(self._chanllgeRedPoint)
	LailisiController.instance:stopEffect()
end

function LailisiMainView:buildUI()
	LailisiMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChanllge = self:getBtn("btnChanllge")
	self._btnTip = self:getBtn("btnTip")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._petName = self:getBtn("petName/btnTip")
	self._chanllgeRedPoint = self:getGo("btnChanllge/redpoint")
	self._tableView = self:getGo("tableview")
	self._itemCell = self:getGo("cell")
	self._roleConGo = self:getGo("con")
	self._goldBarCon = self:getGo("goldBarCon")
	self._rareGo = self:getGo("petInfo/rare")
	self._txtReward = self:getGo("reward")
	self._challengeTimes = self:getTxt("remain/txt")
	self._openDate = self:getTxt("time/txt")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._petScrollList = ScrollerList.create(self._tableView, self._itemCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))
end

function LailisiMainView:onEnter()
	LailisiMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self:_setActivityId()
	end

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LailisiPet, self._activityId)

	if not isInTime then
		self:_showPopupView()

		return
	end

	self:_refreshViewInfo()
	self:_showTime()
	self:_showGoldBar()
	self:_firstOpenActivity()
	GlobalDispatcher:addListener(GlobalNotify.LailisiMain, self._refresh, self)
	LailisiController.instance:sendPM_ActorGainGetInfoReq()
end

function LailisiMainView:_setActivityId()
	self._activityId = checknumber(LailisiConfig.instance:getCommonCfg("lailisi_Id"))
end

function LailisiMainView:_showPopupView()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function LailisiMainView:_refresh()
	self:_refreshPetTableview()
	self:redPointState()
	self:updateChallengeTimes()
end

function LailisiMainView:_refreshViewInfo()
	LailisiModel.instance:setFinalActIdActivityId(self._activityId)

	self._challengeCfg = LailisiConfig.instance:getChallengeCfg(self._activityId)
	self._raceId = self._challengeCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rareGo)

	self._txtPetName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._raceId, self._roleConGo, 1, nil, true, 0, 0)
	MaterialMgr.findGraphicText(self._txtReward.gameObject, "txtReward").text = self._challengeCfg.aword_preview

	self:_showEffect()
end

function LailisiMainView:_firstOpenActivity()
	local plotId = self._challengeCfg.plotId
	local key = self._viewPresentor.viewName .. "plotid" .. plotId

	if not GameUtil.getUserData(key) and plotId > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, plotId, StoryModel.StoryType.SCCopy)
		GameUtil.saveUserData(key, "1")
	end
end

function LailisiMainView:_showTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.LailisiPet, self._activityId)

	self._openDate.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function LailisiMainView:_showGoldBar()
	local itemArr = string.split(self._challengeCfg.item, "#")
	local objList = {}

	for _, item in ipairs(itemArr) do
		local data = {}

		data.id = item
		data.showAdd = true

		table.insert(objList, data)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function LailisiMainView:_showEffect()
	LailisiController.instance:showUIEff(self.mainGO, "fx_ui_xjs_llstz.prefab", self)
	LailisiController.instance:showUIEff(self._btnChanllge, "fx_ui_xjs_llstz_anniu.prefab", self)
end

function LailisiMainView:_refreshPetTableview()
	local cfg = self._challengeCfg.actIds

	self._petScrollList:reloadData(cfg)
end

function LailisiMainView:updateChallengeTimes()
	local challengeTimes = LailisiModel.instance:getPetProgress(self._activityId) or {}
	local cfg = LailisiConfig.instance:getActivityCfgById(self._activityId)
	local count = cfg.challengeDailyTimes - checknumber(challengeTimes.challengeTimes)

	self._challengeTimes.text = string.format("今日剩余次数<color=#20b376>%s/%s</color>次", count, cfg.challengeDailyTimes)

	local redPoint = LailisiController.instance:getChanllengeRedPointState()

	goutil.setActive(self._chanllgeRedPoint, redPoint)
	RedPointController.instance:regRedPoint(self._chanllgeRedPoint, 297)
end

function LailisiMainView:_updateCell(view, cell, data)
	local cfg = LailisiConfig.instance:getActivityCfgById(data)
	local actType = math.floor(data / 1000)
	local isTime = ActivityDefineController.instance:isInActivityTimeById(actType, data)
	local bgImg = goutil.findChild(cell, "bg")
	local attr = goutil.findChild(cell, "attr")
	local lock = goutil.findChild(cell, "lock")
	local lockTime = goutil.findChildTextComponent(cell, "lock/txt")
	local name = goutil.findChildTextComponent(cell, "txtName")
	local desc = goutil.findChildTextComponent(cell, "txtDesc")
	local redpoint = goutil.findChild(cell, "redpoint")
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.LailisiPet, data)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)
	local pageTips = string.split(cfg.pageTips, "#")
	local pageIcon = string.split(cfg.pageIcon, "#")

	name.text = pageTips[1]
	desc.text = pageTips[2]
	lockTime.text = string.format("%02d月%02d日 开启", startDate.month, startDate.day)

	uGuiUtil.setSpriteToImage(bgImg, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("challenge", pageIcon[1]))
	uGuiUtil.setSpriteToImage(attr, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("challenge", pageIcon[2]))
	goutil.setActive(lock, not isTime)
	goutil.setActive(redpoint, self:_pageRedpoint(data, isTime))
	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(cell):AddClickListener(function()
		self:ishaveInfo(function()
			if isTime then
				UIStateManager.instance:push(self._challengeCfg.levelsView, checknumber(data))
				LailisiModel.instance:clearLastView()
				LailisiModel.instance:saveLastView(self._challengeCfg.mainView)
				LailisiModel.instance:saveLastView(self._challengeCfg.levelsView, data)
				SurveyController.instance:reportBehavior(cfg.reportBehavior)
			else
				FloatWordMgr.instance:show("还没有到开放时间")
			end
		end)
	end)
end

function LailisiMainView:_clearItemCell(cell)
	local bgImg = goutil.findChild(cell, "bg")
	local attr = goutil.findChild(cell, "attr")

	uGuiUtil.clearImage(bgImg)
	uGuiUtil.clearImage(attr)
end

function LailisiMainView:ishaveInfo(handler)
	local info = LailisiModel.instance:getAllInfo()

	if next(info) ~= nil then
		handler()
	else
		FloatWordMgr.instance:show("网络延迟，请稍等")
	end
end

function LailisiMainView:_pageRedpoint(actId, isTime)
	local key = self._viewPresentor.viewName .. actId

	if GameUtil.getUserDayData(key) == nil and isTime then
		return true
	end

	return false
end

function LailisiMainView:redPointState()
	if GameUtil.getUserDayData("ID_LAILISI_DAY") == nil then
		GameUtil.saveUserDayData("ID_LAILISI_DAY", 1)
	end
end

function LailisiMainView:_showPopupView()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function LailisiMainView:_onClickTip()
	local ruleName = self._challengeCfg.rule

	TipsFacade.instance:openRulesView(ruleName)
end

function LailisiMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function LailisiMainView:_onClickSkill()
	local skinId = self._raceId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function LailisiMainView:_onClickPetAttr()
	TipsFacade.instance:openTipWindow(lang("tip"), self._challengeCfg.attrDesc, function()
		return
	end, "确定")
end

function LailisiMainView:_onClickChallenge()
	self:ishaveInfo(function()
		UIStateManager.instance:push(self._challengeCfg.challengeView)
		LailisiModel.instance:clearLastView()
		LailisiModel.instance:saveLastView(self._challengeCfg.mainView)
		LailisiModel.instance:saveLastView(self._challengeCfg.challengeView)

		local cfg = LailisiConfig.instance:getActivityCfgById(self._activityId)

		SurveyController.instance:reportBehavior(cfg.reportBehavior)
	end)
end

return LailisiMainView
