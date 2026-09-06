-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgZoneView.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgZoneView", package.seeall)

local OriginGodDragonClgZoneView = class("OriginGodDragonClgZoneView", ViewComponent)

function OriginGodDragonClgZoneView:buildUI()
	OriginGodDragonClgZoneView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnReset = self:getGo("btns/btnReset")
	self._btnBuff = self:getGo("btns/btnBuff")
	self._btnLockPet = self:getGo("btns/btnLockPet")
	self._zoneView = self:getGo("zoneView")
	self._zoneCellList = {}

	for idx = 1, self._zoneView.transform.childCount do
		local mainGo = self._zoneView.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
		cell._tagPass = goutil.findChild(mainGo, "tagPass")
		cell._tagLock = goutil.findChild(mainGo, "tagLock")
		self._zoneCellList[idx] = cell
	end
end

function OriginGodDragonClgZoneView:bindEvents()
	OriginGodDragonClgZoneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnLockPet, self._onClickBtnLockPet, self)
end

function OriginGodDragonClgZoneView:unbindEvents()
	OriginGodDragonClgZoneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnLockPet)
end

function OriginGodDragonClgZoneView:onEnter()
	OriginGodDragonClgZoneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)
	self._actData = OriginGodDragonClgConfig.instance:getActivityData(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonResetRes, self._handlePM_OriginGodDragonResetRes, self)
end

function OriginGodDragonClgZoneView:onExit()
	OriginGodDragonClgZoneView.super.onExit(self)

	for _, cell in pairs(self._zoneCellList) do
		self:_clearZoneCell(cell)
	end
end

function OriginGodDragonClgZoneView:_handlePM_OriginGodDragonResetRes()
	OriginGodDragonClgController.instance:sendPM_OriginGodDragonClgInfoReq(self._activityId)
end

function OriginGodDragonClgZoneView:_onUpdate()
	local zoneDatas = OriginGodDragonClgConfig.instance:getZoneDatas(self._activityId) or {}

	for zoneId, cell in ipairs(self._zoneCellList) do
		local data = OriginGodDragonClgConfig.instance:getZoneData(self._activityId, zoneId)

		if data then
			self:_updateZoneCell(cell, zoneId)
		else
			GameUtil.SetActive(cell._mainGo, false)
			self:_clearZoneCell(cell)
		end
	end
end

function OriginGodDragonClgZoneView:_updateZoneCell(cell, zoneId)
	local data = OriginGodDragonClgConfig.instance:getZoneData(self._activityId, zoneId)
	local isPass = self._subMo:isPassZone(zoneId)
	local isUnlock = self._subMo:isUnlockZone(zoneId)

	GameUtil.SetActive(cell._mainGo, true)
	GameUtil.SetActive(cell._tagPass, isPass)
	GameUtil.SetActive(cell._tagLock, not isUnlock)

	cell._txtName.text = data.name

	GameUtil.addClickHandler(cell._mainGo, function()
		if not isUnlock then
			FloatWordMgr.instance:show("未解锁")

			return
		end

		UIStateManager.instance:push(ViewName.OriginGodDragonClgStageView, self._activityId, zoneId)
	end, self)
end

function OriginGodDragonClgZoneView:_clearZoneCell(cell)
	GameUtil.rmClickHandler(cell._mainGo)
end

function OriginGodDragonClgZoneView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginGodDragonClgZoneView:_onClickBtnReset()
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isHavePassStage = false
		local stageDatas = OriginGodDragonClgConfig.instance:getStageDatas(self._activityId) or {}

		for _, data in ipairs(stageDatas) do
			local info = self._subMo:getStageInfo(data.stageId)

			if info then
				isHavePassStage = true

				break
			end
		end

		if not isHavePassStage then
			result = GameEnum.ResultCode.Error
			tips = "无需重置"
		end
	end

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	local tipsContent = "重置后将清除所有进度，是否确认重置？"

	local function okFunc()
		OriginGodDragonClgController.instance:sendPM_OriginGodDragonResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginGodDragonClgZoneView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.OriginGodDragonClgBuffView, self._activityId)
end

function OriginGodDragonClgZoneView:_onClickBtnLockPet()
	UIStateManager.instance:push(ViewName.OriginGodDragonClgBanPetView, self._activityId)
end

return OriginGodDragonClgZoneView
