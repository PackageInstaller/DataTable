-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/view/DragonsoulvotemainView.lua

module("logic.extensions.dragonsoulvote.view.DragonsoulvotemainView", package.seeall)

local DragonsoulvotemainView = class("DragonsoulvotemainView", ViewComponent)

function DragonsoulvotemainView:ctor()
	DragonsoulvotemainView.super.ctor(self)
end

function DragonsoulvotemainView:unbindEvents()
	DragonsoulvotemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnVoteGain)
end

function DragonsoulvotemainView:bindEvents()
	DragonsoulvotemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoTo, self)
	GameUtil.addClickHandler(self._btnVoteGain, self._onClickJump, self)
end

function DragonsoulvotemainView:buildUI()
	DragonsoulvotemainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("txtTime/txt")
	self._btnGoto = self:getGo("left/btnGoto")
	self._imgNone = self:getGo("left/imgNone")
	self._imgHead = self:getGo("left/imgHead")
	self._imgBody = self:getGo("left/imgBody")
	self._imgShadow = self:getGo("left/imgShadow")
	self._txtName = self:getTxt("left/txtName")
	self._bubble = self:getGo("left/bubble")
	self._txtTip = self:getTxt("left/bubble/txtTip")
	self._head = self:getGo("left/head")
	self._btnAid = self:getGo("right/btnAid")
	self._txtAid = self:getTxt("right/btnAid/txtAid")
	self._btnVoteGain = self:getGo("btnVoteGain")
	self._btnPrize = self:getGo("btnPrize")
	self._redpoint = self:getGo("btnPrize/redpoint")
	self._empty = self:getGo("right/empty")
	self._tableview = self:getGo("right/tableview")
	self._tablecell = self:getGo("right/tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DragonsoulvotemainView:onExit()
	DragonsoulvotemainView.super.onExit(self)
	self._scrollList:dispose()
	RedPointController.instance:unregRedPoint(self._redpoint)
	UIEffectManager.instance:stopEffect(self._pmEff)
end

function DragonsoulvotemainView:onEnter()
	DragonsoulvotemainView.super.onEnter(self)

	self._activityId = DragonSoulVoteController.instance:getActivityId()
	self._randSpeakIdx = math.random(1, 10)
	self._randHeadIdx = math.random(1, 10)
	self._actCfg = DragonSoulVoteConfig.instance:getActivityCfgById(self._activityId)

	self.addGEvent(self, GlobalNotify.DRAGON_SOUL_VOTE_UPDATE, self._onRefreshUI, self)
	DragonSoulVoteController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redpoint, checknumber(self._actCfg.redPointId))

	local effPath = "20241122/longhunyuzhi/fx_ui_longhuanyuzhi_fw.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)
end

