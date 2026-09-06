-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementTeam.lua

module("logic.extensions.battlesettlement.view.SettlementTeam", package.seeall)

local SettlementTeam = class("SettlementTeam", BSAnimPlay)

function SettlementTeam:buildUI(parent)
	SettlementTeam.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._teamList = goutil.findChild(parent, "teamList"):GetComponent(goutil.Type_RectTransform)
	self._tableview = goutil.findChild(parent, "teamList"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(parent, "teamList/itemPet")

	self._tableCell:SetActive(false)

	self._btnStatics = goutil.findChild(parent, "btnStatics")
end

function SettlementTeam:onEnter(totalHeight, curPosY, delayTime, view)
	SettlementTeam.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true
	self._view = view

	goutil.setActive(self._parent, true)
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_addUnitToList()

	return self:getNextData()
end

function SettlementTeam:onExit()
	self._isEntered = false
	self._view = nil

	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()

	if self._uiEffects then
		for k, v in pairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end

	self:doKillTween()
	goutil.setActive(self._parent, false)
end

function SettlementTeam:_addUnitToList()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}
	self._isPlayExpAnimation = false
	self._unitTime = 0.3
	self._tweens = {}
	self._uiEffects = {}
	self._expAnimTime = 0

	local isExpedition = BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.Expedition
	local isShowHp = BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.Eternalholydragon or BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.DivineDiShiTianClg or BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.NuoYaSisterClgExtreme

	if BattleModel.instance.isEndlessBattle then
		self._curViewDatas = self:_getEndlessBattleUnits()
	elseif BattleModel.instance.HolyStripeCopyFight then
		self._curViewDatas = self:_getHolyStripeCopyBattleUnits()
	else
		local units = BattleModel.instance:getUnits()

		self._curViewDatas = {}

		for i, v in pairs(units) do
			if not v.attrs:isDoppelganger() and not v.attrs:IsOraclePet() and not v.attrs:isTJSummonedCharacter() and not v.attrs:isSpiritInvocationPet() then
				local valueData = {}

				valueData.isDead = v:isDead() or v.attrs:getCurHp() == 0

				local isHaveExpUp, unitExpInfo = self:_unitIsExpUp(v.id)

				valueData.isHaveExpUp = isHaveExpUp
				valueData.raceId = v.attrs:getOriginRaceId()
				valueData.skinId = v.attrs:getOriginSkinId()
				valueData.isExpedition = isExpedition

				if isExpedition then
					valueData.hpPercent = v.attrs:getCurHp() / v.attrs:getMaxHp()
					valueData.vigourPercent = v.attrs:getCurVigour() / v.attrs:getMaxVigour()
				end

				valueData.isShowHp = isShowHp

				if isShowHp then
					valueData.hpPercent = v.attrs:getCurHp() / v.attrs:getMaxHp()
				end

				if isHaveExpUp then
					local raceId = v.attrs:getOriginRaceId()
					local skinId = v.attrs:getOriginSkinId()
					local cfg = CharacterConfig.instance:getPetCo(raceId)

					valueData.raceId = raceId
					valueData.skinId = skinId
					valueData.maxLv = cfg.maxLv

					local oldLv, oldExp = CharacterConfig.instance:GetCurExpLevel(raceId, unitExpInfo.oldCurExp)
					local newLv, newExp = CharacterConfig.instance:GetCurExpLevel(raceId, unitExpInfo.newCurExp)
					local oldTotalExp = CharacterConfig.instance:GetLevelExpByLevel(raceId, oldLv)
					local newTotalExp = CharacterConfig.instance:GetLevelExpByLevel(raceId, newLv)

					valueData.oldLv = oldLv
					valueData.oldExp = oldExp
					valueData.newLv = newLv
					valueData.newExp = newExp
					valueData.oldTotalExp = oldTotalExp
					valueData.newTotalExp = newTotalExp

					local oldPercent, newPercent, time = self:_getExpTime(newLv, oldLv, oldExp, oldTotalExp, newExp, newTotalExp)

					valueData.oldPercent = oldPercent
					valueData.newPercent = newPercent
					valueData.time = time
					self._expAnimTime = time > self._expAnimTime and time or self._expAnimTime
				else
					valueData.level = v.attrs:getLevel()
				end

				table.insert(self._curViewDatas, valueData)
			end
		end
	end

	for k, v in pairs(self._uiEffects) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._uiEffects = {}

	self._tableview:ReloadData()
end

