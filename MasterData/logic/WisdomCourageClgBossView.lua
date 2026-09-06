-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgBossView.lua

module("logic.extensions.wisdomcourageclg.view.WisdomCourageClgBossView", package.seeall)

local WisdomCourageClgBossView = class("WisdomCourageClgBossView", ViewComponent)
local _bossId = 0

function WisdomCourageClgBossView:buildUI()
	WisdomCourageClgBossView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)

	self._txtDescRule = self:getTxt("ruleCol/desc/txt")
	self._btnSweep = self:getGo("ruleCol/btnSweep")
	self._btnChallenge = self:getGo("ruleCol/btnChallenge/btn")
	self._txtDescBtnChallenge = self:getTxt("ruleCol/btnChallenge/desc/txt")
	self._defaultStrTxtDescBtnChallenge = self._txtDescBtnChallenge.text

	local rankScrView = self:getGo("ruleCol/rankScrView")
	local rankScrCell = self:getGo("ruleCol/rankScrCell")

	self._itemScrCell = self:getGo("ruleCol/itemScrCell")
	self._rankScrollerList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)

	self._slider = self:getSlider("slider")
	self._txtSlider = self:getTxt("slider/txt")
	self._strTxtSlider = self._txtSlider.text
	self._con = self:getGo("con")
	self._btnRank = self:getGo("btnRank")
	self._txtTips = self:getTxt("tips/txt")
end

function WisdomCourageClgBossView:bindEvents()
	WisdomCourageClgBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnSweep, self._onClickBtnSweep, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
end

function WisdomCourageClgBossView:unbindEvents()
	WisdomCourageClgBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnSweep)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank)
end

function WisdomCourageClgBossView:onEnter()
	WisdomCourageClgBossView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = WisdomCourageClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = WisdomCourageClgController.instance:getWisdomCourageClgMo(self._activityId)
	self._actData = WisdomCourageClgConfig.instance:getActData(self._activityId)
	self._bossCfg = WisdomCourageClgConfig.instance:getBossCfg(self._activityId) or {}
	self._day = self:getCurBuffDay(self._activityId)
	self._buffData = WisdomCourageClgConfig.instance:getBossBuffData(self._activityId, self._day)
	_bossId = Mathf.Max(_bossId, 1)
	self._bossId = Mathf.Min(_bossId, #self._bossCfg)

	self.addGEvent(self, GlobalNotify.HandlePM_WisdomCourageClgBossInfoRes, self._onUpdate, self)
	WisdomCourageClgController.instance:sendPM_WisdomCourageClgBossInfoReq(self._activityId)
end

function WisdomCourageClgBossView:onExit()
	WisdomCourageClgBossView.super.onExit(self)

	_bossId = self._bossId

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	self._petScrollerList:dispose()
	self._rankScrollerList:dispose()
end

function WisdomCourageClgBossView:_onUpdate()
	local skinId = self:_getSkinId()
	local bossData = WisdomCourageClgConfig.instance:getBossData(self._activityId, self._bossId)

	if skinId > 0 then
		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[1] then
			local x = 0

			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)
				end
			end
		end
	else
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = skinId > 0 and PetSkinConfig.instance:getPetSkinName(skinId) or ""

	self._petScrollerList:reloadData(self._bossCfg)

	if bossData then
		self._txtDescRule.text = bossData.desc or "无"
	end

	local left = self._clgMo:getLeftDailyTimes(self._bossId)
	local max = self._clgMo:getMaxDailyTimes(self._bossId)

	self._txtDescBtnChallenge.text = string.format(self._defaultStrTxtDescBtnChallenge, left, max)

	local result = self:getTryStartClgResultAndTips(false, self._activityId, self._bossId)

	GameUtil.SetGray(self._btnChallenge, result ~= GameEnum.ResultCode.Success)

	local cfg = WisdomCourageClgConfig.instance:getBossDamageCfg(self._activityId) or {}
	local index = 0

	for idx, data in ipairs(cfg) do
		index = idx - 1

		if not self._clgMo:isHasGainPrizeInBoss(data.prizeId) then
			break
		end
	end

	self._rankScrollerList:reloadData(cfg)
	self._rankScrollerList:MoveCellToCenter(index)

	self._txtTips.text = self._buffData.buffDesc

	local cur = self._clgMo:getTodayMaxDamage(self._bossId)
	local max = self._clgMo:getHistoryMaxDamage(self._bossId)

	if self._slider then
		if max <= 0 then
			self._slider:SetValue(0)
		else
			self._slider:SetValue(cur / max)
		end
	end

	self._txtSlider.text = string.format(self._strTxtSlider, cur, max)
