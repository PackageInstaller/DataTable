-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceHistoryView.lua

module("logic.extensions.rankrace.view.RankRaceHistoryView", package.seeall)

local RankRaceHistoryView = class("RankRaceHistoryView", TableViewComponent)

RankRaceHistoryView.TweenTime = 0.2

function RankRaceHistoryView:ctor()
	RankRaceHistoryView.super.ctor(self)
end

function RankRaceHistoryView:buildUI()
	RankRaceHistoryView.super.buildUI(self)

	self._btnClose = self:getBtn("topleft/btnClose")
end

function RankRaceHistoryView:bindEvents()
	RankRaceHistoryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function RankRaceHistoryView:unbindEvents()
	RankRaceHistoryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function RankRaceHistoryView:destroyUI()
	RankRaceHistoryView.super.destroyUI(self)
end

function RankRaceHistoryView:onEnter()
	RankRaceHistoryView.super.onEnter(self)

	self._curViewDatas = RankRaceController.instance:getArrangeSeasonData()

	self._tableview:ReloadData()
end

function RankRaceHistoryView:onEnterFinished()
	RankRaceHistoryView.super.onEnterFinished(self)
end

function RankRaceHistoryView:onExit()
	RankRaceHistoryView.super.onExit(self)

	self._curViewDatas = nil

	self._tableview:Travel(self._clearTableview, self)
end

function RankRaceHistoryView:onExitFinished()
	RankRaceHistoryView.super.onExitFinished(self)
end

function RankRaceHistoryView:_onClickBtnClose()
	self:close()
end

function RankRaceHistoryView:_getPath()
	return {
		cellPath = "sv_item",
		viewPath = "sv_info"
	}
end

function RankRaceHistoryView:_cellSize(view, idx)
	if not self._clickCellIndex then
		return 300, 550
	end

	if idx == self._clickCellIndex - 1 then
		return 760, 550
	else
		return 300, 550
	end
end

