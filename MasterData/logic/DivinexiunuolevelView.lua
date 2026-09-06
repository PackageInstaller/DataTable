-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/view/DivinexiunuolevelView.lua

module("logic.extensions.divinexiunuo.view.DivinexiunuolevelView", package.seeall)

local DivinexiunuolevelView = class("DivinexiunuolevelView", ViewComponent)

function DivinexiunuolevelView:ctor()
	DivinexiunuolevelView.super.ctor(self)
end

function DivinexiunuolevelView:unbindEvents()
	DivinexiunuolevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivinexiunuolevelView:bindEvents()
	DivinexiunuolevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickHelp, self)
end

function DivinexiunuolevelView:buildUI()
	DivinexiunuolevelView.super.buildUI(self)

	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._con = self:getGo("item/con")
	self._txtDesc = self:getTxt("ScrollView/Viewport/Content")
	self._lineList = {}
	self._stageList = {}

	for i = 1, 3 do
		local stage = self:getGo("btnStage_" .. i)
		local line = self:getGo("line_" .. i)

		table.insert(self._stageList, stage)
		table.insert(self._lineList, line)
	end

	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivinexiunuolevelView:onExit()
	DivinexiunuolevelView.super.onExit(self)
	self._scrollList:dispose()

	for k, v in pairs(self._scrollMap) do
		v:dispose()
	end

	MaterialMgr.resetAll(self._con)
end

function DivinexiunuolevelView:onEnter()
	DivinexiunuolevelView.super.onEnter(self)

	self._activityId = DivineXiuNuoController.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	self._scrollMap = {}

	self.addGEvent(self, GlobalNotify.DIVINE_XIUNUO_INFO_UPDATE, self._onRefreshUI, self)
	DivineXiuNuoController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function DivinexiunuolevelView:_onRefreshUI()
	self._info = DivineXiuNuoModel.instance:getInfo(self._activityId) or {}
	self._stageInfoMap = {}

	if not self._info.stageInfo then
		local stageInfoList = {}

		for i, v in pairs(stageInfoList) do
			self._stageInfoMap[v.stageId] = v
		end

		local curPhaseId = checknumber(self._info.curPhaseId)

		curPhaseId = curPhaseId == 0 and 1 or curPhaseId
		self._curPhaseId = curPhaseId
		self._txtTime.text = ""

		local now = ServerTime.now()

		for i, v in ipairs(self._stageList) do
			local txt = goutil.findChildTextComponent(v, "txt")
			local pass = goutil.findChild(v, "pass")

			GameUtil.SetActive(pass, false)

			local cfg = DivineXiuNuoConfig.instance:getPhaseCfgById(self._activityId, i) or {}
			local timeStart = GameUtil.string2time(cfg.openTime)

			if i < curPhaseId then
				txt.text = ""

				GameUtil.setUIImageColorIdx(v, 1)
				GameUtil.SetActive(pass, true)
			elseif i == curPhaseId then
				if timeStart <= now then
					GameUtil.setUIImageColorIdx(v, 0)

					txt.text = langPara("第<size=45>%s</size>层", i)
				else
					GameUtil.setUIImageColorIdx(v, 1)

					txt.text = langPara("<color=#67b6ee>%s\n开启</color>", GameUtil.formatTimeString("%m.%d", cfg.openTime))
				end
			elseif timeStart <= now then
				GameUtil.setUIImageColorIdx(v, 0)

				txt.text = lang("<size=22><color=#67b6ee>通关上一层\n开启</color></size>")
			else
				GameUtil.setUIImageColorIdx(v, 1)

				txt.text = langPara("<size=22><color=#67b6ee>通关上一层\n%s\n开启</color></size>", GameUtil.formatTimeString("%m.%d", cfg.openTime))
			end
		end

		for i, v in ipairs(self._lineList) do
			GameUtil.SetActive(v, i <= curPhaseId)
		end

		local list = DivineXiuNuoConfig.instance:getStageListById(self._activityId, self._curPhaseId) or {}

		self._scrollList:reloadData(list)

		for i, v in ipairs(list) do
			if not self._stageInfoMap[v.stageId] then
				local info = {}

				if not info.passed then
					self._scrollList:MoveCellToCenter(i - 1)

					break
				end
			end
		end

		local cfg = DivineXiuNuoConfig.instance:getPhaseCfgById(self._activityId, curPhaseId) or {}

		self._txtDesc.text = cfg.desc

		MaterialMgr.resetAll(self._con)
		MaterialMgr.setCellByCfg(cfg.prize, self._con)
	end
