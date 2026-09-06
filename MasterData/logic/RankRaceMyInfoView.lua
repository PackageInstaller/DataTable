-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceMyInfoView.lua

module("logic.extensions.rankrace.view.RankRaceMyInfoView", package.seeall)

local RankRaceMyInfoView = class("RankRaceMyInfoView", ViewComponent)

function RankRaceMyInfoView:ctor()
	RankRaceMyInfoView.super.ctor(self)
end

function RankRaceMyInfoView:buildUI()
	RankRaceMyInfoView.super.buildUI(self)

	self.btnClose = self:getBtn("topleft/btnClose")
	self.btnDeclare = self:getBtn("btnDeclare")
	self.btnHistory = self:getBtn("btnHistory")
	self._txtFightCountValue = {}
	self._txtFightWinRateValue = {}

	for i = 1, 3 do
		self._txtFightCountValue[i] = self:getGo("topInfo/txtTopInfo_" .. i .. "/txtFightCount/txtFightCountValue"):GetComponent("Text")
		self._txtFightWinRateValue[i] = self:getGo("topInfo/txtTopInfo_" .. i .. "/txtFightWinRate/txtFightWinRateValue"):GetComponent("Text")
	end

	self._txtRaceGrade = self:getGo("bottomInfo/txtRaceGrade"):GetComponent("Text")
	self._imgGradeBg = {}
	self._imgBIGrade = {}
	self._txtBIFightCountValue = {}
	self._txtBIFightWinRateValue = {}
	self._txtBILegend = {}
	self._txtBILegendValue = {}
	self._txtBIGradeName = {}
	self._gradeStart = {}

	for i = 1, 2 do
		self._imgGradeBg[i] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/imgGradeBg")
		self._imgBIGrade[i] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/imgBIGrade"):GetComponent("UIImageSpriteChange")
		self._txtBIFightCountValue[i] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/txtBIFightCount/txtBIFightCountValue"):GetComponent("Text")
		self._txtBIFightWinRateValue[i] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/txtBIFightWinRate/txtBIFightWinRateValue"):GetComponent("Text")
		self._txtBILegend[i] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/txtBILegend"):GetComponent("Text")
		self._txtBILegendValue[i] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/txtBILegend/txtBILegendValue"):GetComponent("Text")
		self._txtBIGradeName[i] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/txtBIGradeName"):GetComponent("Text")
		self._gradeStart[i] = {}

		for j = 1, 3 do
			self._gradeStart[i][j] = self:getGo("bottomInfo/txtBottomInfo_" .. i .. "/txtBIGradeName/gradeStart_" .. j)
		end
	end

	self._petBgMaskRoot = self:getGo("petBgMask/root")
	self._roleImgGo = self:getGo("petBgMask/root/roleImg")
	self._petPhoto = PetPhotoShow.Get(self._roleImgGo)
end

function RankRaceMyInfoView:bindEvents()
	RankRaceMyInfoView.super.bindEvents(self)
	self.btnClose:AddClickListener(self._onClickBtnClose, self)
	self.btnDeclare:AddClickListener(self._onClickBtnDeclare, self)
	self.btnHistory:AddClickListener(self._onClickBtnHistory, self)
end

function RankRaceMyInfoView:unbindEvents()
	RankRaceMyInfoView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self.btnDeclare:RemoveClickListener()
	self.btnHistory:RemoveClickListener()
end

function RankRaceMyInfoView:destroyUI()
	RankRaceMyInfoView.super.destroyUI(self)
end

function RankRaceMyInfoView:onEnter()
	RankRaceMyInfoView.super.onEnter(self)

	self._allInfos = RankRaceController.instance:getAllInfos()

	if not self._allInfos then
		RankingMatchAgent.instance:sendRM_GetAllInformationReq()
	else
		self:_updateView()
	end
end

function RankRaceMyInfoView:onEnterFinished()
	RankRaceMyInfoView.super.onEnterFinished(self)
	self:_updateLihui()
end

function RankRaceMyInfoView:onExit()
	RankRaceMyInfoView.super.onExit(self)
	self:_clearPetRes()
	self:_clearBigbg()
	self._petPhoto:destroy()
end

function RankRaceMyInfoView:_clearBigbg()
	if not self._imgGradeBg then
		return
	end

	for i = 1, 2 do
		local bigImg = Framework.ImageBigBG.Get(self._imgGradeBg[i])

		if bigImg then
			bigImg:ClearImage()
		end
	end
