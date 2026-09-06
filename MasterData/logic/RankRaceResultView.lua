-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceResultView.lua

module("logic.extensions.rankrace.view.RankRaceResultView", package.seeall)

local RankRaceResultView = class("RankRaceResultView", ViewComponent)

function RankRaceResultView:buildUI()
	RankRaceResultView.super.buildUI(self)

	self._imgBg = self:getGo("imgBg"):GetComponent("RawImage")
	self._imgLevelBg = self:getGo("imgLevelBg")
	self._imgLevelNum = self:getGo("imgLevelNum"):GetComponent("UIImageSpriteChange")
	self._btnSure = self:getBtn("BtnSure")
	self._btnSureTxt = self:getTxt("BtnSure/Text")
	self._myScroesTxt = self:getTxt("scoresresult/MyScores")
	self._enemyScoresTxt = self:getTxt("scoresresult/EnemyScores")
	self._winTimesTxt = self:getTxt("wintimesresult/WinTimes")
	self._widNoRank = self:getGo("widNoRank")
	self._rankLevelTxt = self:getTxt("widNoRank/RankLevel")
	self._titleTxt = goutil.findChildComponent(self.mainGO, "Title", "UIImageSpriteChange")
	self._line1 = self:getGo("line1")
	self._line2 = self:getGo("line2")
	self._stars = {}

	for i = 1, 3 do
		self._stars[i] = self:getGo("widNoRank/Star" .. i)
	end

	self._widRank = self:getGo("widRank")
	self._txtRankValue = self:getGo("widRank/txtRankValue"):GetComponent("Text")
	self._txtRankChange = self:getGo("widRank/txtRankChange"):GetComponent("Text")
	self._imgRankChange = self:getGo("widRank/imgRankChange"):GetComponent("UIImageSpriteChange")
	self._txtRankScoreOri = self:getTxt("widRank/txtRankScoreOri")
	self._txtRankScoreCur = self:getTxt("widRank/txtRankScoreCur")
	self._imgRankScoreChangeGo = self:getGo("widRank/imgRankScoreChange")
	self._txtRankScoreTitleGo = self:getGo("widRank/txtRankScoreTitle")
end

function RankRaceResultView:bindEvents()
	RankRaceResultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function RankRaceResultView:unbindEvents()
	RankRaceResultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function RankRaceResultView:onEnter()
	RankRaceResultView.super.onEnter(self)

	local param = self._viewPresentor:getOpenParam()

	self._reason = param and param[1]
	self._detailData = param and param[2].data

	if self:_openByDetail() then
		self._btnSureTxt.text = RankRaceConfig.instance:getWord(25)

		RankRaceController.instance:operView(ViewName.RankRaceReportDetailView, function(_view)
			_view:setChild(self._imgBg.gameObject)
			GameUtil.setLocalScale(self._imgBg.gameObject, 1, 1, 1)
			self._imgBg.gameObject.transform:SetSiblingIndex(1)
		end)
		self._titleTxt.gameObject:SetActive(false)
		self._line1.gameObject:SetActive(false)
		self._line2.gameObject:SetActive(false)
	end

	self._shaderInfo = {
		{
			177,
			1,
			1,
			1.01
		},
		{
			45,
			0.2,
			1,
			1.01
		}
	}

	self:_updateResultInfos()
end

function RankRaceResultView:onExit()
	RankRaceResultModel.instance:clearGameResult()
	self._imgBg.gameObject.transform:SetParent(self.mainGO.transform)
	RankRaceResultView.super.onExit(self)
	self:_clearMat()
	self:_clearEffect()
	removetimer(self._clearNumJumpEffect, self)
	removetimer(self._clearNumChangeJumpEffect, self)
	removetimer(self._clearScoreChangeJumpEffect, self)
	removetimer(self._clearScoreJumpEffect, self)
	self:_clearBigbg()
end

function RankRaceResultView:_clearBigbg()
	if not self._imgLevelBg then
		return
	end

	local bigImg = Framework.ImageBigBG.Get(self._imgLevelBg)

	if bigImg then
		bigImg:ClearImage()
	end
