-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahLevelView.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahLevelView", package.seeall)

local OriginDragonNoahLevelView = class("OriginDragonNoahLevelView", ViewComponent)
local RoleWidthList = {
	893,
	449,
	325,
	-383
}
local RoleChangeArrowWidthList = {
	420,
	342
}
local ArrowWidthList = {
	526,
	110
}

function OriginDragonNoahLevelView:ctor()
	OriginDragonNoahLevelView.super.ctor(self)
end

function OriginDragonNoahLevelView:unbindEvents()
	OriginDragonNoahLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function OriginDragonNoahLevelView:bindEvents()
	OriginDragonNoahLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickBtnRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function OriginDragonNoahLevelView:buildUI()
	OriginDragonNoahLevelView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._aojiu = self:getGo("show/role/aojiu")
	self._noah = self:getGo("show/role/noah")
	self._txtDistance = self:getTxt("show/txtDistance")
	self._imgArrow = self:getGo("show/imgArrow")
	self._role = self:getGo("show/role")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtRuleDesc = self:getTxt("right/ScrollView/Viewport/Content")
	self._emptyPet = self:getGo("right/emptyPet")
	self._btnRule = self:getGo("right/btnRule")
	self._btnChallenge = self:getGo("right/btnChallenge")
	self._txtChallenge = self:getTxt("right/btnChallenge/txtChallenge")
	self._txtTotalMove = self:getTxt("right/txtTotalMove")
	self._tableviewBan = self:getGo("right/tableviewBan")
	self._tablecellBan = self:getGo("right/tableviewBan/tablecellBan")
	self._scrollListBan = ScrollerList.create(self._tableviewBan, self._tablecellBan, GameUtil.handler(self._updateCellBan, self), GameUtil.handler(self._clearCellBan, self))
end

function OriginDragonNoahLevelView:onExit()
	OriginDragonNoahLevelView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollListBan:dispose()

	if self._rotateSequenceAoJiu then
		self._rotateSequenceAoJiu:Kill(true)

		self._rotateSequenceAoJiu = nil
	end

	if self._moveSequenceAoJiu then
		self._moveSequenceAoJiu:Kill(true)

		self._moveSequenceAoJiu = nil
	end

	if self._rotateSequenceNoah then
		self._rotateSequenceNoah:Kill(true)

		self._rotateSequenceNoah = nil
	end

	if self._moveSequenceNoah then
		self._moveSequenceNoah:Kill(true)

		self._moveSequenceNoah = nil
	end

	if self._tweener then
		self._tweener:Kill(false)

		self._tweener = nil
	end
end

function OriginDragonNoahLevelView:onEnter()
	OriginDragonNoahLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDragonNoahClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDragonNoahClgResetRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 539001
	end

	self._actCfg = OriginDragonNoahConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = OriginDragonNoahConfig.instance:getStageCfgs(self._activityId)
	self._curSelectIdx = OriginDragonNoahController.instance:getLastStageId()
	self._rotateRate = 0.3
	self._moveRate = 1
	self._stopRate = 1
	self._rotateLeft = Vector3.New(0, 0, 5)
	self._rotateRight = Vector3.New(0, 0, -5)

	local aoJiuLocalX = GameUtil.getLocalPos(self._aojiu).x
	local noahLocalX = GameUtil.getLocalPos(self._noah).x

	self._totalDistance = noahLocalX - aoJiuLocalX
	self._isPlayingAnim = false

	self:_onSetUI()
	OriginDragonNoahController.instance:sendPM_OriginDragonNoahClgInfoReq(self._activityId)
end

function OriginDragonNoahLevelView:_onSetUI()
	self._txtRuleDesc.text = self._actCfg.ruleDesc

	self._scrollList:reloadData(self._stageCfgs)
end

