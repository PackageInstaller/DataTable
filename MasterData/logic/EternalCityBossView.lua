-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBossView.lua

module("logic.extensions.eternalcity.view.EternalCityBossView", package.seeall)

local EternalCityBossView = class("EternalCityBossView", ViewComponent)

function EternalCityBossView:buildUI()
	EternalCityBossView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._txtName = self:getTxt("infoCol/txtName")
	self._txtTips = self:getTxt("infoCol/tips/txt")
	self._strTxtTips = self._txtTips.text
	self._txtRule = self:getTxt("infoCol/txtRule")

	local prizeScrView = self:getGo("infoCol/prizeCol/scrView")
	local prizeScrCell = self:getGo("infoCol/prizeCol/scrCell")

	GameUtil.SetActive(prizeScrCell, false)

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnBuild = self:getGo("btnBuild")
	self._btnPetShop = self:getGo("btnPetShop")
	self._redPointBtnPetShop = self:getGo("btnPetShop/redPoint")
	self._btnClg = self:getGo("infoCol/btnClg")
	self._txtTimesBtnClg = self:getTxt("infoCol/btnClg/txtTimes")
end

function EternalCityBossView:bindEvents()
	EternalCityBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBuild, self._onClickBtnBuild, self)
	GameUtil.addClickHandler(self._btnPetShop, self._onClickBtnPetShop, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function EternalCityBossView:unbindEvents()
	EternalCityBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuild)
	GameUtil.rmClickHandler(self._btnPetShop)
	GameUtil.rmClickHandler(self._btnClg)
end

function EternalCityBossView:onEnter()
	EternalCityBossView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._actData = EternalCityConfig.instance:getActivityData(self._activityId)
	self._bossId = EternalCityController.instance:getCurBossId(self._activityId)
	self._bossData = EternalCityConfig.instance:getBossData(self._activityId, self._bossId)
	self._skinId = self._bossData.skinId
	self._progressPlan = self._bossData.progressPlan
	self._progressDatas = EternalCityConfig.instance:getProgressDatas(self._progressPlan)
	self._prizeList = {}

	for _, data in pairs(self._progressDatas) do
		local arr = string.split(data.prize, "#")

		table.insertto(self._prizeList, arr)
	end

	self._prizeList = MaterialMgr.mergeMatStrList(self._prizeList)

	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityInfoRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
	settimer(10, self._checkNextRefreshBossClgTimesTime, self, true)
end

function EternalCityBossView:onExit()
	EternalCityBossView.super.onExit(self)
	removetimer(self._checkNextRefreshBossClgTimesTime, self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
	self._prizeScrollerList:dispose()
	RedPointController.instance:unregRedPoint(self._redPointBtnPetShop)
end

function EternalCityBossView:_checkNextRefreshBossClgTimesTime()
	local nextTime = self._subMo:getNextRefreshBossClgTimesTime()

	if nextTime <= ServerTime.now() then
		EternalCityController.instance:sendPM_EternalCityInfoReq(self._activityId)
	end
end

function EternalCityBossView:_onSetUI()
	local skinId = self._skinId
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)

				MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)

				self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
				self._txtRule.text = self._bossData.ruleDesc
				self._txtName.text = PetSkinConfig.instance:getPetSkinName(skinId)

				local hour = self._subMo:getRefreshBossClgTime()
				local maxTimes = self._subMo:getMaxBossClgTimes()

				self._txtTips.text = string.format(self._strTxtTips, hour, maxTimes)

				RedPointController.instance:regRedPoint(self._redPointBtnPetShop, RedPointModel.ID_ETERNALCITY_PETSHOP)
			end
		end
	end
end

function EternalCityBossView:_onUpdate()
	local leftTimes = self._subMo:getRemainBossClgTimes()
	local maxTimes = self._subMo:getMaxBossClgTimes()

	self._txtTimesBtnClg.text = leftTimes > 0 and string.format("<color=#00FF00FF>%s</color>/%s", leftTimes, maxTimes) or string.format("%s/%s", leftTimes, maxTimes)

	self._prizeScrollerList:reloadData(self._prizeList)
end

function EternalCityBossView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local proxy = MaterialMgr.setCellByCfg(prizeStr, mainGo)

	if proxy then
		proxy.binder:setNum(0)
	end
end

function EternalCityBossView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function EternalCityBossView:_onClickBtnTip()
	local key = self._actData.ruleKeyBoss

	TipsFacade.instance:openRulesView(key)
end

function EternalCityBossView:_onClickBtnBuild()
	UIStateManager.instance:push(ViewName.EternalCityActiveBuildView, self._activityId)
end

function EternalCityBossView:_onClickBtnPetShop()
	UIStateManager.instance:push(ViewName.EternalCityPetShopView, self._activityId)
end

function EternalCityBossView:_onClickBtnClg()
	local result = self:_getTryBossClgResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	EternalCityController.instance:enterBossBattle(self._activityId, self._bossId)
end

function EternalCityBossView:_getTryBossClgResultAndTips(isNeedTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isEnoughBossClgTimes() then
		result = GameEnum.ResultCode.Error
		tips = "次数不足"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return EternalCityBossView
