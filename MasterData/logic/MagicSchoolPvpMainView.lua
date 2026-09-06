-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpMainView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpMainView", package.seeall)

local MagicSchoolPvpMainView = class("MagicSchoolPvpMainView", ViewComponent)

function MagicSchoolPvpMainView:ctor()
	MagicSchoolPvpMainView.super.ctor(self)
end

function MagicSchoolPvpMainView:buildUI()
	MagicSchoolPvpMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnClg = self:getGo("btnClg/btn")
	self._imgPassBtnClg = self:getGo("btnClg/btn/imgPass")
	self._redBtnClg = self:getGo("btnClg/btn/redPoint")
	self._txtTimeBtnClg = self:getTxt("btnClg/time/txt")
	self._txtCountBtnClg = self:getTxt("btnClg/btn/txtCount")
	self._strTxtCountBtnClg = self._txtCountBtnClg.text
	self._headView = self:getGo("infoCol/headView")
	self._headCell = self:getGo("infoCol/headCell")
	self._txtMaxDamage = self:getTxt("infoCol/txtMaxDamage")
	self._tagTeamBlack = self:getGo("infoCol/tagTeamBlack")
	self._tagTeamWrite = self:getGo("infoCol/tagTeamWrite")
	self._tagEmpty = self:getGo("infoCol/tagEmpty")

	GameUtil.SetActive(self._headCell, false)

	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._btnFmt = self:getGo("btnFmt")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._redBtnJump4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._redBtnJump5 = self:getGo("jumpBtnCol/btnJump5/redPoint")
	self._redBtnJumps = {
		self._redBtnJump1,
		self._redBtnJump2,
		self._redBtnJump3,
		self._redBtnJump4,
		self._redBtnJump5
	}
	self._redDataFields = {
		"jumpRedIdOne",
		"jumpRedIdTwo",
		"jumpRedIdThree",
		"jumpRedIdFour",
		"jumpRedIdFive"
	}
end

function MagicSchoolPvpMainView:bindEvents()
	MagicSchoolPvpMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
end

function MagicSchoolPvpMainView:unbindEvents()
	MagicSchoolPvpMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
end

