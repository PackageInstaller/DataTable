-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengeFmtExView.lua

module("logic.extensions.xuchallenge.view.XuChallengeFmtExView", package.seeall)

local XuChallengeFmtExView = class("XuChallengeFmtExView", ViewComponent)

function XuChallengeFmtExView:buildUI()
	XuChallengeFmtExView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._defaultShowPos = GameUtil.getAnchoredPos(self._moveNode) or Vector2.New(-110, 80)
	self._txtTips = self:getTxt("moveNode/txtTips")
	self._petView = self:getGo("moveNode/petView")
	self._petCell = self:getGo("moveNode/petCell")
	self._petRecordPos = self._petView:GetComponent(ComponentType.TestRecordPos)
	self._btnSure = self:getGo("moveNode/btnSure")
end

function XuChallengeFmtExView:bindEvents()
	XuChallengeFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function XuChallengeFmtExView:unbindEvents()
	XuChallengeFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)
	GameUtil.rmClickHandler(self._btnSure)
end

function XuChallengeFmtExView:onEnter()
	XuChallengeFmtExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1] or self:getFirstParam()

	if self._fmtMo == nil then
		return
	end

	self._activityId = self._fmtMo:getActivityId()
	self._challengeStageId = self._fmtMo:getStageId()
	self._subMo = XuChallengeController.instance:getSubMo(self._activityId)
	self._challengeStageData = XuChallengeConfig.instance:getStageData(self._activityId, self._challengeStageId)
	self._maxSacrificeCount = checknumber(self._challengeStageData and self._challengeStageData.canSacrificeStageNum)
	self._selectedStageId = 0
	self._isPopupState = true

	self:_initMoveNodePos()
	goutil.setActive(self._btnHide.gameObject, true)
	self.addGEvent(self, GlobalNotify.XuChallengePreviewSacrificeChanged, self._onPreviewSacrificeChanged, self)
	self:_onUpdate()
end

function XuChallengeFmtExView:onExit()
	XuChallengeFmtExView.super.onExit(self)
	self:_stopTween()
	self:_resetMoveNode()
	self:_clearPetCol()
end

function XuChallengeFmtExView:_onUpdate()
	self._petDataList = self:_buildPetDataList()

	self:_refreshSelectedStageId()
	self:_updateTips()
	self:_updatePetCol()
end

function XuChallengeFmtExView:_onPreviewSacrificeChanged()
	if self._fmtMo then
		self._fmtMo:refreshPreviewSacrificeState()
	end

	self:_onUpdate()
end

function XuChallengeFmtExView:_buildPetDataList()
	local result = {}

	for _, stageId in ipairs(self._subMo:getStageIds() or {}) do
		local raceId = checknumber(self._subMo:getBindRaceId(stageId))

		if raceId > 0 then
			local previewRaceId = checknumber(self._subMo:getPreviewRaceIdByStageId(stageId))

			table.insert(result, {
				stageId = stageId,
				raceId = raceId,
				previewRaceId = previewRaceId,
				isSacrifice = previewRaceId > 0 and previewRaceId ~= raceId
			})
		end
	end

	return result
end

function XuChallengeFmtExView:_refreshSelectedStageId()
	if checknumber(self._selectedStageId) <= 0 then
		self._selectedStageId = 0

		return
	end

	for _, data in ipairs(self._petDataList or {}) do
		if data.stageId == self._selectedStageId then
			return
		end
	end

	self._selectedStageId = 0
end

function XuChallengeFmtExView:_updateTips()
	local curCount = self._subMo:getPreviewSacrificeCount()

	self._txtTips.text = string.format("最多可献祭（%s/%s）只精灵", curCount, self._maxSacrificeCount)
end

function XuChallengeFmtExView:_updatePetCol()
	GameUtil.updateCellsList(self._petView, self._petCell, self._petDataList, self._updatePetCell, self)

	if self._petRecordPos then
		self._petRecordPos:LoadPlan(0)
	end
end

function XuChallengeFmtExView:_clearPetCol()
	GameUtil.clearCells(self._petView, self._clearPetCell, self)
end