end

function RankRaceResultView:_updateResultInfosByDetail()
	self._myScroesTxt.text = self._detailData.myAlivePetSize
	self._enemyScoresTxt.text = self._detailData.opAlivePetSize

	local originRank = self._detailData.originRank
	local curRank = self._detailData.curRank
	local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(self._detailData.star)

	uGuiUtil.setSpriteToImage(self._imgLevelBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))
	self._imgLevelBg.gameObject:SetActive(true)

	if curRank == -1 then
		self._imgLevelNum.gameObject:SetActive(true)
		self._widNoRank.gameObject:SetActive(true)
		self._widRank.gameObject:SetActive(false)

		local currLevelStar = _configRankRaceLevel._levelStart

		for i = 1, currLevelStar do
			if self._stars[i] then
				self._stars[i]:SetActive(true)
			end
		end

		for i = currLevelStar + 1, #self._stars do
			if self._stars[i] then
				self._stars[i]:SetActive(false)
			end
		end

		self._rankLevelTxt.text = _configRankRaceLevel._levelName

		self._imgLevelNum:SetState(_configRankRaceLevel._subLevel - 1)
	else
		self._imgLevelNum.gameObject:SetActive(false)
		self._widNoRank.gameObject:SetActive(false)
		self._widRank.gameObject:SetActive(true)

		if originRank <= -1 then
			originRank = 1000
		end

		local _changeRank = originRank - curRank

		self._txtRankChange.text = _changeRank

		goutil.setActive(self._imgRankChange.gameObject, _changeRank ~= 0)

		self._txtRankChange.text = _changeRank ~= 0 and curRank or ""
		self._txtRankValue.text = originRank

		local curLegendRankScore = checknumber(self._detailData.curLegendRankScore)
		local originLegendRankScore = checknumber(self._detailData.originLegendRankScore)
		local isShowScore = true

		goutil.setActive(self._imgRankScoreChangeGo, isShowScore and curLegendRankScore ~= originLegendRankScore)
		goutil.setActive(self._txtRankScoreTitleGo, isShowScore)

		self._txtRankScoreOri.text = isShowScore and originLegendRankScore or ""
		self._txtRankScoreCur.text = isShowScore and originLegendRankScore ~= curLegendRankScore and curLegendRankScore or ""
	end
end