end

function RankRaceMyInfoView:onExitFinished()
	RankRaceMyInfoView.super.onExitFinished(self)
end

function RankRaceMyInfoView:_onClickBtnClose()
	self:close()
end

function RankRaceMyInfoView:_onClickBtnDeclare()
	UIStateManager.instance:push(ViewName.RankRaceDeclareView)
end

function RankRaceMyInfoView:_onClickBtnHistory()
	UIStateManager.instance:push(ViewName.RankRaceHistoryView)
end

function RankRaceMyInfoView:_updateView()
	self._allInfos = RankRaceController.instance:getAllInfos()

	if not self._allInfos then
		return
	end

	self:_updateTopInfo()
	self:_updateBottomInfo()
end

function RankRaceMyInfoView:_updateTopInfo()
	if not self._allInfos then
		return
	end

	local _allSeasonFightCount = {
		0,
		0,
		0
	}
	local _allSeasonWinCount = {
		0,
		0,
		0
	}

	for i, v in ipairs(self._allInfos) do
		if v and v.total and v.wins then
			_allSeasonFightCount[1] = _allSeasonFightCount[1] + v.total
			_allSeasonWinCount[1] = _allSeasonWinCount[1] + v.wins

			local _seasonWord, _type = RankRaceController.instance:_deCodeMatchSeasonId(v.matchSeasonId)

			if _type == RankRaceController.MatchTypeClassics then
				_allSeasonFightCount[2] = _allSeasonFightCount[2] + v.total
				_allSeasonWinCount[2] = _allSeasonWinCount[2] + v.wins
			elseif _type == RankRaceController.MatchTypeLimit then
				_allSeasonFightCount[3] = _allSeasonFightCount[3] + v.total
				_allSeasonWinCount[3] = _allSeasonWinCount[3] + v.wins
			end
		end
	end

	for i = 1, 3 do
		self._txtFightCountValue[i].text = _allSeasonFightCount[i]
		self._txtFightWinRateValue[i].text = _allSeasonFightCount[i] == 0 and "0%" or math.floor(_allSeasonWinCount[i] / _allSeasonFightCount[i] * 100) .. "%"
	end
end

function RankRaceMyInfoView:_updateBottomInfo()
	if not self._allInfos then
		return
	end

	if not self._curSeasonDataInfo then
		self._curSeasonDataInfo = {}
		self._curSeasonDataInfo[1], self._curSeasonDataInfo[2] = RankRaceController.instance:_getCurSeasonData()
	end

	local _seasonNum, _, _ = RankRaceController.instance:getCurSeasonNum()

	self._txtRaceGrade.text = string.format(RankRaceConfig.instance:getWord(5), _seasonNum)

	for i = 1, 2 do
		if self._curSeasonDataInfo[i] then
			self._txtBIFightCountValue[i].text = self._curSeasonDataInfo[i].total
			self._txtBIFightWinRateValue[i].text = self._curSeasonDataInfo and self._curSeasonDataInfo[i].total == 0 and "0%" or math.floor(self._curSeasonDataInfo[i].wins / self._curSeasonDataInfo[i].total * 100) .. "%"

			local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(self._curSeasonDataInfo[i].star)

			if _configRankRaceLevel then
				uGuiUtil.setSpriteToImage(self._imgGradeBg[i].gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))
				self._imgGradeBg[i].gameObject:SetActive(true)
			end

			if not self._curSeasonDataInfo[i].rank or self._curSeasonDataInfo[i].rank and self._curSeasonDataInfo[i].rank <= 0 then
				self._txtBILegend[i].gameObject:SetActive(false)

				self._txtBILegendValue[i].text = "未上榜"

				self._txtBIGradeName[i].gameObject:SetActive(true)

				if _configRankRaceLevel then
					self._txtBIGradeName[i].text = _configRankRaceLevel._levelName

					if _configRankRaceLevel._bigLevel >= 8 then
						self._imgBIGrade[i].gameObject:SetActive(false)

						for j = 1, 3 do
							self._gradeStart[i][j].gameObject:SetActive(false)
						end
					else
						self._imgBIGrade[i].gameObject:SetActive(true)
						self._imgBIGrade[i]:SetState(_configRankRaceLevel._subLevel - 1)
						self:_updateStartShow(_configRankRaceLevel._levelStart, _configRankRaceLevel._levelAllStart, self._gradeStart[i])
					end
				end
			else
				self._txtBIGradeName[i].gameObject:SetActive(false)
				self._txtBILegend[i].gameObject:SetActive(true)

				if _configRankRaceLevel then
					self._txtBILegend[i].text = _configRankRaceLevel._levelName or ""
				end

				self._txtBILegendValue[i].text = self._curSeasonDataInfo[i].rank
			end
		else
			self._txtBIFightCountValue[i].text = 0
			self._txtBIFightWinRateValue[i].text = "0%"

			self._txtBILegend[i].gameObject:SetActive(false)

			self._txtBILegendValue[i].text = "未上榜"

			self._txtBIGradeName[i].gameObject:SetActive(true)

			local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(RankRaceController.BeginStart)

			if _configRankRaceLevel then
				uGuiUtil.setSpriteToImage(self._imgGradeBg[i].gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))
				self._imgGradeBg[i].gameObject:SetActive(true)

				self._txtBIGradeName[i].text = _configRankRaceLevel._levelName

				if _configRankRaceLevel._bigLevel >= 8 then
					self._imgBIGrade[i].gameObject:SetActive(false)

					for j = 1, 3 do
						self._gradeStart[i][j].gameObject:SetActive(false)
					end
				else
					self._imgBIGrade[i].gameObject:SetActive(true)
					self._imgBIGrade[i]:SetState(_configRankRaceLevel._subLevel - 1)
					self:_updateStartShow(_configRankRaceLevel._levelStart, _configRankRaceLevel._levelAllStart, self._gradeStart[i])
				end
			end
		end
	end
