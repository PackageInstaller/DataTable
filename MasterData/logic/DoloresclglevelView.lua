-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/DoloresclglevelView.lua

module("logic.extensions.doloresclg.view.DoloresclglevelView", package.seeall)

local DoloresclglevelView = class("DoloresclglevelView", ViewComponent)

function DoloresclglevelView:ctor()
	DoloresclglevelView.super.ctor(self)
end

function DoloresclglevelView:unbindEvents()
	DoloresclglevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DoloresclglevelView:bindEvents()
	DoloresclglevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DoloresclglevelView:buildUI()
	DoloresclglevelView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtDesc = self:getTxt("rule/txtDesc")
	self._tab1 = self:getGo("tab1")
	self._tab2 = self:getGo("tab2")
	self._tab3 = self:getGo("tab3")
	self._txtCount = self:getTxt("rule/txtCount")
	self._attrCell = self:getGo("attrCell")

	GameUtil.SetActive(self._attrCell, false)

	self._tabList = {}

	for i = 1, 3 do
		table.insert(self._tabList, self:getGo("tab" .. i))
	end

	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._tabtableview = self:getGo("tabtableview")
	self._tabtablecell = self:getGo("tabtableview/tabtablecell")
	self._tabScrollList = ScrollerList.create(self._tabtableview, self._tabtablecell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._cellScrollMap = {}
end

function DoloresclglevelView:onExit()
	DoloresclglevelView.super.onExit(self)
	self._scrollList:dispose()
	self._tabScrollList:dispose()
end

function DoloresclglevelView:onEnter()
	DoloresclglevelView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DoloresController.instance:getDefaultActivity()
	end

	self.addGEvent(self, GlobalNotify.DOLORES_INFO_UPDATE, self._refreshUI, self)
	DoloresController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
end

function DoloresclglevelView:_refreshUI()
	self._actCfg = DoloresConfig.instance:getActCfg(self._activityId) or {}

	local info = DoloresModel.instance:getInfo(self._activityId) or {}

	if not info.curStageInfos then
		local curStageInfos = {}

		self._curStageInfosMap = {}

		local cur = 0
		local tem = {}

		for i, v in ipairs(curStageInfos) do
			self._curStageInfosMap[v.stageId] = v

			for j, attr in ipairs(v.lockAttrTypes or {}) do
				if tem[attr] == nil then
					tem[attr] = true
					cur = cur + 1
				end
			end
		end

		self._passedPhaseId = checknumber(info.passedPhaseId)

		local phaseCfg = DoloresConfig.instance:getPhaseById(self._activityId, self._passedPhaseId + 1) or {}
		local stagePlanId = phaseCfg.stagePlanId
		local stageList = DoloresConfig.instance:getStageListById(stagePlanId) or {}

		self._scrollList:reloadData(stageList)

		for i, v in ipairs(stageList) do
			local stageInfo = self._curStageInfosMap[v.stageId]
			local isPass = stageInfo ~= nil

			if isPass then
				self._scrollList:MoveCellInView(i - 1)

				break
			end
		end

		local phaseCfgList = DoloresConfig.instance:getPhaseListById(self._activityId) or {}

		self._tabScrollList:reloadData(phaseCfgList)

		local total = checknumber(phaseCfg.passNum)

		self._txtCount.text = self:getTxtCountDesc((total <= cur or nil) and "#20b376", cur, total)
		self._txtDesc.text = self._actCfg.ruleDesc
	end
end

function DoloresclglevelView:_updateCell(view, cell, data, tag)
	local empty = goutil.findChild(cell, "empty")
	local btnReset = goutil.findChild(cell, "btnReset")
	local btnFight = goutil.findChild(cell, "btnFight")
	local tableview = goutil.findChild(cell, "tableview")
	local lock = goutil.findChild(cell, "lock")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local pass = goutil.findChild(cell, "fmt/pass")
	local headFmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = goutil.findChild(cell, "fmt/headFmt/cell_" .. i)
		item.con = goutil.findChild(cell, string.format("fmt/headFmt/cell_%s/con", i))

		table.insert(headFmtList, item)
		GameUtil.SetActive(item.go, false)
	end

	local creepsMasterId = data.creepsMasterId
	local cfgCreeps = DoloresConfig.instance:getCreepsCfgs(creepsMasterId)

	for j, cfgEnemy in ipairs(cfgCreeps) do
		local item = headFmtList[cfgEnemy.posId]

		if item and item.go then
			GameUtil.SetActive(item.go, true)
			GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
			MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, item.con)
		end
	end

	local stageInfo = self._curStageInfosMap[data.stageId]
	local isPass = stageInfo ~= nil

	GameUtil.SetActive(pass, isPass)
	GameUtil.SetActive(btnReset, isPass)
	GameUtil.SetActive(btnFight, not isPass)
	GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickReset, self, data))
	GameUtil.addClickHandler(btnFight, GameUtil.handler(self._onClickFight, self, data))

	local scrollList = self._cellScrollMap[cell]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableview, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

		scrollList:setCenterMode(true)

		self._cellScrollMap[cell] = scrollList
	end

	stageInfo = stageInfo or {}

	if not stageInfo.lockAttrTypes then
		local lockAttrTypes = {}

		scrollList:reloadData(lockAttrTypes)
		GameUtil.SetActive(empty, #lockAttrTypes == 0)
		GameUtil.SetActive(lock, false)

		local phaseCfg = DoloresConfig.instance:getPhaseById(self._activityId, self._passedPhaseId + 1)

		if phaseCfg and phaseCfg.openDay then
			local str, isLock = ActivityDefineController.instance:getActTimeShowWithOpenDay(self._activityId, phaseCfg.openDay)

			if isLock then
				GameUtil.SetActive(lock, true)

				txtLock.text = str
			end
		end
	end
end

function DoloresclglevelView:_updateAttrCell(view, cell, data, tag)
	local Img_attr = goutil.findChild(cell, "Img_attr")
	local race = GameEnum.Races[data]

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)
end