function RankRaceResultView:_updateResultInfos()
	if self:_openByDetail() then
		self:_updateResultInfosByDetail()
	else
		self._myScroesTxt.text = RankRaceResultModel.instance:getMyPetLeftCount()
		self._enemyScoresTxt.text = RankRaceResultModel.instance:getOpPetLeftCount()

		local _matchType = RankRaceController.instance:getCurViewType()
		local originRank = RankRaceController.instance:getRecordPreRank(_matchType + 1)
		local curRank = RankRaceResultModel.instance:getCurrRank()
		local originStar = RankRaceResultModel.instance:getOriginStar()
		local addStar = RankRaceResultModel.instance:getAddStar()
		local currStar = originStar + addStar
		local originLegendRankScore = RankRaceResultModel.instance:getOriginLegendRankScore()
		local curLegendRankScore = RankRaceResultModel.instance:getCurrLegendRankScore()
		local _configRankRaceoriginStarLevel = RankRaceController.instance:getLevelInfoByCurStart(originStar)
		local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(currStar)

		self._imgLevelBg.gameObject:SetActive(false)
		self._rankLevelTxt.gameObject:SetActive(false)
		self._imgLevelNum.gameObject:SetActive(false)

		self._levelEqual = false

		if _configRankRaceoriginStarLevel._bigLevel < _configRankRaceLevel._bigLevel then
			self:_playLevelUpEffect(_configRankRaceoriginStarLevel, _configRankRaceLevel)
		elseif _configRankRaceoriginStarLevel._bigLevel == _configRankRaceLevel._bigLevel then
			print("1044200312 level 222222:", _configRankRaceoriginStarLevel._subLevel, _configRankRaceLevel._subLevel)

			if _configRankRaceoriginStarLevel._subLevel > _configRankRaceLevel._subLevel then
				self:_playLevelUpEffect(_configRankRaceoriginStarLevel, _configRankRaceLevel)
			elseif _configRankRaceoriginStarLevel._subLevel == _configRankRaceLevel._subLevel then
				uGuiUtil.setSpriteToImage(self._imgLevelBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))

				self._levelEqual = true

				self._imgLevelBg.gameObject:SetActive(true)
				self._rankLevelTxt.gameObject:SetActive(true)
				self._imgLevelNum.gameObject:SetActive(true)
			else
				self:_playLevelDownEffect(_configRankRaceoriginStarLevel, _configRankRaceLevel)
			end
		else
			self:_playLevelDownEffect(_configRankRaceoriginStarLevel, _configRankRaceLevel)
		end

		if curRank == -1 then
			self._imgLevelNum.gameObject:SetActive(true)
			self._widNoRank.gameObject:SetActive(true)
			self._widRank.gameObject:SetActive(false)

			local preLevelStar = _configRankRaceoriginStarLevel._levelStart
			local currLevelStar = _configRankRaceLevel._levelStart
			local _lightStartCount = self._levelEqual and (preLevelStar < currLevelStar and currLevelStar - 1 or currLevelStar) or currLevelStar

			for i = 1, _lightStartCount do
				if self._stars[i] then
					self._stars[i]:SetActive(true)
				end
			end

			for i = _lightStartCount + 1, #self._stars do
				if self._stars[i] then
					self._stars[i]:SetActive(false)
				end
			end

			if self._levelEqual then
				if preLevelStar < currLevelStar then
					self:_playStartUpEffect(currLevelStar)
				elseif preLevelStar == currLevelStar then
					-- block empty
				else
					self:_playStartDownEffect(preLevelStar)
				end
			end

			if self._rankLevelTxt.gameObject.activeSelf then
				self._rankLevelTxt.text = _configRankRaceLevel._levelName
			end

			if self._imgLevelNum.gameObject.activeSelf then
				self._imgLevelNum:SetState(_configRankRaceLevel._subLevel - 1)
			end
		else
			self._imgLevelNum.gameObject:SetActive(false)
			self._widNoRank.gameObject:SetActive(false)
			self._widRank.gameObject:SetActive(true)

			if originRank <= -1 then
				originRank = 1000
			end

			local _changeRank = originRank - curRank
			local rankHasChange = _changeRank ~= 0

			goutil.setActive(self._imgRankChange.gameObject, rankHasChange)

			self._txtRankChange.text = _changeRank ~= 0 and curRank or ""
			self._txtRankValue.text = originRank
			curLegendRankScore = checknumber(curLegendRankScore)
			originLegendRankScore = checknumber(originLegendRankScore)

			local scoreHasChange = curLegendRankScore > 0 and curLegendRankScore ~= originLegendRankScore

			goutil.setActive(self._imgRankScoreChangeGo, scoreHasChange)

			self._txtRankScoreOri.text = math.max(originLegendRankScore, 0)
			self._txtRankScoreCur.text = scoreHasChange and curLegendRankScore or ""

			if rankHasChange then
				self._txtRankValue.gameObject:SetActive(false)
				print("1044200312 level originRank, curRank:", originRank, curRank)
				self:_playRankNumEffect()
				self._txtRankChange.gameObject:SetActive(false)
				self:_playRankNumChangeEffect()
			end

			if scoreHasChange then
				self._txtRankScoreOri.gameObject:SetActive(false)
				self:_playScoreNumEffect()
				self._txtRankScoreCur.gameObject:SetActive(false)
				self:_playScoreNumChangeEffect()
			end
		end
	end

	self.battleResult = RankRaceResultModel.instance:getBattleResult()

	if self:_openByDetail() then
		if self._detailData.myAlivePetSize == self._detailData.opAlivePetSize then
			self._titleTxt:SetState(1)
		elseif self._detailData.myAlivePetSize > self._detailData.opAlivePetSize then
			self._titleTxt:SetState(0)
		else
			self._titleTxt:SetState(2)
		end
	elseif self.battleResult == RankRaceResultModel.BattleRes_Win then
		self._titleTxt:SetState(0)
	elseif self.battleResult == RankRaceResultModel.BattleRes_Lose then
		self._titleTxt:SetState(2)
	else
		self._titleTxt:SetState(1)
	end

	self:_changeMatParam()

	if self:_openByDetail() then
		if self._detailData.winStreak > 0 then
			self._winTimesTxt.text = self._detailData.winStreak or 0
		end
	else
		local _viewType = RankRaceController.instance:getCurViewType()
		local _openRankingMatchData = RankRaceController.instance:getOpenRankingMatchData(_viewType)

		if _openRankingMatchData then
			if _openRankingMatchData.winStreak > 0 then
				self._winTimesTxt.text = _openRankingMatchData.winStreak or 0
			end
		end
	end