function RankRaceHistoryView:_updateCell(view, cell, data)
	local _imgBIGradeBgCover = goutil.findChild(cell.gameObject, "btnSeasonCard/imgBIGradeBg")
	local _imgBIGradeCover = goutil.findChild(cell.gameObject, "btnSeasonCard/imgBIGrade"):GetComponent("UIImageSpriteChange")
	local _txtBIGradeNameCover = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/txtBIGradeName", "Text")
	local _gradeStartCover = {}

	for i = 1, 3 do
		_gradeStartCover[i] = goutil.findChild(cell.gameObject, "btnSeasonCard/txtBIGradeName/gradeStart_" .. i)
	end

	local _txtHide = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/txtHide", "Text")

	_txtHide.gameObject:SetActive(false)

	local _txtMatchName = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/txtMatchName", "Text")
	local _txtTime = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/txtTime", "Text")

	if data._classData then
		if not data._classData.matchSeasonId then
			local _showPage = true

			_showPage = data._limitData

			if data._limitData then
				local _seasonId = data._limitData.matchSeasonId
				local _seasonNum, _seasonYear, _seasonMonth = RankRaceController.instance:getSeasonNumBySeasonId(_seasonId)

				_txtMatchName.text = "S" .. _seasonNum
				_txtTime.text = _seasonYear .. "-" .. _seasonMonth

				local isShowScore = checknumber(_seasonId) >= 20232500

				if data._classData then
					if not data._classData.star then
						local _start = RankRaceController.BeginStart
						local _configRankRaceLevelCover = RankRaceController.instance:getLevelInfoByCurStart(_start)

						if _configRankRaceLevelCover then
							_txtBIGradeNameCover.text = _configRankRaceLevelCover._levelName

							uGuiUtil.setSpriteToImage(_imgBIGradeBgCover.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevelCover._bigLevel))
							_imgBIGradeBgCover.gameObject:SetActive(true)
							_imgBIGradeCover:SetState(_configRankRaceLevelCover._subLevel - 1)

							if _configRankRaceLevelCover._bigLevel >= 8 then
								for i = 1, 3 do
									_gradeStartCover[i].gameObject:SetActive(false)
								end
							else
								self:_updateStartShow(_configRankRaceLevelCover._levelStart, _configRankRaceLevelCover._levelAllStart, _gradeStartCover)
							end
						end

						local _imgInfoBk = goutil.findChild(cell, "btnSeasonCard/imgInfoBk")
						local _txtBottomInfo = {}
						local _imgBIGradeBg = {}
						local _imgBIGrade = {}
						local _txtBIFightCountValue = {}
						local _txtBIFightWinRateValue = {}
						local _txtBILegend = {}
						local _txtBILegendValue = {}
						local _txtBIGradeName = {}
						local _gradeStart = {}
						local _txtScores = {}

						for i = 1, 2 do
							local tempData = i == 1 and data._classData or data._limitData

							_txtBottomInfo[i] = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i, "Text")
							_txtBottomInfo[i].text = RankRaceConfig.instance:getWord(i)
							_imgBIGradeBg[i] = goutil.findChild(cell, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/imgBIGradeBg")
							_imgBIGrade[i] = goutil.findChild(cell, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/imgBIGrade"):GetComponent("UIImageSpriteChange")
							_txtBIFightCountValue[i] = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/txtBIFightCount/txtBIFightCountValue", "Text")

							if tempData then
								_txtBIFightCountValue[i].text = tempData.total or 0
							end

							_txtBIFightWinRateValue[i] = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/txtBIFightWinRate/txtBIFightWinRateValue", "Text")
							_txtBIFightWinRateValue[i].text = "0%"

							if not tempData or tempData and tempData.total == 0 then
								-- block empty
							else
								_txtBIFightWinRateValue[i].text = math.floor(tempData.wins / tempData.total * 100) .. "%"
							end

							_txtBILegend[i] = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/txtBILegend", "Text")
							_txtBILegendValue[i] = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/txtBILegend/txtBILegendValue", "Text")
							_txtBIGradeName[i] = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/txtBIGradeName", "Text")
							_txtScores[i] = goutil.findChildComponent(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/txtScore", "Text")
							_gradeStart[i] = {}

							for j = 1, 3 do
								_gradeStart[i][j] = goutil.findChild(cell.gameObject, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/txtBIGradeName/gradeStart_" .. j)
							end

							if not tempData or tempData and tempData.rank <= 0 then
								_txtBILegendValue[i].text = RankRaceConfig.instance:getWord(22)
							elseif tempData then
								_txtBILegendValue[i].text = tempData.rank or 0
							end

							if tempData then
								local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(tempData.star or RankRaceController.BeginStart)

								if _configRankRaceLevel then
									_txtBIGradeName[i].text = _configRankRaceLevel._levelName

									uGuiUtil.setSpriteToImage(_imgBIGradeBg[i].gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))
									_imgBIGradeBg[i].gameObject:SetActive(true)
									_imgBIGrade[i]:SetState(_configRankRaceLevel._subLevel - 1)

									if _configRankRaceLevel._bigLevel >= 8 then
										for j = 1, 3 do
											_gradeStart[i][j].gameObject:SetActive(false)
										end

										_txtScores[i].text = isShowScore and string.format("%s积分", tempData.legendRankScore) or ""
									else
										self:_updateStartShow(_configRankRaceLevel._levelStart, _configRankRaceLevel._levelAllStart, _gradeStart[i])

										_txtScores[i].text = ""
									end
								end
							end
						end

						if self._clickCellIndex then
							if data._id ~= self._clickCellIndex then
								_showPage = false
							end

							GameUtil.setWidth(_imgInfoBk, _showPage and 460 or 0)

							for i = 1, 2 do
								_txtBottomInfo[i].gameObject:SetActive(_showPage)
							end

							_txtHide.gameObject:SetActive(_showPage)

							if _showPage then
								self._imgInfoBkRecord = {
									_imgInfoBk = _imgInfoBk,
									_txtBottomInfo = _txtBottomInfo,
									_txtHide = _txtHide
								}
							end

							Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSeasonCard"):AddClickListener(function()
								if not self._timestamp or self._timestamp < os.clock() * 1000 - (RankRaceHistoryView.TweenTime * 1000 + 100) then
									self._timestamp = os.clock() * 1000

									if self._imgInfoBkRecord then
										GameUtil.setWidth(self._imgInfoBkRecord._imgInfoBk, 0)

										for i = 1, 2 do
											self._imgInfoBkRecord._txtBottomInfo[i].gameObject:SetActive(false)
										end

										self._imgInfoBkRecord._txtHide.gameObject:SetActive(false)
									end

									if self._clickCellIndex and self._clickCellIndex == data._id then
										self._clickCellIndex = nil
									else
										self._clickCellIndex = data._id
									end

									self._tableview:ReloadData()
								end
							end, self)
						end
					end
				end
			end
		end
	end
end

function RankRaceHistoryView:_updateStartShow(_curLightStartCount, _allStartCount, _startObj)
	if not _curLightStartCount or not _allStartCount then
		return
	end

	if _curLightStartCount < 0 or _allStartCount < _curLightStartCount then
		return
	end

	for i = 1, _curLightStartCount do
		uGuiUtil.setImageGrayStateRecursive(_startObj[i], false)
	end

	for i = _curLightStartCount + 1, _allStartCount do
		uGuiUtil.setImageGrayStateRecursive(_startObj[i], true)
	end
end

function RankRaceHistoryView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSeasonCard"):RemoveClickListener()

	local _imgBIGradeBgCover = goutil.findChild(cell.gameObject, "btnSeasonCard/imgBIGradeBg")
	local bigImg = Framework.ImageBigBG.Get(_imgBIGradeBgCover)

	if bigImg then
		bigImg:ClearImage()
	end

	local _imgBIGradeBg = {}

	for i = 1, 2 do
		_imgBIGradeBg[i] = goutil.findChild(cell, "btnSeasonCard/imgInfoBk/txtBottomInfo_" .. i .. "/imgBIGradeBg")

		local _imgBIGradeBgBigbg = Framework.ImageBigBG.Get(_imgBIGradeBg[i])

		if _imgBIGradeBgBigbg then
			_imgBIGradeBgBigbg:ClearImage()
		end
	end
end

function RankRaceHistoryView:_onReloadFinish()
	if self._clickCellIndex then
		self._tweenOpen = TweenUtil.ValueTo(0, 460, RankRaceHistoryView.TweenTime, function(val)
			GameUtil.setWidth(self._imgInfoBkRecord._imgInfoBk, val)
		end, function()
			self._tweenOpen = nil

			for i = 1, 2 do
				self._imgInfoBkRecord._txtBottomInfo[i].gameObject:SetActive(true)
			end

			self._imgInfoBkRecord._txtHide.gameObject:SetActive(true)
		end, self, DG.Tweening.Ease.OutCubic)
	end
end

return RankRaceHistoryView
