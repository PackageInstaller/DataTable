-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/view/CiyuanlonghuangnuoyalevelView.lua

module("logic.extensions.ciyuanlonghuangnuoya.view.CiyuanlonghuangnuoyalevelView", package.seeall)

local CiyuanlonghuangnuoyalevelView = class("CiyuanlonghuangnuoyalevelView", ViewComponent)

function CiyuanlonghuangnuoyalevelView:unbindEvents()
	CiyuanlonghuangnuoyalevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function CiyuanlonghuangnuoyalevelView:bindEvents()
	CiyuanlonghuangnuoyalevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickHelp, self)
end

function CiyuanlonghuangnuoyalevelView:buildUI()
	CiyuanlonghuangnuoyalevelView.super.buildUI(self)

	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._txtDesc = self:getTxt("ScrollView/Viewport/Content")
	self._txtDesc2 = self:getTxt("item/txtDesc")
	self._stageList = {}

	for i = 1, 3 do
		local stage = self:getGo("btnStage_" .. i)

		table.insert(self._stageList, stage)
	end

	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function CiyuanlonghuangnuoyalevelView:onExit()
	CiyuanlonghuangnuoyalevelView.super.onExit(self)
	self._scrollList:dispose()

	for k, v in pairs(self._scrollMap) do
		v:dispose()
	end
end

function CiyuanlonghuangnuoyalevelView:onEnter()
	CiyuanlonghuangnuoyalevelView.super.onEnter(self)

	self._activityId = CiyuanlonghuangnuoyaController.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	self._scrollMap = {}

	self.addGEvent(self, GlobalNotify.CIYUANLONGHUANG_NUOYA_INFO_UPDATE, self._onRefreshUI, self)
	CiyuanlonghuangnuoyaController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function CiyuanlonghuangnuoyalevelView:_onRefreshUI()
	self._info = CiyuanlonghuangnuoyaModel.instance:getInfo(self._activityId) or {}

	local totalValue = 0

	self._stageInfoMap = {}

	if not self._info.stageInfo then
		for i, v in pairs(self._info.stageInfo) do
			totalValue = totalValue + checknumber(v.timeScore)
			self._stageInfoMap[v.stageId] = v
		end

		local curPhaseId = checknumber(self._info.curPhaseId)

		curPhaseId = curPhaseId == 0 and 1 or curPhaseId
		self._curPhaseId = curPhaseId
		self._txtTime.text = ""

		local now = ServerTime.now()

		for i, v in ipairs(self._stageList) do
			local txt = goutil.findChildTextComponent(v, "txt")
			local txtTime = goutil.findChildTextComponent(v, "txtTime")
			local txtTip = MaterialMgr.findGraphicText(v, "bubble/txtTip")
			local pass = goutil.findChild(v, "pass")
			local bg_2 = goutil.findChild(v, "bg_2")
			local bg_no = goutil.findChild(v, "bg_no")

			GameUtil.SetActive(pass, false)

			local cfg = CiyuanlonghuangnuoyaConfig.instance:getPhaseCfgById(self._activityId, i) or {}

			if not cfg.title then
				txt.text = ""
				txtTime.text = ""
				txtTip.text = ""

				GameUtil.SetActive(bg_2, false)
				GameUtil.SetActive(bg_no, false)

				local prize = cfg.prize
				local pType, pId, pNum = MaterialMgr.getMatParams(prize)

				if pType then
					txtTip.text = MaterialMgr.getContentMatCfg(pType, pId, 50, -10, MaterialMgr.ICON_TYPE_CFGID) .. "x" .. checknumber(pNum)
				end

				local timeStart = GameUtil.string2time(cfg.openTime)

				if i < curPhaseId then
					txt.text = ""

					GameUtil.SetActive(pass, true)
					GameUtil.SetActive(bg_no, false)
				elseif i == curPhaseId then
					if timeStart <= now then
						GameUtil.SetActive(bg_2, true)
					else
						GameUtil.SetActive(bg_no, true)

						txtTime.text = langPara("%s\n开启", GameUtil.formatTimeString("%m.%d", cfg.openTime))
					end
				elseif timeStart <= now then
					GameUtil.SetActive(bg_no, true)

					txtTime.text = lang("通关\n上一层\n开启")
				else
					GameUtil.SetActive(bg_no, true)

					txtTime.text = langPara("%s\n开启", GameUtil.formatTimeString("%m.%d", cfg.openTime))
				end
			end
		end

		local list = CiyuanlonghuangnuoyaConfig.instance:getStageListById(self._activityId, self._curPhaseId) or {}

		self._scrollList:reloadData(list)

		local cfg = CiyuanlonghuangnuoyaConfig.instance:getPhaseCfgById(self._activityId, curPhaseId) or {}

		self._txtDesc.text = cfg.desc
		self._txtDesc2.text = langPara("击败全部敌阵，且时间点数大于等于<color=#ffff00>%s</color>\n当前时间点总数：<color=#20b376>%s</color>", cfg.passPhaseScore, totalValue)
	end
