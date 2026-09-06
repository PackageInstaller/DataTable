-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/view/FireworklistView.lua

module("logic.extensions.firework.view.FireworklistView", package.seeall)

local FireworklistView = class("FireworklistView", ViewComponent)

function FireworklistView:ctor()
	FireworklistView.super.ctor(self)
end

function FireworklistView:unbindEvents()
	FireworklistView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._goButton:RemoveClickListener()
end

function FireworklistView:bindEvents()
	FireworklistView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._goButton:AddClickListener(function()
		self:close()

		local time1 = GameUtil.time2date(ServerTime.now())
		local time2 = GameUtil.string2time("0-0-0 " .. langPara("%02d:%02d:%02d", time1.hour, time1.min, time1.sec))

		if time2 < FireworkController.instance.startTimes[self.curTimeId] then
			FloatWordMgr.instance:show("烟花盛宴还没开放噢，请耐心等待开启~")

			return
		end

		if FireworkController.instance.curTimeId == nil then
			FloatWordMgr.instance:show("本场烟花盛典已结束")

			return
		end

		UIStateManager.instance:clear(true)
		SceneFacade.instance:enterCityFromThisScene(self.cfgs[self.curTimeId].sceneId)
		TipsFacade.instance:openTipWindow("目标", "请在此场景中寻找烟花，参与烟花盛典哦~")
	end)
end

function FireworklistView:buildUI()
	FireworklistView.super.buildUI(self)

	self._closeButton = self:getBtn("closeBtn")
	self._goButton = self:getBtn("btnGo")
	self._tableCell1 = self:getGo("cell1")

	self._tableCell1:SetActive(false)

	self._scrollObj1 = self:getGo("tableview1")
	self._tableview1 = ScrollerList.create(self._scrollObj1, self._tableCell1, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self._clearTableview1, self))
	self._tableCell2 = self:getGo("cell2")

	self._tableCell2:SetActive(false)

	self._scrollObj2 = self:getGo("tableview2")
	self._tableview2 = ScrollerList.create(self._scrollObj2, self._tableCell2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearTableview2, self))
end

function FireworklistView:onExit()
	FireworklistView.super.onExit(self)
	self._tableview1:dispose()
	self._tableview2:dispose()
end

function FireworklistView:onEnter()
	FireworklistView.super.onEnter(self)

	self.lastPositionPlanId = nil
	self.curActId = FireworkModel.instance.curActId
	self.cfgs = FireworkConfig.instance:getSceneTimeCfgs(self.curActId)

	FireworkController.instance:checkTime()

	self.curTimeId = FireworkController.instance.lastTimeId

	self._tableview1:reloadData(self.cfgs)
	self._tableview1:refresh()
	self._tableview1:MoveCellToCenter(self.curTimeId - 1)
end

function FireworklistView:_onRefreshTab(id)
	if self.lastPositionPlanId == id then
		return
	end

	self.lastPositionPlanId = id

	local cfgss = FireworkConfig.instance:getSceneNPCCfgs(id)

	self._tableview2:reloadData(cfgss)
	self._tableview2:refresh()
	self._goButton.gameObject:SetActive(self.curTimeId == FireworkController.instance.lastTimeId)
end

function FireworklistView:_updateCell1(view, cell, data)
	local sceneId = data.sceneId
	local cfgPos = FireworkConfig.instance:getScenePosCfg(self.curActId, sceneId)
	local scenePositionPlanId = cfgPos.scenePositionPlanId
	local time1 = GameUtil.formatTimeStamp("%H:%M", FireworkController.instance.startTimes[data.id])
	local time2 = GameUtil.formatTimeStamp("%H:%M", FireworkController.instance.overTimes[data.id])

	goutil.findChildTextComponent(cell, "nameTxt").text = time1 .. "-" .. time2

	local image = goutil.findChild(cell, "iconIma")
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

	uGuiUtil.setSpriteToImage(image, uGuiUtil.SpriteType.BigBg, GameUrl.getSceneIconUrl(sceneCo.showImage))

	local isSelect = self.curTimeId == data.id

	goutil.findChild(cell, "select"):SetActive(isSelect)

	if isSelect then
		self:_onRefreshTab(scenePositionPlanId)
	end

	GameUtil.addClickHandler(cell, function()
		self.curTimeId = data.id

		self._tableview1:refresh()
	end)
end

function FireworklistView:_updateCell2(view, cell, data)
	local isFire = FireworkModel.instance:isNpcFireOver(self.curTimeId, data.id)

	goutil.findChild(cell, "receiveGo"):SetActive(isFire)

	goutil.findChildTextComponent(cell, "nameTxt").text = data.name

	local path = GameUrl.getCharacterIconUrl(data.icon)
	local icon = goutil.findChild(cell, "iconIma")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, path)
end

function FireworklistView:_clearTableview1(cell)
	uGuiUtil.clearImage(goutil.findChild(cell, "iconIma"))
end

function FireworklistView:_clearTableview2(cell)
	uGuiUtil.clearImage(goutil.findChild(cell, "iconIma"))
end

return FireworklistView