end

function RankRaceResultView:_playRankNumEffect()
	settimer(1.5, self._clearNumJumpEffect, self, false)

	local effect_path = "fx_ui_pipeduishou/fx_ui_ranknumbereffects.prefab"

	self._numJump = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, -22, -196.5, 0)
	end)

	self._numJump:setParent(self.mainGO.transform)
	self._numJump:setScale(1)
end

function RankRaceResultView:_clearNumJumpEffect()
	if self._numJump then
		UIEffectManager.instance:stopEffect(self._numJump)

		self._numJump = nil
	end

	removetimer(self._clearNumJumpEffect, self)
	self._txtRankValue.gameObject:SetActive(true)
end

function RankRaceResultView:_playRankNumChangeEffect()
	settimer(1.5, self._clearNumChangeJumpEffect, self, false)

	local effect_path = "fx_ui_pipeduishou/fx_ui_ranknumbereffects.prefab"

	self._numChangeJump = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 106, -196.5, 0)
	end)

	self._numChangeJump:setParent(self.mainGO.transform)
	self._numChangeJump:setScale(1)
end

function RankRaceResultView:_clearNumChangeJumpEffect()
	if self._numChangeJump then
		UIEffectManager.instance:stopEffect(self._numChangeJump)

		self._numChangeJump = nil
	end

	removetimer(self._clearNumChangeJumpEffect, self)
	self._txtRankChange.gameObject:SetActive(true)
end

function RankRaceResultView:_playLevelUpEffect(_configRankRaceoriginStarLevel, _configRankRaceLevel)
	if not _configRankRaceoriginStarLevel or not _configRankRaceLevel then
		return
	end

	local effect_path = "fx_ui_rankraceresult/duanweieffect_levelup.prefab"

	self._levelUpEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		local imgLevelBg_low = goutil.findChild(eff.effGo, "imgLevelBg_low")

		uGuiUtil.setSpriteToImage(imgLevelBg_low.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceoriginStarLevel._bigLevel))

		local imgLevelNum_low = goutil.findChild(eff.effGo, "imgLevelBg_low/imgLevelNum_low"):GetComponent("UIImageSpriteChange")

		imgLevelNum_low:SetState(_configRankRaceoriginStarLevel._subLevel - 1)

		local imgLevelBg_hight = goutil.findChild(eff.effGo, "imgLevelBg_hight")

		uGuiUtil.setSpriteToImage(imgLevelBg_hight.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))

		local imgLevelNum_hight = goutil.findChild(eff.effGo, "imgLevelBg_hight/imgLevelNum_hight"):GetComponent("UIImageSpriteChange")

		imgLevelNum_hight:SetState(_configRankRaceLevel._subLevel - 1)

		local RankLevel_hight = goutil.findChild(eff.effGo, "RankLevel_hight"):GetComponent("Text")

		RankLevel_hight.text = _configRankRaceLevel._bigLevel < 8 and _configRankRaceLevel._levelName or ""

		local RankLevel_low = goutil.findChild(eff.effGo, "RankLevel_low"):GetComponent("Text")

		RankLevel_low.text = _configRankRaceLevel._bigLevel < 8 and _configRankRaceoriginStarLevel._levelName or ""

		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 32, 0)
	end)

	self._levelUpEffect:setParent(self._imgBg.gameObject.transform)
	self._levelUpEffect:setScale(1)
