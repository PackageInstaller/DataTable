-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationSignInView.lua

module("logic.extensions.operationsignin.view.OperationSignInView", package.seeall)

local OperationSignInView = class("OperationSignInView", ViewComponent)
local SIGN_IN_NUM = 70

function OperationSignInView:ctor()
	OperationSignInView.super.ctor(self)
end

function OperationSignInView:buildUI()
	OperationSignInView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._signInCells = {}

	for i = 1, SIGN_IN_NUM do
		local cell = {}
		local go = self:getGo("signinCells/cell" .. i)

		if go then
			cell.go = go
			cell.bg = goutil.findChild(cell.go, "bg")
			cell.itemcell = goutil.findChild(cell.go, "itemCell")
			cell.signin = goutil.findChild(cell.go, "btnSignin")

			goutil.setActive(cell.signin, false)

			cell.btn = GameUtil.asBtn(cell.signin)
			cell.mark = goutil.findChild(cell.go, "markHasGain")

			goutil.setActive(cell.mark, false)

			cell.txtDay = goutil.findChildTextComponent(cell.go, "txtDay")
			cell.txtNum = goutil.findChildTextComponent(go, "txtNum")
			cell.isHasGain = false
			cell.effParent = goutil.findChild(cell.go, "eff")
			cell.lock = goutil.findChild(cell.go, "lock")
			self._signInCells[i] = cell
		else
			break
		end
	end

	self.con = self:getGo("con")
	self._maskBlock = self:getGo("MaskBlock")
	self._switchEffGo = self:getGo("effect")
	self._txtNum = self:getTxt("periods/txtNum")
end

function OperationSignInView:bindEvents()
	OperationSignInView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, #self._signInCells do
		self._signInCells[i].btn:AddClickListener(function()
			self:_onClickSingin(i)
		end, self)
	end
end

function OperationSignInView:unbindEvents()
	OperationSignInView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, #self._signInCells do
		self._signInCells[i].btn:RemoveClickListener()
	end
end

function OperationSignInView:destroyUI()
	OperationSignInView.super.destroyUI(self)
end

function OperationSignInView:onEnter()
	OperationSignInView.super.onEnter(self)

	self.activityId = self:_getActivityId()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self.activityId)

	if not isInTime then
		FloatWordMgr.instance:show("当前活动未开启")
		self:close()

		return
	end

	GlobalDispatcher:addListener(OperationCheckInAgent.PM_OperationCheckInGetInfoRes, self._onOperationCheckInGetInfoRes, self)

	self.hideChildList = {}

	if checknumber(self.activityId) == 18017 then
		self._txtNum.text = lang("第1/2期")
		self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, 15002, self.con, 0.25)
	elseif checknumber(self.activityId) == 18018 then
		self._txtNum.text = lang("第2/2期")
		self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, 11000, self.con, 0.2)
	else
		self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self:_getShowRaceId(), self.con, 1)
	end

	self:refreshUIByActcfg()
	OperationCheckInAgent.instance:sendPM_OperationCheckInGetInfoReq(self.activityId)

	local path = "fx_ui_20211014/xinxinniannian_qiandao/fx_ui_qiandao_xxnn.prefab"

	self._maineff = UIEffectManager.instance:playEffect(self, path, self.mainGO, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self.mainGO.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function OperationSignInView:_onPrefabResourcesLoaded(res)
	if res and res.IsSuccess then
		res:Retain()

		self._res = res
		self._yuebing = goutil.clone(res:GetMainAsset())
	end
end

function OperationSignInView:onEnterFinished()
	OperationSignInView.super.onEnterFinished(self)
end

function OperationSignInView:onExit()
	OperationSignInView.super.onExit(self)

	if self._switchEffect then
		UIEffectManager.instance:stopEffect(self._switchEffect)

		self._switchEffect = nil
	end

	self._maskBlock:SetActive(false)
	removetimer(self._timer, self)

	for i = 1, #self._signInCells do
		MaterialMgr.resetAll(self._signInCells[i].itemcell)

		if self._signInCells[i].eff then
			UIEffectManager.instance:stopEffect(self._signInCells[i].eff)

			self._signInCells[i].eff = nil
		end
	end

	UIEffectManager.instance:stopEffect(self._maineff)

	self._maineff = nil

	if self.loader and self.loader.asset and self.hideChildList then
		for i, v in ipairs(self.hideChildList) do
			local c = goutil.findChild(self.loader.asset, v)

			GameUtil.SetActive(c, true)
		end
	end

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	GlobalDispatcher:removeListener(OperationCheckInAgent.PM_OperationCheckInGetInfoRes, self._onOperationCheckInGetInfoRes, self)
end

function OperationSignInView:onExitFinished()
	OperationSignInView.super.onExitFinished(self)
end

function OperationSignInView:_getActivityId()
	return OperationSignInModel.instance:getCurActicityId()
end

function OperationSignInView:refreshUIByActcfg()
	self._prizeList = OperationSignInConfig.instance:getSignInCfgList(self.activityId)

	table.sort(self._prizeList, function(a, b)
		return a.day < b.day
	end)

	for i = 1, #self._signInCells do
		if self._prizeList[i] then
			goutil.setActive(self._signInCells[i].go, true)

			local reward = self._prizeList[i].reward
			local type, id, num = MaterialMgr.getMatParams(reward)

			self._signInCells[i].txtNum.text = "x" .. num

			local cell = self._signInCells[i].itemcell

			GameUtil.addClickHandler(cell, function()
				CommonTipsMgr.instance:openTipsByConfStr(cell, reward)
			end)

			self._signInCells[i].proxy = MaterialMgr.setCellByCfg(reward, self._signInCells[i].itemcell)

			self._signInCells[i].proxy.binder:setNum(0)
		end
	end

	local activityType = ActivityDefineController.instance:getActTypeByActId(self.activityId)

	self.startTime, self.endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self.activityId)

	if self.endTime < GameUtil.ForeverActTimeStringStamp then
		settimer(1, self._timer, self, true)
		self:_timer()
	else
		removetimer(self._timer, self)

		self._txtLeftTime.text = "常驻"
	end
