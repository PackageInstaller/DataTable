-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattleprepareView.lua

module("logic.extensions.lotusbattle.view.LotusbattleprepareView", package.seeall)

local LotusbattleprepareView = class("LotusbattleprepareView", ViewComponent)

LotusbattleprepareView.TimeType = {
	WaitMatch = 2,
	CountDown = 1
}

function LotusbattleprepareView:ctor()
	LotusbattleprepareView.super.ctor(self)

	self._pkEffectHandlers = {}
end

function LotusbattleprepareView:unbindEvents()
	LotusbattleprepareView.super.unbindEvents(self)
	self._btnChallenge:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function LotusbattleprepareView:bindEvents()
	LotusbattleprepareView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function LotusbattleprepareView:buildUI()
	LotusbattleprepareView.super.buildUI(self)

	self._bufftablecellGo = self:getGo("leftcon/bufftablecell")
	self._pettablecellGo = self:getGo("leftcon/pettablecell")
	self._bufftableviewGo = self:getGo("leftcon/bufftableview")
	self._pettableviewGo = self:getGo("leftcon/pettableview")
	self._tableviewGo = self:getGo("bottomleftcon/tableview")
	self._tablecellGo = self:getGo("bottomleftcon/tablecell")
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._petscrollerList = ScrollerList.create(self._pettableviewGo, self._pettablecellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._rankscrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtTime = self:getTxt("top/txtTime")
	self._txtDetail = self:getTxt("top/txtDetail")
	self._modeImgNum = self:getGo("top/mode/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtDetail_1 = self:getTxt("top/txtDetail_1")
	self._txtDetail_2 = self:getTxt("top/txtDetail_2")
	self._effectGo = self:getGo("effect")
	self._pk2Go = self:getGo("rolecon/pk2")
	self._player2Go = self:getGo("rolecon/player2")
	self._pk1Go = self:getGo("rolecon/pk1")
	self._player3Go = self:getGo("rolecon/player3")
	self._player1Go = self:getGo("rolecon/player1")

	self:_buildPkPlayer(1, self._pk1Go)
	self:_buildPkPlayer(2, self._pk2Go)
	self:_buildMovePlay(1, self._player1Go)
	self:_buildMovePlay(2, self._player2Go)
	self:_buildMovePlay(3, self._player3Go)

	self._pk1Canvas = self:getGo("rolecon/pk1/pk"):GetComponent(ComponentType.CanvasGroup)
	self._pk2Canvas = self:getGo("rolecon/pk2/pk"):GetComponent(ComponentType.CanvasGroup)
	self._pk2_effecrGo = self:getGo("rolecon/pk2/effecr")
	self._pk1_effectGo = self:getGo("rolecon/pk1/effect")
end

function LotusbattleprepareView:_buildPkPlayer(index, go)
	self._pkPlayers = self._pkPlayers or {}
	self._pkPlayers[index] = {
		mainGo = go,
		goHead1 = goutil.findChild(go, "player_pk1/head"),
		goHead2 = goutil.findChild(go, "player_pk2/head"),
		txtName1 = goutil.findChildTextComponent(go, "player_pk1/name/txtName"),
		txtName2 = goutil.findChildTextComponent(go, "player_pk2/name/txtName"),
		goPk = goutil.findChild(go, "pk")
	}
end

function LotusbattleprepareView:_buildMovePlay(index, go)
	self._movePlayers = self._movePlayers or {}
	self._movePlayers[index] = {
		mainGo = go,
		goHead = goutil.findChild(go, "head"),
		txtName = goutil.findChildTextComponent(go, "name/txtName")
	}
end

function LotusbattleprepareView:onExit()
	LotusbattleprepareView.super.onExit(self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFNotifyBattleFieldChangedRes, self._onLBFNotifyBattleFieldChangedRes, self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFNotifyForceStartMatchRes, self._onClickbtnChallenge, self)
	self._petscrollerList:dispose()
	self._buffscrollerList:dispose()
	self._rankscrollerList:dispose()
	CommonTipsMgr.instance:closeOneView(ViewName.BufftipsView)
	CommonTipsMgr.instance:closeOneView(ViewName.PetTips)
	removetimer(self._tick, self)
	removetimer(self._tickPlayPkEffect, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	for k, v in pairs(self._pkPlayers) do
		HeadItemController.instance:resetHeadCell(v.goHead1)
		HeadItemController.instance:resetHeadCell(v.goHead2)
	end

	for k, v in pairs(self._movePlayers) do
		HeadItemController.instance:resetHeadCell(v.goHead)
	end

	for k, v in pairs(self._pkEffectHandlers) do
		UIEffectManager.instance:stopEffect(v.handler)
	end

	self._pkEffectHandlers = {}
end

function LotusbattleprepareView:onEnter()
	LotusbattleprepareView.super.onEnter(self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFNotifyBattleFieldChangedRes, self._onLBFNotifyBattleFieldChangedRes, self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFNotifyForceStartMatchRes, self._onClickbtnChallenge, self)
	LotusbattleController.instance:clearBattleMsg()

	self._activityId = LotusbattleModel.instance:getActivityId()
	self._modelId = LotusbattleModel.instance:getModelId()
	self._timeType = LotusbattleprepareView.TimeType.CountDown

	self:_calTargetTickTime()
	settimer(1, self._tick, self, true)
	self:_tick()
	self:_updateUI()
	self:_setEffect()

	self._pk1Alpha = -1
	self._pk2Alpha = -1

	settimer(0, self._tickPlayPkEffect, self, true)
end

function LotusbattleprepareView:_onClickbtnChallenge()
	if self._timeType == LotusbattleprepareView.TimeType.WaitMatch then
		FloatWordMgr.instance:show("匹配中")

		return
	end

	removetimer(self._tick, self)

	self._timeType = LotusbattleprepareView.TimeType.WaitMatch

	self:_setTime()
	LotusBattleFieldAgent.instance:sendPM_LBFStartBattleMatchReq()
end

function LotusbattleprepareView:_onClickbtnClose()
	local text = "确定要退出战场吗？"

	local function okFunc()
		LotusBattleFieldAgent.instance:sendPM_LBFLeaveGameReq(self._activityId)
		self:close()
	end

	TipsFacade.instance:openTipWindow("提示", text, okFunc)
end

function LotusbattleprepareView:_onLBFNotifyBattleFieldChangedRes()
	self:_refreshBattleField()
end

function LotusbattleprepareView:_refreshBattleField()
	local battleField = LotusbattleModel.instance:getPrepareBattlefield()

	self:_refreshKillRank(battleField.skillRank)
	self:_refreshKillNum(battleField.activePlayerUserId)
	self:_refreshMovePlayers(battleField)
end

function LotusbattleprepareView:_refreshMovePlayers(battleField)
	if not battleField.activePlayerUserId then
		local headInfos = LotusbattleModel.instance:getPrepareBattleFieldHeadInfos()
		local activeHeadInfos = {}
		local activePlayerUserId_kv = {}

		for i, userId in ipairs(battleField.activePlayerUserId) do
			activePlayerUserId_kv[userId] = userId
		end

		local needSize = 6
		local myUserId = tostring(RoleModel.instance:getUserId())

		for i, v in ipairs(headInfos) do
			if activePlayerUserId_kv[v.userId] and v.userId ~= myUserId then
				table.insert(activeHeadInfos, v)

				needSize = needSize - 1

				if needSize <= 0 then
					break
				end
			end
		end

		local activePlayerNum = #activeHeadInfos

		HeadItemController.instance:setMyHeadCell(self._movePlayers[3].goHead)

		self._movePlayers[3].txtName.text = RoleModel.instance:getUserName()

		local nodeList = self:_getPlayersNodeListByActiveNum(activePlayerNum)

		for i, v in ipairs(nodeList) do
			local headInfo = activeHeadInfos[i]

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(v.goHead, headInfo)

				v.txtName.text = headInfo.userName
			end
		end
	end
end

function LotusbattleprepareView:_getPlayersNodeListByActiveNum(activePlayerNum)
	activePlayerNum = math.min(activePlayerNum, 6)

	goutil.setActive(self._pkPlayers[1].mainGo, false)
	goutil.setActive(self._pkPlayers[2].mainGo, false)
	goutil.setActive(self._movePlayers[1].mainGo, false)
	goutil.setActive(self._movePlayers[2].mainGo, false)
	goutil.setActive(self._movePlayers[3].mainGo, true)

	local nodeList = {}

	if activePlayerNum <= 2 then
		for i = 1, activePlayerNum do
			goutil.setActive(self._movePlayers[i].mainGo, true)
			table.insert(nodeList, {
				goHead = self._movePlayers[i].goHead,
				txtName = self._movePlayers[i].txtName
			})
		end
	elseif activePlayerNum == 3 then
		goutil.setActive(self._pkPlayers[1].mainGo, true)
		goutil.setActive(self._movePlayers[1].mainGo, true)
		table.insert(nodeList, {
			goHead = self._pkPlayers[1].goHead1,
			txtName = self._pkPlayers[1].txtName1
		})
		table.insert(nodeList, {
			goHead = self._pkPlayers[1].goHead2,
			txtName = self._pkPlayers[1].txtName2
		})
		table.insert(nodeList, {
			goHead = self._movePlayers[1].goHead,
			txtName = self._movePlayers[1].txtName
		})
	elseif activePlayerNum == 4 then
		for i, v in ipairs(self._pkPlayers) do
			goutil.setActive(v.mainGo, true)
			table.insert(nodeList, {
				goHead = v.goHead1,
				txtName = v.txtName1
			})
			table.insert(nodeList, {
				goHead = v.goHead2,
				txtName = v.txtName2
			})
		end
	else
		for i, v in ipairs(self._pkPlayers) do
			goutil.setActive(v.mainGo, true)
			table.insert(nodeList, {
				goHead = v.goHead1,
				txtName = v.txtName1
			})
			table.insert(nodeList, {
				goHead = v.goHead2,
				txtName = v.txtName2
			})
		end

		for i = 1, activePlayerNum - 4 do
			goutil.setActive(self._movePlayers[i].mainGo, true)
			table.insert(nodeList, {
				goHead = self._movePlayers[i].goHead,
				txtName = self._movePlayers[i].txtName
			})
		end
	end

	return nodeList
end

function LotusbattleprepareView:_refreshKillNum(activePlayerUserId)
	activePlayerUserId = activePlayerUserId or {}

	local modelId = LotusbattleModel.instance:getModelId()
	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)
	local aliveNum = #activePlayerUserId
	local deathNum = modelCfg.memberNum - aliveNum

	self._txtDetail_1.text = string.format("存活：%s", aliveNum)
	self._txtDetail_2.text = string.format("淘汰：%s", deathNum)
end

function LotusbattleprepareView:_refreshKillRank(skillRank)
	skillRank = skillRank or {}

	local userId = tostring(RoleModel.instance:getUserId())
	local is100Players = self._modelId == 2

	table.sort(skillRank, function(a, b)
		if a.headInfo.userId == userId or b.headInfo.userId == userId then
			return a.headInfo.userId == userId
		elseif a.killNum ~= b.killNum then
			return a.killNum > b.killNum
		elseif a.headInfo.playerLv ~= b.headInfo.playerLv then
			return a.headInfo.playerLv > b.headInfo.playerLv
		else
			return checknumber(a.headInfo.userId) < checknumber(b.headInfo.userId)
		end
	end)

	local showNum = 0

	showNum = is100Players and 10 or #skillRank

	local rankList = {}

	for i = 1, #skillRank do
		if skillRank[i].headInfo.userId ~= userId then
			table.insert(rankList, skillRank[i])

			showNum = showNum - 1

			if showNum <= 0 then
				break
			end
		end
	end

	table.insert(rankList, 1, {
		isMe = true
	})
	self._rankscrollerList:reloadData(rankList)
end

function LotusbattleprepareView:_updateUI()
	self._baseViewInfo = LotusbattleModel.instance:getPrepareBaseInfo()

	if not self._baseViewInfo then
		return
	end

	self:_refreshBattleField()
	self:_setModel()
	self:_setBuff()
	self:_setPets()
end

function LotusbattleprepareView:_setBuff()
	local buffIds = LotusbattleModel.instance:getBagBuffIds()
	local buffCfgs = {}
	local modelId = LotusbattleModel.instance:getModelId()

	for k, buffId in pairs(buffIds) do
		local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)
		local buffCfg = LotusbattleConfig.instance:getBuffCfg(modelCfg.buffPlanId, buffId)

		table.insert(buffCfgs, buffCfg)
	end

	self._buffscrollerList:reloadData(buffCfgs)
end

function LotusbattleprepareView:_setPets()
	local petMos = LotusbattleModel.instance:getBagPets()
	local creepsCfgs = self:_getCreepsCfgs(petMos)
	local finalCreepsCfgs = {}
	local count = 0
	local finalLen = 1

	for i, v in ipairs(creepsCfgs) do
		count = count + 1
		finalCreepsCfgs[finalLen] = finalCreepsCfgs[finalLen] or {}
		finalCreepsCfgs[finalLen][count] = v

		if count == 2 then
			count = 0
			finalLen = finalLen + 1
		end
	end

	self._petscrollerList:reloadData(finalCreepsCfgs)
end

function LotusbattleprepareView:_getCreepsCfgs(petMos)
	local list = {}

	for i, v in pairs(petMos) do
		local cfg = LotusbattleConfig.instance:getCreepsCfg(v.petId)

		table.insert(list, cfg)
	end

	return list
end

function LotusbattleprepareView:_updateBuffCell(view, cell, buffCfg, tag)
	local btnIcon = Framework.ButtonAdapter.GetFrom(cell.gameObject, "icon")

	uGuiUtil.clearImage(btnIcon.gameObject)

	local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local data = LotusbattleConfig.instance:getBuffTipSimpleData(buffCfg.buffPlanId, buffCfg.buffId)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function LotusbattleprepareView:_clearBuffCell(cell)
	local btnIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(btnIcon)
end

function LotusbattleprepareView:_updatePetCell(view, cell, creepsCfgGroup, tag)
	local btnIcon1 = Framework.ButtonAdapter.GetFrom(cell.gameObject, "petcell_1/con")
	local btnIcon2 = Framework.ButtonAdapter.GetFrom(cell.gameObject, "petcell_2/con")
	local goPetcell_2 = goutil.findChild(cell.gameObject, "petcell_2")
	local tCreepsCfg = creepsCfgGroup[1]
	local dCreepsCfg = creepsCfgGroup[2]

	self:_updatePetCellSub(btnIcon1, tCreepsCfg)
	self:_updatePetCellSub(btnIcon2, dCreepsCfg)
	goutil.setActive(goPetcell_2, dCreepsCfg)
end

function LotusbattleprepareView:_updatePetCellSub(btnIcon, creepsCfg)
	uGuiUtil.clearImage(btnIcon.gameObject)

	if not creepsCfg then
		return
	end

	local modelCo = CharacterConfig.instance:getModelCo(creepsCfg.raceId)
	local spriteName = GameUrl.getCharacterIconUrl(modelCo.headName)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local mo = LotusbattleModel.instance:getPetMoByCreepsId(creepsCfg.creepsId)

		CommonTipsMgr.instance:showPetTips(mo)
	end)
