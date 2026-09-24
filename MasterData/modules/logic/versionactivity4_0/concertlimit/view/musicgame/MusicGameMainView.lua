-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameMainView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameMainView", package.seeall)

local MusicGameMainView = class("MusicGameMainView", BaseView)

function MusicGameMainView:onInitView()
	self._goblock = gohelper.findChild(self.viewGO, "root/#go_block")
	self._goblockItem = gohelper.findChild(self.viewGO, "root/#go_block/#go_blockItem")
	self._goleft = gohelper.findChild(self.viewGO, "root/#go_left")
	self._gorules = gohelper.findChild(self.viewGO, "root/#go_left/#go_rules")
	self._txtRulesDesc = gohelper.findChildText(self.viewGO, "root/#go_left/#go_rules/#txt_RulesDesc")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_left/#btn_reset")
	self._golightreset = gohelper.findChild(self.viewGO, "root/#go_left/#btn_reset/#go_lightreset")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_left/#btn_back")
	self._gonorback = gohelper.findChild(self.viewGO, "root/#go_left/#btn_back/#go_norback")
	self._goright = gohelper.findChild(self.viewGO, "root/#go_right")
	self._gofirst = gohelper.findChild(self.viewGO, "root/#go_right/#go_first")
	self._txtfirst = gohelper.findChildText(self.viewGO, "root/#go_right/#go_first/#txt_first")
	self._goscores = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores")
	self._goscore1 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score1")
	self._txtscore1 = gohelper.findChildText(self.viewGO, "root/#go_right/#go_scores/#go_score1/#txt_score1")
	self._goscoreeff1 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score1/vx_effect")
	self._goscore2 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score2")
	self._txtscore2 = gohelper.findChildText(self.viewGO, "root/#go_right/#go_scores/#go_score2/#txt_score2")
	self._goscoreeff2 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score2/vx_effect")
	self._goscore3 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score3")
	self._txtscore3 = gohelper.findChildText(self.viewGO, "root/#go_right/#go_scores/#go_score3/#txt_score3")
	self._goscoreeff3 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score3/vx_effect")
	self._goscore4 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score4")
	self._txtscore4 = gohelper.findChildText(self.viewGO, "root/#go_right/#go_scores/#go_score4/texture/#txt_score4")
	self._goscoreeff4 = gohelper.findChild(self.viewGO, "root/#go_right/#go_scores/#go_score4/vx_effect")
	self._btnfinish = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_right/#btn_finish")
	self._gofinishlight = gohelper.findChild(self.viewGO, "root/#go_right/#btn_finish/#go_finishlight")
	self._gofinishgrey = gohelper.findChild(self.viewGO, "root/#go_right/#btn_finish/#go_finishgrey")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MusicGameMainView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnfinish:AddClickListener(self._btnfinishOnClick, self)
end

function MusicGameMainView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnfinish:RemoveClickListener()
end

function MusicGameMainView:_btnshowOnClick()
	self._showline = not self._showline

	self:_refresh()
end

function MusicGameMainView:_btnbackOnClick()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.play_ui_yingmen4_0_roll_back)
	MusicGameModel.instance:backSelectedBlockLines()
	self:_refresh()
end

function MusicGameMainView:_btnfinishOnClick()
	local score = MusicGameModel.instance:getCurScore()

	if score <= 0 then
		return
	end

	local multi = MusicGameModel.instance:getGameScoreMulti()

	self._resultScore = multi * score

	Activity234Rpc.instance:sendAct234FinishGameRequest(self._actId, score, "")
end

function MusicGameMainView:_btnresetOnClick()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.play_ui_yingmen4_0_reset)
	GameFacade.showMessageBox(MessageBoxIdDefine.V4a0SelfMusicGameReset, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)
end

function MusicGameMainView:onClickYes()
	MusicGameModel.instance:clearSelectedBlockLines()
	self:_refresh()
end

function MusicGameMainView:_editableInitView()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	self:_initView()
	self:_addSelfEvents()
end

function MusicGameMainView:_initView()
	local guideGMNode = GMController.instance:getGMNode("musicgamemainview", self.viewGO)

	if guideGMNode then
		self._btnshow = gohelper.findChildButtonWithAudio(guideGMNode, "#btn_show")
		self._txtshow = gohelper.findChildText(guideGMNode, "#btn_show/txt")
	end

	self._finishAnim = self._gofinishlight:GetComponent(typeof(UnityEngine.Animation))
	self._gofinishEff1 = gohelper.findChild(self.viewGO, "root/#go_right/#btn_finish/#go_finishlight/light")
	self._gofinishEff2 = gohelper.findChild(self.viewGO, "root/#go_right/#btn_finish/#go_finishlight/light2")
	self._showline = false

	gohelper.setActive(self._goblockItem, false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goblock)
	self._blockMap = self:getUserDataTb_()
