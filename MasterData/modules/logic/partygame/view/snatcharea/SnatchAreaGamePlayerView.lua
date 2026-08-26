-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGamePlayerView.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGamePlayerView", package.seeall)

local SnatchAreaGamePlayerView = class("SnatchAreaGamePlayerView", BaseView)

function SnatchAreaGamePlayerView:onInitView()
	self.centerRectTr = gohelper.findChildComponent(self.viewGO, "root/center/playermovearea", gohelper.Type_RectTransform)
	self.goPlayerItem = gohelper.findChild(self.viewGO, "root/center/playermovearea/playmoveitem")

	gohelper.setActive(self.goPlayerItem, false)

	self.playerItemList = {}
	self.pickClick = gohelper.findChildClick(self.viewGO, "root/right/pick_btn")
	self.goSelectImage = gohelper.findChild(self.viewGO, "root/right/pick_btn/selected")
	self.goUnSelectImage = gohelper.findChild(self.viewGO, "root/right/pick_btn/unselect")

	self.pickClick:AddClickDownListener(self.onPickClickDown, self)
	self.pickClick:AddClickUpListener(self.onPickClickUp, self)
	gohelper.setActive(self.goSelectImage, false)
	gohelper.setActive(self.goUnSelectImage, true)

	self.interface = PartyGameCSDefine.SnatchAreaInterfaceCs
	self.rectWidth, self.rectHeight = recthelper.getWidth(self.centerRectTr), recthelper.getHeight(self.centerRectTr)
	self.preState = nil
	self.playerPlayedAnimDict = {}
end

function SnatchAreaGamePlayerView:addEvents()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.frameTick, self)
end

function SnatchAreaGamePlayerView:onPickClickUp()
	local curState = self.interface.GetCurState()

	if curState ~= SnatchEnum.GameState.Playing then
		return
	end

	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId.button1)
	gohelper.setActive(self.goSelectImage, false)
	gohelper.setActive(self.goUnSelectImage, true)
end

function SnatchAreaGamePlayerView:onPickClickDown()
	local curState = self.interface.GetCurState()

	if curState ~= SnatchEnum.GameState.Playing then
		return
	end

	gohelper.setActive(self.goSelectImage, true)
	gohelper.setActive(self.goUnSelectImage, false)
end

function SnatchAreaGamePlayerView:frameTick()
	local curState = self.interface.GetCurState()

	if curState == SnatchEnum.GameState.StartRound then
		self:clearPlayerItem()
		self:initPixSize()
	elseif curState == SnatchEnum.GameState.Settlement then
		self:tryShowScore()
	end

	self:refreshPlayer()
	self:refreshButton()

	self.preState = curState
end

function SnatchAreaGamePlayerView:initPixSize()
	local curState = self.interface.GetCurState()

	if self.preState == curState then
		return
	end

	self.pixTotalWidth, self.pixTotalHeight = self.interface.GetMapPixSize(nil, nil)
end

function SnatchAreaGamePlayerView:refreshPlayer()
	local curState = self.interface.GetCurState()

	if curState == SnatchEnum.GameState.StartRound then
		self:hidePlayer()
	elseif curState == SnatchEnum.GameState.ShowOperate then
		self:showPlayer()
	else
		self:refreshPlayerPos()
	end
end

function SnatchAreaGamePlayerView:refreshButton()
	local curState = self.interface.GetCurState()

	if self.preState == curState then
		return
	end

	if curState == SnatchEnum.GameState.Playing then
		gohelper.setActive(self.pickClick.gameObject, true)
	else
		gohelper.setActive(self.pickClick.gameObject, false)
	end
end

function SnatchAreaGamePlayerView:tryShowScore()
	local curStep = self.interface.GetSettlementStep()

	if curStep <= self.preHandleStep then
		return
	end

	self.preHandleStep = curStep

	for _, playerItem in ipairs(self.playerItemList) do
		local playerMo = playerItem.playerMo
		local uid = playerMo.uid

		if not playerItem.playedAddScoreAnim then
			local canPlay, score = self.interface.GetPlayerCanAddScore(uid, 0)

			if canPlay then
				playerItem.headItem:setScoreAddAnim(true, score)

				playerItem.playedAddScoreAnim = true
			end
		end
	end
end

function SnatchAreaGamePlayerView:onOpen()
	self:initPlayer()
end

function SnatchAreaGamePlayerView:hidePlayer()
	for _, playerItem in ipairs(self.playerItemList) do
		gohelper.setActive(playerItem.go, false)
	end
end

