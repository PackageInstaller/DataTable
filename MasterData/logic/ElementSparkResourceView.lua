-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkResourceView.lua

module("logic.extensions.elementspark.view.ElementSparkResourceView", package.seeall)

local ElementSparkResourceView = class("ElementSparkResourceView", ViewComponent)

function ElementSparkResourceView:ctor()
	ElementSparkResourceView.super.ctor(self)
end

function ElementSparkResourceView:unbindEvents()
	ElementSparkResourceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReceive)
end

function ElementSparkResourceView:bindEvents()
	ElementSparkResourceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReceive, self._onClickReceive, self)
end

function ElementSparkResourceView:buildUI()
	ElementSparkResourceView.super.buildUI(self)

	self._btnReceive = self:getBtn("btnReceive")
	self._txtScore = self:getTxt("score/txt")
	self._tableviewGo = self:getGo("tableview")
	self._scrollRect = self:getScrollRect("tableview")
	self._cell = self:getGo("cell")
	self._empty = self:getGo("empty")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ElementSparkResourceView:onExit()
	ElementSparkResourceView.super.onExit(self)
	self._tableview:dispose()
end

function ElementSparkResourceView:onEnter()
	ElementSparkResourceView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetResourceInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.EleSparkGainResourceRes, self._refreshPetScore, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._campId = ElementSparkModel.instance:getMyCampId()
	self._planId = ElementSparkController.instance:getMapPlanId()
	self._petShopScore = ElementSparkModel.instance:getPetShopScore()
	self._txtScore.text = "酒馆积分：" .. self._petShopScore

	self:_sendInfoReq()
end

function ElementSparkResourceView:_sendInfoReq()
	ElementSparkController.instance:sendPM_EleSparkGetResourceInfoReq(self._activityId)
end

function ElementSparkResourceView:_refresh()
	self._info = ElementSparkController.instance:getResourceScoreData()

	local isEmpty = TableUtil.isTableEmpty(self._info)

	if isEmpty then
		GameUtil.SetActive(self._tableviewGo, false)
		GameUtil.SetActive(self._empty, true)
		GameUtil.SetActive(self._btnReceive, false)
	else
		GameUtil.SetActive(self._tableviewGo, true)
		GameUtil.SetActive(self._empty, false)
		GameUtil.SetActive(self._btnReceive, true)
		self._tableview:reloadData(self._info)

		self._scrollRect.scrollRect.verticalNormalizedPosition = 1
	end
end

function ElementSparkResourceView:_refreshPetScore(msg)
	UIStateManager.instance:push(ViewName.ElementSparkResourcePopView, msg)

	self._petShopScore = self._petShopScore + msg.petShopScore
	self._txtScore.text = "酒馆积分：" .. self._petShopScore

	self:_sendInfoReq()
end

function ElementSparkResourceView:_updateCell(view, cell, data)
	local chunkIcon = goutil.findChild(cell, "chunk"):GetComponent("UIImageSpriteChange")
	local tag = goutil.findChild(cell, "tag")
	local txtName = goutil.findChildTextComponent(cell, "name/txtName")
	local txtCampRate = goutil.findChildTextComponent(cell, "txtCampRate")
	local txtPersonRate = goutil.findChildTextComponent(cell, "txtPersonRate")
	local txtShopRate = goutil.findChildTextComponent(cell, "txtShopRate")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtPersonScore = goutil.findChildTextComponent(cell, "txtPersonScore")
	local txtShopScore = goutil.findChildTextComponent(cell, "txtShopScore")
	local cfg = ElementSparkConfig.instance:getMapChunkCfgById(self._planId, data.chunkId)
	local belongCampId = ElementSparkModel.instance:getChunkBelong(data.chunkId)

	chunkIcon:ChangeSprite(cfg.resourcePic)
	GameUtil.SetActive(tag, belongCampId ~= self._campId)

	txtName.text = cfg.chunkName
	txtCampRate.text = string.format("阵营积分：<color=#FCDB96FF>%d/分钟</color>", checknumber(data.campScoreRate))
	txtPersonRate.text = string.format("个人积分：<color=#FCDB96FF>%d/分钟</color>", checknumber(data.personScoreRate))
	txtShopRate.text = string.format("酒馆积分：<color=#FCDB96FF>%d/分钟</color>", checknumber(data.petShopScoreRate))

	local manualCampScoreRate = ElementSparkConfig.instance:getProductCfg(1).maxManualGainLimit
	local manualPersonScoreRate = ElementSparkConfig.instance:getProductCfg(2).maxManualGainLimit
	local manualPetShopScoreRate = ElementSparkConfig.instance:getProductCfg(3).maxManualGainLimit

	txtScore.text = string.format("阵营积分：<color=#FCDB96FF>%d/%d</color>", checknumber(data.campScoreCanGain), manualCampScoreRate)
	txtPersonScore.text = string.format("个人积分：<color=#FCDB96FF>%d/%d</color>", checknumber(data.personScoreCanGain), manualPersonScoreRate)
	txtShopScore.text = string.format("酒馆积分：<color=#FCDB96FF>%d/%d</color>", checknumber(data.petShopScoreCanGain), manualPetShopScoreRate)

	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onClickChunk, self, data.chunkId))
end

function ElementSparkResourceView:_clearCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function ElementSparkResourceView:_onClickChunk(chunkId)
	ElementSparkSceneController.instance:moveChunkToCenterAndLocation(chunkId)
	self:close()
end

function ElementSparkResourceView:_onClickReceive()
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	local isCanGain = ElementSparkController.instance:isCanGainResource()

	if isCanGain then
		ElementSparkController.instance:sendPM_EleSparkGainResourceReq(self._activityId)
	else
		FloatWordMgr.instance:show("暂无可领取资源")
	end
end

return ElementSparkResourceView
