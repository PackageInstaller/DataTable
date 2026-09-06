-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleMatchView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleMatchView", package.seeall)

local MahjongBattleMatchView = class("MahjongBattleMatchView", ViewComponent)

function MahjongBattleMatchView:ctor()
	MahjongBattleMatchView.super.ctor(self)
end

function MahjongBattleMatchView:unbindEvents()
	MahjongBattleMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function MahjongBattleMatchView:bindEvents()
	MahjongBattleMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancle, self)
end

function MahjongBattleMatchView:buildUI()
	MahjongBattleMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._txtTime = self:getTxt("matching/txtTime")
	self._btnCancel = self:getGo("matching/btnCancel")
	self._suc = self:getGo("suc")
	self._conLeft = self:getGo("suc/left")

	local goTabLeft = self:getGo("suc/left/tableview")
	local goCellLeft = self:getGo("suc/left/tableview/tablecell")

	self._tableviewLeft = ScrollerList.create(goTabLeft, goCellLeft, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtNameLeft = self:getTxt("suc/left/txtName")
	self._headLeft = self:getGo("suc/left/head")
	self._buffLeft = self:getGo("suc/left/buff")
	self._txtBuffLeft = self:getTxt("suc/left/buff/txt")
	self._picBuffLeft = self:getGo("suc/left/buff/icon/pic")
	self._conRight = self:getGo("suc/right")

	local goTabRight = self:getGo("suc/right/tableview")
	local goCellRight = self:getGo("suc/right/tableview/tablecell")

	self._tableviewRight = ScrollerList.create(goTabRight, goCellRight, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtNameRight = self:getTxt("suc/right/txtName")
	self._headRight = self:getGo("suc/right/head")
	self._buffRight = self:getGo("suc/right/buff")
	self._txtBuffRight = self:getTxt("suc/right/buff/txt")
	self._picBuffRight = self:getGo("suc/right/buff/icon/pic")
	self._txtTimerTips = self:getTxt("suc/txtTimerTips")
	self._aniNode = self:getGo("aniNode")
	self._goAnim = self:getResInstance(MahjongBattleMatchViewPresentor.AniSpine)

	goutil.addChildToParent(self._goAnim, self._aniNode)
end

function MahjongBattleMatchView:onExit()
	MahjongBattleMatchView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headLeft)
	HeadItemController.instance:resetHeadCell(self._headRight)
	self._tableviewLeft:dispose()
	self._tableviewRight:dispose()
	removetimer(self._updateTimer, self)
	removetimer(self._updateCloseTimer, self)
end

function MahjongBattleMatchView:onEnter()
	MahjongBattleMatchView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleMatchFightRes, self._handleGetNewMatch, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	local state = MahjongBattleModel.instance:getCurStateByActId(self._activityId)

	if state ~= MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION and state ~= MahjongBattleModel.PLAYER_STATE.WAITING_MATCH_OPPONENT then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)

		return
	end

	self:_startMatch()
	goutil.setActive(self._aniNode, false)
end

function MahjongBattleMatchView:_onClickCancle()
	self:close()
end

function MahjongBattleMatchView:_handleFail()
	FloatWordMgr.instance:show("匹配失败")
	self:close()
end