end

function LotusbattleprepareView:_clearPetCell(cell)
	local btnIcon1 = goutil.findChild(cell.gameObject, "petcell_1/con")
	local btnIcon2 = goutil.findChild(cell.gameObject, "petcell_2/con")

	uGuiUtil.clearImage(btnIcon1)
	uGuiUtil.clearImage(btnIcon2)
end

function LotusbattleprepareView:_updateRankCell(view, cell, data, tag)
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goMyTag = goutil.findChild(cell.gameObject, "myTag")
	local txtKill = goutil.findChildTextComponent(cell.gameObject, "txtKill")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	HeadItemController.instance:resetHeadCell(goHead)

	local killNum = 0

	if data.isMe then
		HeadItemController.instance:setMyHeadCell(goHead)

		txtName.text = RoleModel.instance:getUserName()
		killNum = LotusbattleModel.instance:getKillNum()
	else
		HeadItemController.instance:setHeadCellByInfo(goHead, data.headInfo)

		txtName.text = data.headInfo.userName
		killNum = data.killNum
	end

	txtKill.text = string.format("击杀:<color=#ffa251>%s</color>", killNum)
end

function LotusbattleprepareView:_clearRankCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHead)
end

function LotusbattleprepareView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self:_setTime(leftTime)

	if leftTime <= 0 then
		FloatWordMgr.instance:show("强制进入匹配队列")
		self:_onClickbtnChallenge()
		removetimer(self._tick, self)

		return
	end
