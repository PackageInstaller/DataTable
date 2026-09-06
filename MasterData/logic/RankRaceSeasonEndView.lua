-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceSeasonEndView.lua

module("logic.extensions.rankrace.view.RankRaceSeasonEndView", package.seeall)

local RankRaceSeasonEndView = class("RankRaceSeasonEndView", TableViewComponent)

RankRaceSeasonEndView.MaxStartCount = 5

function RankRaceSeasonEndView:ctor()
	RankRaceSeasonEndView.super.ctor(self)
end

function RankRaceSeasonEndView:buildUI()
	RankRaceSeasonEndView.super.buildUI(self)

	self._fadeLeft = self:getGo("bg/fadeLeft")
	self._fadeRight = self:getGo("bg/fadeRight")
	self._txtSeason = self:getGo("txtSeason"):GetComponent("Text")
	self._txtSeasonTime = self:getGo("txtSeason/txtSeasonTime"):GetComponent("Text")
	self._widGrade = self:getGo("widGrade")
	self._imgStartBk = {}
	self._startWid = {}
	self._imgLevel = {}
	self._start = {}
	self._txtGrade = {}
	self._txtType = {}

	for i = 1, 2 do
		self._imgStartBk[i] = self:getGo("widGrade/imgStartBk_" .. i)
		self._imgLevel[i] = self:getGo("widGrade/imgStartBk_" .. i .. "/imgLevel"):GetComponent("UIImageSpriteChange")
		self._startWid[i] = self:getGo("widGrade/imgStartBk_" .. i .. "/startWid")
		self._start[i] = {}

		for j = 1, RankRaceSeasonEndView.MaxStartCount do
			self._start[i][j] = self:getGo("widGrade/imgStartBk_" .. i .. "/startWid/start_" .. j)
		end

		self._txtGrade[i] = self:getGo("widGrade/imgStartBk_" .. i .. "/txtGrade"):GetComponent("Text")
		self._txtType[i] = self:getGo("widGrade/imgStartBk_" .. i .. "/txtType"):GetComponent("Text")
	end

	self._btnConfirmGrade = self:getBtn("widGrade/btnConfirmGrade")
	self._txtConfirm = self:getGo("widGrade/btnConfirmGrade/txtConfirm"):GetComponent("Text")
	self._widReward = self:getGo("widReward")
	self._txtReward = self:getGo("widReward/txtReward"):GetComponent("Text")
	self._txtRemind = self:getGo("widReward/txtRemind"):GetComponent("Text")
	self._btnConfirmReward = self:getBtn("widReward/btnConfirmReward")
	self._txtConfirmReward = self:getGo("widReward/btnConfirmReward/txtConfirmReward"):GetComponent("Text")
	self._widNewSeason = self:getGo("widNewSeason")
	self._txtSeasonName = self:getGo("widNewSeason/txtSeasonName"):GetComponent("Text")
	self._txtNewSeasonTime = self:getGo("widNewSeason/txtNewSeasonTime"):GetComponent("Text")
	self._txtNewSeasonTime2 = self:getGo("widNewSeason/txtNewSeasonTime2"):GetComponent("Text")
	self._txtNewSeason = self:getGo("widNewSeason/txtNewSeason"):GetComponent("Text")
	self._btnConfirmNew = self:getBtn("widNewSeason/btnConfirmNew")
	self._txtConfirmNew = self:getGo("widNewSeason/btnConfirmNew/txtConfirmNew"):GetComponent("Text")
end

function RankRaceSeasonEndView:bindEvents()
	RankRaceSeasonEndView.super.bindEvents(self)
	self._btnConfirmGrade:AddClickListener(self._onClickBtnConfirmGrade, self)
	self._btnConfirmReward:AddClickListener(self._onClickBtnConfirmReward, self)
	self._btnConfirmNew:AddClickListener(self._onClickBtnConfirmNew, self)
end