function OriginDragonNoahLevelView:_tryPlayAnim()
	if self._rotateSequenceAoJiu then
		self._rotateSequenceAoJiu:Kill(true)

		self._rotateSequenceAoJiu = nil
	end

	if self._moveSequenceAoJiu then
		self._moveSequenceAoJiu:Kill(true)

		self._moveSequenceAoJiu = nil
	end

	if self._rotateSequenceNoah then
		self._rotateSequenceNoah:Kill(true)

		self._rotateSequenceNoah = nil
	end

	if self._moveSequenceNoah then
		self._moveSequenceNoah:Kill(true)

		self._moveSequenceNoah = nil
	end

	if self._tweener then
		self._tweener:Kill(false)

		self._tweener = nil
	end

	local noahPreScore, aoJiuPreScore = OriginDragonNoahController.instance:getRolePreScores()
	local noahCurScore, aoJiuCurScore = OriginDragonNoahModel.instance:getNoahAoJiuTotalScore(self._activityId)
	local noahPrePosX = self:_getScorePos(noahPreScore, OriginDragonNoahController.BuffIdx.noah)
	local aoJiuPrePosX = self:_getScorePos(aoJiuPreScore, OriginDragonNoahController.BuffIdx.aoJiu)
	local noahPosX = self:_getScorePos(noahCurScore, OriginDragonNoahController.BuffIdx.noah)
	local aoJiuPosX = self:_getScorePos(aoJiuCurScore, OriginDragonNoahController.BuffIdx.aoJiu)
	local isAtEdgeAoJiu = aoJiuPrePosX == aoJiuPosX and aoJiuPrePosX == self._actCfg.roleInitPos[OriginDragonNoahController.BuffIdx.noah]
	local preRoleWidth = self:_getRoleWidth(noahPreScore, aoJiuPreScore)
	local curRoleWidth = self:_getRoleWidth(noahCurScore, aoJiuCurScore)
	local duration = (aoJiuCurScore - checknumber(aoJiuPreScore)) * self._moveRate

	if aoJiuPreScore and aoJiuCurScore - checknumber(aoJiuPreScore) > 0 and not isAtEdgeAoJiu then
		self:_setRotateAnim()
		self:_setRoleWidthAnim(preRoleWidth, curRoleWidth, duration)
	else
		self:_setArrowWidth(curRoleWidth)
		GameUtil.setWidth(self._role, curRoleWidth)
	end
end

function OriginDragonNoahLevelView:_setCurPos()
	local noahCurScore, aoJiuCurScore = OriginDragonNoahModel.instance:getNoahAoJiuTotalScore(self._activityId)
	local curRoleWidth = self:_getRoleWidth(noahCurScore, aoJiuCurScore)

	self:_setArrowWidth(curRoleWidth)
	GameUtil.setWidth(self._role, curRoleWidth)
	OriginDragonNoahController.instance:setScore(aoJiuCurScore, OriginDragonNoahController.BuffIdx.aoJiu)
	OriginDragonNoahController.instance:setScore(noahCurScore, OriginDragonNoahController.BuffIdx.noah)
end