function SettlementTeam:_getEndlessBattleUnits()
	local battleStartData = EndlessBattleModel.instance:popBattleStartData()
	local originalStates = battleStartData.originalStates
	local myTeamId = battleStartData.myTeamId
	local playerView

	for _, v in ipairs(originalStates.teams) do
		if v.teamId == myTeamId then
			playerView = v.playerView

			break
		end
	end

	local finalMyUnits = BattleModel.instance:getUnits()
	local dic = {}
	local units = {}

	for _, v in ipairs(finalMyUnits) do
		dic[v.id] = v
	end

	for _, v in ipairs(playerView.characterViews) do
		local unit = {}

		unit.raceId = 0

		local cfg = PetSkinConfig.instance:getPetSkinCfg(checknumber(v.curFaceId))

		if cfg then
			unit.raceId = cfg.raceId
		end

		unit.skinId = v.curFaceId
		unit.isHaveExpUp = false
		unit.isExpedition = false
		unit.level = checknumber(v.lv)

		local curUnit = dic[v.id]

		if curUnit then
			local petCo = CharacterConfig.instance:getPetCo(curUnit.raceId)

			print("unit name = " .. petCo.name)

			unit.isDead = curUnit:isDead()
		else
			unit.isDead = true
		end

		table.insert(units, unit)
	end

	return units
end

function SettlementTeam:_getHolyStripeCopyBattleUnits()
	return HolyStripeCopyModel.instance:getCurBattleSettlePetUnits()
end

function SettlementTeam:_unitIsExpUp(petId)
	local brData = BattleModel.instance.bettleResultData

	if not brData.expResult then
		return false
	end

	local expLists = brData.expResult.petGainExp

	if not expLists or #expLists <= 0 then
		return false
	end

	for i, v in ipairs(expLists) do
		if v.petId == petId then
			local sub = v.newCurExp - v.oldCurExp

			if Mathf.Abs(sub) < 1 then
				return false
			end

			return true, v
		end
	end

	return false
end

function SettlementTeam:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementTeam:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementTeam:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2 + self:getPlayExpNeedTime()
end

function SettlementTeam:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, -5)
	Framework.TransformUtil.SetAnchoredPos(self._teamList, 1500, self._teamList.anchoredPosition.y)

	if self._btnStatics then
		Framework.TransformUtil.SetAnchoredPos(self._btnStatics.transform, 1680, 54)
	end

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	if self._btnStatics then
		self._btnStatics.transform:DOAnchorPosX(160, curTime):SetDelay(curDelay)
	end

	curDelay = curDelay + self._delayTime1

	self._teamList:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	curDelay = curDelay + self._delayTime1

	self:_playExpAnimation(curDelay + curTime)
end

function SettlementTeam:doKillTween()
	SettlementTeam.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._teamList:DOKill(true)

	if self._btnStatics then
		self._btnStatics.transform:DOKill(true)
	end

	if self._tweens then
		for k, v in pairs(self._tweens) do
			v:Kill(true)
		end
	end

	if self._playOverTweener then
		self._playOverTweener:Kill(true)
	end
end

function SettlementTeam:doCompleteTween()
	self:doKillTween()

	if self:isPlayingExpAnimation() then
		self:offExpAnimation()
	end

	if self._btnStatics then
		Framework.TransformUtil.SetAnchoredPos(self._btnStatics.transform, 160, 54)
	end

	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, -5)
	Framework.TransformUtil.SetAnchoredPos(self._teamList, 0, self._teamList.anchoredPosition.y)
end

function SettlementTeam:_playExpAnimation(curDelay)
	self._playOverTweener = TweenUtil.DoDelay(curDelay, function()
		self._isPlayExpAnimation = true

		if self._uiEffects then
			for k, v in pairs(self._uiEffects) do
				UIEffectManager.instance:stopEffect(v)
			end
		end

		self._uiEffects = {}

		self._tableview:ReloadData()
	end)
end

function SettlementTeam:isPlayingExpAnimation()
	return self._isPlayExpAnimation
end

function SettlementTeam:offExpAnimation()
	self._isPlayExpAnimation = false
end

function SettlementTeam:getPlayExpNeedTime()
	printInfo("播放经验条的时间", self._expAnimTime)

	if self._expAnimTime > 0 then
		return self._expAnimTime + self._unitTime
	else
		return self._expAnimTime
	end
end

function SettlementTeam:_numInView()
	return #self._curViewDatas
end

function SettlementTeam:_cellSize()
	return 80, 80
end