end

function RankRaceResultView:_playLevelDownEffect(_configRankRaceoriginStarLevel, _configRankRaceLevel)
	if not _configRankRaceoriginStarLevel or not _configRankRaceLevel then
		return
	end

	local effect_path = "fx_ui_rankraceresult/duanweieffect_leveldown.prefab"

	self._levelDownEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		local imgLevelBg_hight = goutil.findChild(eff.effGo, "imgLevelBg_hight")

		uGuiUtil.setSpriteToImage(imgLevelBg_hight.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceoriginStarLevel._bigLevel))

		local imgLevelNum_hight = goutil.findChild(eff.effGo, "imgLevelBg_hight/imgLevelNum_hight"):GetComponent("UIImageSpriteChange")

		imgLevelNum_hight:SetState(_configRankRaceoriginStarLevel._subLevel - 1)

		local imgLevelBg_low = goutil.findChild(eff.effGo, "imgLevelBg_low")

		uGuiUtil.setSpriteToImage(imgLevelBg_low.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))

		local imgLevelNum_low = goutil.findChild(eff.effGo, "imgLevelBg_low/imgLevelNum_low"):GetComponent("UIImageSpriteChange")

		imgLevelNum_low:SetState(_configRankRaceLevel._subLevel - 1)

		local RankLevel_hight = goutil.findChild(eff.effGo, "RankLevel_hight"):GetComponent("Text")

		RankLevel_hight.text = _configRankRaceoriginStarLevel._levelName

		local RankLevel_low = goutil.findChild(eff.effGo, "RankLevel_low"):GetComponent("Text")

		RankLevel_low.text = _configRankRaceLevel._levelName

		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 32, 0)
	end)

	self._levelDownEffect:setParent(self._imgBg.gameObject.transform)
	self._levelDownEffect:setScale(1)
end

function RankRaceResultView:_playStartUpEffect(currLevelStar)
	if not currLevelStar then
		return
	end

	local effect_path = "fx_ui_rankraceresult/starupgradeeffect.prefab"

	self._levelStartUpEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		local x = 0

		if currLevelStar == 1 then
			x = -57
		elseif currLevelStar == 2 then
			x = -2.5
		elseif currLevelStar == 3 then
			x = 52
		end

		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, x, -143, 0)
	end)

	self._levelStartUpEffect:setParent(self.mainGO.transform)
	self._levelStartUpEffect:setScale(1)
end

function RankRaceResultView:_playStartDownEffect(preLevelStar)
	if not preLevelStar then
		return
	end

	local effect_path = "fx_ui_rankraceresult/starbrokeneffect.prefab"

	self._levelStartDownEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		local x = 0

		if preLevelStar == 1 then
			x = -57
		elseif preLevelStar == 2 then
			x = -2.5
		elseif preLevelStar == 3 then
			x = 52
		end

		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, x, -143, 0)
	end)

	self._levelStartDownEffect:setParent(self.mainGO.transform)
	self._levelStartDownEffect:setScale(1)
end

function RankRaceResultView:_clearEffect()
	if self._levelUpEffect then
		UIEffectManager.instance:stopEffect(self._levelUpEffect)

		self._levelUpEffect = nil
	end

	if self._levelDownEffect then
		UIEffectManager.instance:stopEffect(self._levelDownEffect)

		self._levelDownEffect = nil
	end

	if self._levelStartUpEffect then
		UIEffectManager.instance:stopEffect(self._levelStartUpEffect)

		self._levelStartUpEffect = nil
	end

	if self._levelStartDownEffect then
		UIEffectManager.instance:stopEffect(self._levelStartDownEffect)

		self._levelStartDownEffect = nil
	end

	if self._numJump then
		UIEffectManager.instance:stopEffect(self._numJump)

		self._numJump = nil
	end

	if self._numChangeJump then
		UIEffectManager.instance:stopEffect(self._numChangeJump)

		self._numChangeJump = nil
	end

	if self._scoreJump then
		UIEffectManager.instance:stopEffect(self._scoreJump)

		self._scoreJump = nil
	end

	if self._scoreChangeJump then
		UIEffectManager.instance:stopEffect(self._scoreChangeJump)

		self._scoreChangeJump = nil
	end