end

function RankRaceMyInfoView:_updateStartShow(_curLightStartCount, _allStartCount, _startObj)
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

function RankRaceMyInfoView:_getMaxFightPet()
	local pets = BagPetsController.instance:getFightBagPet()
	local map = {}

	if pets then
		table.sort(pets, function(x, y)
			if not map[x.petId] then
				local xZdl = x:getFightingPower()

				if not map[y.petId] then
					local yZdl = y:getFightingPower()

					map[x.petId] = xZdl
					map[y.petId] = yZdl

					return yZdl < xZdl
				end
			end
		end)
	end

	return pets and pets[1]
end

function RankRaceMyInfoView:_updateLihui()
	local _maxFightPet = self:_getMaxFightPet()

	if not _maxFightPet or not _maxFightPet.raceId then
		return
	end

	self._petPhoto:showPetEffect((checknumber(_maxFightPet.curFaceId) or nil) and _maxFightPet.curFaceId, true)
end

function RankRaceMyInfoView:_clearPetRes()
	if self._tempMats then
		for i, _tempMat in ipairs(self._tempMats) do
			UnityEngine.GameObject.Destroy(_tempMat)
		end
	end

	if self._pet then
		self._pet = RoleObjectPool.instance:removeRole(self._pet)
	end
end

function RankRaceMyInfoView:testPet(raceId)
	if not raceId then
		return
	end

	self:_clearPetRes()
	self._petPhoto:showPetEffect(raceId, true)
end

function RankRaceMyInfoView:testPetFastTimer(_beginFastId)
	if not _beginFastId then
		return
	end

	self._beginFastId = _beginFastId
	self._testPetCount = 1

	if not self.testPetTB and CharacterConfig.instance._modelUICfg then
		self.testPetTB = table.values(CharacterConfig.instance._modelUICfg)

		table.sort(self.testPetTB, function(a, b)
			if a.id and b.id then
				return a.id < b.id
			end
		end)
	end

	if self._beginFastId then
		for i, v in ipairs(self.testPetTB) do
			if v.id and v.id == self._beginFastId then
				self._testPetCount = i

				break
			end
		end
	end

	settimer(2, self.testPetFast, self, true)
end

function RankRaceMyInfoView:testPetFast()
	print("当前第", self._testPetCount, "个精灵， 当前 ID = ", self.testPetTB[self._testPetCount].id)
	self:testPet(self.testPetTB[self._testPetCount].id)

	self._testPetCount = self._testPetCount + 1
end

function RankRaceMyInfoView:testPetStop()
	removetimer(self.testPetFast, self)
end

return RankRaceMyInfoView
