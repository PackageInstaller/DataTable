-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeBlockView.lua

module("logic.extensions.qichallenge.view.QiChallengeBlockView", package.seeall)

local QiChallengeBlockView = class("QiChallengeBlockView", ViewComponent)

function QiChallengeBlockView:buildUI()
	QiChallengeBlockView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtDebuff = self:getTxt("txtDefuff")
	self._blockPetTable = self:getGo("blockPet/tableview")
	self._blockPetCell = self:getGo("blockPet/item")
	self._btnBlock = self:getBtn("btnBlock")
	self._txtLimit = self:getTxt("limit/txtLimit")
	self._emptyGo = self:getGo("empty")
end

function QiChallengeBlockView:bindEvents()
	QiChallengeBlockView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBlock, self._onClickBlock, self)
end

function QiChallengeBlockView:unbindEvents()
	QiChallengeBlockView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBlock)
end

function QiChallengeBlockView:onEnter()
	QiChallengeBlockView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_QiChallengeGetInfoRes, self._handlePM_QiChallengeGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_QiChallengeAllSealRes, self._handlePM_QiChallengeGetInfoRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._activityCfg = QiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._blockPetList = ScrollerList.create(self._blockPetTable, self._blockPetCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._selectMap = {}
	self._selectCount = 0

	self:_refreshView()

	local debuffDesc = QiChallengeConfig.instance:getBuff(self._activityCfg.deBuffId).desc

	self._txtDebuff.text = langPara("被封印的精灵，%s（敌我双方）", debuffDesc)

	QiChallengeAgent.instance:sendPM_QiChallengeGetInfoReq(self._activityId)
end

function QiChallengeBlockView:onExit()
	QiChallengeBlockView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_QiChallengeGetInfoRes, self._handlePM_QiChallengeGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_QiChallengeAllSealRes, self._handlePM_QiChallengeGetInfoRes, self)
end

function QiChallengeBlockView:_refreshView()
	local list = QiChallengeModel.instance:getCanSealRaceInfos()

	GameUtil.SetActive(self._emptyGo, list and #list <= 0)

	self._txtLimit.text = langPara("封印：%d/%d", QiChallengeModel.instance:getBlockRaceCount() + self._selectCount, self._activityCfg.sealNum)

	self._blockPetList:reloadData(list)
end

function QiChallengeBlockView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local select = goutil.findChild(go, "select")
	local block = goutil.findChild(go, "block")
	local btnSelect = GameUtil.asBtn(goutil.findChild(go, "btnSelect"))

	MaterialMgr.resetAll(con)

	local proxy = MaterialMgr.setCell(MatType.Pet, data.id, con)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	proxy.binder:SetGray(data.isBlock)
	GameUtil.SetActive(select, self._selectMap[data.id] or false)
	GameUtil.SetActive(block, data.isBlock)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		if data.isBlock == true then
			FloatWordMgr.instance:show(lang("该精灵已被封印"))

			return
		else
			self:_onClickSelect(data.id)
		end
	end)
end

function QiChallengeBlockView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local select = goutil.findChild(go, "select")
	local block = goutil.findChild(go, "block")
	local btnSelect = GameUtil.asBtn(goutil.findChild(go, "btnSelect"))

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btnSelect)
end

function QiChallengeBlockView:_onClickSelect(id)
	if self._selectMap[id] == true then
		self._selectCount = self._selectCount - 1
		self._selectMap[id] = false
	elseif self._selectCount + QiChallengeModel.instance:getBlockRaceCount() >= self._activityCfg.sealNum then
		FloatWordMgr.instance:show(lang("已达到最大封印数量"))

		return
	else
		self._selectCount = self._selectCount + 1
		self._selectMap[id] = true
	end

	self:_refreshView()
end

function QiChallengeBlockView:_onClickBlock()
	local raceIds = {}

	for i, v in pairs(self._selectMap) do
		if v == true then
			table.insert(raceIds, i)
		end
	end

	if #raceIds <= 0 then
		FloatWordMgr.instance:show(lang("当前无新增封印精灵的数量"))
	else
		QiChallengeAgent.instance:sendPM_QiChallengeAllSealReq(self._activityId, raceIds)
	end

	self:close()
end

function QiChallengeBlockView:_handlePM_QiChallengeGetInfoRes()
	self._selectMap = {}
	self._selectCount = 0

	self:_refreshView()
end

return QiChallengeBlockView
