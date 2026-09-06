-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlonglevelView.lua

module("logic.extensions.kingwujinlong.view.KingwujinlonglevelView", package.seeall)

local KingwujinlonglevelView = class("KingwujinlonglevelView", ViewComponent)

function KingwujinlonglevelView:ctor()
	KingwujinlonglevelView.super.ctor(self)
end

function KingwujinlonglevelView:unbindEvents()
	KingwujinlonglevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnLock)
	GameUtil.rmClickHandler(self._btnBuff)
end

function KingwujinlonglevelView:bindEvents()
	KingwujinlonglevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnLock, self._onClickLock, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function KingwujinlonglevelView:buildUI()
	KingwujinlonglevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClg = self:getGo("btnClg")
	self._btnReset = self:getGo("btnReset")
	self._btnLock = self:getGo("btnLock")
	self._btnBuff = self:getGo("btnBuff")
	self._Content = self:getTxt("tips/scrView/Viewport/Content")
	self._leftFmt = self:getGo("leftFmt")
	self._rightFmt = self:getGo("rightFmt")
	self._goEmpty = self:getGo("leftFmt/goEmpty")
	self._itemcell = self:getGo("bubble/itemcell")
	self._imgHasGain = self:getGo("bubble/imgHasGain")
	self._scrView = self:getGo("tabCol/scrView")
	self._scrCell = self:getGo("tabCol/scrCell")
	self._scrollList = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingwujinlonglevelView:onExit()
	KingwujinlonglevelView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._itemcell)
end

function KingwujinlonglevelView:onEnter()
	KingwujinlonglevelView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = KingWujinlongController.instance:getActivityId()
	end

	self._scrollMap = {}

	self.addGEvent(self, GlobalNotify.KING_WUJINLONG_CLG_INFO_UPDATE, self._onRefreshUI, self)
	KingWujinlongController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
	KingWujinlongController.instance:tryShowChangeSet()
end

function KingwujinlonglevelView:_onRefreshUI()
	self._info = KingWujinlongModel.instance:getInfo(self._activityId) or {}
	self._clgInfo = self._info.clgInfo or {}

	if not self._clgInfo.posId2Count then
		local posId2Count = {}
		local historyPassStageId = checknumber(self._clgInfo.historyPassStageId)

		self._curPassStageId = checknumber(self._clgInfo.curPassStageId)

		local list = KingWujinlongConfig.instance:getStageCfgListById(self._activityId) or {}

		self._scrollList:reloadData(list)

		for i, v in ipairs(list) do
			if self._curPassStageId + 1 == v.stageId then
				self._scrollList:MoveCellToCenter(i - 1)

				break
			end
		end

		local cfg = KingWujinlongConfig.instance:getStageCfgById(self._activityId, self._curPassStageId + 1) or {}

		MaterialMgr.setCellByCfg(cfg.passPrize, self._itemcell)

		local creeps = KingWujinlongConfig.instance:getCreepsById(cfg.creepsMasterId) or {}

		self:_updateRightFmt(creeps)
		self:_updateLeftFmt(posId2Count)

		self._actCfg = KingWujinlongConfig.instance:getActivityCfgById(self._activityId) or {}
		self._Content.text = self._actCfg.battleDesc

		GameUtil.SetActive(self._imgHasGain, historyPassStageId > self._curPassStageId)
	end
end

function KingwujinlonglevelView:_updateLeftFmt(posId2Count)
	local map = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._leftFmt, "formation/seatTag_" .. i)

		map[i] = go

		GameUtil.SetActive(go, false)
	end

	local has = false

	for i, v in ipairs(posId2Count) do
		local posId = v.left
		local num = v.right
		local go = map[posId]

		if go and num > 0 then
			GameUtil.SetActive(go, true)

			local txt = goutil.findChildTextComponent(go, "img/txt")

			txt.text = num
			has = true
		end
	end

	GameUtil.SetActive(self._goEmpty, not has)
end

function KingwujinlonglevelView:_updateRightFmt(creepCfgs)
	local map = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._rightFmt, "formation/cell_" .. i)

		map[i] = go

		GameUtil.SetActive(go, false)
		GameUtil.rmClickHandler(go)
	end

	for k, v in pairs(creepCfgs) do
		local posId = checknumber(v.posId)

		if posId > 0 then
			local go = map[posId]

			GameUtil.SetActive(go, true)

			local con = goutil.findChild(go, "con")

			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))

			local mo = FightingPowerPetMo.New()

			mo:fromChallengeCreepCo(v)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:showPetTips(mo)
			end)
		end
	end
end

function KingwujinlonglevelView:_updateCell(view, cell, data, tag)
	local imgLock = goutil.findChild(cell, "imgLock")
	local imgPass = goutil.findChild(cell, "imgPass")
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	GameUtil.SetActive(imgPass, self._curPassStageId >= data.stageId)
	GameUtil.SetActive(imgSelected, self._curPassStageId + 1 == data.stageId)
	GameUtil.SetActive(imgLock, self._curPassStageId + 1 < data.stageId)

	txtName.text = data.name
end

function KingwujinlonglevelView:_clearCell(cell)
	return
end

function KingwujinlonglevelView:_onClickTip()
	TipsFacade.instance:openRulesView("kingwujinlonglevelview_rule")
end

function KingwujinlonglevelView:_onClickStart()
	KingWujinlongController.instance:openFmtView(self._activityId, self._curPassStageId)
end

function KingwujinlonglevelView:_onClickReset()
	if self._curPassStageId == 0 then
		TipsFacade.instance:openCommonTips("未通关任何关卡")
	else
		TipsFacade.instance:openPopupWindow(lang("tip"), "是否将所有关卡重置为未挑战，解除所有精灵封印(奖励不重置)", function()
			KingWujinlongController.instance:sendReset(self._activityId)
		end)
	end
end

function KingwujinlonglevelView:_onClickLock()
	UIStateManager.instance:push(ViewName.KingwujinlonglockView, self._activityId)
end

function KingwujinlonglevelView:_onClickBuff()
	UIStateManager.instance:push(ViewName.KingwujinlongbuffView, self._activityId)
end

return KingwujinlonglevelView