function DoloresclglevelView:_clearAttrCell(cell)
	return
end

function DoloresclglevelView:_clearCell(cell)
	return
end

function DoloresclglevelView:_onClickReset(data)
	TipsFacade.instance:openPopupWindow(lang("tip"), "是否将本关重置为未挑战，清空吞噬属性？", function()
		DoloresController.instance:sendResetInfo(self._activityId, self._passedPhaseId + 1, data.stageId)
	end)
end

function DoloresclglevelView:_onClickFight(data)
	local phaseCfg = DoloresConfig.instance:getPhaseById(self._activityId, self._passedPhaseId + 1)

	if phaseCfg and phaseCfg.openDay then
		local str, isLock = ActivityDefineController.instance:getActTimeShowWithOpenDay(self._activityId, phaseCfg.openDay)

		if isLock then
			TipsFacade.instance:openCommonTips(str)
		else
			DoloresController.instance:openFmtView(self._activityId, self._passedPhaseId + 1, data.stageId, self:getResultViewName(), self._viewPresentor.viewName)
		end
	end
end

function DoloresclglevelView:_updateTabCell(view, cell, data, tag)
	local tab = goutil.findChild(cell, "tab")
	local bg = goutil.findChild(cell, "tab/bg")
	local txtName = goutil.findChildTextComponent(cell, "tab/bg/txtName")
	local txtLevel = goutil.findChildTextComponent(cell, "tab/txtLevel")
	local pass = goutil.findChild(cell, "tab/pass")
	local lock = goutil.findChild(cell, "tab/lock")
	local txtLock = goutil.findChildTextComponent(cell, "tab/lock/txtLock")

	txtLevel.text = langPara("第%s关", data.phaseId)

	local str, isLock = ActivityDefineController.instance:getActTimeShowWithOpenDay(self._activityId, data.openDay)

	txtLock.text = "请先通关上一层"
	txtName.text = str

	GameUtil.SetActive(bg, isLock)

	if data.phaseId == self._passedPhaseId + 1 then
		GameUtil.setUIImageSpriteIdx(tab, 1)
		GameUtil.setUITextColorIdx(txtName, 1)
		GameUtil.setUITextColorIdx(txtLevel, 1)
	else
		GameUtil.setUIImageSpriteIdx(tab, 0)
		GameUtil.setUITextColorIdx(txtName, 0)
		GameUtil.setUITextColorIdx(txtLevel, 0)
	end

	GameUtil.SetActive(lock, data.phaseId > self._passedPhaseId + 1 or isLock)
	GameUtil.SetActive(pass, data.phaseId <= self._passedPhaseId)
end

function DoloresclglevelView:_clearTabCell(cell)
	return
end

function DoloresclglevelView:getResultViewName()
	return ViewName.DoloresclgresultView
end

function DoloresclglevelView:getTxtCountDesc(color, cur, total)
	return langPara("累积吞噬精灵属性\n<color=%s>%s/%s</color>", color, cur, total)
end

return DoloresclglevelView
