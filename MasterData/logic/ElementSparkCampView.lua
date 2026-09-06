-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkCampView.lua

module("logic.extensions.elementspark.view.ElementSparkCampView", package.seeall)

local ElementSparkCampView = class("ElementSparkCampView", ViewComponent)

function ElementSparkCampView:ctor()
	ElementSparkCampView.super.ctor(self)
end

function ElementSparkCampView:unbindEvents()
	ElementSparkCampView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnSetTeam)
	GameUtil.rmClickHandler(self._btnMyTeam)
	GameUtil.rmClickHandler(self._btnEffect)
end

function ElementSparkCampView:bindEvents()
	ElementSparkCampView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickbtnRecord, self)
	GameUtil.addClickHandler(self._btnSetTeam, self._onClickSetTeam, self)
	GameUtil.addClickHandler(self._btnMyTeam, self._onClickMyTeam, self)
	GameUtil.addClickHandler(self._btnEffect, self._onClickEffect, self)
end

function ElementSparkCampView:buildUI()
	ElementSparkCampView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnEffect = self:getBtn("btnEffect")
	self._btnLevelUp = self:getBtn("info/btnLevelUp")
	self._btnRecord = self:getBtn("info/btnRecord")
	self._btnSetTeam = self:getBtn("info/btnSetTeam")
	self._btnMyTeam = self:getBtn("info/btnMyTeam")
	self._txtSetTeam = self:getTxt("info/btnSetTeam/txt")
	self._txtName = self:getTxt("name/txtName")
	self._txtCount = self:getTxt("count/txtCount")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._txtScore = self:getTxt("info/txtScore")
	self._guardCd = self:getGo("info/standBy")
	self._tableviewGo = self:getGo("tableview")
	self._viewPort = self:getGo("tableview/Viewport")
	self._guardCell = self:getGo("guardCell")
	self._empty = self:getGo("empty")
	self._boss = self:getGo("boss")
	self._bossBlood = self:getSlider("boss/bossBlood")
	self._txtBlood = self:getTxt("boss/txtBlood")
	self._txtBloodRate = self:getTxt("boss/txtBloodRate")
	self._txtPetName = self:getTxt("boss/txtName")
	self._petCell = self:getGo("petCell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._guardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._bossIcon = self:getGo("boss/petHead")
end

function ElementSparkCampView:onExit()
	ElementSparkCampView.super.onExit(self)
	self._tableview:dispose()
	removetimer(self._cutDownList, self)
end

function ElementSparkCampView:onEnter()
	ElementSparkCampView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetMyGuardInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.EleSparkGetMyFormsRes, self._refreshFormInfo, self)
	self.addGEvent(self, GlobalNotify.EleSparkSendGuardDefenseFormReq, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.EleSparkRevokeDefenseFormRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.EleSparkUpgradeGuardRes, self._refreshLevel, self)
	self.addGEvent(self, GlobalNotify.ElementSparkMapChange, self._onMapChange, self)
	self.addGEvent(self, GlobalNotify.EleSparkGetInfoRes, self._onMapChange, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._chunkId = checknumber(self:getFirstParam())
	self._planId = ElementSparkController.instance:getMapPlanId()

	self:_sendInfoReq()

	self._txtSetTeam.text = "布置守军"
	self._maxGuardCount = 0
	self._guardCount = 0
	self._isForm = false
	self._canRevoke = false
	self._isBossState = false
	self._isSetDefenseTeam = false
	self._isSetTeamInChunk = false

	GameUtil.SetActive(self._guardCd, false)

	self._cdList = {}

	settimer(1, self._cutDownList, self, true)
end

function ElementSparkCampView:_sendInfoReq()
	ElementSparkController.instance:sendPM_EleSparkGetMyGuardInfoReq(self._activityId, self._chunkId)
	ElementSparkController.instance:sendPM_EleSparkGetMyFormsReq(self._activityId)
end

function ElementSparkCampView:_refresh()
	self._chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(self._planId, self._chunkId)
	self._guardInfo = ElementSparkModel.instance:getGuardInfo()
	self._canRevoke = checkbool(self._guardInfo.canRevoke)
	self._starLv = self._chunkCfg.star
	self._level = self._guardInfo.level or 1
	self._myDefenseChunkId = checknumber(self._guardInfo.myDefenseChunkId)
	self._isSetTeamInChunk = self._myDefenseChunkId == self._chunkId

	local pos = self._chunkCfg.pos
	local campId = ElementSparkModel.instance:getMyCampId()
	local campName = ElementSparkConfig.instance:getCampCfgById(self._activityId, campId).name

	self._maxGuardCount = ElementSparkConfig.instance:getMapLvCfgById(self._planId, self._starLv, self._level).guardNum

	if not self._guardInfo.defenseForms then
		self._guardCount = #self._guardInfo.defenseForms

		self:_refreshBoss()

		if #self._guardInfo.defenseForms <= 0 then
			GameUtil.SetActive(self._empty, true)
			GameUtil.SetActive(self._tableviewGo, false)
		else
			GameUtil.SetActive(self._empty, false)
			GameUtil.SetActive(self._tableviewGo, true)
			self._tableview:reloadData(self._guardInfo.defenseForms)
		end

		self._txtName.text = string.format("%s阵营-%d星地块(%d,%d)", campName, self._starLv, pos[1], pos[2])
		self._txtCount.text = string.format("守军数量/守军驻扎上限：<color=20b376>%d</color>/%d", self._guardCount, self._maxGuardCount)

		local accGuardMinutes = checknumber(self._guardInfo.accGuardMinutes)
		local isDefense = self._myDefenseChunkId > 0

		if not isDefense then
			self._txtDesc.text = "暂未布置守军"
		else
			local accGuardScore = checknumber(self._guardInfo.accGuardScore)

			if self._isSetTeamInChunk then
				self._txtDesc.text = string.format("累计驻守%d分钟。可获得%d个人积分", accGuardMinutes, accGuardScore)
			else
				local pos = ElementSparkConfig.instance:getMapChunkCfgById(self._planId, self._myDefenseChunkId).pos

				self._txtDesc.text = string.format("我的守军正在(%d,%d)地块驻守，累计%d分钟、%d个人积分", pos[1], pos[2], accGuardMinutes, accGuardScore)
			end
		end

		local campDamageInfos = ElementSparkController.instance:filterCampDamageInfos(self._guardInfo.campDamageInfos)

		if #campDamageInfos <= 0 then
			self._txtScore.text = "当前暂无其他阵营攻打本地块"
		else
			local desc = ""

			for i, v in ipairs(campDamageInfos) do
				local newRecord = string.format("%s阵营贡献:%d", v.campName, v.percent)

				desc = desc .. newRecord
			end

			self._txtScore.text = desc
		end

		self:_refreshGuard()
	end
end

function ElementSparkCampView:_refreshFormInfo()
	self._isForm = not TableUtil.isTableEmpty(ElementSparkController.instance:getDefenseTeamInfoById(1))
end

function ElementSparkCampView:_refreshBoss()
	local bossInfo = ElementSparkModel.instance:getGuardBossInfo()

	self._isBossState = not TableUtil.isTableEmpty(bossInfo)

	local bossHp = bossInfo.bossFullHp
	local leftHp = bossInfo.bossLeftHp

	self._txtPetName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._chunkCfg.bossRaceId)

	MaterialMgr.setIcon(self._bossIcon, MatType.PET_SKIN, self._chunkCfg.bossRaceId)

	if self._isBossState then
		GameUtil.SetActive(self._txtBlood.gameObject, true)
		GameUtil.SetActive(self._txtBloodRate.gameObject, true)

		local recoveryRate = bossInfo.rate

		self._txtBlood.text = string.format("剩余血量：<color=#eb4642>%d</color>/%d", leftHp, bossHp)
		self._txtBloodRate.text = string.format("非战时回血：<color=#eb4642>%d%%</color>/分钟", recoveryRate / 100)

		self._bossBlood:SetValue(1 / bossHp * leftHp)
	else
		GameUtil.SetActive(self._txtBlood.gameObject, false)
		GameUtil.SetActive(self._txtBloodRate.gameObject, false)
	end