function SnatchAreaGamePlayerView:showPlayer()
	for _, playerItem in ipairs(self.playerItemList) do
		gohelper.setActive(playerItem.go, true)

		local _, pixPosX, pixPosY = self.interface.GetPlayerPixPos(playerItem.playerMo.uid, nil, nil)
		local anchorPosX, anchorPosY = SnatchAreaHelper.pixPos2AnchorPos(pixPosX, pixPosY, self.rectWidth, self.rectHeight, self.pixTotalWidth, self.pixTotalHeight)

		recthelper.setAnchor(playerItem.rectTr, anchorPosX, anchorPosY)
		playerItem.animator:Play("idle")

		playerItem.playedAudio = false
	end
end

function SnatchAreaGamePlayerView:clearPlayerItem()
	self.preHandleStep = 0

	for _, playerItem in ipairs(self.playerItemList) do
		playerItem.headItem:setScoreAddAnim(false, 0)

		playerItem.playedAddScoreAnim = false
	end
end

function SnatchAreaGamePlayerView:initPlayer()
	local playerMoList = PartyGameModel.instance:getCurGamePlayerList()

	for index, playerMo in ipairs(playerMoList) do
		local playerItem = self.playerItemList[index]

		if not playerItem then
			playerItem = self:createPlayerItem()

			table.insert(self.playerItemList, playerItem)
		end

		local uid = playerMo.uid

		playerItem.playerMo = playerMo

		gohelper.setActive(playerItem.go, true)

		playerItem.txtUid.text = tostring(uid)

		playerItem.headItem:setData({
			isShowBkg = false,
			isShowRank = true,
			isShowArrow = true,
			isShowScore = false,
			isAutoShowArrow = true,
			uid = uid
		})
	end
end

function SnatchAreaGamePlayerView:refreshPlayerPos()
	for _, playerItem in ipairs(self.playerItemList) do
		local uid = playerItem.playerMo.uid
		local _, pixPosX, pixPosY = self.interface.GetPlayerPixPos(uid, nil, nil)
		local pickAreaType = self.interface.GetPlayerPickArea(uid)
		local picked = pickAreaType ~= SnatchEnum.AreaType.None

		if picked then
			local row, column = self.interface:GetCellCoordinates(pixPosY, nil, nil)

			pixPosX, pixPosY = self.interface.GetCellPos(row, column, nil, nil)
		end

		local anchorPosX, anchorPosY = SnatchAreaHelper.pixPos2AnchorPos(pixPosX, pixPosY, self.rectWidth, self.rectHeight, self.pixTotalWidth, self.pixTotalHeight)

		self:setPlayerItemPos(playerItem, anchorPosX, anchorPosY)

		local animName = picked and "select" or "idle"

		playerItem.animator:Play(animName)

		if picked and not playerItem.playedAudio then
			AudioMgr.instance:trigger(340105)
		end

		playerItem.playedAudio = picked
	end
end

function SnatchAreaGamePlayerView:setPlayerItemPos(playerItem, anchorX, anchorY)
	local curAnchorX, curAnchorY = recthelper.getAnchor(playerItem.rectTr)
	local xLen = math.abs(curAnchorX - anchorX)
	local yLen = math.abs(curAnchorY - anchorY)

	ZProj.TweenHelper.KillByObj(playerItem.rectTr)

	if xLen > 10 or yLen > 10 then
		ZProj.TweenHelper.DOAnchorPos(playerItem.rectTr, anchorX, anchorY, 0.2)
	else
		recthelper.setAnchor(playerItem.rectTr, anchorX, anchorY)
	end
end

function SnatchAreaGamePlayerView:createPlayerItem()
	local playerItem = self:getUserDataTb_()

	playerItem.go = gohelper.cloneInPlace(self.goPlayerItem)
	playerItem.animator = playerItem.go:GetComponent(gohelper.Type_Animator)
	playerItem.rectTr = playerItem.go:GetComponent(gohelper.Type_RectTransform)
	playerItem.txtUid = gohelper.findChildText(playerItem.go, "uid")
	playerItem.playedAddScoreAnim = false

	local headRoot = gohelper.findChild(playerItem.go, "head_root")

	playerItem.headItem = GameFacade.createLuaComp("partygameplayerhead", headRoot, PartyGamePlayerHead, nil, self.viewContainer)

	playerItem.headItem:setAddScoreScale(2)

	playerItem.playedAudio = false

	return playerItem
end

function SnatchAreaGamePlayerView:onDestroyView()
	if self.pickClick then
		self.pickClick:RemoveClickDownListener()
		self.pickClick:RemoveClickUpListener()

		self.pickClick = nil
	end

	for _, playerItem in ipairs(self.playerItemList) do
		ZProj.TweenHelper.KillByObj(playerItem.rectTr)
	end
end

return SnatchAreaGamePlayerView