function RankRaceSeasonEndView:unbindEvents()
	RankRaceSeasonEndView.super.unbindEvents(self)
	self._btnConfirmGrade:RemoveClickListener()
	self._btnConfirmReward:RemoveClickListener()
	self._btnConfirmNew:RemoveClickListener()
end

function RankRaceSeasonEndView:destroyUI()
	RankRaceSeasonEndView.super.destroyUI(self)
end

function RankRaceSeasonEndView:onEnter()
	RankRaceSeasonEndView.super.onEnter(self)
	self:_updateBaseTxtSeason()

	local _getOpenParam = self._viewPresentor:getOpenParam()

	if _getOpenParam and _getOpenParam[1] then
		if _getOpenParam[1] == -1 then
			self._lastClassicStar = 1
			self._realLastClassicStar = nil
		else
			self._lastClassicStar = _getOpenParam[1]
			self._realLastClassicStar = _getOpenParam[1]
		end
	else
		self._lastClassicStar = 1
		self._realLastClassicStar = nil
	end

	if _getOpenParam and _getOpenParam[2] then
		if _getOpenParam[2] == -1 then
			self._lastExtremeStar = 1
			self._realLastExtremeStar = nil
		else
			self._lastExtremeStar = _getOpenParam[2]
			self._realLastExtremeStar = _getOpenParam[2]
		end
	else
		self._lastExtremeStar = 1
		self._realLastExtremeStar = nil
	end

	self:_initRewardConfig(self._lastClassicStar, self._lastExtremeStar)

	local _configRankRaceLevelClass = RankRaceController.instance:getLevelInfoByCurStart(self._lastClassicStar)

	if _configRankRaceLevelClass then
		print("1044200312 if _configRankRaceLevelLimit then 3333333333333:", _configRankRaceLevelClass._bigLevel)

		if self._realLastClassicStar then
			self._txtGrade[1].text = _configRankRaceLevelClass._levelName

			self:_updateStartShow(1, _configRankRaceLevelClass._levelStart, _configRankRaceLevelClass._levelAllStart)
		else
			self._txtGrade[1].text = RankRaceConfig.instance:getWord(29)

			self._startWid[1].gameObject:SetActive(false)
		end

		uGuiUtil.setSpriteToImage(self._imgStartBk[1].gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevelClass._bigLevel))

		if _configRankRaceLevelClass._bigLevel >= 8 then
			self._imgLevel[1].gameObject:SetActive(false)
			self._startWid[1].gameObject:SetActive(false)
		else
			self._imgLevel[1]:SetState(_configRankRaceLevelClass._subLevel - 1)
		end
	else
		print("1044200312 if _configRankRaceLevelLimit then 444444444:", debug.traceback())
		self._imgStartBk[1].gameObject:SetActive(false)
	end

	local _configRankRaceLevelLimit = RankRaceController.instance:getLevelInfoByCurStart(self._lastExtremeStar)

	if _configRankRaceLevelLimit then
		print("1044200312 if _configRankRaceLevelLimit then 1111:", _configRankRaceLevelLimit._bigLevel)

		if self._realLastExtremeStar then
			self._txtGrade[2].text = _configRankRaceLevelLimit._levelName

			self:_updateStartShow(2, _configRankRaceLevelLimit._levelStart, _configRankRaceLevelLimit._levelAllStart)
		else
			self._txtGrade[2].text = RankRaceConfig.instance:getWord(29)

			self._startWid[2].gameObject:SetActive(false)
		end

		uGuiUtil.setSpriteToImage(self._imgStartBk[2].gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevelLimit._bigLevel))

		if _configRankRaceLevelLimit._bigLevel >= 8 then
			self._imgLevel[2].gameObject:SetActive(false)
			self._startWid[2].gameObject:SetActive(false)
		else
			self._imgLevel[2]:SetState(_configRankRaceLevelLimit._subLevel - 1)
		end
	else
		print("1044200312 if _configRankRaceLevelLimit then 222222:", debug.traceback())
		self._imgStartBk[2].gameObject:SetActive(false)
	end

	local startScale = 4

	for i = 1, 2 do
		UnityTweens.TweenScale.StartTween(self._imgStartBk[i], Vector3.New(startScale, startScale, startScale), Vector3.New(1, 1, 1), 0.2)
	end