function XuChallengeFmtExView:_updatePetCell(mainGo, data)
	local img = goutil.findChild(mainGo, "img")
	local icon = goutil.findChild(mainGo, "icon")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local tagSacrifice = goutil.findChild(mainGo, "tagSacrifice")

	MaterialMgr.clearIcon(icon)
	MaterialMgr.setIcon(icon, MatType.Pet, data.raceId)
	GameUtil.SetActive(tagSelect, data.stageId == self._selectedStageId)
	GameUtil.SetActive(tagSacrifice, data.isSacrifice)
	GameUtil.rmClickHandler(img)
	GameUtil.rmClickHandler(mainGo)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPetCell, self, data))
end

function XuChallengeFmtExView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local img = goutil.findChild(mainGo, "img")
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.rmClickHandler(img)
	GameUtil.rmClickHandler(mainGo)
	MaterialMgr.clearIcon(icon)
end

function XuChallengeFmtExView:_getSelectedData()
	for _, data in ipairs(self._petDataList or {}) do
		if data.stageId == self._selectedStageId then
			return data
		end
	end

	return nil
end

function XuChallengeFmtExView:_clearPreviewSacrifice()
	for _, data in ipairs(self._subMo:getPreviewStageToRaceIds() or {}) do
		self._subMo:setPreviewRaceIdByStageId(self._challengeStageId, data.stageId, 0)
	end
end

function XuChallengeFmtExView:_openPetSacrificeView(stageId)
	UIStateManager.instance:push(ViewName.XuChallengePetSacrificeView, self._activityId, self._challengeStageId, stageId)
end

function XuChallengeFmtExView:_onClickPetCell(data)
	self._selectedStageId = data.stageId

	self:_updatePetCol()
end

function XuChallengeFmtExView:_onClickBtnSure()
	local data = self:_getSelectedData()

	if data == nil then
		FloatWordMgr.instance:show("请选择献祭精灵")

		return
	end

	if self._maxSacrificeCount <= 0 then
		FloatWordMgr.instance:show("本关不可献祭精灵")

		return
	end

	if data.isSacrifice then
		self:_openPetSacrificeView(data.stageId)

		return
	end

	if self._subMo:getPreviewSacrificeCount() >= self._maxSacrificeCount then
		TipsFacade.instance:openPopupWindow("提示", "本次献祭精灵数量已达上限，是否取消当前已选择的献祭精灵并改为该精灵？", function()
			self:_clearPreviewSacrifice()
			GlobalDispatcher:dispatch(GlobalNotify.XuChallengePreviewSacrificeChanged)
			self:_openPetSacrificeView(data.stageId)
		end, nil, "确定", "取消")

		return
	end

	self:_openPetSacrificeView(data.stageId)
end

function XuChallengeFmtExView:_stopTween()
	if self._moveNode then
		UnityTweens.TweenPosition.StopTween(self._moveNode)
	end

	if self._arrowRectTrans then
		UnityTweens.TweenRotate.StopTween(self._arrowRectTrans)
	end
end

function XuChallengeFmtExView:_initMoveNodePos()
	if self._defaultShowPos == nil then
		local pos = GameUtil.getAnchoredPos(self._moveNode) or Vector2.New(-110, 80)

		if pos.x >= 300 then
			pos = Vector2.New(-110, pos.y)
		end

		self._defaultShowPos = pos
	end

	self._showPos = Vector2.New(self._defaultShowPos.x, self._defaultShowPos.y)
	self._hidePos = Vector2.New(400, self._showPos.y)

	self:_resetMoveNode()
end

function XuChallengeFmtExView:_resetMoveNode()
	if self._moveNode and self._showPos then
		Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, self._showPos.x, self._showPos.y)
	end

	if self._arrowRectTrans then
		Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
	end
end

function XuChallengeFmtExView:_getMoveNodePos()
	local pos = GameUtil.getAnchoredPos(self._moveNode)

	return Vector3.New(pos.x, pos.y, 0)
end

function XuChallengeFmtExView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, self:_getMoveNodePos(), Vector3.New(self._hidePos.x, self._hidePos.y, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function XuChallengeFmtExView:_onClickArrow()
	if self._isPopupState then
		self:_onClickHide()
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, self:_getMoveNodePos(), Vector3.New(self._showPos.x, self._showPos.y, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

return XuChallengeFmtExView