function DragonsoulvotemainView:_onRefreshUI()
	local info = DragonSoulVoteModel.instance:getInfo(self._activityId) or {}

	if not info.myPredict then
		local myPredict = {}
		local myPredictMsgId = checknumber(info.myPredictMsgId)

		if not info.voteInfos then
			self._txtAid.text = MaterialMgr.getMatCount(self._actCfg.voteMp)
			self._playerList = string.split(self._actCfg.playerList or "", "#")
			self._msgList = DragonSoulVoteConfig.instance:getMsgCfgListById(self._activityId) or {}
			self._voteMap = {}

			for i, v in ipairs(info.voteInfos) do
				self._voteMap[v.item.left] = self._voteMap[v.item.left] or {}
				self._voteMap[v.item.left][v.item.right] = checknumber(v.voteCount)
			end

			local cfg = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 1, checknumber(myPredict.left))
			local cfg2 = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 2, checknumber(myPredict.right))

			GameUtil.SetActive(self._imgNone, true)
			GameUtil.SetActive(self._imgShadow, true)
			GameUtil.SetActive(self._imgBody, false)
			GameUtil.SetActive(self._imgBody, false)
			uGuiUtil.setSpriteToImage(self._imgNone.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", "board_longhunyuzhi_03"))

			if cfg and cfg2 then
				GameUtil.SetActive(self._imgNone, false)
				GameUtil.SetActive(self._imgShadow, false)
				GameUtil.SetActive(self._imgBody, true)
				GameUtil.SetActive(self._imgBody, true)
				uGuiUtil.setSpriteToImage(self._imgHead.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", cfg.path))
				uGuiUtil.setSpriteToImage(self._imgBody.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", cfg2.path))

				local map = DragonSoulVoteConfig.instance:getPredictCfgMap(self._activityId)
				local map1 = DragonSoulVoteConfig.instance:getPredictGroupCfg(self._activityId, 1)
				local map2 = DragonSoulVoteConfig.instance:getPredictGroupCfg(self._activityId, 2)
				local list = {}

				for k, v in pairs(map1) do
					for k2, v2 in pairs(map2) do
						local obj = {}

						obj.left = v.itemId
						obj.right = v2.itemId

						table.insert(list, obj)
					end
				end

				ArraySort.sortOn(list, function(a)
					if not self._voteMap[a.left] then
						return 0
					else
						return checknumber(self._voteMap[a.left][a.right])
					end
				end, ArraySort.DESCENDING)

				for i, v in ipairs(list) do
					v.index = i
				end

				self._scrollList:reloadData(list)
				GameUtil.SetActive(self._empty, false)
				GameUtil.SetActive(self._head, true)
				GameUtil.SetActive(self._bubble, true)

				self._txtName.text = cfg2.name .. "·" .. cfg.name

				HeadItemController.instance:setMyHeadCell(self._head)

				if not self._msgList[myPredictMsgId] then
					if not self._msgList[myPredictMsgId].desc then
						self._txtTip.text = ""
					end
				end
			else
				self._txtName.text = ""

				self._scrollList:reloadData({})
				GameUtil.SetActive(self._empty, true)
				GameUtil.SetActive(self._head, false)
				GameUtil.SetActive(self._bubble, false)
			end

			GameUtil.SetActive(self._btnGoto, checknumber(myPredict.left) == 0 and checknumber(myPredict.right) == 0)
		end
	end
end

function DragonsoulvotemainView:_updateCell(view, cell, data, tag)
	local btnVote = goutil.findChild(cell, "btnVote")
	local head = goutil.findChild(cell, "head")
	local imgBody = goutil.findChild(cell, "petIcon/imgBody")
	local imgHead = goutil.findChild(cell, "petIcon/imgHead")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtVote = goutil.findChildTextComponent(cell, "vote/txt")
	local txtTip = goutil.findChildTextComponent(cell, "bubble/txtTip")
	local txtRank = goutil.findChildTextComponent(cell, "rank/txt")
	local rankIma = goutil.findChild(cell, "rank/rankIma")

	self._voteMap[checknumber(data.left)] = self._voteMap[checknumber(data.left)] or {}

	local voteCount = checknumber(self._voteMap[checknumber(data.left)][checknumber(data.right)])
	local cfg = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 1, checknumber(data.left)) or {}
	local cfg2 = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 2, checknumber(data.right)) or {}

	txtName.text = cfg2.name .. "·" .. cfg.name

	uGuiUtil.setSpriteToImage(imgHead.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", cfg.path))
	uGuiUtil.setSpriteToImage(imgBody.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/dragonsoulvote", cfg2.path))

	txtVote.text = "人气值：" .. voteCount

	local idx = checknumber(data.left) + checknumber(data.right) + self._randHeadIdx

	idx = 1 + idx % #self._playerList

	if not self._playerList[idx] then
		local headId = 1
		local proxy = HeadItemController.instance:setHeadCell(head, headId)

		if proxy then
			proxy.binder:setAutoTips(false)
		end

		local idx = checknumber(data.left) + checknumber(data.right) + self._randHeadIdx

		idx = 1 + idx % #self._msgList

		local msgCfg = self._msgList[idx]

		txtTip.text = msgCfg.desc

		if data.index <= 3 then
			GameUtil.setUIImageSpriteIdx(rankIma, data.index - 1)

			txtRank.text = ""
		else
			GameUtil.setUIImageSpriteIdx(rankIma, 3)

			txtRank.text = data.index
		end

		GameUtil.addClickHandler(btnVote, GameUtil.handler(self._onClickVote, self, data))
	end
end

function DragonsoulvotemainView:_clearCell(cell)
	local head = goutil.findChild(cell, "head")
	local petIcon = goutil.findChild(cell, "petIcon")

	HeadItemController.instance:resetHeadCell(head)
	uGuiUtil.clearImage(petIcon)
end

function DragonsoulvotemainView:_onClickGoTo()
	UIStateManager.instance:push(ViewName.DragonsoulvotemakeView, self._activityId)
end

function DragonsoulvotemainView:_onClickJump()
	GotoMgr.gotoByString(self._actCfg.jumpTo)
end

function DragonsoulvotemainView:_onClickRecord()
	UIStateManager.instance:push(ViewName.DragonsoulvoteprizeView, self._activityId)
end

function DragonsoulvotemainView:_onClickTip()
	TipsFacade.instance:openRulesView("dragonsoulvotemainview_rule")
end

function DragonsoulvotemainView:_onClickVote(data)
	local time = GameUtil.string2time(self._actCfg.voteEndTime)

	if time <= ServerTime.now() then
		TipsFacade.instance:openCommonTips("投票已截止~")

		return
	end

	local mattype, id, num = MaterialMgr.getMatParams(self._actCfg.voteMp)
	local cfg = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 1, checknumber(data.left)) or {}
	local cfg2 = DragonSoulVoteConfig.instance:getPredictCfgById(self._activityId, 2, checknumber(data.right)) or {}
	local nn = cfg2.name .. "·" .. cfg.name

	TipsFacade.instance:openPopupCostAdjustView(mattype, id, 1, langPara("是否消耗%s个应援棒投票给%s？", 1, nn), function(num)
		DragonSoulVoteController.instance:sendVote(self._activityId, data.left, data.right, num)
	end, nil, nil, function(state, num)
		if state == TipsFacade.STATE_NUM_CHANGE then
			return langPara("是否消耗%s个应援棒投票给%s？", num, nn)
		end
	end)
end

return DragonsoulvotemainView
