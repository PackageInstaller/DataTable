-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/view/PetGainPrizeView.lua

module("logic.extensions.timeserverpetgain.view.PetGainPrizeView", package.seeall)

local PetGainPrizeView = class("PetGainPrizeView", ViewComponent)

function PetGainPrizeView:ctor()
	PetGainPrizeView.super.ctor(self)

	self._skinIdList = {
		11006,
		11005,
		1100601,
		16006,
		1600601
	}
	self._reportIdList = {
		SurveyBehaviorID.ZHIHUIJIAZU_3,
		SurveyBehaviorID.ZHIHUIJIAZU_1,
		SurveyBehaviorID.ZHIHUIJIAZU_2,
		SurveyBehaviorID.ZHIHUIJIAZU_4,
		SurveyBehaviorID.ZHIHUIJIAZU_5
	}
end

function PetGainPrizeView:buildUI()
	PetGainPrizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBless = self:getBtn("btnBless")
	self._redPoint = self:getGo("btnBless/redPoint")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtPlayerScore = self:getTxt("txtPlayerScore")
	self._txtTime = self:getTxt("time/txtTime")
	self._itemList = {}

	for i = 1, 5 do
		local item = {}

		if i == 1 then
			item.btnGoto = self:getBtn(string.format("item%d/btnGoto", i))
			item.txt = self:getTxt(string.format("item%d/btnGoto/Text", i))
			item.roleGo = self:getGo(string.format("item%d/con", i))
		else
			item.btn = self:getBtn(string.format("item%d", i))
			item.btnGoto = self:getBtn(string.format("item%d/btnGoto", i))
			item.iconChange = self:getGo(string.format("item%d/bg", i)):GetComponent(ComponentType.UIImageSpriteChange)
			item.txt = self:getTxt(string.format("item%d/txt", i))
		end

		table.insert(self._itemList, item)
	end

	self._uiCustomInput = UICustomInput.Get(self:getGo("btnTip"))
	self._bubble = self:getGo("bubble")

	goutil.setActive(self._bubble, false)
end

function PetGainPrizeView:bindEvents()
	PetGainPrizeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBless:AddClickListener(self._onClickBless, self)
	self._uiCustomInput:AddListener(self._onClickCustomInput, self)

	for i = 1, 5 do
		if i ~= 1 then
			self._itemList[i].btn:AddClickListener(function()
				self:_onClickBtnChange(i)
			end)
		end

		self._itemList[i].btnGoto:AddClickListener(function()
			self:_onClickPetBtn(i)
		end)
	end
end

function PetGainPrizeView:unbindEvents()
	PetGainPrizeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBless:RemoveClickListener()
	self._uiCustomInput:RemoveListener()

	for i = 1, 5 do
		if i > 1 then
			self._itemList[i].btn:RemoveClickListener()
		end

		self._itemList[i].btnGoto:RemoveClickListener()
	end
end

function PetGainPrizeView:_onClickClose()
	self:close()
end

function PetGainPrizeView:_onClickCustomInput(hover)
	if hover then
		if not self._bubble.activeSelf then
			goutil.setActive(self._bubble, true)
		end
	elseif self._bubble.activeSelf then
		goutil.setActive(self._bubble, false)
	end
end

function PetGainPrizeView:onEnter()
	PetGainPrizeView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_PetGainPrize1)

	self._realIndexList = TimeServerPetGainModel.instance:getPetIndexList()
	self._activityId = 162001
	self._cfgActivity = TimeServerPetGainConfig.instance:getActivityCfg(self._activityId)
	self._progressPlanId = self._cfgActivity.progressPlanId
	self._targetRaceId = self._cfgActivity.raceId

	self:_updatePetItem()
	self:_initActivityTimeText()
end

function PetGainPrizeView:onExit()
	PetGainPrizeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeServerPetGainGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeServerPetGainGetProgressPrizeRes, self._onGetProgressPrizeRes, self)
	RedPointController.instance:unregRedPoint(self._redPoint)
	self._playerSliderMo:onExit()
	self:_resetRoleModel()
	TimeServerPetGainModel.instance:savePetIndexList(self._realIndexList)
end

function PetGainPrizeView:_onGetInfoRes()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
end

function PetGainPrizeView:_onGetProgressPrizeRes()
	self._playerSliderMo:updatePlayerReward()
end