function OriginDragonNoahLevelView:_onUpdate()
	self._info = OriginDragonNoahModel.instance:getInfo(self._activityId)
	self._stageInfoMap = OriginDragonNoahModel.instance:getStageInfoMap(self._activityId)

	local leftDistance = OriginDragonNoahController.instance:getLeftScore(self._activityId)
	local curStageInfo = self._stageInfoMap[self._curSelectIdx]

	if curStageInfo then
		if not curStageInfo.lockRaceIds then
			local banRaceIds = {}

			if curStageInfo then
				if not curStageInfo.scores then
					local curScores = {}

					self._curStagePass = curStageInfo ~= nil
					self._txtChallenge.text = self._curStagePass and "重置本关" or "进入战斗"
					self._txtDistance.text = string.format("两者距离剩余<color=#20b376>%d</color>米", leftDistance)
					self._txtTotalMove.text = #curScores > 0 and string.format("诺亚：前进<color=#20b376>%d</color>米\n敖九：前进<color=#20b376>%d</color>米", curScores[1], curScores[2]) or string.format("暂无数据")

					GameUtil.SetActive(self._emptyPet, #banRaceIds <= 0)
					self._scrollListBan:setCenterMode(true)
					self._scrollList:reloadData(self._stageCfgs)
					self._scrollListBan:reloadData(banRaceIds)
					self:_tryPlayAnim()
				end
			end
		end
	end
end

function OriginDragonNoahLevelView:_updateCell(view, cell, data)
	local imgPet = goutil.findChild(cell, "imgPet")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local pass = goutil.findChild(cell, "pass")
	local txtNoah = goutil.findChildTextComponent(cell, "txtNoah")
	local txtAojiu = goutil.findChildTextComponent(cell, "txtAojiu")
	local creepsMasterId = data.creepsMasterId
	local firstRaceId = OriginDragonNoahConfig.instance:getCreepFirstRaceId(creepsMasterId)

	if self._stageInfoMap then
		local stageInfo = self._stageInfoMap[data.stageId]
		local noahScore = stageInfo and checknumber(stageInfo.scores[OriginDragonNoahController.BuffIdx.noah]) or 0
		local aoJiuScore = stageInfo and checknumber(stageInfo.scores[OriginDragonNoahController.BuffIdx.aoJiu]) or 0
		local hasPass = stageInfo ~= nil

		txtNoah.text = string.format("诺亚：前进<color=#20b376>%d米</color>", noahScore)
		txtAojiu.text = string.format("敖九：前进<color=#20b376>%d米</color>", aoJiuScore)

		MaterialMgr.setIcon(imgPet, MatType.Pet, firstRaceId, nil, nil)
		GameUtil.SetActive(pass, hasPass)
		GameUtil.SetActive(imgSelect, self._curSelectIdx == data.stageId)
		GameUtil.addClickHandler(cell, function()
			if self._tweener then
				self._tweener:Kill(false)

				self._tweener = nil
			end

			self:_setCurPos()

			self._curSelectIdx = data.stageId

			OriginDragonNoahController.instance:setLastStageId(self._curSelectIdx)
			self:_onUpdate()
		end, self)
	end
end

function OriginDragonNoahLevelView:_clearCell(cell)
	local imgPet = goutil.findChild(cell, "imgPet")

	GameUtil.rmClickHandler(cell)
	MaterialMgr.clearIcon(imgPet)
end

function OriginDragonNoahLevelView:_updateCellBan(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local petId = BagModel.instance:getMaxZdlPetIdByRaceId(data)
	local bagPetMo = BagPetsController.instance:getPet(petId)
	local proxy = MaterialMgr.setCellByMo(bagPetMo, pet)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end)
end

function OriginDragonNoahLevelView:_clearCellBan(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function OriginDragonNoahLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginDragonNoahLevelView:_onClickBtnRule()
	UIStateManager.instance:push(ViewName.OriginDragonNoahRulePopView, self._activityId)
end

function OriginDragonNoahLevelView:_onClickBtnChallenge()
	if self._stageInfoMap then
		local stageInfo = self._stageInfoMap[self._curSelectIdx]
		local hasPass = stageInfo ~= nil

		if hasPass then
			TipsFacade.instance:openPopupWindow("提示", "是否重置本关，清空前进记录，解除精灵封印", function()
				OriginDragonNoahController.instance:sendPM_OriginDragonNoahClgResetReq(self._activityId, self._curSelectIdx)
			end, nil, "确定", "取消")
		else
			OriginDragonNoahController.instance:enterBattleClg(self._activityId, self._curSelectIdx)
		end
	end
end

function OriginDragonNoahLevelView:_getScorePos(score, roleType)
	local noahPrePosX = self._actCfg.roleInitPos[OriginDragonNoahController.BuffIdx.noah]
	local aoJiuPrePosX = self._actCfg.roleInitPos[OriginDragonNoahController.BuffIdx.aoJiu]

	if score == nil then
		if roleType == OriginDragonNoahController.BuffIdx.noah then
			return noahPrePosX
		else
			return aoJiuPrePosX
		end
	end

	local totalDistance = aoJiuPrePosX - noahPrePosX
	local totalScore = self._actCfg.passScore
	local posX = 0
	local rate = score / totalScore

	if roleType == OriginDragonNoahController.BuffIdx.noah then
		if rate > 1 then
			return aoJiuPrePosX
		end

		posX = rate * totalDistance
	else
		if rate > 1 then
			return noahPrePosX
		end

		posX = (1 - rate) * totalDistance
	end

	return posX
end

function OriginDragonNoahLevelView:_getRoleWidth(scoreNoah, scoreAoJiu)
	if scoreNoah == nil or scoreAoJiu == nil then
		return RoleWidthList[1]
	end

	local targetScore = self._actCfg.passScore
	local totalScore = scoreNoah + scoreAoJiu

	if totalScore <= targetScore then
		local starWidth = RoleWidthList[1]
		local endWidth = RoleWidthList[2]
		local totalWidth = starWidth - endWidth
		local rate = totalWidth / targetScore
		local finalWidth = starWidth - rate * totalScore

		finalWidth = math.max(finalWidth, endWidth)

		return finalWidth
	else
		local starWidth = RoleWidthList[3]
		local endWidth = RoleWidthList[4]
		local totalWidth = starWidth - endWidth
		local extraScore = totalScore - targetScore
		local rate = totalWidth / targetScore
		local finalWidth = starWidth - rate * extraScore

		finalWidth = math.max(finalWidth, endWidth)

		return finalWidth
	end
end

function OriginDragonNoahLevelView:_setRoleWidthAnim(startWidth, endWidth, duration)
	local noahCurScore, aoJiuCurScore = OriginDragonNoahModel.instance:getNoahAoJiuTotalScore(self._activityId)

	self._tweener = TweenUtil.ValueTo(startWidth, endWidth, duration, function(val)
		self:_setArrowWidth(val)
		GameUtil.setWidth(self._role, val)
	end, function()
		OriginDragonNoahController.instance:setScore(aoJiuCurScore, OriginDragonNoahController.BuffIdx.aoJiu)
		OriginDragonNoahController.instance:setScore(noahCurScore, OriginDragonNoahController.BuffIdx.noah)

		if self._rotateSequenceNoah then
			self._rotateSequenceNoah:Kill(true)

			self._rotateSequenceNoah = nil
		end

		if self._rotateSequenceAoJiu then
			self._rotateSequenceAoJiu:Kill(true)

			self._rotateSequenceAoJiu = nil
		end

		if self._tweener then
			self._tweener:Kill(false)
		end

		self._tweener = nil
	end, self)
end

function OriginDragonNoahLevelView:_setRotateAnim()
	self._rotateSequenceNoah = DG.Tweening.DOTween.Sequence()
	self._rotateSequenceAoJiu = DG.Tweening.DOTween.Sequence()

	for i = 1, 6 do
		local rotateLeftTween = self._aojiu.transform:DORotate(self._rotateLeft, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)
		local rotateMiddleTween = self._aojiu.transform:DORotate(Vector3.zero, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)
		local rotateRightTween = self._aojiu.transform:DORotate(self._rotateRight, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)

		self._rotateSequenceAoJiu:Append(rotateLeftTween)
		self._rotateSequenceAoJiu:Append(rotateMiddleTween)
		self._rotateSequenceAoJiu:Append(rotateRightTween)
		self._rotateSequenceAoJiu:Append(rotateMiddleTween)
	end

	self._rotateSequenceAoJiu:SetLoops(-1)

	for i = 1, 6 do
		local rotateLeftTween = self._noah.transform:DORotate(self._rotateLeft, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)
		local rotateMiddleTween = self._noah.transform:DORotate(Vector3.zero, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)
		local rotateRightTween = self._noah.transform:DORotate(self._rotateRight, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)

		self._rotateSequenceNoah:Append(rotateLeftTween)
		self._rotateSequenceNoah:Append(rotateMiddleTween)
		self._rotateSequenceNoah:Append(rotateRightTween)
		self._rotateSequenceNoah:Append(rotateMiddleTween)
	end

	self._rotateSequenceNoah:SetLoops(-1)
end

function OriginDragonNoahLevelView:_setArrowWidth(curWidth)
	if curWidth > RoleChangeArrowWidthList[1] then
		local diffWidth = RoleWidthList[1] - curWidth
		local finalWidth = ArrowWidthList[1] - diffWidth

		finalWidth = math.max(finalWidth, ArrowWidthList[2])

		GameUtil.setWidth(self._imgArrow, finalWidth)
	elseif curWidth < RoleChangeArrowWidthList[2] then
		local diffWidth = RoleChangeArrowWidthList[2] - curWidth
		local finalWidth = ArrowWidthList[2] + diffWidth

		finalWidth = math.max(finalWidth, ArrowWidthList[2])

		GameUtil.setWidth(self._imgArrow, finalWidth)
	else
		GameUtil.setWidth(self._imgArrow, ArrowWidthList[2])
	end
end

return OriginDragonNoahLevelView
