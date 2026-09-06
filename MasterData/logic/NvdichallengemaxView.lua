-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdichallengemaxView.lua

module("logic.extensions.nvdi.view.NvdichallengemaxView", package.seeall)

local NvdichallengemaxView = class("NvdichallengemaxView", ViewComponent)

function NvdichallengemaxView:ctor()
	NvdichallengemaxView.super.ctor(self)
end

function NvdichallengemaxView:unbindEvents()
	NvdichallengemaxView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShow)
	GameUtil.rmClickHandler(self._btnTip)
end

function NvdichallengemaxView:bindEvents()
	NvdichallengemaxView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
end

function NvdichallengemaxView:buildUI()
	NvdichallengemaxView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnShow = self:getGo("btnShow")
	self._btnTip = self:getGo("btnTip")
	self._tableview = self:getGo("tableview")
	self._tabelcell = self:getGo("tabelcell")
	self._petCell = self:getGo("petCell")
	self._txtDesc = self:getTxt("txtDesc")
	self._scrollList = ScrollerList.create(self._tableview, self._tabelcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function NvdichallengemaxView:onExit()
	NvdichallengemaxView.super.onExit(self)
	self._scrollList:dispose()
end

function NvdichallengemaxView:onEnter()
	NvdichallengemaxView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityType = NvdiChallengeController.instance:getActivityType()

	local isInTime = NvdiChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._cellScMap = {}
	self._actCfg = NvdiChallengeConfig.instance:getActivityCfgById(self._activityId) or {}

	self.addGEvent(self, GlobalNotify.NVDI_CHALLENGE_INFO_UPDATE, self._refreshUI, self)
	self:_refreshUI()
	NvdiChallengeController.instance:sendGetInfo(self._activityId)
end

function NvdichallengemaxView:_refreshUI()
	self._info = NvdiChallengeModel.instance:getInfo(self._activityId) or {}
	self._isAllPass = NvdiChallengeModel.instance:isPassAllOfExtStage(self._activityId)
	self._stageInfoMap = {}

	for i, v in ipairs(self._info.extremeClgStageInfo or {}) do
		self._stageInfoMap[v.stageId] = v
	end

	self._txtDesc.text = NvdiChallengeConfig.instance:getCommonCfgById("empress_extreme_rule")

	local list = NvdiChallengeConfig.instance:getStageCfgList(self._activityId) or {}
	local idx = 0

	for i, v in ipairs(list) do
		local info = self._stageInfoMap[v.stageId]

		if info == nil or not info.passed then
			idx = i - 1

			break
		end
	end

	self._scrollList:reloadData(list)
	self._scrollList:MoveCellInView(idx)
	NvdiChallengeController.instance:checkAndShowSuccView()
end

function NvdichallengemaxView:_onClickTips()
	TipsFacade.instance:openRulesView("nvdichallengemaxview_rule")
end

function NvdichallengemaxView:_onClickShow()
	UIStateManager.instance:push(ViewName.NvdibuffView, self._activityId)
end

function NvdichallengemaxView:_updateCell(view, cell, data, tag)
	local btn = goutil.findChild(cell, "root")
	local pass = goutil.findChild(cell, "root/pass")
	local txtEmpty = goutil.findChild(cell, "root/txtEmpty")
	local txtName = goutil.findChildTextComponent(cell, "root/txtName")
	local txtDamage = goutil.findChildTextComponent(cell, "root/txtDamage")
	local icon = goutil.findChild(cell, "root/icon")
	local btnRefresh = goutil.findChild(cell, "root/btnRefresh")
	local tableview = goutil.findChild(cell, "root/tableview")
	local imgRole = goutil.findChild(cell, "root/imgRole/img")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	if modelCo then
		uGuiUtil.setSpriteToImage(imgRole.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	GameUtil.SetActive(btnRefresh, false)
	GameUtil.SetActive(pass, false)

	local scr = self._cellScMap[cell]

	if scr == nil then
		scr = ScrollerList.create(tableview, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self.clearPetCell, self))
		self._cellScMap[cell] = scr
	end

	uGuiUtil.clearImage(icon)
	GameUtil.SetActive(icon, false)

	txtName.text = tostring(data.name)
	txtDamage.text = "无"

	local list = {}
	local info = self._stageInfoMap[data.stageId]

	if info then
		GameUtil.SetActive(pass, info.passed)
		GameUtil.SetActive(btnRefresh, not self._isAllPass and info.passed)

		list = info.lockedRace or {}

		if info.buffIdUsed > 0 then
			GameUtil.SetActive(icon, true)

			txtDamage.text = ""

			local cfg = NvdiChallengeConfig.instance:getBuffCfgById(self._activityId, info.buffIdUsed) or {}

			uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
		end
	end

	scr:reloadData(list)
	GameUtil.SetActive(txtEmpty, #list == 0)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickGoMissionview, self, data))
	GameUtil.addClickHandler(btnRefresh, GameUtil.handler(self._onClickRefresh, self, data))
end

function NvdichallengemaxView:clearCell(cell)
	local scr = self._cellScMap[cell]

	if scr then
		scr:dispose()
	end

	local imgRole = goutil.findChild(cell, "root/imgRole/img")

	uGuiUtil.clearImage(imgRole.gameObject)
end

function NvdichallengemaxView:_updatePetCell(view, cell, data, tag)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

function NvdichallengemaxView:clearPetCell(cell, data, tag)
	MaterialMgr.resetAll(cell)
end

function NvdichallengemaxView:_onClickGoMissionview(data)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local info = self._stageInfoMap[data.stageId]

	if info and info.passed then
		if self._isAllPass then
			TipsFacade.instance:openCommonTips("已经全部通关")
		else
			TipsFacade.instance:openCommonTips("已通关,重置关卡后可挑战")
		end

		return
	end

	NvdiChallengeController.instance:showExtMissionview(self._activityId, data.stageId)
end

function NvdichallengemaxView:_onClickRefresh(data)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local content = "是否将本关卡重置为未挑战，解除精灵与命途的封印"

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		NvdiChallengeController.instance:sendResetExtStage(self._activityId, data.stageId)
	end)
end

return NvdichallengemaxView