end

function MusicGameMainView:_addSelfEvents()
	if self._btnshow then
		self._btnshow:AddClickListener(self._btnshowOnClick, self)
	end

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onReOpenView, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGame, self._onFinishGame, self)
	self.addEventCb(self, MusicGameController.instance, MusicGameEvent.CancelGame, self._onCancelGame, self)
	self.addEventCb(self, MusicGameController.instance, MusicGameEvent.BlockLongPress, self._onBlockLongPress, self)
	self.addEventCb(self, MusicGameController.instance, MusicGameEvent.BlockPressEnd, self._onBlockPressEnd, self)
end

function MusicGameMainView:_removeSelfEvents()
	if self._btnshow then
		self._btnshow:RemoveClickListener()
	end

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
		self._drag:RemoveDragListener()

		self._drag = nil
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onReOpenView, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGame, self._onFinishGame, self)
	self.removeEventCb(self, MusicGameController.instance, MusicGameEvent.CancelGame, self._onCancelGame, self)
	self.removeEventCb(self, MusicGameController.instance, MusicGameEvent.BlockLongPress, self._onBlockLongPress, self)
	self.removeEventCb(self, MusicGameController.instance, MusicGameEvent.BlockPressEnd, self._onBlockPressEnd, self)
end

function MusicGameMainView:_onBlockLongPress(blockMo)
	self:_addSelectBlock(blockMo.id)
	self:_refresh()
end

function MusicGameMainView:_onBlockPressEnd()
	local connects = MusicGameModel.instance:getSelectedBlockLines()

	if not connects or #connects > 1 then
		return
	end

	MusicGameModel.instance:clearSelectedBlockLines()
	self:_refresh()
end

function MusicGameMainView:_onCancelGame()
	local score = MusicGameModel.instance:getCurScore()
	local multi = MusicGameModel.instance:getGameScoreMulti()

	self._resultScore = multi * score

	Activity234Rpc.instance:sendAct234FinishGameRequest(self._actId, score, "")
end

function MusicGameMainView:_onDragBegin(param, pointerEventData)
	local blockMo = self:_getBlockByScreenPos(pointerEventData.position)

	self._startConnectBlock = nil

	self:_tryConnectBlock(blockMo)
end

function MusicGameMainView:_onDrag(param, pointerEventData)
	local blockMo = self:_getBlockByScreenPos(pointerEventData.position)

	self:_tryConnectBlock(blockMo)
end

function MusicGameMainView:_onDragEnd(param, pointerEventData)
	local connects = MusicGameModel.instance:getSelectedBlockLines()

	if connects and #connects <= 1 then
		MusicGameModel.instance:clearSelectedBlockLines()
	end

	self:_refresh()
end

function MusicGameMainView:_getBlockByScreenPos(screenPos)
	local posX, posY = recthelper.screenPosToAnchorPos2(screenPos, self._goblock.transform)

	for _, blockItem in pairs(self._blockMap) do
		local trans = blockItem.goroot.transform
		local anchorX, anchorY = recthelper.rectToRelativeAnchorPos2(trans.position, self._goblock.transform)
		local halfWidth = recthelper.getWidth(trans) / 2
		local halfHeight = recthelper.getHeight(trans) / 2

		if halfWidth >= math.abs(posX - anchorX) and halfHeight >= math.abs(posY - anchorY) then
			return (blockItem:getBlockMo())
		end
	end

	return nil
end

