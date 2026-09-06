-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulaspopView.lua

module("logic.extensions.gulas.view.GulaspopView", package.seeall)

local GulaspopView = class("GulaspopView", ViewComponent)

function GulaspopView:unbindEvents()
	GulaspopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function GulaspopView:bindEvents()
	GulaspopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function GulaspopView:buildUI()
	GulaspopView.super.buildUI(self)

	self._closeBtn = self:getGo("btnClose")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._scrollObj = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self._tableview:regReloadFinish(GameUtil.handler(self._reloadFinish, self))

	self.title = self:getTxt("title/txtTitle")
	self.level = self:getTxt("desc/txtLevel")
	self._txtDesc = self:getTxt("desc/txtDesc")
end

function GulaspopView:onExit()
	GulaspopView.super.onExit(self)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)
end

function GulaspopView:onEnter()
	GulaspopView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.GULAS_CLG_INFO_UPDATE, self._onRefreshUI, self)
	GulasController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function GulaspopView:_onRefreshUI()
	self._info = GulasModel.instance:getInfo(self._activityId) or {}
	self._teamLockRaceIds = self._info.teamLockRaceIds or {}
	self._passPhaseId = checknumber(self._info.passPhaseId)
	self._currPhaseId = self._passPhaseId + 1

	local list = GulasConfig.instance:getPhaseCfgListById(self._activityId) or {}

	self.level.text = string.format("当前关卡：%d/%d", self._currPhaseId, #list)
	self._actCfg = GulasConfig.instance:getActivityCfgById(self._activityId) or {}
	self._txtDesc.text = self._actCfg.popupDesc

	self._tableview:reloadData(list)
	self._tableview:refresh()
end

function GulaspopView:_updateCell(view, cell, data)
	local btnObj = goutil.findChild(cell, "btnAchieve")
	local getObj = goutil.findChild(cell, "receive")
	local btn = GameUtil.asBtn(btnObj)

	goutil.findChildTextComponent(cell, "txtDay").text = string.format("第%d关", data.phaseId)

	GameUtil.SetActive(btnObj, false)
	GameUtil.SetActive(getObj, self._passPhaseId >= data.phaseId)

	local awards = string.split(data.prize, "#")
	local itemNum = #awards
	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount

	while childCount < itemNum do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local go = transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(awards[i], go)
		go:SetActive(true)
	end

	for i = itemNum + 1, childCount do
		transform:GetChild(i - 1).gameObject:SetActive(false)
	end
end

function GulaspopView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnAchieve"))

	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

function GulaspopView:_reloadFinish()
	return
end

return GulaspopView
