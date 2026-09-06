-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/puzzlegame/view/PuzzleGameHudView.lua

module("logic.extensions.puzzlegame.view.PuzzleGameHudView", package.seeall)

local PuzzleGameHudView = class("PuzzleGameHudView", ViewComponent)

function PuzzleGameHudView:buildUI()
	PuzzleGameHudView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
end

function PuzzleGameHudView:bindEvents()
	PuzzleGameHudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function PuzzleGameHudView:unbindEvents()
	PuzzleGameHudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function PuzzleGameHudView:onEnter()
	PuzzleGameHudView.super.onEnter(self)

	local data = self:getFirstParam()
	local actId = 0

	actId = type(data) == "string" and checkint(data) or data and checkint(data.params[1]) or 0

	print(">>>>>>>>>>>>>>>>>>>>>预告id", actId)

	if actId > 0 and ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PuzzleGameHud, actId) then
		PuzzleGameModel.instance:setActId(actId)
		self:refreshViewByCfg()
		PuzzleGameController.instance:getInfo(self._actId)
		self:_onRefreshByInfo()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	GlobalDispatcher:addListener(GlobalNotify.PuzzleGameHudGetInfo, self._onRefreshByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.PuzzleGameHudGainProgressPrize, self._refreshProgress, self)
end

function PuzzleGameHudView:onExit()
	PuzzleGameHudView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PuzzleGameHudGetInfo, self._onRefreshByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.PuzzleGameHudGainProgressPrize, self._refreshProgress, self)
	self._playerSliderMo:onExit()
end

function PuzzleGameHudView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "puzzlegamehudview")
end

function PuzzleGameHudView:_onRefreshByInfo()
	self._hasLoginDay = PuzzleGameModel.instance:getCurLoginDay()
	self._hasFinishPuzzleIds = PuzzleGameModel.instance:getHasFinishPuzzleIds()

	self:_updataList()
	self:_refreshProgress()
end

function PuzzleGameHudView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtName.text = data.name

	local isLoginLock = self._hasLoginDay < data.jigsawId

	if data.jigsawId % 2 == 1 then
		GameUtil.setAnchoredPos(cell.con, 0, -24)
	else
		GameUtil.setAnchoredPos(cell.con, 0, 0)
	end

	local isTimeLock = GameUtil.string2time(data.startTime) - ServerTime.now() > 0

	GameUtil.addClickHandler(cell.btnUnlock, GameUtil.handler(self._onClickGame, self, data))

	local isRealLock = isLoginLock or isTimeLock

	if isRealLock then
		GameUtil.SetActive(cell.markLock, true)
	else
		GameUtil.SetActive(cell.btnUnlock, not table.keyof(self._hasFinishPuzzleIds, data.jigsawId))
	end

	GameUtil.addClickHandler(cell.con, function()
		if isRealLock then
			FloatWordMgr.instance:show("明日登录后解锁拼图")
		else
			self:_onClickGame(data)
		end
	end)

	if not string.nilorempty(data.picPath) then
		local path = GameUrl.getBonusIconUrl(data.picPath)
		local grayPath = GameUrl.getBonusIconUrl(data.grayIcon)

		uGuiUtil.setSpriteToImage(cell.imgBg, uGuiUtil.SpriteType.BigBg, path)
		uGuiUtil.setSpriteToImage(cell.markLock, uGuiUtil.SpriteType.BigBg, grayPath)
	end
end

function PuzzleGameHudView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.con = goutil.findChild(cell.go, "con")
	cell.markLock = goutil.findChild(cell.con, "maskLock")
	cell.btnUnlock = goutil.findChild(cell.con, "btnUnlock")
	cell.txtName = goutil.findChildTextComponent(cell.con, "name/txtName")

	GameUtil.SetActive(cell.markLock, false)
	GameUtil.SetActive(cell.btnUnlock, false)
	GameUtil.rmClickHandler(cell.btnUnlock)
	GameUtil.rmClickHandler(cell.con)

	cell.imgBg = goutil.findChild(cell.con, "imgBg")

	uGuiUtil.clearImage(cell.imgBg)
	uGuiUtil.clearImage(cell.markLock)

	return cell
end

function PuzzleGameHudView:_updataList()
	local dataList = self:_getCurDataList()

	self._tableView:reloadData(dataList)
end

function PuzzleGameHudView:_getCurDataList()
	if not self._puzzleCfgs then
		return self._puzzleCfgs
	end
end

function PuzzleGameHudView:refreshViewByCfg()
	self._actId = PuzzleGameModel.instance:getActId()
	self._progressCfgs = PuzzleGameConfig.instance:getProgressCfgs(self._actId)
	self._puzzleCfgs = PuzzleGameConfig.instance:getPuzzleCfgs(self._actId)

	self:_initPlayerParams()
end

function PuzzleGameHudView:_refreshProgress()
	self._playerSliderMo:updatePlayerReward()
end

function PuzzleGameHudView:_onClickGame(data)
	if PuzzleGameModel.instance:isPassPuzzle(data.jigsawId) then
		UIStateManager.instance:push(ViewName.PuzzleHudGameView, data, true)
	else
		UIStateManager.instance:push(ViewName.PuzzleHudGameView, data, false)
	end
end

function PuzzleGameHudView:_initPlayerParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._progressCfgs

	function playerParam.getPlayerProgress()
		return table.nums(PuzzleGameModel.instance:getHasFinishPuzzleIds())
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.finishedNum
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return rewardCfg.finishedNum <= table.nums(PuzzleGameModel.instance:getHasFinishPuzzleIds()) and not table.keyof(PuzzleGameModel.instance:getHagGainPrizes(), rewardCfg.progressId)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return table.keyof(PuzzleGameModel.instance:getHagGainPrizes(), rewardCfg.progressId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		PuzzleGameController.instance:gainProgressPrize(rewardCfg)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

return PuzzleGameHudView
