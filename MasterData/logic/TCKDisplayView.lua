-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKDisplayView.lua

module("logic.extensions.teenchampionking.view.TCKDisplayView", package.seeall)

local TCKDisplayView = class("TCKDisplayView", ViewComponent)

function TCKDisplayView:ctor()
	TCKDisplayView.super.ctor(self)
end

function TCKDisplayView:unbindEvents()
	TCKDisplayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnLookBack)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)

	for i, con in ipairs(self._roleConList) do
		GameUtil.rmClickHandler(con.btnShow)
	end
end

function TCKDisplayView:bindEvents()
	TCKDisplayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickbtnClg, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickbtnExchange, self)
	GameUtil.addClickHandler(self._btnLookBack, self._onClickbtnLookBack, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)

	for i, con in ipairs(self._roleConList) do
		GameUtil.addClickHandler(con.btnShow, GameUtil.handler(self._onClickShowInfo, self, i))
	end
end

function TCKDisplayView:buildUI()
	TCKDisplayView.super.buildUI(self)

	self._btnClg = self:getGo("btnClg")
	self._btnLookBack = self:getGo("btnLookBack")
	self._btnExchange = self:getGo("btnExchange")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldcon")
	self._txtLeftTimes = self:getTxt("txtLeftTimes")
	self._modelCam = self:getGo("modelCam")
	self._roleConList = {}

	for i = 1, 3 do
		local con = {}

		con.go = self:getGo("roleList/role_" .. i)
		con.txtNameShow = goutil.findChildTextComponent(con.go, "infoCom/txtNameShow")
		con.txtPower = goutil.findChildTextComponent(con.go, "infoCom/txtPower")
		con.btnShow = goutil.findChild(con.go, "btnShow")
		con.rolePoint = self:getGo("modelCam/rolePoint_" .. i)

		local avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		avatar:setParent(con.rolePoint.transform)
		avatar:setLayer(SceneLayer.UI3D_Value)

		con.avatar = avatar
		self._roleConList[i] = con
	end

	self._showTxtList = {}

	for i = 1, 3 do
		self._showTxtList[i] = self:getTxt("displayInfo/txt_" .. i)
	end
end

function TCKDisplayView:onExit()
	TCKDisplayView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	removetimer(self._updateDisplayInfo, self)
end

function TCKDisplayView:onEnter()
	TCKDisplayView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.PM_TCKGetDisplayInfo, self._handleGetDisplayInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetQualifierInfo, self._handleGetQualifierInfo, self)
	self:_handleGetQualifierInfo()
	self:_handleGetDisplayInfo()
	TeenChampionKingController.instance:getQualifierInfo(self._activityId, TeenChampionKingController.EntertainmentStepId)

	self._showStartId = #self._showDisplayInfos

	self:_updateDisplayInfo()
	settimer(3, self._updateDisplayInfo, self, true)
end

function TCKDisplayView:onEnterFinished()
	TeenChampionKingController.instance:getDisplayInfo(self._activityId)
end

function TCKDisplayView:destroyUI()
	TCKDisplayView.super.destroyUI(self)

	for i, con in ipairs(self._roleConList) do
		if con.avatar then
			AvatarsMgrNew.instance:removeAvatar(con.avatar)

			con.avatar = nil
		end
	end
end

function TCKDisplayView:_updateUIByCfg()
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)

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

function TCKDisplayView:_handleGetDisplayInfo()
	self._showRoleInfos = self._showRoleInfos or {}
	self._showDisplayInfos = self._showDisplayInfos or {}

	table.clear(self._showRoleInfos)
	table.clear(self._showDisplayInfos)

	local displayInfo = TeenChampionKingModel.instance:getDisplayInfo(self._activityId)
	local displayInfo = TeenChampionKingModel.instance:getDisplayInfo(self._activityId)

	if displayInfo then
		if not displayInfo.topList then
			for _, detail in ipairs(displayInfo.topList) do
				table.insert(self._showRoleInfos, detail)
			end

			if not displayInfo.guessRightCount then
				for i, count in ipairs(displayInfo.guessRightCount) do
					if i > 1 then
						local showStr = string.format("全服%s人预测命中%s个排名", count, i - 1)

						table.insert(self._showDisplayInfos, showStr)
					end
				end
			end
		end
	end

	for i, con in ipairs(self._roleConList) do
		local showInfo = self._showRoleInfos[i]

		if showInfo then
			goutil.setActive(con.go, true)
			con.avatar:setVisible(true)

			local headInfo = showInfo.headInfo.headInfo

			con.txtNameShow.text = headInfo.userName
			con.txtPower.text = showInfo.zdl

			local skId = DressModel.instance:getSkeIdByGender(showInfo.gender)
			local mo = DressModel.instance:getAvatarPlayerMo(skId, (not showInfo.clothes or nil) and {}, 0)

			con.avatar:updateByMo(mo)
		else
			con.avatar:setVisible(false)
			goutil.setActive(con.go, false)
		end
	end
end

function TCKDisplayView:_handleGetQualifierInfo()
	self._leftTime = 0

	local info = TeenChampionKingModel.instance:getQualifierInfo(self._activityId, TeenChampionKingController.EntertainmentStepId)

	if info then
		local timeLimit = self._actCfg.dailyFightTimes

		self._leftTime = checknumber(timeLimit) - checknumber(info.dailyPrizeTimes)
	end

	self._txtLeftTimes.text = string.format("今日奖励次数：%s", self._leftTime)
end

function TCKDisplayView:_onClickbtnExchange()
	local str = self._actCfg.shopGotoStr

	if not GameUtil.isEmptyString(str) then
		GotoMgr.gotoByString(str)
	end
end

function TCKDisplayView:_onClickbtnClg()
	UIStateManager.instance:push(ViewName.TCKQualifyView, self._activityId, TeenChampionKingController.EntertainmentStepId)
end

function TCKDisplayView:_onClickbtnLookBack()
	UIStateManager.instance:push(ViewName.TeenChampionKingMainView, self._activityId)
end

function TCKDisplayView:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function TCKDisplayView:_onClickShowInfo(Id)
	local playerInfo = self._showRoleInfos[Id]
	local con = self._roleConList[Id]

	if con and playerInfo then
		FriendController.instance:showInfoView(playerInfo.headInfo.headInfo.userId, con.btnShow)
	end
end

function TCKDisplayView:_updateDisplayInfo()
	if not self._showDisplayInfos then
		return
	end

	if self._showDisplayInfos and #self._showDisplayInfos > 0 then
		self._showStartId = self._showStartId + 1

		if self._showStartId > #self._showDisplayInfos then
			self._showStartId = 1
		end

		for i, txt in ipairs(self._showTxtList) do
			local showId = #self._showDisplayInfos - (self._showStartId + i - 2)

			if showId <= 0 then
				showId = showId + #self._showDisplayInfos
			end

			local showStr = self._showDisplayInfos[showId]

			txt.text = showStr and showStr or ""
		end
	else
		for i, txt in ipairs(self._showTxtList) do
			txt.text = ""
		end
	end
end

return TCKDisplayView