function MahjongBattleMatchView:_handleGetNewMatch()
	local opponent
	local buffIdMy = 0
	local buffIdOp = 0

	self._petMoListMy = {}
	self._petMoListOp = {}

	local baseInfo = MahjongBattleModel.instance:getBaseInfoByActId(self._activityId)

	if baseInfo then
		opponent = baseInfo.opponent

		if baseInfo.opponent then
			buffIdOp = opponent.summonBuff or 0

			local isMirror = checknumber(opponent.headInfo.userId) < 0

			if isMirror then
				local creepsMasterId = Mathf.Abs(checknumber(opponent.headInfo.userId))
				local masterCfgs = MahjongBattleConfig.instance:getCreepsCfgsById(creepsMasterId) or {}

				for _, masterCfg in ipairs(masterCfgs) do
					local fPowerPet = FightingPowerPetMo.New()

					fPowerPet:fromChallengeCreepCo(masterCfg)

					local petMo = fPowerPet:toBaseBagPetMo()

					if petMo then
						table.insert(self._petMoListOp, petMo)
					end
				end
			elseif not opponent.creepsInfos then
				local creepsInfos = {}

				for _, creepsInfo in ipairs(creepsInfos) do
					local petMo = MahjongBattleModel.instance:getPetMo(self._activityId, creepsInfo.creepsId, creepsInfo.awakenLevel)

					if petMo then
						table.insert(self._petMoListOp, petMo)
					end
				end
			end
		end

		local challengeInfo = baseInfo.challengeInfo

		if challengeInfo then
			buffIdMy = challengeInfo.selectSummonBuff or 0

			if not challengeInfo.creepsInfos then
				local creepsInfos = {}

				for _, creepsInfo in ipairs(creepsInfos) do
					local petMo = MahjongBattleModel.instance:getPetMo(self._activityId, creepsInfo.creepsId, creepsInfo.awakenLevel)

					if petMo then
						table.insert(self._petMoListMy, petMo)
					end
				end
			end
		end
	end

	if not opponent then
		return
	end

	removetimer(self._updateTimer, self)
	removetimer(self._updateCloseTimer, self)
	goutil.setActive(self._suc, false)
	goutil.setActive(self._matching, false)
	HeadItemController.instance:setMyHeadCell(self._headLeft)

	self._txtNameLeft.text = RoleModel.instance:getUserName()

	local opHeadInfo = opponent.headInfo

	if opHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(self._headRight, opHeadInfo)

		self._txtNameRight.text = opHeadInfo.userName

		self:_playAni()
	else
		goutil.setActive(self._matching, true)
	end

	self._tableviewLeft:reloadData(self._petMoListMy)
	self._tableviewRight:reloadData(self._petMoListOp)

	if buffIdMy > 0 then
		local buffCfg = MahjongBattleConfig.instance:getSummonBuffCfgById(self._activityId, buffIdMy)

		if buffCfg then
			local spriteName = GameUrl.getIconUrl(buffCfg.buffIcon)

			uGuiUtil.setSpriteToImage(self._picBuffLeft, nil, spriteName)

			self._txtBuffLeft.text = buffCfg.buffName

			goutil.setActive(self._buffLeft, true)
		else
			goutil.setActive(self._buffLeft, false)
		end
	else
		goutil.setActive(self._buffLeft, false)
	end

	if buffIdOp > 0 then
		local buffCfg = MahjongBattleConfig.instance:getSummonBuffCfgById(self._activityId, buffIdOp)

		if buffCfg then
			local spriteName = GameUrl.getIconUrl(buffCfg.buffIcon)

			uGuiUtil.setSpriteToImage(self._picBuffRight, nil, spriteName)

			self._txtBuffRight.text = buffCfg.buffName

			goutil.setActive(self._buffRight, true)
		else
			goutil.setActive(self._buffRight, false)
		end
	else
		goutil.setActive(self._buffRight, false)
	end
end

function MahjongBattleMatchView:_startMatch()
	goutil.setActive(self._suc, false)
	goutil.setActive(self._matching, true)
	goutil.setActive(self._aniNode, false)

	self._timer = 0
	self._timeCount = checkint(math.random(1, 4))
	self._failLimit = 10
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)

	settimer(1, self._updateTimer, self, true)
end

function MahjongBattleMatchView:_updateTimer()
	self._timer = self._timer + 1
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)

	if self._timer >= self._timeCount then
		MahjongBattleController.instance:matchOpponent(self._activityId)
	end

	if self._timer >= self._failLimit then
		self:_handleFail()
	end
end

function MahjongBattleMatchView:_playAni()
	removetimer(self._updateTimer, self)
	goutil.setActive(self._suc, true)

	self._closeTimer = 6

	self:_updateCloseTimer()
	settimer(1, self._updateCloseTimer, self, true)
	self:_playSpineAnim()
end

function MahjongBattleMatchView:_updateCloseTimer()
	self._closeTimer = self._closeTimer - 1

	if self._closeTimer > 0 then
		self._txtTimerTips.text = string.format("倒计时%d秒后自动关闭", self._closeTimer)
	else
		removetimer(self._updateCloseTimer, self)
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)
	end
end

function MahjongBattleMatchView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local proxy = MaterialMgr.setCellByMo(data, icon)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function MahjongBattleMatchView:_clearCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
end

function MahjongBattleMatchView:_playSpineAnim(finishFunc)
	if not self._goAnim then
		if finishFunc then
			GameUtil.callBack(finishFunc)
		end

		return
	end

	goutil.setActive(self._aniNode, true)
	RoleObjectPool.instance:playAnimation(self._goAnim, "idle", false, function()
		return
	end, true)
end

return MahjongBattleMatchView