end

function RankRaceSeasonEndView:onEnterFinished()
	RankRaceSeasonEndView.super.onEnterFinished(self)
end

function RankRaceSeasonEndView:onExit()
	RankRaceSeasonEndView.super.onExit(self)
	removetimer(self._showSecondWid, self)
	removetimer(self._showThirdWid, self)
	self:_clearBigbg()
end

function RankRaceSeasonEndView:onExitFinished()
	RankRaceSeasonEndView.super.onExitFinished(self)
end

function RankRaceSeasonEndView:_onClickBtnConfirmGrade()
	local tweenTime = 0.3

	UnityTweens.TweenPosition.StartTween(self._imgStartBk[1], Vector3.New(-250, 59, 0), Vector3.New(-1050, 59, 0), tweenTime)
	UnityTweens.TweenPosition.StartTween(self._imgStartBk[2], Vector3.New(250, 59, 0), Vector3.New(1050, 59, 0), tweenTime)
	settimer(tweenTime, self._showSecondWid, self, false)
end

function RankRaceSeasonEndView:_showSecondWid()
	removetimer(self._showSecondWid, self)
	self._widGrade.gameObject:SetActive(false)
	self._widReward.gameObject:SetActive(true)
end

function RankRaceSeasonEndView:_onClickBtnConfirmReward()
	local tweenTime = 0.3
	local startScale = 4

	UnityTweens.TweenScale.StartTween(self._txtNewSeason.gameObject, Vector3.New(startScale, startScale, startScale), Vector3.New(1, 1, 1), 0.2)
	settimer(tweenTime, self._showThirdWid, self, false)
end

function RankRaceSeasonEndView:_showThirdWid()
	removetimer(self._showThirdWid, self)
	self._fadeLeft.gameObject:SetActive(false)
	self._fadeRight.gameObject:SetActive(false)
	self._txtSeason.gameObject:SetActive(false)
	self._widReward.gameObject:SetActive(false)
	self._widNewSeason.gameObject:SetActive(true)
end

function RankRaceSeasonEndView:_onClickBtnConfirmNew()
	UIStateManager.instance:push(ViewName.RankRaceChooseView)
	self:close()
end

function RankRaceSeasonEndView:_updateBaseTxtSeason()
	local _preSeasonNum, _preYear, _preMonth = RankRaceController.instance:getPreSeasonNum()

	self._txtSeason.text = "S" .. _preSeasonNum

	local _lastMonthDay = os.date("%d", os.time({
		day = 0,
		year = _preYear,
		month = _preMonth + 1
	}))

	self._txtSeasonTime.text = _preYear .. "/" .. _preMonth .. "/01 ~ " .. _preYear .. "/" .. _preMonth .. "/" .. _lastMonthDay

	local _curSeasonNum, _curYear, _curMonth = RankRaceController.instance:getCurSeasonNum()

	self._txtNewSeason.text = "S" .. _curSeasonNum
	_lastMonthDay = os.date("%d", os.time({
		day = 0,
		year = _curYear,
		month = _curMonth + 1
	}))
	self._txtNewSeasonTime.text = _curYear .. "/" .. _curMonth .. "/01"
	self._txtNewSeasonTime2.text = _curYear .. "/" .. _curMonth .. "/" .. _lastMonthDay
end

