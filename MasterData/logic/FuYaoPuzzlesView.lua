-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/view/FuYaoPuzzlesView.lua

module("logic.extensions.fuyao.view.FuYaoPuzzlesView", package.seeall)

local FuYaoPuzzlesView = class("FuYaoPuzzlesView", ViewComponent)

function FuYaoPuzzlesView:ctor()
	FuYaoPuzzlesView.super.ctor(self)
end

function FuYaoPuzzlesView:unbindEvents()
	FuYaoPuzzlesView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function FuYaoPuzzlesView:bindEvents()
	FuYaoPuzzlesView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
end

function FuYaoPuzzlesView:buildUI()
	FuYaoPuzzlesView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("info/btnChallenge")
	self._txtDesc = self:getTxt("info/txtDesc")

	local puzzleParent = self:getGo("puzzles")

	self._puzzleList = {}

	for i = 1, puzzleParent.transform.childCount do
		local puzzle = {}

		puzzle.go = goutil.findChild(puzzleParent, "puzzle_" .. i)
		puzzle.pass = goutil.findChild(puzzle.go, "pass")
		puzzle.mask = goutil.findChildImageComponent(puzzle.go, "mask")
		puzzle.canvas = puzzle.go:GetComponent("CanvasGroup")
		puzzle.name = goutil.findChildTextComponent(puzzle.go, "txt")
		self._puzzleList[i] = puzzle
	end

	self._drag = Framework.UIDragTrigger.Get(self:getGo("rayTrigger"))
	self._rewardViewGo = self:getGo("info/rewardview")
	self._rewardCell = self:getGo("info/rewardcell")
	self._rewardView = ScrollerList.create(self._rewardViewGo, self._rewardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FuYaoPuzzlesView:onExit()
	FuYaoPuzzlesView.super.onExit(self)

	self._puzzlesPosRec = nil

	self._rewardView:dispose()

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	removetimer(self._doMoveAnim, self)
	GlobalDispatcher:removeListener(GlobalNotify.FuyaoGetInfoRes, self._refresh, self)
end

function FuYaoPuzzlesView:onEnter()
	FuYaoPuzzlesView.super.onEnter(self)

	self._activityId = FuYaoModel.instance:getActivityId()
	self._fuyaoCommonCfg = FuYaoConfig.instance:getFuyaoCommonCfg(self._activityId)
	self._curSwithId = 1
	self._curPuzzlePass = false
	self._effectList = {}

	self:_initUI()
	self:_refresh()
	GlobalDispatcher:addListener(GlobalNotify.FuyaoGetInfoRes, self._refresh, self)
	FuYaoController.instance:sendPM_FuyaoGetInfoReq(self._activityId)
end

function FuYaoPuzzlesView:_initUI()
	for i = 1, #self._puzzleList do
		local cfg = self._fuyaoCommonCfg[i]

		self._puzzleList[i].name.text = cfg.name

		GameUtil.SetActive(self._puzzleList[i].cell, cfg)
	end

	self:_initPuzzles()
end

function FuYaoPuzzlesView:_initPuzzles()
	self._animInfoList = {
		{
			posY = -96,
			canvasAlpha = 1,
			maskAlpha = 0,
			alpha = 1,
			scale = 1,
			posX = -80
		},
		{
			posY = -90,
			canvasAlpha = 1,
			maskAlpha = 0.4,
			alpha = 1,
			scale = 0.8,
			posX = 114
		},
		{
			posY = -86,
			canvasAlpha = 0.7,
			maskAlpha = 0.7,
			alpha = 0.7,
			scale = 0.55,
			posX = 264
		},
		{
			posY = -84,
			canvasAlpha = 0.7,
			maskAlpha = 0.7,
			alpha = 0.7,
			scale = 0.45,
			posX = -548
		},
		{
			posY = -86,
			canvasAlpha = 0.7,
			maskAlpha = 0.4,
			alpha = 0.7,
			scale = 0.55,
			posX = -432
		},
		{
			posY = -90,
			canvasAlpha = 1,
			maskAlpha = 0.4,
			alpha = 1,
			scale = 0.8,
			posX = -278
		}
	}
	self._totalAnimCount = #self._animInfoList
	self._puzzlesPosRec = {}
end

function FuYaoPuzzlesView:_refresh()
	self._curSwithId = FuYaoController.instance:getFristNoPassId()

	self:_refreshUI()
	self:_refreshAnimPos()
end

function FuYaoPuzzlesView:_refreshUI()
	local creepsMasterId = self._fuyaoCommonCfg[self._curSwithId].creepsMasterId
	local prizeCfg = string.split(self._fuyaoCommonCfg[self._curSwithId].prize, "#")

	self._passPuzzles = FuYaoModel.instance:getPassPuzzles()
	self._curPuzzlePass = TableUtil.isHad(self._passPuzzles, self._curSwithId)
	self._txtDesc.text = FuYaoConfig.instance:getFuyaoMasterCfg(creepsMasterId).stageDesc

	GameUtil.SetActive(self._btnChallenge, not TableUtil.isHad(self._passPuzzles, self._curSwithId))
	self._rewardView:reloadData(prizeCfg)
end

function FuYaoPuzzlesView:_refreshAnimPos()
	for idx, puzzle in ipairs(self._puzzleList) do
		local animId = idx - self._curSwithId + 1

		if animId <= 0 then
			animId = animId + self._totalAnimCount
		end

		table.insert(self._puzzlesPosRec, animId)
		GameUtil.setLocalPos(puzzle.go, self._animInfoList[animId].posX, self._animInfoList[animId].posY, 0)
		GameUtil.setLocalScale(puzzle.go, self._animInfoList[animId].scale, self._animInfoList[animId].scale, 1)
		Game.ImageUtil.SetImageAlpha(puzzle.mask, self._animInfoList[animId].maskAlpha)

		puzzle.canvas.alpha = self._animInfoList[animId].canvasAlpha

		local cfg = self._fuyaoCommonCfg[self._curSwithId]

		if cfg then
			local isPass = TableUtil.isHad(self._passPuzzles, idx)

			GameUtil.SetActive(self._puzzleList[idx].pass, isPass)
		end
	end
end

function FuYaoPuzzlesView:_updateCell(view, cell, data)
	local cellGo = cell.gameObject

	MaterialMgr.setCellByCfg(data, goutil.findChild(cellGo, "con"))
	GameUtil.SetActive(goutil.findChild(cellGo, "recieve"), self._curPuzzlePass)
end

function FuYaoPuzzlesView:_clearCell(cell)
	local cellGo = cell.gameObject

	MaterialMgr.resetAll(cellGo)
	GameUtil.SetActive(goutil.findChild(cellGo, "recieve"), self._curPuzzlePass)
end

function FuYaoPuzzlesView:_onDrag(eventData)
	self._disMove = self._disMove + eventData.delta.x

	if self._ableToMove then
		if self._disMove > 100 then
			self:switchRight()

			self._ableToMove = false
		elseif self._disMove < -100 then
			self:switchLeft()

			self._ableToMove = false
		end
	end
end

function FuYaoPuzzlesView:_onBeginDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0
	self._ableToMove = true
end

function FuYaoPuzzlesView:_onEndDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0

	removetimer(self._doMoveAnim, self)

	self._ableToMove = false
end

function FuYaoPuzzlesView:_doMoveAnim()
	if self._curMoveStep > self._needMoveStep then
		self._curMoveStep = self._curMoveStep - 1

		self:switchLeft()
	elseif self._curMoveStep < self._needMoveStep then
		self._curMoveStep = self._curMoveStep + 1

		self:switchRight()
	end

	if self._curMoveStep == self._needMoveStep then
		removetimer(self._doMoveAnim, self)
	end
end

function FuYaoPuzzlesView:switchRight()
	for idx = 1, self._totalAnimCount do
		local animId = self._puzzlesPosRec[idx] + 1

		if animId > self._totalAnimCount then
			animId = 1
		end

		local puzzle = self._puzzleList[idx]
		local animParm = self._animInfoList[animId]
		local newPos = Vector3.New(animParm.posX, animParm.posY, 0)
		local tweenMove = puzzle.go.transform:DOLocalMove(newPos, 0.5):SetEase(DG.Tweening.Ease.Linear)
		local newScale = Vector3.New(animParm.scale, animParm.scale, animParm.scale)
		local tweenScale = puzzle.go.transform:DOScale(newScale, 0.5):SetEase(DG.Tweening.Ease.Linear)
		local newColor = Color.New(0, 0, 0, animParm.maskAlpha)
		local tweenColor = puzzle.mask:DOColor(newColor, 0.5)

		puzzle.canvas.alpha = animParm.canvasAlpha
		self._tweenList = self._tweenList or {}

		table.insert(self._tweenList, tweenMove)
		table.insert(self._tweenList, tweenScale)
		table.insert(self._tweenList, tweenColor)

		self._puzzlesPosRec[idx] = animId
	end

	self._curSwithId = self._curSwithId - 1

	if self._curSwithId <= 0 then
		self._curSwithId = self._totalAnimCount
	end

	self:_refreshUI()
end

function FuYaoPuzzlesView:switchLeft()
	for idx = 1, self._totalAnimCount do
		local animId = self._puzzlesPosRec[idx] - 1

		if animId <= 0 then
			animId = self._totalAnimCount
		end

		local puzzle = self._puzzleList[idx]
		local animParm = self._animInfoList[animId]
		local newPos = Vector3.New(animParm.posX, animParm.posY, 0)
		local tweenMove = puzzle.go.transform:DOLocalMove(newPos, 0.5):SetEase(DG.Tweening.Ease.Linear)
		local newScale = Vector3.New(animParm.scale, animParm.scale, animParm.scale)
		local tweenScale = puzzle.go.transform:DOScale(newScale, 0.5):SetEase(DG.Tweening.Ease.Linear)
		local newColor = Color.New(0, 0, 0, animParm.maskAlpha)
		local tweenColor = puzzle.mask:DOColor(newColor, 0.5)

		puzzle.canvas.alpha = animParm.canvasAlpha
		self._tweenList = self._tweenList or {}

		table.insert(self._tweenList, tweenMove)
		table.insert(self._tweenList, tweenScale)
		table.insert(self._tweenList, tweenColor)

		self._puzzlesPosRec[idx] = animId
	end

	self._curSwithId = self._curSwithId + 1

	if self._curSwithId > self._totalAnimCount then
		self._curSwithId = 1
	end

	self:_refreshUI()
end

function FuYaoPuzzlesView:_onClickChallenge()
	FuYaoController.instance:openChallengeForm(self._activityId, self._curSwithId, self._fuyaoCommonCfg[self._curSwithId].creepsMasterId, false)
end

return FuYaoPuzzlesView
