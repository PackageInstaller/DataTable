-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/view/DragonsoulvotemakeView.lua

module("logic.extensions.dragonsoulvote.view.DragonsoulvotemakeView", package.seeall)

local DragonsoulvotemakeView = class("DragonsoulvotemakeView", ViewComponent)

function DragonsoulvotemakeView:ctor()
	DragonsoulvotemakeView.super.ctor(self)
end

function DragonsoulvotemakeView:unbindEvents()
	DragonsoulvotemakeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnOK)
end

function DragonsoulvotemakeView:bindEvents()
	DragonsoulvotemakeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPre, self)
	GameUtil.addClickHandler(self._btnOK, self._onClickOK, self)
end

function DragonsoulvotemakeView:buildUI()
	DragonsoulvotemakeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._imgNone = self:getGo("left/imgNone")
	self._imgHead = self:getGo("left/imgHead")
	self._imgBody = self:getGo("left/imgBody")
	self._imgShadow = self:getGo("left/imgShadow")
	self._txtName = self:getTxt("left/txtName")
	self._right = self:getGo("right")
	self._tablecell = self:getGo("right/tablecell")
	self._tableviewTop = self:getGo("right/tableviewTop")
	self._tableviewDown = self:getGo("right/tableviewDown")
	self._txtTime = self:getTxt("txtTime/txt")
	self._btnNext = self:getGo("right/btnNext")
	self._speak = self:getGo("speak")
	self._btnPre = self:getGo("speak/btnPre")
	self._btnOK = self:getGo("speak/btnOK")
	self._tableCellSpeak = self:getGo("speak/tableview/tablecell")
	self._tableviewSpeak = self:getGo("speak/tableview")
	self._effectGo = self:getGo("effect")
	self._scrollListTop = ScrollerList.create(self._tableviewTop, self._tablecell, GameUtil.handler(self._updateTopCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollListTop:setCenterMode(true)

	self._scrollListDown = ScrollerList.create(self._tableviewDown, self._tablecell, GameUtil.handler(self._updateDownCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollListDown:setCenterMode(true)

	self._scrollListSpeak = ScrollerList.create(self._tableviewSpeak, self._tableCellSpeak, GameUtil.handler(self._updateSpeakCell, self), GameUtil.handler(self._clearSpeakCell, self))
end

function DragonsoulvotemakeView:onExit()
	DragonsoulvotemakeView.super.onExit(self)
	self._scrollListTop:dispose()
	self._scrollListDown:dispose()
	self._scrollListSpeak:dispose()
	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
end

function DragonsoulvotemakeView:onEnter()
	DragonsoulvotemakeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DragonSoulVoteController.instance:getActivityId()
	end

	self._selectGroupIdx = 0
	self._selectItemIdx = 0
	self._selectSpeakIdx = 0

	GameUtil.SetActive(self._right, true)
	GameUtil.SetActive(self._speak, false)
	self.addGEvent(self, GlobalNotify.DRAGON_SOUL_VOTE_UPDATE, self._onRefreshUI, self)
	DragonSoulVoteController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local effPath = "20241122/longhunyuzhi/fx_ui_longhuanyuzhi_fw.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)
end

function DragonsoulvotemakeView:_onRefreshUI()
	local groupList = DragonSoulVoteConfig.instance:getPredictGroupCfg(self._activityId, 1)
	local itemList = DragonSoulVoteConfig.instance:getPredictGroupCfg(self._activityId, 2)

	self._scrollListTop:reloadData(groupList)
	self._scrollListDown:reloadData(itemList)

	local msgList = DragonSoulVoteConfig.instance:getMsgCfgListById(self._activityId) or {}

	self._scrollListSpeak:reloadData(msgList)
	self:_refreshRole()
end

function DragonsoulvotemakeView:_onClickTip()
	TipsFacade.instance:openRulesView("dragonsoulvotemakeview_rule")
end

function DragonsoulvotemakeView:_onClickNext()
	if self._selectGroupIdx == 0 or self._selectItemIdx == 0 then
		TipsFacade.instance:openCommonTips("请先选择王者之魂和英灵龙脉精灵后再进行下一步")

		return
	end

	GameUtil.SetActive(self._right, false)
	GameUtil.SetActive(self._speak, true)
	self._scrollListSpeak:refresh()
	self._scrollListSpeak:MoveCellToBegin(0)
end

function DragonsoulvotemakeView:_onClickPre()
	self._selectSpeakIdx = 0

	GameUtil.SetActive(self._right, true)
	GameUtil.SetActive(self._speak, false)
end

function DragonsoulvotemakeView:_onClickOK()
	if self._selectGroupIdx == 0 or self._selectItemIdx == 0 then
		TipsFacade.instance:openCommonTips("请先选择王者之魂和英灵龙脉精灵后再点下一步")

		return
	end

	if self._selectSpeakIdx == 0 then
		TipsFacade.instance:openCommonTips("请先选择对精灵的展望")

		return
	end

	DragonSoulVoteController.instance:sendMakeRole(self._activityId, self._selectGroupIdx, self._selectItemIdx, self._selectSpeakIdx)
	TipsFacade.instance:openCommonTips("预知成功，快去支持喜欢的龙脉王者吧！")
	self:close()
	DragonSoulVoteController.instance:sendGetInfo(self._activityId)
end

function DragonsoulvotemakeView:_updateTopCell(view, cell, data, tag)
	local img = goutil.findChild(cell, "img")
	local select = goutil.findChild(cell, "select")
	local top = goutil.findChild(cell, "top")
	local txt = goutil.findChildTextComponent(cell, "txt")

	MaterialMgr.setIcon(img, MatType.PET_SKIN, data.raceId)

	txt.text = data.name

	GameUtil.SetActive(select, data.itemId == self._selectGroupIdx)
	GameUtil.addClickHandler(top, function()
		self._selectGroupIdx = data.itemId

		self._scrollListTop:refresh()
		self:_refreshRole()
	end)
end

function DragonsoulvotemakeView:_updateDownCell(view, cell, data, tag)
	local img = goutil.findChild(cell, "img")
	local select = goutil.findChild(cell, "select")
	local top = goutil.findChild(cell, "top")
	local txt = goutil.findChildTextComponent(cell, "txt")

	MaterialMgr.setIcon(img, MatType.PET_SKIN, data.raceId)

	txt.text = data.name

	GameUtil.SetActive(select, data.itemId == self._selectItemIdx)
	GameUtil.addClickHandler(top, function()
		self._selectItemIdx = data.itemId

		self._scrollListDown:refresh()
		self:_refreshRole()
	end)
end

function DragonsoulvotemakeView:_clearCell(cell)
	local img = goutil.findChild(cell, "img")

	MaterialMgr.clearIcon(img)
end

function DragonsoulvotemakeView:_updateSpeakCell(view, cell, data, tag)
	local img = goutil.findChild(cell, "img")
	local top = goutil.findChild(cell, "top")
	local select = goutil.findChild(cell, "select")
	local txt = goutil.findChildTextComponent(cell, "txt")

	txt.text = data.desc

	GameUtil.SetActive(select, data.msgId == self._selectSpeakIdx)
	GameUtil.addClickHandler(top, function()
		self._selectSpeakIdx = data.msgId

		self._scrollListSpeak:refresh()
	end)
end

function DragonsoulvotemakeView:_clearSpeakCell(cell)
	local img = goutil.findChild(cell, "img")
end

function DragonsoulvotemakeView:_refreshRole()
	local cfg = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 1, self._selectGroupIdx)
	local cfg2 = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 2, self._selectItemIdx)

	GameUtil.SetActive(self._imgNone, true)
	GameUtil.SetActive(self._imgShadow, true)
	GameUtil.SetActive(self._imgBody, false)
	GameUtil.SetActive(self._imgBody, false)
	uGuiUtil.setSpriteToImage(self._imgNone.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", "board_longhunyuzhi_03"))

	self._txtName.text = "生成形象后呈现"

	if cfg and cfg2 then
		GameUtil.SetActive(self._imgNone, false)
		GameUtil.SetActive(self._imgShadow, false)
		GameUtil.SetActive(self._imgBody, true)
		GameUtil.SetActive(self._imgBody, true)
		uGuiUtil.setSpriteToImage(self._imgHead.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", cfg.path))
		uGuiUtil.setSpriteToImage(self._imgBody.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", cfg2.path))

		self._txtName.text = cfg2.name .. "·" .. cfg.name

		UIEffectManager.instance:stopEffect(self._pmEff2)

		local effPath = "20241122/longhunyuzhi/fx_ui_longhuanyuzhi_dianjiliang.prefab"

		self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self._effectGo, 0, 0, false, nil, nil, nil, self)

		self._pmEff2:setParent(self._effectGo.transform)
		self._pmEff2:setScale(1)
	end
end

return DragonsoulvotemakeView