end

function DivinexiunuolevelView:_updateCell(view, cell, data, tag)
	local pass = goutil.findChild(cell, "fmt/pass")
	local down = goutil.findChild(cell, "down")
	local tablecell = goutil.findChild(cell, "down/tablecell")
	local tableview = goutil.findChild(cell, "down/tableview")
	local empty = goutil.findChild(cell, "down/empty")
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

	local list = DivineXiuNuoConfig.instance:getCreepsById(data.creepsMasterId) or {}

	for i, v in ipairs(list) do
		local posId = checknumber(v.posId)

		if posId > 0 then
			local go = map[posId]

			GameUtil.SetActive(go, true)

			local con = goutil.findChild(go, "con")
			local tagCell = goutil.findChild(go, "tagCell")

			MaterialMgr.setIcon(con, MatType.Pet, v.raceId)

			local flag = v.flag

			GameUtil.SetActive(tagCell, false)

			if not string.nilorempty(flag) then
				GameUtil.SetActive(tagCell, true)

				local txt1 = goutil.findChild(tagCell, "txt_1")
				local txt2 = goutil.findChild(tagCell, "txt_2")

				GameUtil.SetActive(txt1, flag == ConstString.Race[GameEnum.RaceType.Guang])
				GameUtil.SetActive(txt2, flag == ConstString.Race[GameEnum.RaceType.An])
			end
		end
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickFmt, self, data))

	if not self._stageInfoMap[data.stageId] then
		GameUtil.SetActive(pass, self._stageInfoMap[data.stageId].passed)
		GameUtil.SetActive(btn, false)

		if self._stageInfoMap[data.stageId].passed == true and checknumber(data.isShowLock) == 1 then
			GameUtil.SetActive(btn, true)
		end

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickReset, self, data))

		if not self._stageInfoMap[data.stageId].raceIdLocked then
			local raceList = {}

			scrollList:reloadData(raceList)
			GameUtil.SetActive(empty, #raceList == 0)
			GameUtil.SetActive(down, checknumber(data.isShowLock) == 1)
			scrollList:setCenterMode(true)
		end
	end
end

function DivinexiunuolevelView:_clearCell(cell)
	return
end

function DivinexiunuolevelView:_clearPetCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function DivinexiunuolevelView:_updatePetCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCell(MatType.Pet, data, con)
end

function DivinexiunuolevelView:_onClickFmt(data)
	local info = self._stageInfoMap[data.stageId]

	if info and info.passed then
		TipsFacade.instance:openCommonTips("当前关卡已通关")
	else
		local now = ServerTime.now()
		local cfg = DivineXiuNuoConfig.instance:getPhaseCfgById(self._activityId, data.phaseId) or {}
		local timeStart = GameUtil.string2time(cfg.openTime)

		if timeStart <= now then
			DivineXiuNuoController.instance:openFmtView(self._activityId, data.phaseId, data.stageId)
		else
			TipsFacade.instance:openCommonTips("活动未开启")
		end
	end
end

function DivinexiunuolevelView:_onClickReset(data)
	local info = self._stageInfoMap[data.stageId]

	if info and info.passed then
		TipsFacade.instance:openPopupWindow(lang("tip"), "是否重置本关挑战为未挑战，且解除精灵封印", function()
			DivineXiuNuoController.instance:sendResetStage(self._activityId, data.phaseId, data.stageId)
		end)
	end
end

function DivinexiunuolevelView:_onClickHelp()
	TipsFacade.instance:openRulesView("DivinexiunuolevelView_rule")
end

return DivinexiunuolevelView