function MagicSchoolPvpMainView:onEnter()
	MagicSchoolPvpMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = MagicSchoolPvPController.instance:getActivityId()
	end

	local isInTime = MagicSchoolPvPController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)
	self._actData = MagicSchoolPvpConfig.instance:getActivityData(self._activityId)
	self._reqStatus = {}
	self._reqStatus.HandlePM_MSPvPInfoRes = false
	self._reqStatus.HandlePM_MSPvPGetPresetFormationRes = false

	self.addGEvent(self, GlobalNotify.HandlePM_MSPvPInfoRes, self._handlePM_MSPvPInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MSPvPGetPresetFormationRes, self._handlePM_MSPvPGetPresetFormationRes, self)
	self.addGEvent(self, GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
	self:_onSetUI()
	self:_onUpdate()

	local function successCallBack()
		MagicSchoolPvPController.instance:sendPM_MSPvPInfoReq(self._activityId)
		MagicSchoolPvPController.instance:sendPM_MSPvPGetPresetFormationReq(self._activityId)
	end

	local failCallBack

	local function cancelCallBack()
		self:close()
	end

	MagicSchoolController.instance:canPlayAfterFinishChooseCamp(self._activityId, successCallBack, failCallBack, cancelCallBack)
end

function MagicSchoolPvpMainView:onExit()
	MagicSchoolPvpMainView.super.onExit(self)
	self:_onClearInfoCol()
	self:_unregisterRedPoints()
end

function MagicSchoolPvpMainView:_handlePM_MSPvPInfoRes()
	self:_onUpdate()

	self._reqStatus.HandlePM_MSPvPInfoRes = true

	self:_tryDoJoinTeam()
end

function MagicSchoolPvpMainView:_handlePM_MSPvPGetPresetFormationRes()
	self._reqStatus.HandlePM_MSPvPGetPresetFormationRes = true

	self:_tryDoJoinTeam()
end

function MagicSchoolPvpMainView:_tryDoJoinTeam()
	local isOk = true

	for _, status in pairs(self._reqStatus) do
		if not status then
			isOk = false

			break
		end
	end

	if not isOk then
		return
	end

	local joinTeamInfo = MagicSchoolPvPController.instance:popJoinTeamInfo()

	if joinTeamInfo == nil then
		return
	end

	if joinTeamInfo.activityId ~= self._activityId then
		return
	end

	local groupId = joinTeamInfo.groupId
	local teamId = joinTeamInfo.teamId
	local teamCode = joinTeamInfo.teamCode
	local result = MagicSchoolPvPController.instance:getEnterPvpResultAndTips(true, self._activityId, groupId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if self._subMo:isEmptyFormationSimpleForm() then
		self:_onClickBtnFmt()
	else
		FormTeamController.instance:enterFormTeamView(groupId)
		FormTeamController.instance:getJoinTeam(teamId, groupId, teamCode)
	end
end

function MagicSchoolPvpMainView:_onJoinTeam()
	UIStateManager.instance:push(ViewName.FormTeamCurTeamView)
end

function MagicSchoolPvpMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_registerRedPoints()

	local openTimeArrays = self._subMo:getOpenTimeArrays()
	local timeStr = "时间："

	for idx, timeArray in ipairs(openTimeArrays) do
		local sDate = GameUtil.string2date(timeArray[1])
		local eDate = GameUtil.string2date(timeArray[2])

		timeStr = timeStr .. string.format("%02d:%02d-%02d:%02d", sDate.hour, sDate.min, eDate.hour, eDate.min)

		if idx < #openTimeArrays then
			timeStr = timeStr .. "\n"
		end
	end

	self._txtTimeBtnClg.text = timeStr

	local goldInfo = {
		showAdd = false,
		id = self._actData.actItem
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		goldInfo
	})
end

function MagicSchoolPvpMainView:_onUpdate()
	local curTimes = self._subMo:getCurDailyTimes()
	local maxTimes = self._subMo:getMaxDailyTimes()

	self._txtCountBtnClg.text = string.format(self._strTxtCountBtnClg, Mathf.Max(maxTimes - curTimes, 0), maxTimes)

	self:_onUpdateInfoCol()
end

function MagicSchoolPvpMainView:_onUpdateInfoCol()
	local scoreInfo = self._subMo:getBestScoreInfo()

	if scoreInfo then
		if not scoreInfo.totalDamage then
			local totalDamage = 0

			if scoreInfo then
				if not scoreInfo.campId then
					local campId = 0
					local childCount = self._headView.transform.childCount

					if scoreInfo then
						if not #scoreInfo.headInfo then
							local dataLength = 0
							local length = Mathf.Max(dataLength, childCount)

							for idx = 1, length do
								local mainGo = idx <= childCount and self._headView.transform:GetChild(idx - 1).gameObject or goutil.cloneAndSetParent(self._headCell, self._headView.transform, self._headCell.name .. idx)
								local headRoot = goutil.findChild(mainGo, "headRoot")
								local txtName = goutil.findChildTextComponent(mainGo, "txtName")

								if idx <= dataLength then
									local headInfo = scoreInfo.headInfo[idx]

									txtName.text = headInfo.userName

									GameUtil.SetActive(mainGo, true)
									HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)
								else
									txtName.text = "--"

									HeadItemController.instance:resetHeadCell(headRoot)
									GameUtil.SetActive(mainGo, false)
								end
							end

							self._txtMaxDamage.text = string.format("%s", MmUtil.formatNumber(totalDamage, MmUtil.Units_OnlyW, 0))

							GameUtil.SetActive(self._tagTeamBlack, campId == MagicSchoolPvPEnum.CampId_Black)
							GameUtil.SetActive(self._tagTeamWrite, campId == MagicSchoolPvPEnum.CampId_White)
							GameUtil.SetActive(self._tagEmpty, scoreInfo == nil)
						end
					end
				end
			end
		end
	end
end

function MagicSchoolPvpMainView:_onClearInfoCol()
	for idx = 1, self._headView.transform.childCount do
		local mainGo = self._headView.transform:GetChild(idx - 1).gameObject

		HeadItemController.instance:resetHeadCell(mainGo)
	end
end

function MagicSchoolPvpMainView:_registerRedPoints()
	for idx, redGo in ipairs(self._redBtnJumps) do
		local redField = self._redDataFields[idx]
		local redIdStr = self._actData[redField]

		if not goutil.isNil(redGo) and not string.nilorempty(redIdStr) then
			local redIdList = string.split(redIdStr, "#")
			local validRedIds = {}

			for _, redId in ipairs(redIdList) do
				if not string.nilorempty(redId) and checknumber(redId) ~= 0 then
					table.insert(validRedIds, redId)
				end
			end

			if #validRedIds > 0 then
				RedPointController.instance:regRedPoint(redGo, unpack(validRedIds))
			else
				RedPointController.instance:unregRedPoint(redGo)
			end
		end
	end
end

function MagicSchoolPvpMainView:_unregisterRedPoints()
	for _, redGo in ipairs(self._redBtnJumps) do
		if not goutil.isNil(redGo) then
			RedPointController.instance:unregRedPoint(redGo)
		end
	end
end

function MagicSchoolPvpMainView:_onClickBtnClg()
	local groupId = self._subMo:getCurGroupId()
	local result = MagicSchoolPvPController.instance:getEnterPvpResultAndTips(true, self._activityId, groupId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if self._subMo:isEmptyFormationSimpleForm() then
		self:_onClickBtnFmt()
	else
		FormTeamController.instance:enterFormTeamView(groupId)
	end
end

function MagicSchoolPvpMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function MagicSchoolPvpMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.MagicSchoolPvpRankView, self._activityId)
end

function MagicSchoolPvpMainView:_onClickBtnFmt()
	MagicSchoolPvPController.instance:enterFormation(self._activityId, false)
end

function MagicSchoolPvpMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

return MagicSchoolPvpMainView
