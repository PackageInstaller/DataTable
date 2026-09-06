-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanmainView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanmainView", package.seeall)

local SixartdaoguanmainView = class("SixartdaoguanmainView", ViewComponent)

SixartdaoguanmainView.FirstStoryKey = "SixartdaoguanmainView.FirstStoryKey"

function SixartdaoguanmainView:ctor()
	SixartdaoguanmainView.super.ctor(self)

	self._activityType = GameEnum.ActivityType.SixArtDaoguan
end

function SixartdaoguanmainView:unbindEvents()
	SixartdaoguanmainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnJump1:RemoveClickListener()
	self._btnJump3:RemoveClickListener()
	self._btnJump2:RemoveClickListener()
	self._btnJump4:RemoveClickListener()
end

function SixartdaoguanmainView:bindEvents()
	SixartdaoguanmainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnJump1:AddClickListener(self._onClickbtnJump1, self)
	self._btnJump3:AddClickListener(self._onClickbtnJump3, self)
	self._btnJump2:AddClickListener(self._onClickbtnJump2, self)
	self._btnJump4:AddClickListener(self._onClickbtnJump4, self)
end

function SixartdaoguanmainView:buildUI()
	SixartdaoguanmainView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnJump1 = self:getBtn("jumpBtnCol/btnJump1")
	self._btnJump3 = self:getBtn("jumpBtnCol/btnJump3")
	self._btnJump2 = self:getBtn("jumpBtnCol/btnJump2")
	self._btnJump4 = self:getBtn("jumpBtnCol/btnJump4")
	self._txtTime = self:getTxt("txtOpenTime/txt")

	self:_buildCells()
end

function SixartdaoguanmainView:_buildCells()
	self._cellGos = {}

	local root = self:getGo("cellscon")

	for i = 1, 5 do
		self._cellGos[i] = goutil.findChild(root, "cell" .. i)
	end
end

function SixartdaoguanmainView:onExit()
	SixartdaoguanmainView.super.onExit(self)

	for i, v in ipairs(self._cellGos) do
		self:_clearCell(v)
	end
end

function SixartdaoguanmainView:onEnter()
	SixartdaoguanmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanGetInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self:_updateUI()

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.SixArtDaoguan, self._activityId)

	SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanGetInfoReq(self._activityId)
	self:_playFirstEnterStory()
end

function SixartdaoguanmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.SixArtDaoguan)
	end
end

function SixartdaoguanmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("sixartdaoguan")
end

function SixartdaoguanmainView:_onClickbtnClose()
	self:close()
end

function SixartdaoguanmainView:_onClickbtnJump1()
	UIStateManager.instance:push(ViewName.SixartdaoguanrankView, self._activityId)
end

function SixartdaoguanmainView:_onClickbtnJump2()
	UIStateManager.instance:push(ViewName.SixartdaoguanpetshopView, self._activityId)
end

function SixartdaoguanmainView:_onClickbtnJump3()
	UIStateManager.instance:push(ViewName.SixartdaoguanrankrewardView, self._activityId)
end

function SixartdaoguanmainView:_onClickbtnJump4()
	FuncOpenController.instance:openFunc(191, self._activityType, self._activityId)
end

function SixartdaoguanmainView:_updateUI()
	local challengeCfgs = SixartdaoguanConfig.instance:getChallengeCfgs(self._activityId)

	for i, v in ipairs(challengeCfgs) do
		self:_updateCell(self._cellGos[i], v)
	end
end

function SixartdaoguanmainView:_updateCell(cell, data, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "root/btn")
	local goBg = goutil.findChild(cell.gameObject, "root/bg")
	local goFirstPassGo = goutil.findChild(cell.gameObject, "root/firstPassGo")
	local goHead = goutil.findChild(cell.gameObject, "root/firstPassGo/head")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "root/firstPassGo/txtName")
	local goPassGo = goutil.findChild(cell.gameObject, "root/passGo")
	local goRoot = goutil.findChild(cell.gameObject, "root")
	local txtOpenTime = goutil.findChildTextComponent(cell.gameObject, "root/lockGo/txtOpenTime")
	local goLockGo = goutil.findChild(cell.gameObject, "root/lockGo")
	local stageCfgs = SixartdaoguanConfig.instance:getStageCfgs(self._activityId, data.challengeId)
	local cnt = #stageCfgs
	local challengeInfo = SixartdaoguanModel.instance:getChallengeInfo(self._activityId, data.challengeId)
	local openTime = GameUtil.string2time(data.openDateTime)
	local isOpen = openTime <= ServerTime.now()
	local isPass = challengeInfo and cnt <= challengeInfo.stageIdPassed

	if challengeInfo then
		::label_16_0::

		local var_16_0 = challengeInfo.first

		if challengeInfo.first then
			local hasFirstPassPlayer = challengeInfo.first.userName

			GameUtil.SetGray(goBg, not isOpen)
			goutil.setActive(goFirstPassGo, hasFirstPassPlayer)
			goutil.setActive(goPassGo, isPass)
			goutil.setActive(goLockGo, not isOpen)

			if not isOpen then
				local date = GameUtil.string2date(data.openDateTime)

				txtOpenTime.text = string.format("%s.%s %s:00后开启", date.month, date.day, date.hour)
			end

			if hasFirstPassPlayer then
				HeadItemController.instance:resetHeadCell(goHead)
				HeadItemController.instance:setHeadCellByInfo(goHead, challengeInfo.first, true)

				txtName.text = string.format("%s\n%s", challengeInfo.first.userName, challengeInfo.first.areaName)
			end

			btn:AddClickListener(function()
				if not isOpen then
					FloatWordMgr.instance:show("未开启")

					return
				end

				UIStateManager.instance:push(ViewName.SixartdaoguanstageView, self._activityId, data.challengeId)
			end)
		end
	end
end

function SixartdaoguanmainView:_clearCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "root/firstPassGo/head")

	HeadItemController.instance:resetHeadCell(goHead)
end

function SixartdaoguanmainView:_playFirstEnterStory()
	local isPlay = GameUtil.getUserData(SixartdaoguanmainView.FirstStoryKey)

	if isPlay then
		return
	end

	GameUtil.saveUserData(SixartdaoguanmainView.FirstStoryKey, true)

	local storyId = SixartdaoguanConfig.instance:getClientValue("FirstStoryId", true)

	GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
end

return SixartdaoguanmainView