function PetGainPrizeView:_initRewardSlider()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = TimeServerPetGainConfig.instance:getProgressCfgList(self._progressPlanId)

	function playerParam.getPlayerProgress()
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):getUserNum()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.userNum
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):isRewardCanGet(rewardCfg.id, rewardCfg.userNum)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):isRewardGeted(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		TimeServerPetGainAgent.instance:sendPM_TimeServerPetGainGetProgressPrizeReq(self._activityId, rewardCfg.id)
	end

	function playerParam.getRewardTip(rewardCfg)
		local isExist = BagModel.instance:isExistRaceId(self._targetRaceId)

		if not isExist then
			return string.format("获得%s后，即可领取哦", MaterialModel:getMaterialsName(MatType.Pet, self._targetRaceId))
		end

		return ""
	end

	local isSkipAnimation = false

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function PetGainPrizeView:_setPlayerScore()
	self._txtPlayerScore.text = TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):getUserNum()
end

function PetGainPrizeView:_onClickBless()
	local array = MaterialMgr.changeItemStrArr(self._cfgActivity.buff)
	local contentArray = {}

	for _, str in ipairs(array) do
		local type, id, _ = MaterialMgr.getMatParams(str)
		local cfg = MaterialMgr.getMatCfg(type, id)

		table.insert(contentArray, cfg.desc)
	end

	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_PetGainPrize1, true)
	TipsFacade.instance:openTipWindow(lang("tip"), table.concat(contentArray, "\n"), nil, lang("confirm"))
end

function PetGainPrizeView:_onClickBtnChange(index)
	self._realIndexList[index] = self._realIndexList[1]
	self._realIndexList[1] = self._realIndexList[index]

	self:_updatePetItem()
end

function PetGainPrizeView:_onClickPetBtn(index)
	local realIndex = self._realIndexList[index]
	local skinId = self._skinIdList[realIndex]
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if not skinCfg then
		return
	end

	local srcCfg = ItemConfig.instance:getSourceCfg(self:_getSrcId(skinCfg.source))

	if not srcCfg then
		printError("道具来源配置不存在 skinId = ", skinId)

		return
	end

	local isInTime = false

	if string.nilorempty(srcCfg.openTime) then
		isInTime = true
	else
		local timeList = string.split(srcCfg.openTime, "#")
		local dateStart = GameUtil.string2date(timeList[1])
		local dateEnd = GameUtil.string2date(timeList[2])

		if not GameUtil.checkIsInTimePeriod(timeList[1], timeList[2]) then
			FloatWordMgr.instance:show(string.format("开启时间：%02d.%02d-%02d.%02d", dateStart.month, dateStart.day, dateEnd.month, dateEnd.day))

			return
		end
	end

	if realIndex == 1 then
		if not GodDiShiTianModel.instance:isRecieveGetInfoRes() then
			printInfo("test 未接收到协议，无法判断跳转")
		else
			local isFuncOpen = FuncOpenController.instance:checkFuncIdOrShowLockTips(375)

			if isFuncOpen then
				SurveyController.instance:reportBehavior(self._reportIdList[realIndex])
				GotoMgr.gotoByString(srcCfg.jumpTo)
			end
		end

		return
	else
		SurveyController.instance:reportBehavior(self._reportIdList[realIndex])
		GotoMgr.gotoByString(srcCfg.jumpTo)
	end
end

function PetGainPrizeView:_getSrcId(source)
	local arr = string.split(source, ",")

	return checknumber(arr[1])
end

function PetGainPrizeView:_updatePetItem()
	for i = 1, 5 do
		local skinId = self._skinIdList[self._realIndexList[i]]
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local srcCfg

		if not string.nilorempty(skinCfg.source) then
			srcCfg = ItemConfig.instance:getSourceCfg(self:_getSrcId(skinCfg.source))
		else
			printError("获得途径没有配：skinId = ", skinId)
		end

		if not srcCfg then
			printError("道具来源配置不存在 skinId = ", skinId)

			return
		end

		local isInTime = false
		local timeStart

		if string.nilorempty(srcCfg.openTime) then
			isInTime = true
		else
			local timeList = string.split(srcCfg.openTime, "#")

			isInTime = GameUtil.checkIsInTimePeriod(timeList[1], timeList[2])
			timeStart = timeList[1]
		end

		local insertStr = i == 1 and "" or "\n"

		if isInTime then
			self._itemList[i].txt.text = string.format("前往%s获得", insertStr)
		elseif not string.nilorempty(timeStart) then
			local dateStart = GameUtil.string2date(timeStart)

			self._itemList[i].txt.text = string.format("%02d.%02d%s开启", dateStart.month, dateStart.day, insertStr)
		end

		if i == 1 then
			self:_showRoleModel(skinId)
		else
			self._itemList[i].iconChange:SetState(self._realIndexList[i] - 1)
		end
	end
end

function PetGainPrizeView:_showRoleModel(skinId)
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._itemList[1].roleGo, scale, nil, true, x, y)
end

function PetGainPrizeView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function PetGainPrizeView:_initActivityTimeText()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.TimeServerPetGain, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

return PetGainPrizeView