end

function LotusbattleprepareView:_setTime(leftTime)
	self._txtTime.text = self._timeType == LotusbattleprepareView.TimeType.CountDown and string.format("倒计时：%s", leftTime) or "等待匹配中"
end

function LotusbattleprepareView:_setModel()
	local modelId = LotusbattleModel.instance:getModelId()
	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)

	self._modeImgNum:SetNum(modelCfg.memberNum)
end

function LotusbattleprepareView:_calTargetTickTime()
	local forceMathTime = LotusbattleConfig.instance:getStageTime(self._activityId, "forceMatchTime")

	self._targetTickTime = ServerTime.now() + forceMathTime

	local nextForceTime = LotusbattleModel.instance:getNextForceTime()

	if nextForceTime > 0 and nextForceTime < self._targetTickTime then
		self._targetTickTime = nextForceTime
	end
end

function LotusbattleprepareView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_qiecuojiemian_fengwei.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function LotusbattleprepareView:_tickPlayPkEffect()
	self:_checkCanvasGroup(self._pk1Canvas, "_pk1Alpha", self._pk1_effectGo)
	self:_checkCanvasGroup(self._pk2Canvas, "_pk2Alpha", self._pk2_effecrGo)
end

function LotusbattleprepareView:_checkCanvasGroup(canvasGroup, alphaAttrName, effectRoot)
	if canvasGroup.alpha > self[alphaAttrName] and canvasGroup.alpha >= 0.8 then
		self:_playPkEffect(effectRoot)
	end

	self[alphaAttrName] = canvasGroup.alpha
end

function LotusbattleprepareView:_playPkEffect(effectRoot)
	local data = self._pkEffectHandlers[effectRoot]

	if data and data.isPlaying then
		return
	end

	local handler = data and data.handler

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_qiecuojiemian_zhuanji.prefab"

	handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, function()
		self._pkEffectHandlers[effectRoot].isPlaying = false
	end)

	handler:setParent(effectRoot.transform)
	handler:setLocalPos(18, 49, 0)
	handler:setScale(1)

	self._pkEffectHandlers[effectRoot] = {
		isPlaying = true,
		handler = handler
	}
end

return LotusbattleprepareView
