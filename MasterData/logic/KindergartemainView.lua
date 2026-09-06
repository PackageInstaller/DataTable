-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartemainView.lua

module("logic.extensions.kindergarten.view.KindergartemainView", package.seeall)

local KindergartemainView = class("KindergartemainView", ViewComponent)

function KindergartemainView:ctor()
	KindergartemainView.super.ctor(self)

	self._classRoomNum = 3
end

function KindergartemainView:unbindEvents()
	KindergartemainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnMakeMoney:RemoveClickListener()
	self._btnChengjiu:RemoveClickListener()
	self._btnMgr:RemoveClickListener()
	self._btnLv:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnInvite:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnShop2)

	for k, v in pairs(self._classBtnItems) do
		v.btn:RemoveClickListener()
	end
end

function KindergartemainView:bindEvents()
	KindergartemainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnMakeMoney:AddClickListener(self._onClickbtnMakeMoney, self)
	self._btnChengjiu:AddClickListener(self._onClickbtnChengjiu, self)
	self._btnMgr:AddClickListener(self._onClickbtnMgr, self)
	self._btnLv:AddClickListener(self._onClickbtnLv, self)
	self._btnShop:AddClickListener(self._onClickbtnShop, self)
	self._btnInvite:AddClickListener(self._onClickbtnInvite, self)
	GameUtil.addClickHandler(self._btnShop2, self._onClickShop2, self)

	for k, v in pairs(self._classBtnItems) do
		v.btn:AddClickListener(GameUtil.handler(self._onClickbtnClass, self, k))
	end
end

function KindergartemainView:buildUI()
	KindergartemainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnMakeMoney = self:getBtn("btnMakeMoney")
	self._redPointMakeMoney = self:getGo("btnMakeMoney/redpoint")
	self._btnChengjiu = self:getBtn("btnChengjiu")
	self._redPointChengjiu = self:getGo("btnChengjiu/redpoint")
	self._btnMgr = self:getBtn("btnMgr")
	self._redPointMgr = self:getGo("btnMgr/redpoint")
	self._btnLv = self:getBtn("btnLv")
	self._btnShop = self:getBtn("btnShop")
	self._btnShop2 = self:getGo("btnShop2")
	self._btnInvite = self:getBtn("btnInvite")
	self._redPointInvite = self:getGo("btnInvite/redpoint")
	self._txtLevel = self:getTxt("btnLv/txtLevel")
	self._goldBarCon = self:getGo("goldBar")
	self._txtStudent = self:getTxt("studentCount/txt")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime/txt")

	self:_buildClassBtns()
end

function KindergartemainView:_buildClassBtns()
	self._classBtnItems = {}

	for i = 1, self._classRoomNum do
		local go = self:getGo("btnClass" .. i)

		self._classBtnItems[i] = {
			btn = Framework.ButtonAdapter.Get(go),
			txtLevel = goutil.findChildTextComponent(go, "txtLevel"),
			txtName = goutil.findChildTextComponent(go, "txtName")
		}
	end
end

function KindergartemainView:onExit()
	KindergartemainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointMakeMoney)
	RedPointController.instance:unregRedPoint(self._redPointChengjiu)
	RedPointController.instance:unregRedPoint(self._redPointMgr)
	RedPointController.instance:unregRedPoint(self._redPointInvite)
end

function KindergartemainView:onEnter()
	KindergartemainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KindergartenGetInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.KindergartenAddStudentRes, self._handleKindergartenAddStudentRes, self)

	self._activityType = KindergartenController.instance:getActivityType()

	self:_setActId()
	KindergartenModel.instance:setActivityId(self._activityId)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self:_initView()
	self:_updateUI()
	self:_setActTime()
	self:_sendInfoReq()
end

