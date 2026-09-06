-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/view/CiyuanshenglongchallengefightView.lua

module("logic.extensions.ciyuanshenglong.view.CiyuanshenglongchallengefightView", package.seeall)

local CiyuanshenglongchallengefightView = class("CiyuanshenglongchallengefightView", ViewComponent)

function CiyuanshenglongchallengefightView:ctor()
	CiyuanshenglongchallengefightView.super.ctor(self)
end

function CiyuanshenglongchallengefightView:unbindEvents()
	CiyuanshenglongchallengefightView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPetInfo)
	GameUtil.rmClickHandler(self._btnPetSkill)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnJump)

	for i, btnTab in ipairs(self._btnTabList) do
		GameUtil.rmClickHandler(btnTab)
	end
end

function CiyuanshenglongchallengefightView:bindEvents()
	CiyuanshenglongchallengefightView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPetInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnPetSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickFight, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)

	for i, btnTab in ipairs(self._btnTabList) do
		GameUtil.addClickHandler(btnTab, function()
			self:_onClickTab(i)
		end)
	end
end

function CiyuanshenglongchallengefightView:buildUI()
	CiyuanshenglongchallengefightView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTime = self:getTxt("time/txt")
	self._petCon = self:getGo("petCon")
	self._txtPetName = self:getTxt("petInfo/txt")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._txtTodayScore = self:getTxt("info/txtTodayScore")
	self._txtHistoryScore = self:getTxt("info/txtHistoryScore")
	self._txtHas = self:getGo("info/txtHas")
	self._btnJump = self:getGo("info/btnJump")
	self._jumpHas = self:getGo("info/btnJump/txtHas")
	self._jumpNot = self:getGo("info/btnJump/txtNot")
	self._petRare = self:getGo("petInfo/pointRare")
	self._btnPetInfo = self:getGo("petInfo/btnIntroduce")
	self._btnPetSkill = self:getGo("petInfo/btnSkill")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnTab_1 = self:getGo("btnTab_1")
	self._btnTab_2 = self:getGo("btnTab_2")
	self._btnTab_3 = self:getGo("btnTab_3")
	self._btnTabList = {}

	for i = 1, 3 do
		local btnTab = self:getGo("btnTab_" .. i)

		table.insert(self._btnTabList, btnTab)
	end
end

function CiyuanshenglongchallengefightView:onExit()
	CiyuanshenglongchallengefightView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	for i, btnTab in ipairs(self._btnTabList) do
		local icon = goutil.findChild(btnTab, "icon")

		MaterialMgr.clearIcon(icon)
	end
end

function CiyuanshenglongchallengefightView:onEnter()
	CiyuanshenglongchallengefightView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.CiYuanShengLong)
	self._stageList = CiyuanshenglongConfig.instance:getStageCfgListById(self._activityId) or {}

	for i, btnTab in ipairs(self._btnTabList) do
		local cfg = self._stageList[i]
		local icon = goutil.findChild(btnTab, "icon")

		MaterialMgr.setIcon(icon, MatType.Pet, cfg.displayId)
	end

	self._curIndex = CiyuanshenglongModel.instance.tabChallengeIndex

	CiYuanHolyDragonClgAgent.instance:sendPM_CiYuanHolyDragonClgGetInfoReq(self._activityId)
	self.addGEvent(self, GlobalNotify.CIYUANSHENGLONG_INFO_UPDATE, self._refreshUI, self)
	self:_refreshUI()
end

function CiyuanshenglongchallengefightView:_refreshUI()
	for i, btnTab in ipairs(self._btnTabList) do
		local select = goutil.findChild(btnTab, "select")

		GameUtil.SetActive(select, self._curIndex == i)
	end

	self._txtTodayScore.text = "0"
	self._txtHistoryScore.text = "0"

	if not self._stageList[self._curIndex] then
		local curCfg = {}
		local info = CiyuanshenglongModel.instance:getMsgInfo(self._activityId) or {}

		if not info.stageInfo then
			local stageInfo = {}

			for i, v in ipairs(stageInfo) do
				if v.stageId == curCfg.stageId then
					self._txtTodayScore.text = v.todayMaxScore
					self._txtHistoryScore.text = v.historyMaxScore

					break
				end
			end

			GameUtil.SetActive(self._txtHas, checkbool(info.hasGainDailyBalancePrize))
			GameUtil.SetActive(self._btnJump, not checkbool(info.hasGainDailyBalancePrize))
			GameUtil.SetActive(self._jumpHas, checknumber(info.myCurDailyRank) > 0)
			GameUtil.SetActive(self._jumpNot, checknumber(info.myCurDailyRank) <= 0)

			self._txtDesc.text = curCfg.ruleDesc

			local raceId = curCfg.displayId

			MaterialMgr.setCell(MatType.Rare, raceId, self._petRare)

			self._skinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)
			self._txtPetName.text = self._skinCfg.name
			self._loader = RoleObjectPool.instance:removeRole(self._loader)

			local modelCfg = CharactorFacade.instance:getBattleResultModelUIPosAndScale(raceId)

			if not modelCfg[1] then
				local x = 0

				if not modelCfg[2] then
					local y = 0

					if not modelCfg[3] then
						local scale = 1

						self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, raceId, self._petCon, scale, true, x, y)

						local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.CiYuanShengLong, self._activityId)
						local startDate = GameUtil.time2date(startTime)
						local endDate = GameUtil.time2date(endTime)

						self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
					end
				end
			end
		end
	end
end

function CiyuanshenglongchallengefightView:_onClickTab(index)
	self._curIndex = index
	CiyuanshenglongModel.instance.tabChallengeIndex = index

	self:_refreshUI()
end

function CiyuanshenglongchallengefightView:_onClickInfo()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId

		PetbookController.instance:openPetinfoView(raceId)
	end
end

function CiyuanshenglongchallengefightView:_onClickSkill()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId
		local skinId = self._skinCfg.skinId

		PetbookController.instance:previewBattle(raceId, skinId)
	end
end

function CiyuanshenglongchallengefightView:_onClickFight()
	self._activityConfig = CiyuanshenglongConfig.instance:getActivityCfgById(self._activityId)

	if not self._activityConfig.challengeClosedTimeRange then
		local arr = string.split(self._activityConfig.challengeClosedTimeRange, "-") or {}

		if not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true) then
			if not self._stageList[self._curIndex] then
				CiyuanshenglongController.instance:openMissionView(self._activityId, self._stageList[self._curIndex].stageId)
			end
		else
			FloatWordMgr.instance:show(lang("不在开放时间内"))
		end
	end
end

function CiyuanshenglongchallengefightView:_onClickJump()
	UIStateManager.instance:push(ViewName.CiyuanshenglongchallengerankView, self._activityId, CiyuanshenglongModel.TAB_TODAY)
end

return CiyuanshenglongchallengefightView