end

function CiyuanlonghuangnuoyalevelView:_updateCell(view, cell, data, tag)
	local pass = goutil.findChild(cell, "fmt/pass")
	local down = goutil.findChild(cell, "down")
	local tablecell = goutil.findChild(cell, "down/tablecell")
	local tableview = goutil.findChild(cell, "down/tableview")
	local empty = goutil.findChild(cell, "down/empty")
	local txtValue1 = goutil.findChildTextComponent(cell, "down/txtValue")
	local downTime = goutil.findChild(cell, "downTime")
	local txtValue2 = goutil.findChildTextComponent(cell, "downTime/txtValue")
	local fmt = goutil.findChild(cell, "fmt")
	local btn = goutil.findChild(cell, "btn")
	local scrollList = self._scrollMap[cell]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
		self._scrollMap[cell] = scrollList
	end

	local map = {}

	for i = 1, 9 do
		local go = goutil.findChild(cell, "fmt/cell_" .. i)

		map[i] = go

		GameUtil.SetActive(go, false)
	end

	local list = CiyuanlonghuangnuoyaConfig.instance:getCreepsById(data.creepsMasterId) or {}

	for i, v in ipairs(list) do
		local posId = checknumber(v.posId)

		if posId > 0 then
			local go = map[posId]

			GameUtil.SetActive(go, true)

			local con = goutil.findChild(go, "con")
			local tagCell = goutil.findChild(go, "tagCell")

			MaterialMgr.setIcon(con, MatType.Pet, v.raceId)
			GameUtil.SetActive(tagCell, false)
		end
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickFmt, self, data))

	if not self._stageInfoMap[data.stageId] then
		local info = {}

		if self._curPhaseId == CiyuanlonghuangnuoyaController.SPECIAL_PHASE_ID then
			GameUtil.SetActive(pass, info.passed)
		else
			GameUtil.SetActive(pass, false)
		end

		GameUtil.SetActive(btn, false)

		if info.passed == true and checknumber(data.isShowLock) == 1 then
			GameUtil.SetActive(btn, true)
		end

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickReset, self, data))

		if not info.raceIdLocked then
			local raceList = {}

			scrollList:reloadData(raceList)
			GameUtil.SetActive(empty, #raceList == 0)
			GameUtil.SetActive(down, checknumber(data.isShowLock) == 1)
			GameUtil.SetActive(downTime, checknumber(data.isShowLock) == 0)

			txtValue1.text = checknumber(info.timeScore)
			txtValue2.text = langPara("时间点数：%s", checknumber(info.timeScore))

			scrollList:setCenterMode(true)
		end
	end
end

function CiyuanlonghuangnuoyalevelView:_clearCell(cell)
	return
end

function CiyuanlonghuangnuoyalevelView:_clearPetCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function CiyuanlonghuangnuoyalevelView:_updatePetCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCell(MatType.Pet, data, con)
end

function CiyuanlonghuangnuoyalevelView:_onClickFmt(data)
	local info = self._stageInfoMap[data.stageId]

	if info and info.passed and self._curPhaseId == CiyuanlonghuangnuoyaController.SPECIAL_PHASE_ID then
		TipsFacade.instance:openCommonTips("当前关卡已通关,重置后可重新挑战")
	else
		local now = ServerTime.now()
		local cfg = CiyuanlonghuangnuoyaConfig.instance:getPhaseCfgById(self._activityId, data.phaseId) or {}
		local timeStart = GameUtil.string2time(cfg.openTime)

		if timeStart <= now then
			CiyuanlonghuangnuoyaController.instance:openFmtView(self._activityId, data.phaseId, data.stageId)
		else
			TipsFacade.instance:openCommonTips("活动未开启")
		end
	end
end

function CiyuanlonghuangnuoyalevelView:_onClickReset(data)
	local info = self._stageInfoMap[data.stageId]

	if info and info.passed then
		TipsFacade.instance:openPopupWindow(lang("重置"), "重置本阵挑战进度\n时间点数和次元空间封印精灵将重置，是否确认？", function()
			CiyuanlonghuangnuoyaController.instance:sendResetStage(self._activityId, data.phaseId, data.stageId)
		end)
	end
end

function CiyuanlonghuangnuoyalevelView:_onClickHelp()
	TipsFacade.instance:openRulesView("ciyuanlonghuangnuoyalevelview_rule")
end

return CiyuanlonghuangnuoyalevelView