function MusicGameMainView:_tryConnectBlock(blockMo)
	if not blockMo then
		return
	end

	local connects = MusicGameModel.instance:getSelectedBlockLines()

	if not connects or #connects < 1 then
		self:_addSelectBlock(blockMo.id)
		self:_refresh()

		return
	end

	local lastBlockMo = MusicGameModel.instance:getBlockDataById(connects[#connects])

	if lastBlockMo and lastBlockMo.id == blockMo.id then
		self._startConnectBlock = blockMo

		return
	end

	if not self._startConnectBlock then
		return
	end

	local isAdjacent = math.abs(blockMo.x - lastBlockMo.x) + math.abs(blockMo.y - lastBlockMo.y) == 1

	if not isAdjacent then
		return
	end

	local hasConnect = MusicGameModel.instance:isSelectedBlockLines(blockMo.id)

	if #connects > 1 and hasConnect then
		local clearBlockMo = MusicGameModel.instance:getBlockDataById(connects[#connects - 1])

		if clearBlockMo and clearBlockMo.id == blockMo.id then
			MusicGameModel.instance:backSelectedBlockLines()

			self._startConnectBlock = blockMo
		end
	else
		self:_addSelectBlock(blockMo.id)
	end

	self:_refresh()
end

function MusicGameMainView:_addSelectBlock(id)
	local couldConnect = MusicGameModel.instance:isBlockCouldConnect(id)

	if not couldConnect then
		return
	end

	local blockMo = MusicGameModel.instance:getBlockDataById(id)

	if not blockMo.config.audioId then
		AudioMgr.instance:trigger(blockMo.config.audioId)
		MusicGameModel.instance:addSelectedBlockLines(id)
		MusicGameController.instance:dispatchEvent(MusicGameEvent.BlockItemConnect, id)
	end
end

function MusicGameMainView:_onFinishGame()
	MusicGameController.instance:openMusicGameResultView(self._resultScore)
end

function MusicGameMainView:_onBlockItemClick(blockMo)
	if self:_checkRemoveConnect(blockMo) then
		self:_refresh()
	end
end

function MusicGameMainView:_checkRemoveConnect(blockMo)
	local connects = MusicGameModel.instance:getSelectedBlockLines()

	if connects and #connects > 0 then
		local lastBlockMo = MusicGameModel.instance:getBlockDataById(connects[#connects])

		if lastBlockMo and lastBlockMo.id == blockMo.id then
			MusicGameModel.instance:backSelectedBlockLines()

			return true
		end
	end

	return false
end

function MusicGameMainView:_onReOpenView(viewName)
	if viewName ~= self.viewName then
		return
	end

	self:_refresh()
end

function MusicGameMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.play_ui_yingmen4_0_open_game)
	self:_refresh()
end

function MusicGameMainView:_refresh()
	self:_refreshUI()
	self:_refreshScore()
	self:_refreshBlocks()
end

function MusicGameMainView:_refreshUI()
	local isFirstShow = MusicGameModel.instance:isFirstShow(self._actId)

	gohelper.setActive(self._gofirst, isFirstShow)

	if self._txtshow then
		self._txtshow.text = self._showline and "Hide" or "Show"
	end

	local score = MusicGameModel.instance:getCurScore()

	gohelper.setActive(self._gofinishgrey, score <= 0)
	gohelper.setActive(self._gofinishlight, score > 0)

	local showEffCount = MusicGameConfig.instance:getConstNumberValue(MusicGameEnum.ConstId.FinishTipLength)
	local connects = MusicGameModel.instance:getSelectedBlockLines()
	local showLightAnim = showEffCount <= #connects

	self._finishAnim.enabled = showLightAnim

	gohelper.setActive(self._gofinishEff1, showLightAnim)
	gohelper.setActive(self._gofinishEff2, showLightAnim)
end

function MusicGameMainView:_refreshScore()
	local multi = MusicGameModel.instance:getGameScoreMulti()
	local curScore = multi * MusicGameModel.instance:getCurScore()
	local showEff = false

	if self._curScore ~= curScore then
		showEff = true
		self._curScore = curScore
	end

	local scorelv = MusicGameModel.instance:getGameScoreLv(curScore)

	for i = 1, 4 do
		gohelper.setActive(self["_goscore" .. tostring(i)], i == scorelv)

		if showEff and i == scorelv then
			gohelper.setActive(self["_goscoreeff" .. tostring(i)], false)
			gohelper.setActive(self["_goscoreeff" .. tostring(i)], true)

			local lvCo = MusicGameConfig.instance:getLevelCo(scorelv)

			AudioMgr.instance:trigger(lvCo.audioId)
		end

		if i == scorelv then
			self["_txtscore" .. tostring(i)].text = curScore
		end
	end
end

function MusicGameMainView:_refreshBlocks()
	local blocks = MusicGameModel.instance:getBlockMap()

	for y = 1, #blocks do
		for x = 1, #blocks[y] do
			local block = blocks[y][x]

			if not self._blockMap[block.id] then
				local go = gohelper.cloneInPlace(self._goblockItem, block.id)

				self._blockMap[block.id] = MusicGameMainBlockItem.New()

				self._blockMap[block.id]:init(go)
			end

			self._blockMap[block.id]:showLine(self._showline)
			self._blockMap[block.id]:refresh(block)
		end
	end
end

function MusicGameMainView:onClose()
	return
end

function MusicGameMainView:onDestroyView()
	self:_removeSelfEvents()

	if self._blockMap then
		for i, v in pairs(self._blockMap) do
			v:destroy()
		end

		self._blockMap = nil
	end
end

return MusicGameMainView