end

function ElementSparkCampView:_refreshGuard()
	self._isSetDefenseTeam = self._myDefenseChunkId > 0

	if self._isSetDefenseTeam then
		self._txtSetTeam.text = "守军详情"
	end

	if self._cdList[self._guardCd] == nil then
		local info = {}

		info.timeGo = self._guardCd
		info.readyTimeMillis = checknumber(self._guardInfo.myDefenseChunkMillis)
		self._cdList.guard = info
	else
		self._cdList.guard.readyTimeMillis = checknumber(self._guardInfo.myDefenseChunkMillis)
	end
end

function ElementSparkCampView:_refreshLevel(lv)
	self._level = checknumber(lv)
	self._maxGuardCount = ElementSparkConfig.instance:getMapLvCfgById(self._planId, self._starLv, self._level).guardNum
	self._txtCount.text = string.format("守军数量/守军数量上限：<color=20b376>%d</color>/%d", self._guardCount, self._maxGuardCount)
end

function ElementSparkCampView:_updateCell(view, cell, data)
	local head = goutil.findChild(cell, "head")
	local defend = goutil.findChild(cell, "defend")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")
	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	txtName.text = data.headInfo.areaName .. ":" .. data.headInfo.userName
	txtPower.text = string.format("阵容战力：%d", data.zdl)

	for i = 1, 6 do
		local petCell = goutil.findChild(cell, "formation/petCell_" .. i)
		local faceId = checknumber(data.faceIds[i])

		if faceId > 0 then
			GameUtil.SetActive(petCell, true)

			local icon = goutil.findChild(petCell, "petCon/con")
			local blood = goutil.findChild(petCell, "blood"):GetComponent("Slider")
			local leftHp = checknumber(data.leftHps[i])
			local fullHp = checknumber(data.fullHps[i])

			MaterialMgr.setIcon(icon, MatType.Pet, faceId)

			blood.value = 1 / checknumber(fullHp) * leftHp

			GameUtil.SetGray(petCell, leftHp <= 0)
		else
			GameUtil.SetActive(petCell, false)
		end
	end

	GameUtil.SetActive(defend, data.state == 3)

	if self._cdList[cell] == nil then
		local info = {}

		info.timeGo = goutil.findChild(cell, "standBy")
		info.readyTimeMillis = checknumber(data.readyTimeMillis)
		self._cdList[cell] = info
	else
		self._cdList[cell].readyTimeMillis = checknumber(data.readyTimeMillis)
	end
