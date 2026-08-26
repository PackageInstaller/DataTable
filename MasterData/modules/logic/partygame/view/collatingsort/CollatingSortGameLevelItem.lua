-- chunkname: @modules/logic/partygame/view/collatingsort/CollatingSortGameLevelItem.lua

module("modules.logic.partygame.view.collatingsort.CollatingSortGameLevelItem", package.seeall)

local CollatingSortGameLevelItem = class("CollatingSortGameLevelItem", ListScrollCellExtend)

function CollatingSortGameLevelItem:onInitView()
	self._goboard = gohelper.findChild(self.viewGO, "#go_board")
	self._gobox = gohelper.findChild(self.viewGO, "#go_box")
	self._goecs = gohelper.findChild(self.viewGO, "#go_ecs")
	self._goentry = gohelper.findChild(self.viewGO, "#go_entry")
	self._goplayer = gohelper.findChild(self.viewGO, "#go_player")
	self._txtplayerName = gohelper.findChildText(self.viewGO, "#go_player/#txt_playerName")
	self._txtscore = gohelper.findChildText(self.viewGO, "#go_player/#txt_score")
	self._color = gohelper.findChildImage(self.viewGO, "#go_player/headitem/#image_color")
	self._scorebg = gohelper.findChildImage(self.viewGO, "#go_player/headitem/#image_scorebg")
	self._goframe = gohelper.findChild(self.viewGO, "#go_frame")
	self._goframe1 = gohelper.findChild(self.viewGO, "#go_frame/#go_frame1")
	self._goframe2 = gohelper.findChild(self.viewGO, "#go_frame/#go_frame2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollatingSortGameLevelItem:addEvents()
	return
end

function CollatingSortGameLevelItem:removeEvents()
	return
end

function CollatingSortGameLevelItem:_editableInitView()
	self._goMainPlayerFlag = gohelper.findChild(self.viewGO, "#go_player/headitem/arrow")
	self._txtRank = gohelper.findChildText(self.viewGO, "#go_player/headitem/#lvbg/#txt_num")
	self._cacheBall = self:getUserDataTb_()
	self._boxList = self:getUserDataTb_()
	self._boardList = self:getUserDataTb_()
	self._boardPosList = self:getUserDataTb_()
	self._areaList = self:getUserDataTb_()
	self._collisionInfoMap = self:getUserDataTb_()
	self._fallInfoMap = self:getUserDataTb_()
	self._collistionEffectMap = self:getUserDataTb_()
	self._viewGoTrans = self.viewGO.transform

	local transform = self._goboard.transform
	local childCount = transform.childCount
	local posY = 1000000

	for i = 0, childCount - 1 do
		local groupTran = transform:GetChild(i)

		table.insert(self._boardList, groupTran)

		local w, h = recthelper.getWidth(groupTran), recthelper.getHeight(groupTran)
		local area = gohelper.create2d(groupTran.gameObject)

		recthelper.setSize(area.transform, w * 0.82, h * 0.42)
		table.insert(self._areaList, area)

		local y = recthelper.getAnchorY(groupTran)

		table.insert(self._boardPosList, {
			y = y,
			boardAreaTrans = area.transform,
			boardTran = groupTran
		})

		if y < posY then
			posY = y
		else
			logError("CollatingSortGameLevelItem error y index:", i)
		end
	end

	gohelper.setActive(self._goMainPlayerFlag, false)
	gohelper.setActive(self._goframe, false)
end

function CollatingSortGameLevelItem:showFrame(playerNum)
	local fourPlayer = playerNum == CollatingSortGameView.MaxPlayer

	gohelper.setActive(self._goframe, true)
	gohelper.setActive(self._goMainPlayerFlag, true)
	gohelper.setActive(self._goframe1, fourPlayer)
	gohelper.setActive(self._goframe2, playerNum == CollatingSortGameView.MinPlayer)

	local animator = self.viewGO:GetComponent("Animator")

	animator.enabled = true

	animator:Play(fourPlayer and "in1" or "in2")

	self._isMainPlayer = true
end

function CollatingSortGameLevelItem:_editableAddEvents()
	return
end

function CollatingSortGameLevelItem:_editableRemoveEvents()
	return
end

function CollatingSortGameLevelItem:getEntryGo()
	return self._goentry
end

function CollatingSortGameLevelItem:getBoardGo()
	return self._goboard
end

function CollatingSortGameLevelItem:getBoardList()
	return self._boardList
end

function CollatingSortGameLevelItem:getBoxGo()
	return self._gobox
end

function CollatingSortGameLevelItem:getUid()
	return self._mo.uid
end

function CollatingSortGameLevelItem:setOffsetPos(x, y, z)
	self._offsetPosX = x
	self._offsetPosY = y
	self._offsetPosZ = z
end

function CollatingSortGameLevelItem:onNewBall(index, go, dropType, initPosX, initPosY)
	if self._cacheBall[index] then
		return
	end

	local ballPool = self.viewContainer:getBallPool()
	local ballItem = ballPool:getObject()
	local ballGo = ballItem.viewGO

	gohelper.addChild(self._goecs, ballGo)

	self._cacheBall[index] = {
		ballGo,
		go,
		ballItem = ballItem
	}

	ballItem:onUpdateMO(dropType, self._dropType1, self._dropType2)
	ballItem:setInitPos(initPosX, initPosY)
	ballItem:setMoveScale(self:_getMoveScale())

	if self._offsetPosX then
		ballItem:setOffset(self._offsetPosX, self._offsetPosY, self._offsetPosZ)
	end

	ballItem:setEcsGo(go)
end

function CollatingSortGameLevelItem:_getMoveScale()
	local width = UnityEngine.Screen.width
	local height = UnityEngine.Screen.height

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		width, height = SettingsModel.instance:getCurrentScreenSize()
	end

	local screenRatio = width / height
	local targetRatio = 1.7777777777777777

	return math.min(screenRatio / targetRatio, 1)
end

function CollatingSortGameLevelItem:onCollectBall(index, posIndex, score)
	self:_destoryBall(index)

	local box = self._boxList[posIndex + 1]

	if box then
		box:onCollectBall(score)

		if self._isMainPlayer then
			if score > 0 then
				AudioMgr.instance:trigger(AudioEnum3_4.PartyGame12.play_ui_bulaochun_score_get)
			else
				AudioMgr.instance:trigger(AudioEnum3_4.PartyGame12.play_ui_bulaochun_score_deduct)
			end
		end
	end
end

function CollatingSortGameLevelItem:_destoryBall(index)
	local ballPool = self.viewContainer:getBallPool()
	local ballInfo = self._cacheBall[index]

	self._cacheBall[index] = nil

	if ballInfo then
		ballPool:putObject(ballInfo.ballItem)
	else
		logWarn("CollatingSortGameLevelItem onCollectBall no ballInfo index:", tostring(index))
	end
end

function CollatingSortGameLevelItem:onUpdateMO(playerMo, index, dropType1, dropType2)
	self._mo = playerMo
	self._txtplayerName.text = playerMo.name
	self._itemIndex = index
	self._dropType1 = dropType1
	self._dropType2 = dropType2

	self:_initBoxDropType()

	if not self._gomodel then
		self._gomodel = gohelper.findChild(self.viewGO, "#go_player/headitem/#image_head/#go_model")

		local spine = MonoHelper.addNoUpdateLuaComOnceToGo(self._gomodel, CommonPartyGamePlayerSpineComp)

		spine:initSpine(self._mo.uid)
	end
end

function CollatingSortGameLevelItem:_initBoxDropType()
	local go1 = gohelper.findChild(self._gobox, "leftbox")
	local ballItem1 = MonoHelper.addNoUpdateLuaComOnceToGo(go1, CollatingSortGameBoxItem)

	ballItem1:onUpdateMO(self._dropType1)
	table.insert(self._boxList, ballItem1)

	local go2 = gohelper.findChild(self._gobox, "rightbox")
	local ballItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(go2, CollatingSortGameBoxItem)

	ballItem2:onUpdateMO(self._dropType2)
	table.insert(self._boxList, ballItem2)
end

function CollatingSortGameLevelItem:viewDataUpdate()
	local score = 0
	local rank = 0
	local curGame = PartyGameController.instance:getCurPartyGame()

	if self._mo ~= nil and curGame ~= nil then
		score = curGame:getPlayerScore(self._mo.uid)
		rank = curGame:getRank(self._mo.uid)
	end

	self._txtscore.text = tostring(score)

	if rank >= 4 then
		self._txtRank.text = string.format("<color=#EFEDE3>%s</color>", rank)
	end

	local _, color = self._mo:getColorName()

	self._color.color = color

	local imageIndex = (rank > 4 or rank < 1) and 4 or rank

	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._scorebg, "v3a4_party_common_rankbg_" .. imageIndex)
	self:_checkEntityGo()
	self:_checkEffectTimeout()