end

function RankRaceResultView:_changeMatParam()
	local _curShaderParam

	if self.battleResult == RankRaceResultModel.BattleRes_Win then
		_curShaderParam = self._shaderInfo[1]
	elseif self.battleResult == RankRaceResultModel.BattleRes_Lose then
		_curShaderParam = self._shaderInfo[2]
	end

	self._tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_color_hsv"))

	if self.battleResult == RankRaceResultModel.BattleRes_Win or self.battleResult == RankRaceResultModel.BattleRes_Lose then
		self._tempMat.mainTexture = self._imgBg.texture

		self._tempMat:SetFloat("_Hue", _curShaderParam[1])
		self._tempMat:SetFloat("_Saturation", _curShaderParam[2])
		self._tempMat:SetFloat("_Value", _curShaderParam[3])
		self._tempMat:SetFloat("_Lerp", _curShaderParam[4])
		self._tempMat:SetFloat("_Enable", 1)
	else
		self._tempMat:SetFloat("_Enable", 0)
	end

	self._imgBg.material = self._tempMat
end

function RankRaceResultView:_clearMat()
	if self._tempMat then
		goutil.destroy(self._tempMat)

		self._tempMat = nil
	end
end

function RankRaceResultView:_onClickSure()
	self:close()

	if self:_openByDetail() then
		RankRaceController.instance:operView(ViewName.RankRaceReportDetailView, function(_view)
			_view:_onClickBtnBack()
		end)
	end
end

function RankRaceResultView:setActive(show, _reason, _detailData)
	self.mainGO:SetActive(show)

	if show then
		self._reason = _reason
		self._detailData = _detailData.data

		RankRaceController.instance:operView(ViewName.RankRaceReportDetailView, function(_view)
			_view:setChild(self._imgBg.gameObject)
			self._imgBg.gameObject.transform:SetSiblingIndex(1)
		end)
	else
		self._imgBg.gameObject.transform:SetParent(self.mainGO.transform)
		self._imgBg.gameObject.transform:SetSiblingIndex(0)
	end
end

function RankRaceResultView:_openByDetail()
	if self._reason and self._reason == "detail" then
		return true
	end
end

function RankRaceResultView:_numCount(num)
	local t = 1
	local i = 10

	while i <= num do
		i = i * 10
		t = t + 1
	end

	return t
end

function RankRaceResultView:_playScoreNumEffect()
	settimer(1.5, self._clearScoreJumpEffect, self, false)

	local effect_path = "fx_ui_pipeduishou/fx_ui_ranknumbereffects.prefab"

	self._scoreJump = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, -22, -232.3, 0)
	end)

	self._scoreJump:setParent(self.mainGO.transform)
	self._scoreJump:setScale(1)
end

function RankRaceResultView:_clearScoreJumpEffect()
	if self._scoreJump then
		UIEffectManager.instance:stopEffect(self._scoreJump)

		self._scoreJump = nil
	end

	removetimer(self._clearScoreJumpEffect, self)
	self._txtRankScoreOri.gameObject:SetActive(true)
end

function RankRaceResultView:_playScoreNumChangeEffect()
	settimer(1.5, self._clearScoreChangeJumpEffect, self, false)

	local effect_path = "fx_ui_pipeduishou/fx_ui_ranknumbereffects.prefab"

	self._scoreChangeJump = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 106, -232.3, 0)
	end)

	self._scoreChangeJump:setParent(self.mainGO.transform)
	self._scoreChangeJump:setScale(1)
end

function RankRaceResultView:_clearScoreChangeJumpEffect()
	if self._scoreChangeJump then
		UIEffectManager.instance:stopEffect(self._scoreChangeJump)

		self._scoreChangeJump = nil
	end

	removetimer(self._clearScoreChangeJumpEffect, self)
	self._txtRankScoreCur.gameObject:SetActive(true)
end

return RankRaceResultView
