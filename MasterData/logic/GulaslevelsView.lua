-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulaslevelsView.lua

module("logic.extensions.gulas.view.GulaslevelsView", package.seeall)

local GulaslevelsView = class("GulaslevelsView", ViewComponent)

function GulaslevelsView:ctor()
	GulaslevelsView.super.ctor(self)
end

function GulaslevelsView:unbindEvents()
	GulaslevelsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReward)
end

function GulaslevelsView:bindEvents()
	GulaslevelsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)
end

function GulaslevelsView:buildUI()
	GulaslevelsView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtDesc = self:getTxt("desc/content/viewport/desc")
	self._btnReward = self:getGo("info/btnReward/top")
	self._icon = self:getGo("info/btnReward/icon")
	self._txtUp = self:getTxt("info/txtUp")
	self._txtLevel = self:getTxt("info/level/FillArea/info/txtLevel")
	self._head = self:getGo("info/level/FillArea/info/head")
	self._txtDown = self:getTxt("info/txtDown")
	self._levelSlider = self:getSlider("info/level")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function GulaslevelsView:onExit()
	GulaslevelsView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._icon)
end

function GulaslevelsView:onEnter()
	GulaslevelsView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = GulasController.instance:getActivityId()
	end

	self._scrollMap = {}

	self.addGEvent(self, GlobalNotify.GULAS_CLG_INFO_UPDATE, self._onRefreshUI, self)
	GulasController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function GulaslevelsView:_onRefreshUI()
	self._info = GulasModel.instance:getInfo(self._activityId) or {}
	self._teamLockRaceIds = self._info.teamLockRaceIds or {}
	self._passPhaseId = checknumber(self._info.passPhaseId)
	self._currPhaseId = self._passPhaseId + 1

	local cfg = GulasConfig.instance:getPhaseCfgById(self._activityId, self._currPhaseId)

	if cfg then
		local stagePlanId = cfg.stagePlanId
		local list = GulasConfig.instance:getStageCfgListById(stagePlanId) or {}

		self._scrollList:reloadData(list)
	end

	local list = GulasConfig.instance:getPhaseCfgListById(self._activityId) or {}
	local sValue = self._passPhaseId / (#list - 1)

	self._levelSlider:SetValue(sValue)

	self._txtLevel.text = string.format("当前%d层", self._currPhaseId)
	self._txtUp.text = string.format("%d层", #list)
	self._txtDown.text = "1层"

	HeadItemController.instance:setMyHeadCell(self._head)

	self._actCfg = GulasConfig.instance:getActivityCfgById(self._activityId) or {}

	MaterialMgr.setCellByCfg(self._actCfg.bubbleItem, self._icon)

	self._txtDesc.text = self._actCfg.battleDesc
end

function GulaslevelsView:_updateCell(view, cell, data, tag)
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local resetBtn = goutil.findChild(cell, "btnReset")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")
	local txtempty = goutil.findChild(cell, "information/txtempty")
	local tableview = goutil.findChild(cell, "information/tableview")
	local tablecell = goutil.findChild(cell, "information/tableview/petcell")
	local creepsMasterId = data.creepsMasterId
	local creepCfgs = GulasConfig.instance:getCreepsById(creepsMasterId)
	local map = {}

	for i = 1, 9 do
		local go = goutil.findChild(cell, "formation/cell_" .. i)

		map[i] = go

		GameUtil.SetActive(go, false)
	end

	for k, v in pairs(creepCfgs) do
		local posId = checknumber(v.posId)

		if posId > 0 then
			local go = map[posId]

			GameUtil.SetActive(go, true)

			local con = goutil.findChild(go, "con")

			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))
		end
	end

	local scrollList = self._scrollMap[cell]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		scrollList:setCenterMode(true)

		self._scrollMap[cell] = scrollList
	end

	if not self._teamLockRaceIds[data.stageId] then
		local tem = {}

		if not tem.list then
			local petList = {}

			scrollList:reloadData(petList)
			GameUtil.SetActive(txtempty, #petList == 0)
			GameUtil.SetActive(pkBtn, #petList == 0)
			GameUtil.SetActive(resetBtn, #petList > 0)
			GameUtil.SetActive(pass, #petList > 0)
			GameUtil.addClickHandler(pkBtn, function()
				self:_onClickPkBtn(data)
			end)
			GameUtil.addClickHandler(resetBtn, function()
				TipsFacade.instance:openPopupWindow(lang("tip"), "是否重置本关挑战为未挑战，且解除精灵封印", function()
					GulasController.instance:sendResetStage(self._activityId, self._currPhaseId, data.stageId)
				end)
			end)
		end
	end
end

function GulaslevelsView:_onClickPkBtn(data)
	GulasController.instance:openFmtView(self._activityId, self._currPhaseId, data.stageId, ViewName.GulasextView, self._viewPresentor.viewName)
end

function GulaslevelsView:_clearCell(cell)
	local scrollList = self._scrollMap[cell]

	if scrollList then
		scrollList:dispose()
	end
end

function GulaslevelsView:_onClickTip()
	TipsFacade.instance:openRulesView("gulasmainview_rule")
end

function GulaslevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.GulaspopView, self._activityId)
end

function GulaslevelsView:_updatePetCell(view, cell, data)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCell(MatType.Pet, data, con)
end

function GulaslevelsView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell)
end

return GulaslevelsView