end

function ElementSparkCampView:_clearCell(cell)
	return
end

function ElementSparkCampView:_cutDownList()
	for i, info in pairs(self._cdList) do
		local nowTime = ServerTime.nowMs()
		local cutDownTime = info.readyTimeMillis - nowTime
		local txtTime = goutil.findChildTextComponent(info.timeGo, "txtTime")

		if cutDownTime > 0 then
			GameUtil.SetActive(info.timeGo, true)

			txtTime.text = GameUtil.FormatTimeSymbol(cutDownTime / 1000)
		else
			GameUtil.SetActive(info.timeGo, false)
		end
	end
end

function ElementSparkCampView:_onClickTip()
	TipsFacade.instance:openRulesView("ElementSparkCamp_rule")
end

function ElementSparkCampView:_onClickLevelUp()
	UIStateManager.instance:push(ViewName.ElementSparkLevelupView, self._chunkId, self._level)
end

function ElementSparkCampView:_onClickSetTeam()
	if self._isBossState then
		FloatWordMgr.instance:show("本地块所有守军已战败,进入boss阶段,无法再布置守军")

		return
	end

	if self._isSetDefenseTeam and not self._isSetTeamInChunk then
		local tips = langPara("elementspark_7")

		local function sureChange()
			ElementSparkSceneController.instance:moveChunkToCenterAndLocation(self._myDefenseChunkId)
			self:close()
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("text_tong_tips"), tips, sureChange, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	if self._isSetDefenseTeam and not self._canRevoke then
		FloatWordMgr.instance:show("已进入战场无法撤军哦~")

		return
	end

	if self._guardCount >= self._maxGuardCount and not self._isSetDefenseTeam then
		FloatWordMgr.instance:show("阵营守军已达上限哦~")

		return
	end

	if not self._isForm then
		FloatWordMgr.instance:show("守军队伍未设置阵容哦~")

		return
	end

	if self._isSetDefenseTeam then
		local campName = ElementSparkController.instance:getMyCampName()
		local pos = self._chunkCfg.pos
		local chunkInfo = string.format("%s阵营-地块(%d,%d)", campName, pos[1], pos[2])
		local time = ElementSparkConfig.instance:getCommonCfgByKey("GUARD_READY_MINUTE", true)
		local tips = langPara("elementspark_6", chunkInfo, time)

		local function sureChange()
			ElementSparkController.instance:sendPM_EleSparkRevokeDefenseFormReq(self._activityId)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("text_tong_tips"), tips, sureChange, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
	else
		local power = ElementSparkModel.instance:getPowerValue()
		local time = ElementSparkConfig.instance:getCommonCfgByKey("GUARD_READY_MINUTE", true)
		local tips = langPara("elementspark_5", power, time)

		local function sureChange()
			ElementSparkController.instance:sendPM_EleSparkSendGuardDefenseFormReq(self._activityId, self._chunkId, 101)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("text_tong_tips"), tips, sureChange, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
	end
end

function ElementSparkCampView:_onClickMyTeam()
	UIStateManager.instance:push(ViewName.ElementSparkSetTeamView)
end

function ElementSparkCampView:_onClickbtnRecord()
	UIStateManager.instance:push(ViewName.ElementsparkrecordView, self._chunkId)
end

function ElementSparkCampView:_onClickEffect()
	local level = ElementSparkModel.instance:getChunkLevel(self._chunkId)

	UIStateManager.instance:push(ViewName.ElementSparkBossOccupiedEffectView, self._chunkId, level)
end

function ElementSparkCampView:_onMapChange()
	local belongMe = ElementSparkModel.instance:getChunlBelongMe(self._chunkId)

	if not belongMe then
		FloatWordMgr.instance:show("地块已敌方占领")
		self:close()

		return
	end
end

return ElementSparkCampView
