-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingfinalshowView.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingfinalshowView", package.seeall)

local YoungchampionkingfinalshowView = class("YoungchampionkingfinalshowView", ViewComponent)

function YoungchampionkingfinalshowView:ctor()
	YoungchampionkingfinalshowView.super.ctor(self)
end

function YoungchampionkingfinalshowView:unbindEvents()
	YoungchampionkingfinalshowView.super.unbindEvents(self)
	self._btnClg:RemoveClickListener()
	self._btnLookBack:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i, con in ipairs(self._roleConList) do
		GameUtil.rmClickHandler(con.btnShow)
	end
end

function YoungchampionkingfinalshowView:bindEvents()
	YoungchampionkingfinalshowView.super.bindEvents(self)
	self._btnClg:AddClickListener(self._onClickbtnClg, self)
	self._btnLookBack:AddClickListener(self._onClickbtnLookBack, self)
	self._btnTask:AddClickListener(self._onClickbtnTask, self)
	self._btnExchange:AddClickListener(self._onClickbtnExchange, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)

	for i, con in ipairs(self._roleConList) do
		GameUtil.addClickHandler(con.btnShow, GameUtil.handler(self._onClickShowInfo, self, i))
	end
end

function YoungchampionkingfinalshowView:buildUI()
	YoungchampionkingfinalshowView.super.buildUI(self)

	self._btnClg = self:getBtn("btnClg")
	self._btnLookBack = self:getBtn("btnLookBack")
	self._btnTask = self:getBtn("btnTask")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._goldBarCon = self:getGo("goldcon")
	self._challengeTimeTxt = self:getTxt("challengeTimeTxt")
	self._roleConList = {}

	for i = 1, 4 do
		local con = {}

		con.go = self:getGo("roleList/role_" .. i)
		con.conRole = goutil.findChild(con.go, "con")
		con.photoEff = AvatarPhotoShow.Get(con.conRole)

		con.photoEff:setRawWidthAndHeight(1280, 720)
		con.photoEff:setCameraPosition(0, 1, -2)
		con.photoEff:setCamSize(3)

		if i == 1 then
			con.photoEff:setCamSize(2.5)
		end

		con.photoEff:setRTAdjust(1, 1, 1, 0.45)

		con.txtNameShow = goutil.findChildTextComponent(con.go, "infoCom/txtNameShow")
		con.txtPower = goutil.findChildTextComponent(con.go, "infoCom/txtPower")
		con.btnShow = goutil.findChild(con.go, "btnShow")
		con.avatar = nil
		self._roleConList[i] = con
	end
end

function YoungchampionkingfinalshowView:onExit()
	YoungchampionkingfinalshowView.super.onExit(self)

	for _, con in ipairs(self._roleConList) do
		con.photoEff:clear()

		con.avatar = nil
	end
end

function YoungchampionkingfinalshowView:onEnter()
	YoungchampionkingfinalshowView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetDisplayInfoRes, self._onPM_YCKGetDisplayInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetInfoRes, self._onPM_YCKGetInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	YoungChampionKingController.instance:sendPM_YCKGetDisplayInfoReq(self._activityId)
	YoungChampionKingController.instance:sendPM_YCKGetInfoReq(self._activityId)
	self:_updateUIByCfg()
end

function YoungchampionkingfinalshowView:_onPM_YCKGetDisplayInfoRes()
	self:_updateRoleInfo()
end

function YoungchampionkingfinalshowView:_onPM_YCKGetInfoRes()
	local times = YoungChampionKingController.instance:getCurLeftChanllegeTimes(YoungChampionKingEnum.Entertainment_Step_Id)

	self._challengeTimeTxt.text = string.format("今日挑战次数：%s", times)
end

function YoungchampionkingfinalshowView:_updateUIByCfg()
	self._actCfg = YoungChampionKingConfig.instance:getActCfg(self._activityId)

	local btn_list = {
		{
			showAdd = true,
			id = self._actCfg.guessItem
		},
		{
			showAdd = true,
			id = self._actCfg.exchangeItem
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function YoungchampionkingfinalshowView:_updateRoleInfo()
	self._displayInfo = YoungChampionKingModel.instance:getDisplayInfo()

	if not self._displayInfo.playerList then
		for i, playerInfo in ipairs(self._displayInfo.playerList) do
			local con = self._roleConList[i]

			con.txtNameShow.text = playerInfo.headInfo.headInfo.userName
			con.txtPower.text = playerInfo.zdl

			local skId = DressModel.instance:getSkeIdByGender(playerInfo.gender)
			local mo = DressModel.instance:getAvatarPlayerMo(skId, (not playerInfo.clothes or nil) and {}, 0)

			if con.avatar then
				con.avatar:updateByMo(mo)
			else
				con.avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)
				con.avatar.useType = AvatarUseType.Scene

				con.photoEff:addShowAvatarEffect(con.avatar)
			end
		end
	end
end

function YoungchampionkingfinalshowView:_onClickbtnClg()
	UIStateManager.instance:push(ViewName.YoungChampionKingQualifyView, self._activityId, YoungChampionKingEnum.Entertainment_Step_Id)
end

function YoungchampionkingfinalshowView:_onClickbtnLookBack()
	UIStateManager.instance:push(ViewName.YoungChampionKingMainView, self._activityId)
end

function YoungchampionkingfinalshowView:_onClickbtnTask()
	local cfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if cfg then
		UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
	else
		printError("运营活动任务为空：" .. self._activityId)
	end
end

function YoungchampionkingfinalshowView:_onClickbtnExchange()
	local str = self._actCfg.shopGotoStr

	if not GameUtil.isEmptyString(str) then
		GotoMgr.gotoByString(str)
	end
end

function YoungchampionkingfinalshowView:_onClickbtnClose()
	self:close()
end

function YoungchampionkingfinalshowView:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function YoungchampionkingfinalshowView:_onClickShowInfo(Id)
	self._displayInfo = YoungChampionKingModel.instance:getDisplayInfo()

	if not self._displayInfo.playerList then
		local playerList = {}
		local playerInfo = playerList[Id]
		local con = self._roleConList[Id]

		con.txtNameShow.text = playerInfo.headInfo.headInfo.userName

		if con and playerInfo then
			FriendController.instance:showInfoView(playerInfo.headInfo.headInfo.userId, con.btnShow)
		end
	end
end

return YoungchampionkingfinalshowView