function RankRaceSeasonEndView:_updateStartShow(_index, _curLightStartCount, _allStartCount)
	if not _curLightStartCount or not _allStartCount then
		return
	end

	if _curLightStartCount < 0 or _allStartCount < _curLightStartCount then
		return
	end

	for i = 1, _curLightStartCount do
		if not self._start[_index][i].activeSelf then
			self._start[_index][i].gameObject:SetActive(true)
		end

		uGuiUtil.setImageGrayStateRecursive(self._start[_index][i], false)
	end

	for i = _curLightStartCount + 1, _allStartCount do
		if not self._start[_index][i].activeSelf then
			self._start[_index][i].gameObject:SetActive(true)
		end

		uGuiUtil.setImageGrayStateRecursive(self._start[_index][i], true)
	end

	for i = _allStartCount + 1, RankRaceClassicsView.MaxStartCount do
		if self._start[_index][i].activeSelf then
			self._start[_index][i].gameObject:SetActive(false)
		end
	end

	if _allStartCount == 3 then
		GameUtil.setLocalPos(self._startWid[_index], 38, 0, 0)
	elseif _allStartCount == 4 then
		GameUtil.setLocalPos(self._startWid[_index], 17, 0, 0)
	elseif _allStartCount == 5 then
		GameUtil.setLocalPos(self._startWid[_index], 0, 0, 0)
	end
end

function RankRaceSeasonEndView:_initRewardConfig(_classStart, _limitStart)
	if not _classStart or not _limitStart then
		return
	end

	local _prizeData = ""
	local _configRankRaceLevelClass = RankRaceController.instance:getLevelInfoByCurStart(_classStart)

	if self._realLastClassicStar and _configRankRaceLevelClass then
		local _rewardConfig = RankRaceController.instance:getTaskRewardConfig(RankRaceController.TaskTypeSeason, RankRaceController.MatchTypeClassics)

		_prizeData = _rewardConfig[_configRankRaceLevelClass._bigLevel].levelPrize .. "#"
	end

	local _configRankRaceLevelLimit = RankRaceController.instance:getLevelInfoByCurStart(_limitStart)

	if self._realLastExtremeStar and _configRankRaceLevelLimit then
		local _rewardConfig = RankRaceController.instance:getTaskRewardConfig(RankRaceController.TaskTypeSeason, RankRaceController.MatchTypeLimit)

		_prizeData = _prizeData .. _rewardConfig[_configRankRaceLevelLimit._bigLevel].levelPrize
	end

	local _prizeArray = string.split(_prizeData, "#")

	self._curViewDatas = {}

	for i = 1, #_prizeArray do
		local _tagIndex = math.floor((i - 1) / 4) + 1

		self._curViewDatas[_tagIndex] = self._curViewDatas[_tagIndex] or ""
		self._curViewDatas[_tagIndex] = self._curViewDatas[_tagIndex] .. _prizeArray[i] .. "#"
	end

	for i = 1, #self._curViewDatas do
		self._curViewDatas[i] = string.sub(self._curViewDatas[i], 1, #self._curViewDatas[i] - 1)
	end

	self._tableview:ReloadData()
end

function RankRaceSeasonEndView:_getPath()
	return {
		cellPath = "widReward/sv_info/Viewport/Content/sv_item",
		viewPath = "widReward/sv_info"
	}
end

function RankRaceSeasonEndView:_cellSize()
	return 1130, 110
end

function RankRaceSeasonEndView:_updateCell(view, cell, data)
	local _prizeArray = string.split(data, "#")

	if _prizeArray then
		for i = 1, #_prizeArray do
			local _item = goutil.findChild(cell.gameObject, "item_" .. i)

			_item.gameObject:SetActive(true)
			MaterialMgr.resetAll(_item)

			if _prizeArray[i] and _prizeArray[i] ~= "" then
				local proxy = MaterialMgr.setCellByCfg(_prizeArray[i], _item)

				Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.8, 0.8, 1)
			end
		end
	end
end

function RankRaceSeasonEndView:_clearBigbg()
	if not self._imgStartBk then
		return
	end

	for i = 1, 2 do
		local bigImg = Framework.ImageBigBG.Get(self._imgStartBk[i])

		if bigImg then
			bigImg:ClearImage()
		end
	end
end

return RankRaceSeasonEndView