end

function CollatingSortGameLevelItem:_checkEntityGo()
	for index, ballInfo in pairs(self._cacheBall) do
		local entityGo = ballInfo[2]

		if gohelper.isNil(entityGo) or not entityGo.activeSelf then
			self:_destoryBall(index)
		else
			self:_checkCollision(index, ballInfo)
		end
	end
end

function CollatingSortGameLevelItem:_checkCollision(index, ballInfo)
	local ballItem = ballInfo.ballItem
	local goPoint = ballItem:getPoint()
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(goPoint.transform)

	for i, v in ipairs(self._boardPosList) do
		local boardAreaTrans = v.boardAreaTrans

		if not self._collisionInfoMap[index] then
			if self._collisionInfoMap[index] < i and recthelper.screenPosInRect(boardAreaTrans, CameraMgr.instance:getUICamera(), screenPosX, screenPosY) then
				self:_showCollistionEffect(index, goPoint, v.boardTran, i)

				return
			end

			if self._isMainPlayer then
				self:_checkFallAudio(self._collisionInfoMap[index], index, ballItem)
			end
		end
	end
end

function CollatingSortGameLevelItem:_checkFallAudio(lastCollisionIndex, ballIndex, ballItem)
	if self._fallInfoMap[ballIndex] == lastCollisionIndex then
		return
	end

	if lastCollisionIndex == 0 then
		self._fallInfoMap[ballIndex] = lastCollisionIndex

		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame12.play_ui_bulaochun_ball_fall)

		return
	end

	local info = self._boardPosList[lastCollisionIndex]

	if not info then
		return
	end

	local boardAreaTrans = info.boardAreaTrans

	if not boardAreaTrans then
		return
	end

	local _, boardPosY = recthelper.rectToRelativeAnchorPos2(boardAreaTrans.position, self._viewGoTrans)
	local _, ballPosY = recthelper.rectToRelativeAnchorPos2(ballItem.viewGO.transform.position, self._viewGoTrans)

	if ballPosY - boardPosY <= -80 then
		self._fallInfoMap[ballIndex] = lastCollisionIndex

		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame12.play_ui_bulaochun_ball_fall)
	end
end

function CollatingSortGameLevelItem:_showCollistionEffect(index, goPoint, boardTran, boardIndex)
	if self._collisionInfoMap[index] == boardIndex then
		return
	end

	self._collisionInfoMap[index] = boardIndex

	local effectPool = self.viewContainer:getEffectPool()
	local effectGo = effectPool:getObject()

	gohelper.addChild(boardTran.gameObject, effectGo)
	gohelper.setActive(effectGo, true)

	effectGo.transform.position = goPoint.transform.position

	recthelper.setAnchorY(effectGo.transform, 13)

	self._collistionEffectMap[effectGo] = Time.time

	if self._isMainPlayer then
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame12.play_ui_bulaochun_ball_smash)
	end
end

function CollatingSortGameLevelItem:_checkEffectTimeout()
	local effectPool = self.viewContainer:getEffectPool()
	local time = Time.time

	for k, v in pairs(self._collistionEffectMap) do
		if time - v >= 1 then
			self._collistionEffectMap[k] = nil

			effectPool:putObject(k)
		end
	end
end

function CollatingSortGameLevelItem:onDestroyView()
	return
end

return CollatingSortGameLevelItem