end

function OperationSignInView:_onClickSingin(id)
	if not self._signInCells[id].isHasGain then
		if id > self._onlineDay then
			FloatWordMgr.instance:show("未达到签到日期")
			goutil.setActive(self._signInCells[id].signin, false)
		else
			OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(self.activityId, id, function(msg)
				self._signInCells[id].isHasGain = true

				goutil.setActive(self._signInCells[id].signin, false)
				goutil.setActive(self._signInCells[id].mark, true)

				if self._signInCells[id].eff then
					UIEffectManager.instance:stopEffect(self._signInCells[id].eff)

					self._signInCells[id].eff = nil

					GameUtil.SetActive(self._signInCells[id].effParent, false)
				end

				if self._signInCells[id].proxy then
					self._signInCells[id].proxy.binder:setEffStatus(false)
				end

				self._changeSetId = msg.changeSetId

				if checknumber(self._changeSetId) > 0 then
					MaterialFacade.instance:popAndShowChangeSetItems(self._changeSetId)
				end
			end)
		end
	else
		FloatWordMgr.instance:show("已签到")
		goutil.setActive(self._signInCells[id].mark, true)
		goutil.setActive(self._signInCells[id].signin, false)

		if self._signInCells[id].eff then
			UIEffectManager.instance:stopEffect(self._signInCells[id].eff)

			self._signInCells[id].eff = nil
		end
	end
end

function OperationSignInView:_createEff(id)
	if self._signInCells[id].eff then
		UIEffectManager.instance:stopEffect(self._signInCells[id].eff)

		self._signInCells[id].eff = nil
	end

	local path = self:_getEffectPath()

	if not string.nilorempty(path) then
		GameUtil.SetActive(self._signInCells[id].effParent, true)

		self._signInCells[id].eff = UIEffectManager.instance:playEffect(self, path, self._signInCells[id].effParent, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(self._signInCells[id].effParent.transform)
			eff:setClipping(self._signInCells[id].go:GetComponent(goutil.Type_RectTransform))
			GameUtil.setLocalPos(eff.effGo.transform, 0, self:_getYPos(), 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end)
	else
		GameUtil.SetActive(self._signInCells[id].effParent, false)
	end
end

function OperationSignInView:_timer()
	local leftTime = self.endTime - ServerTime.now()

	if leftTime > 0 then
		self._txtLeftTime.text = string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(leftTime))
	else
		FloatWordMgr.instance:show("当前活动结束")
		self:close()
	end
end

function OperationSignInView:_getShowRaceId()
	return 15002
end

function OperationSignInView:_getEffectPath()
	return "fx_ui_qirirenwu/fx_ui_kelingqu_ceshihuikui.prefab"
end

function OperationSignInView:_getYPos()
	return 0
end

function OperationSignInView:_onOperationCheckInGetInfoRes(status, msg)
	self._onlineDay = checknumber(msg.onlineDay)

	if not msg.hasGainPrizeDays then
		for i = 1, #self._signInCells do
			self._signInCells[i].isHasGain = table.keyof(msg.hasGainPrizeDays, i)

			if self._signInCells[i].isHasGain then
				GameUtil.SetActive(self._signInCells[i].effParent, false)
				goutil.setActive(self._signInCells[i].mark, true)
				goutil.setActive(self._signInCells[i].signin, false)

				if self._signInCells[i].proxy then
					self._signInCells[i].proxy.binder:setEffStatus(false)
				end
			else
				if self._signInCells[i].proxy then
					self._signInCells[i].proxy.binder:setEffStatus(true)
				end

				GameUtil.SetActive(self._signInCells[i].effParent, false)
				goutil.setActive(self._signInCells[i].mark, false)

				if i <= self._onlineDay then
					goutil.setActive(self._signInCells[i].signin, true)
					self:_createEff(i)
				else
					goutil.setActive(self._signInCells[i].signin, false)
				end
			end
		end
	end
end

return OperationSignInView