function KindergartemainView:_initView()
	self._activityCfg = KindergartenConfig.instance:getActCfg(self._activityId)

	if not KindergartenModel.instance:getFirstIntoMain(self._activityId) then
		if checknumber(self._activityCfg.operaId) > 0 then
			GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndIntoStroy, self)
			GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._activityCfg.operaId, self)
		else
			self:_onClickbtnTip()
		end

		KindergartenModel.instance:saveFirstIntoMain(self._activityId)
	end

	RedPointController.instance:regRedPoint(self._redPointChengjiu, RedPointModel.ID_KINDERGARTEN_TASK)
	RedPointController.instance:regRedPoint(self._redPointMakeMoney, self._activityCfg.redPointId)
	RedPointController.instance:regRedPoint(self._redPointMgr, "o27")
	RedPointController.instance:regRedPoint(self._redPointInvite, "o28")
	self:_setTopGoldBar()
end

function KindergartemainView:_sendInfoReq()
	KindergartenAgent.instance:sendPM_KindergartenGetInfoReq(self._activityId)
end

function KindergartemainView:_handleKindergartenAddStudentRes()
	self:_sendInfoReq()
end

function KindergartemainView:_onClickbtnClose()
	self:close()
end

function KindergartemainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("kindergarte_main_rule")
end

function KindergartemainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.KindergarteRankView)
end

function KindergartemainView:_onClickbtnClass(index)
	UIStateManager.instance:push(ViewName.KindergartefacilityView, index)
end

function KindergartemainView:_onClickbtnMakeMoney()
	UIStateManager.instance:push(ViewName.TripleMacthesStartView)
end

function KindergartemainView:_onClickbtnChengjiu()
	UIStateManager.instance:push(ViewName.ThreeEliminationTaskView, self._activityId)
end

function KindergartemainView:_onClickbtnMgr()
	UIStateManager.instance:push(ViewName.KindergartemanageView)
end

function KindergartemainView:_onClickbtnLv()
	UIStateManager.instance:push(ViewName.KindergartelevelView)
end

function KindergartemainView:_onClickbtnShop()
	FuncOpenController.instance:openFunc(191, self._activityType, self._activityId)
end

function KindergartemainView:_onClickShop2()
	GotoMgr.gotoByString("mibao#shenyaolibao")
end

function KindergartemainView:_onClickbtnInvite()
	UIStateManager.instance:push(ViewName.KindergarteEnlistView, self._activityId)
end

function KindergartemainView:_onEndIntoStroy()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndIntoStroy, self)
	self:_onClickbtnTip()
end

function KindergartemainView:_updateUI()
	self:_updateLevel()
	self:_updateClass()

	local info = KindergartenModel.instance:getInfo(self._activityId)
	local level = KindergartenController.instance:getGartenLevel(self._activityId)
	local gartenCfg = KindergartenConfig.instance:getLevelData(self._activityId, level)

	self._txtStudent.text = langPara("当前学生：%d/%d", (info or nil) and (info.curStudentCount or 0), gartenCfg.studentLimit)
end

function KindergartemainView:_updateLevel()
	local level = KindergartenController.instance:getGartenLevel(self._activityId)

	self._txtLevel.text = string.format("等级%s", level)
end

function KindergartemainView:_updateClass()
	local cfgs = KindergartenConfig.instance:getClassRoomCfgs(self._activityId)

	for i, v in ipairs(cfgs) do
		local item = self._classBtnItems[i]
		local level = KindergartenController.instance:getClassRoomLevel(self._activityId, v.classroomId)

		item.txtName.text = v.desc
		item.txtLevel.text = string.format("%s级", level)
	end
end

function KindergartemainView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function KindergartemainView:_setActId()
	local id = checknumber(self:getFirstParam())

	if id > 0 then
		self._activityId = id

		return
	end

	self._activityId = ActivityDefineController.instance:getActivityIdByType(KindergartenController.instance:getActivityType())
end

function KindergartemainView:_setTopGoldBar()
	local btn_list = {}
	local arr = string.split(self._activityCfg.showMat, "#")

	for i, v in ipairs(arr) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

return KindergartemainView