end

function WisdomCourageClgBossView:_updatePetCell(view, cell, data, tag)
	local bossId = data.bossId
	local skinId = data.skinId
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "imgMask/con")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local imgLock = goutil.findChild(mainGo, "imgLock")

	GameUtil.SetActive(imgSelect, bossId == self._bossId)

	local result = self:getTryStartClgResultAndTips(false, self._activityId, self._bossId)

	GameUtil.SetActive(imgLock, result ~= GameEnum.ResultCode.Success)
	MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
	GameUtil.addClickHandler(mainGo, function()
		if bossId ~= self._bossId then
			self._bossId = bossId

			self:_onUpdate()
		end
	end)
end

function WisdomCourageClgBossView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(mainGo)
end

function WisdomCourageClgBossView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function WisdomCourageClgBossView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function WisdomCourageClgBossView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function WisdomCourageClgBossView:_getSkinId()
	local data = WisdomCourageClgConfig.instance:getBossData(self._activityId, self._bossId)

	return (data or nil) and (data.skinId or 0)
end

function WisdomCourageClgBossView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local index = cell.index + 1
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local imgHasGain = goutil.findChild(mainGo, "imgHasGain")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local isHasGain = self._clgMo:isHasGainPrizeInBoss(data.prizeId)

	GameUtil.SetActive(imgHasGain, isHasGain)

	txtDesc.text = data.desc
	txtNum.text = index

	if itemScrView and self._itemScrCell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollerListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo]

			self._itemScrollerListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollerListDic[mainGo]:dragNotifyParent()
		end
	end
end

function WisdomCourageClgBossView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollerListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end
end

function WisdomCourageClgBossView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function WisdomCourageClgBossView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function WisdomCourageClgBossView:_onClickBtnRank()
	WisdomCourageClgController.instance:openCommonTabRank(self._activityId, ViewName.WisdomCourageClgBossViewRankChildView)
end

function WisdomCourageClgBossView:_onClickBtnSweep()
	if not WisdomCourageClgController.instance:isInActivityTime(self._activityId) then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	WisdomCourageClgController.instance:enterBattleInBoss(self._activityId, self._bossId, true)
end

function WisdomCourageClgBossView:_onClickBtnChallenge()
	local result = self:getTryStartClgResultAndTips(true, self._activityId, self._bossId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	WisdomCourageClgController.instance:enterBattleInBoss(self._activityId, self._bossId, false)
end

function WisdomCourageClgBossView:getTryStartClgResultAndTips(isNeedTips, activityId, bossId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._clgMo

	if not WisdomCourageClgController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif mo:getLeftDailyTimes(bossId) <= 0 then
		result = GameEnum.ResultCode.IsPass
		tips = "剩余次数不足"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function WisdomCourageClgBossView:getCurBuffDay(activityId)
	local activityType = WisdomCourageClgController.instance:getActivityType()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now())
	local cfg = WisdomCourageClgConfig.instance:getBossBuffCfg(activityId) or {}
	local length = #cfg

	if length > 0 then
		return (day - 1) % length + 1
	else
		return 0
	end
end

return WisdomCourageClgBossView