function SettlementTeam:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function SettlementTeam:_updateCell(view, cell, data)
	local imgHead = goutil.findChild(cell, "imgHead")
	local txtLv = goutil.findChild(cell, "txtLv"):GetComponent(goutil.Type_UIText)
	local progressBar = goutil.findChild(cell, "progressBar"):GetComponent(typeof(ProgressBar))
	local imgTop = goutil.findChild(cell, "progressBar/Mask/imgTop"):GetComponent(typeof(UIImageSpriteChange))
	local effect = goutil.findChild(cell, "progressBar/Mask/imgTop/effect")
	local effectMaxLv = goutil.findChild(cell, "progressBar/Mask/effectMaxLv")
	local maskRect = goutil.findChild(progressBar, "Mask"):GetComponent(goutil.Type_RectTransform)
	local imgDead = goutil.findChild(cell, "imgDead")
	local hpBar = Framework.SliderAdapter.GetFrom(cell.gameObject, "hpBar")
	local vigourBar = Framework.SliderAdapter.GetFrom(cell.gameObject, "vigourBar")

	imgDead:SetActive(data.isDead)
	effect:SetActive(true)
	effectMaxLv:SetActive(false)
	imgTop:ChangeStateNow(0)

	if data.isHaveExpUp then
		progressBar.gameObject:SetActive(true)
		self:_loadEffect(effect.transform, "fx_ui_zhandoujiesuan/fx_ui_jingyan_mask.prefab", 1, maskRect)
		self:_loadEffect(effect.transform, "fx_ui_zhandoujiesuan/fx_ui_jingyan_nomask.prefab", 1, maskRect)

		local isShowMaxEffect = false

		if data.oldLv == data.maxLv then
			imgTop:ChangeStateNow(1)
		end

		if data.oldLv == data.maxLv or data.newLv == data.maxLv then
			isShowMaxEffect = true

			self:_loadEffect(effectMaxLv.transform, "fx_ui_zhandoujiesuan/fx_ui_jingyan_man.prefab", 1)
		end

		txtLv.text = data.oldLv .. " 级"

		progressBar:SetProgressPercent(data.oldPercent)

		if self._isPlayExpAnimation then
			local subLevel = data.newLv - data.oldLv
			local tweener = TweenUtil.DOTweenNum(data.oldPercent, data.newPercent, data.time, function(percent)
				if subLevel == 0 then
					progressBar:SetProgressPercent(percent)
				else
					local num1 = Mathf.Floor(percent)
					local num2 = percent - num1
					local lv = data.oldLv + num1

					lv = lv <= data.maxLv and lv or data.maxLv
					txtLv.text = lv .. " 级"

					progressBar:SetProgressPercent(num2)
				end
			end, self):SetEase(DG.Tweening.Ease.Linear)

			local function onCompleteFunc()
				if isShowMaxEffect then
					imgTop:ChangeStateNow(1)

					if not goutil.isNil(effect) then
						effect:SetActive(false)
					end

					if not goutil.isNil(effectMaxLv) then
						effectMaxLv:SetActive(true)
					end
				end
			end

			TweenUtil.SetComplete(tweener, nil, onCompleteFunc)
			table.insert(self._tweens, tweener)
		end
	else
		progressBar.gameObject:SetActive(false)

		txtLv.text = data.level .. " 级"
	end

	MaterialMgr.setIcon(imgHead, MatType.Pet, checknumber(data.skinId))
	hpBar.gameObject:SetActive(data.isExpedition or data.isShowHp)
	vigourBar.gameObject:SetActive(data.isExpedition)

	if data.isExpedition then
		hpBar:SetValue(data.hpPercent)
		vigourBar:SetValue(data.vigourPercent)
	end

	if data.isShowHp then
		hpBar:SetValue(data.hpPercent)
	end
end

function SettlementTeam:_clearTableview(cell)
	local imgHead = goutil.findChild(cell, "imgHead")
	local img = Framework.ImageBigBG.Get(imgHead)

	img:ClearImage()

	img = nil
end

function SettlementTeam:_getExpTime(newLv, oldLv, oldExp, oldTotalExp, newExp, newTotalExp)
	local oldPercent = 1
	local newPercent = 1

	if oldTotalExp ~= 0 then
		oldPercent = oldExp / oldTotalExp
	end

	if newTotalExp ~= 0 then
		newPercent = newExp / newTotalExp
	end

	local time = 0
	local subLevel = newLv - oldLv

	if subLevel == 0 then
		time = self._unitTime * (newPercent - oldPercent)
	else
		newPercent = newPercent + subLevel
		time = newPercent * self._unitTime
	end

	return oldPercent, newPercent, time
end

function SettlementTeam:_loadEffect(parentTrans, path, scale, rectTransform)
	local effect = UIEffectManager.instance:playEffect(self._view, path, parentTrans, 0, 0, true, false, nil, function(self, uiEffect)
		if rectTransform then
			self:_onEffectLoaded(uiEffect, rectTransform)
		end
	end, self)

	effect.hideEffWhileNotOnTop = nil

	effect:setParent(parentTrans)
	effect:setScale(scale)
	table.insert(self._uiEffects, effect)
end

function SettlementTeam:_onEffectLoaded(uiEffect, rectTransform)
	uiEffect:setClipping(rectTransform)
end

return SettlementTeam
