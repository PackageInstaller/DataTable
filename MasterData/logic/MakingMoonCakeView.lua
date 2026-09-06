-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingMoonCakeView.lua

module("logic.extensions.makingmooncake.view.MakingMoonCakeView", package.seeall)

local MakingMoonCakeView = class("MakingMoonCakeView", ViewComponent)

function MakingMoonCakeView:unbindEvents()
	MakingMoonCakeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._startBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnAuto)
end

function MakingMoonCakeView:bindEvents()
	MakingMoonCakeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._startBtn:AddClickListener(self._onClickStart, self)
	self._sureBtn:AddClickListener(self._onClickSure, self)
	GameUtil.addClickHandler(self._btnAuto, self._onClickBtnAuto, self)
end

function MakingMoonCakeView:buildUI()
	MakingMoonCakeView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._timeText = self:getTxt("time/txtTime")
	self._startBtn = self:getBtn("startBtn")
	self._cell = self:getGo("cell")
	self._view = ScrollerList.create(self:getGo("view"), self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._foodView = self:getGo("foods/foodView")
	self._foods = {
		root = self:getGo("foods")
	}

	local foodCellCount = self._foodView.transform.childCount

	for i = 1, foodCellCount do
		self._foods[i] = {
			go = self:getGo("foods/foodView/" .. i)
		}
		self._foods[i].icon = goutil.findChild(self._foods[i].go, "icon")
		self._foods[i].txtWord = goutil.findChildTextComponent(self._foods[i].go, "txtWord")
		self._foods[i].complete = goutil.findChild(self._foods[i].go, "complete")
		self._foods[i].arrow = self:getGo("foods/arrow/" .. i)
	end

	self._scoreText = self:getTxt("score/value")
	self._addScoreText = self:getTxt("score/value/add")
	self._quality = {}

	for i = 1, 3 do
		self._quality[i] = self:getGo("quality/" .. i)
	end

	self._slider = self:getSlider("quality/bar")
	self._roleGo = self:getGo("role/go")
	self._roleCon = self:getGo("role/con")
	self._moonCake = self:getGo("moonCake")
	self._moonCakeIcon = self:getGo("moonCake/item")
	self._moonCakeName = self:getTxt("moonCake/name")
	self._rule = self:getGo("rule")
	self._sureBtn = self:getBtn("rule/btnSure")
	self._sureBtnText = self:getTxt("rule/btnSure/txtTime")
	self._petImg = self:getGo("petImg")
	self._petImgRect = self._petImg:GetComponent(goutil.Type_RectTransform)
	self._btnAuto = self:getGo("btnAuto")
	self._sliderAuto = self:getImg("slider/FillArea/Fill")
	self._tipAuto = self:getGo("tipAuto")
	self._autoEffRoot = self:getGo("tipAuto/root")
	self._fogEffect = self:getGo("fogEffect")
	self._autoSliderEffRoot = self:getGo("autoSliderEffRoot")
end

function MakingMoonCakeView:onExit()
	MakingMoonCakeView.super.onExit(self)
	removetimer(self._timer, self)
	removetimer(self._ruleTimer, self)
	removetimer(self._throwerSwitchAnim, self)
	removetimer(self._autoPassOne, self)
	removetimer(self._updateAutoSliderUI, self)
	self._view:dispose()
	FixedUpdateBeat:Remove(self._arrowMove, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeEndGameRes, self._handlePM_MakingMoonCakeEndGameRes, self)
	UIEffectManager.instance:stopEffect(self._qualityEff)

	if self._cellEff then
		for i, v in ipairs(self._cellEff) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	UIEffectManager.instance:stopEffect(self._foodEff)
	UIEffectManager.instance:stopEffect(self._timeEff)

	self._makeInfo = nil

	if checknumber(self._curAudioId) ~= 0 then
		AudioPlayerEx.instance:stopVoice(self._curAudioId)

		self._curAudioId = 0
	end

	if self._petCharacterIdx ~= 0 then
		uGuiUtil.clearImage(self._petImg)
	else
		self._thrower:onExit()

		if self._role then
			self._role = RoleObjectPool.instance:removeRole(self._role)
			self._role = nil
		end
	end

	if self._petImgRect then
		self._petImgRect:DOKill(true)
	end

	if self._autoEffect then
		UIEffectManager.instance:stopEffect(self._autoEffect)

		self._autoEffect = nil

		GameUtil.SetActive(self._tipAuto, false)
	end

	if self._fogEff then
		UIEffectManager.instance:stopEffect(self._fogEff)

		self._fogEff = nil
	end

	if self._autoSliderEff then
		UIEffectManager.instance:stopEffect(self._autoSliderEff)

		self._autoSliderEff = nil
	end
end

function MakingMoonCakeView:onEnter()
	MakingMoonCakeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._petCharacterIdx = checknumber(params[2])

	goutil.setActive(self._startBtn.gameObject, false)
	goutil.setActive(self._addScoreText.gameObject, false)

	self._score = 0
	self._maxScore = checknumber(MakingMoonCakeConfig.instance:getParamByKey("MAX_SCORE"))
	self._scoreText.text = 0

	goutil.setActive(self._moonCake, false)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeEndGameRes, self._handlePM_MakingMoonCakeEndGameRes, self)

	if self._petCharacterIdx == 0 then
		GameUtil.SetActive(self._roleGo, true)
		GameUtil.SetActive(self._petImg, false)

		self._thrower = CatchPropsAnimCtrl.New(self._roleGo)

		self._thrower:loadSpine(MakingMoonCakeModel.instance:getRoleUrl())
	else
		GameUtil.SetActive(self._petImg, true)
		GameUtil.SetActive(self._roleGo, false)

		local qPetResourceArr = MakingMoonCakeConfig.instance:getProgressQPetSources()
		local petCharacterName = qPetResourceArr and qPetResourceArr[self._petCharacterIdx]

		self._destinationPosY = 100

		uGuiUtil.clearImage(self._petImg)
		uGuiUtil.setSpriteToImage(self._petImg, uGuiUtil.SpriteType.BigBg, "ui/bigbg/yuanxiao/" .. petCharacterName .. ".png")
		self._petImgRect:DOKill(true)
		self._petImgRect:DOAnchorPosY(self._destinationPosY, 0.5):SetLoops(-1, DG.Tweening.LoopType.Yoyo):SetEase(DG.Tweening.Ease.InOutSine)
	end

	self._isCheckRuleOk = false

	local key = MakingMoonCakeConfig.FIRST_GAME .. self._activityId

	if checknumber(GameUtil.getUserData(key)) == 0 then
		GameUtil.saveUserData(key, 1)
		goutil.setActive(self._rule, true)

		self._ruleTime = 5
		self._sureBtnText.text = MakingMoonCakeController.instance:getText("TEXT_10", "(" .. self._ruleTime .. ")")

		uGuiUtil.setGoGrayState(self._sureBtn.gameObject, true)
		settimer(1, self._ruleTimer, self, true)
	else
		goutil.setActive(self._rule, false)

		self._isCheckRuleOk = true

		self:_onClickStart()
	end

	self._sliderAuto.fillAmount = 0
	self._isPlayingAutoEff = false
end

function MakingMoonCakeView:_onClickSure()
	if self._ruleTime <= 0 then
		goutil.setActive(self._rule, false)

		self._isCheckRuleOk = true

		self:_onClickStart()
	end
end

function MakingMoonCakeView:_onClickStart()
	if not self._isCheckRuleOk then
		return
	end

	self._fogEff = UIEffectManager.instance:playEffect(self, "20250124/btydas/fx_ui_btyds_bw.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
		eff:setParent(self._fogEffect.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)
	end)
	self._time = tonumber(MakingMoonCakeConfig.instance:getParamByKey("GAME_TIME"))
	self._timeText.text = MakingMoonCakeController.instance:getText("TEXT_3", self._time)

	settimer(1, self._timer, self, true)
	goutil.setActive(self._moonCake, true)

	self._completeTimes = 0
	self._puse = false
	self._cellDic = {}
	self._totalAutoTime = 5
	self._autoInvokeInterval = 0.5
	self._curTime = 0
	self._curAutoScore = 0

	self:_updateMoonCake()
end

function MakingMoonCakeView:_updateAutoSlider()
	local totalScore = MakingMoonCakeConfig.instance:getAutoTotalScore()

	self._curAutoScore = self._curAutoScore >= checknumber(totalScore) and checknumber(totalScore) or self._curAutoScore
	self._sliderAuto.fillAmount = self._curAutoScore / checknumber(totalScore)
end

function MakingMoonCakeView:_updateMoonCake()
	self._cellDic = {}
	self._makeInfo = MakingMoonCakeController.instance:createMakeInfo()
	self._cellSelect = {}

	self._view:reloadData(self._makeInfo.selectMaterials)

	for i = 1, #self._foods do
		if self._makeInfo.materials[i] then
			goutil.setActive(self._foods[i].go, true)
			goutil.setActive(self._foods[i].complete, false)
			goutil.setActive(self._foods[i].arrow, true)

			local wordStr = self._makeInfo.materials[i].wordIcon

			if self._foods[i].txtWord and not string.nilorempty(wordStr) then
				self._foods[i].txtWord.text = wordStr
			end

			GameUtil.SetActive(self._foods[i].txtWord, not string.nilorempty(wordStr))

			local iconPath = self._makeInfo.materials[i].icon

			if not string.nilorempty(iconPath) then
				uGuiUtil.setSpriteToImage(self._foods[i].icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(iconPath))
			else
				uGuiUtil.clearImage(self._foods[i].icon)
			end

			GameUtil.SetActive(self._foods[i].icon, not string.nilorempty(iconPath))
		else
			goutil.setActive(self._foods[i].go, false)
			goutil.setActive(self._foods[i].complete, false)
			goutil.setActive(self._foods[i - 1].arrow, false)
			GameUtil.SetActive(self._foods[i].icon, false)
			GameUtil.SetActive(self._foods[i].txtWord, false)
		end
	end

	self._curMaterialIndex = 1
	self._qualityTime = #self._makeInfo.materials * tonumber(MakingMoonCakeConfig.instance:getParamByKey("QUALITY_FACTOR"))
	self._qualityTime = self._qualityTime * math.pow(tonumber(MakingMoonCakeConfig.instance:getParamByKey("QUALITY_PERCENTAGE")) / 100, self._completeTimes)
	self._curQuality = self._qualityTime

	self._slider:SetValue(1)

	if not string.nilorempty(self._makeInfo.data.icon) then
		uGuiUtil.setSpriteToImage(self._moonCakeIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._makeInfo.data.icon))
	end

	self._moonCakeName.text = self._makeInfo.data.name
	self._curAudioId = self._makeInfo.data.audioId

	if self._curAudioId ~= 0 then
		AudioPlayerEx.instance:playVoice(self._curAudioId)
	end

	if self._petCharacterIdx == 0 then
		local skinId = self._makeInfo.data.skinId

		if skinId > 0 then
			local x, y, scale = 0, 0, 1
			local pos = self._makeInfo.data.pos

			if pos then
				scale = pos[3]
				y = pos[2]
				x = pos[1]
			end

			self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._roleCon, scale, nil, true, x, y)
		elseif self._role then
			self._role = RoleObjectPool.instance:removeRole(self._role)
			self._role = nil
		end
	end

	UIEffectManager.instance:stopEffect(self._qualityEff)
	UIEffectManager.instance:stopEffect(self._foodEff)

	self._foodEff = UIEffectManager.instance:playEffect(self, "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_shuaxin.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
		eff:setParent(self._foods.root.transform)
		eff:setScale(1)
		eff:setLocalPos(0, -20, 0)
	end)

	if self._cellEff then
		for i, v in ipairs(self._cellEff) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._cellEff = {}

	FixedUpdateBeat:Remove(self._arrowMove, self)
	FixedUpdateBeat:Add(self._arrowMove, self)
end

function MakingMoonCakeView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell.gameObject, "icon")
	local txtWord = goutil.findChildTextComponent(cell.gameObject, "txtWord")
	local wordStr = data.wordIcon

	if txtWord and not string.nilorempty(wordStr) then
		txtWord.text = wordStr
	end

	GameUtil.SetActive(txtWord, not string.nilorempty(wordStr))

	local iconPath = data.icon

	if not string.nilorempty(iconPath) then
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(iconPath))
	else
		uGuiUtil.clearImage(icon)
	end

	GameUtil.SetActive(icon, not string.nilorempty(iconPath))
	goutil.setActive(goutil.findChild(cell.gameObject, "select"), self._cellSelect[cell])
	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
		if self._cellSelect[cell] then
			return
		end

		local curMaterial = self._makeInfo.materials[self._curMaterialIndex]

		if curMaterial then
			if data.id == curMaterial.id then
				goutil.setActive(self._foods[self._curMaterialIndex].complete, true)
				goutil.setActive(goutil.findChild(cell.gameObject, "select"), true)

				self._cellSelect[cell] = true
				self._curMaterialIndex = self._curMaterialIndex + 1

				local effect = UIEffectManager.instance:playEffect(self, "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_xuanzhong.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
					self:_setEff(eff, cell.transform)
				end)

				table.insert(self._cellEff, effect)
			else
				FloatWordMgr.instance:show(MakingMoonCakeController.instance:getText("TEXT_4"))
			end
		end

		curMaterial = self._makeInfo.materials[self._curMaterialIndex]

		if self._makeInfo.materials[self._curMaterialIndex] == nil then
			self:_onClickMake()
		end
	end)

	local curDic = {}

	curDic.cell = cell
	curDic.data = data

	table.insert(self._cellDic, curDic)
end

function MakingMoonCakeView:_clearCell(cell)
	local icon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(icon)
	Framework.ButtonAdapter.Get(cell.gameObject):RemoveClickListener()
end

function MakingMoonCakeView:_onClickMake()
	local totalScore = MakingMoonCakeConfig.instance:getAutoTotalScore()
	local addScore = tonumber(MakingMoonCakeConfig.instance:getParamByKey("MATERIAL_SCORE")) * #self._makeInfo.materials

	if self._score + addScore >= self._maxScore then
		addScore = math.max(self._maxScore - self._score, 0)
	end

	self._score = self._score + addScore
	self._scoreText.text = self._score
	self._addScoreText.text = "+" .. addScore

	goutil.setActive(self._addScoreText.gameObject, true)

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._addScoreText.transform, 0, 0, 0)

	UnityTweens.TweenPosition.StartTween(self._addScoreText.gameObject, Vector3.New(x, 0, z), Vector3.New(x, 30, z), 0.5, UnityTweens.EaseType.easeOutSine, 0.3):AddListener(function()
		goutil.setActive(self._addScoreText.gameObject, false)
	end)

	self._curAutoScore = self._curAutoScore + addScore
	self._isAutoing = self._isAutoing or false

	if not self._isAutoing then
		self:_updateAutoSlider()
	end

	settimer(1.3, self._throwerSwitchAnim, self, false)

	if self._curAutoScore >= checknumber(totalScore) and not self._isPlayingAutoEff then
		self._autoSliderEff = UIEffectManager.instance:playEffect(self, "20250124/btydas/fx_ui_btyds_ssbf.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
			eff:setParent(self._autoSliderEffRoot.transform)
			eff:setScale(1)
			eff:setLocalPos(0, 0, 0)
		end)
		self._isPlayingAutoEff = true
	end

	self:_updateMoonCake()
end

function MakingMoonCakeView:_onClickBtnAuto()
	local totalScore = MakingMoonCakeConfig.instance:getAutoTotalScore()
	local canAuto = self._curAutoScore < checknumber(totalScore)

	if canAuto then
		return
	end

	self._curTime = 0
	self._curAutoSliderTime = 0
	self._isAutoing = true

	GameUtil.setAnchoredPos(self._petImg, -318.25, 80)
	ViewBlockMgr.instance:blockClick(true, self)
	settimer(self._autoInvokeInterval, self._autoPassOne, self)
	settimer(0.2, self._updateAutoSliderUI, self)
	GameUtil.SetActive(self._tipAuto, true)

	local effPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

	self._autoEffect = UIEffectManager.instance:playEffect(self, effPath, self._autoEffRoot.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	self._autoEffect:setParent(self._autoEffRoot.transform)
	self._autoEffect:setLocalPos(0, 0, 0)
	self._autoEffect:setScale(1)
	self._petImgRect:DOKill(true)
	self._petImgRect:DOAnchorPosY(self._destinationPosY, 0.25):SetLoops(-1, DG.Tweening.LoopType.Yoyo):SetEase(DG.Tweening.Ease.InOutSine)
end

function MakingMoonCakeView:_updateAutoSliderUI()
	self._curAutoSliderTime = self._curAutoSliderTime + 0.2
	self._sliderAuto.fillAmount = (self._totalAutoTime - self._curAutoSliderTime) / self._totalAutoTime

	if self._curAutoSliderTime >= self._totalAutoTime then
		removetimer(self._updateAutoSliderUI, self)

		self._isAutoing = false
		self._curAutoSliderTime = 0

		if self._autoEffect then
			UIEffectManager.instance:stopEffect(self._autoEffect)

			self._autoEffect = nil

			GameUtil.SetActive(self._tipAuto, false)
		end

		if self._autoSliderEff then
			UIEffectManager.instance:stopEffect(self._autoSliderEff)

			self._autoSliderEff = nil
			self._isPlayingAutoEff = false
		end
	end
end

function MakingMoonCakeView:_autoPassOne()
	local curMaterial = self._makeInfo.materials[self._curMaterialIndex]

	self._curTime = self._curTime + self._autoInvokeInterval

	if curMaterial then
		for idx, dic in ipairs(self._cellDic) do
			if dic.data.id == curMaterial.id then
				goutil.setActive(self._foods[self._curMaterialIndex].complete, true)
				goutil.setActive(goutil.findChild(dic.cell.gameObject, "select"), true)

				self._cellSelect[dic.cell] = true
				self._curMaterialIndex = self._curMaterialIndex + 1

				local effect = UIEffectManager.instance:playEffect(self, "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_xuanzhong.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
					self:_setEff(eff, dic.cell.transform)
				end)

				table.insert(self._cellEff, effect)

				curMaterial = self._makeInfo.materials[self._curMaterialIndex]

				if self._makeInfo.materials[self._curMaterialIndex] == nil then
					self:_onClickMake()
				end

				break
			end
		end
	end

	if self._curTime >= self._totalAutoTime then
		removetimer(self._autoPassOne, self)
		ViewBlockMgr.instance:blockClick(false, self)

		self._curAutoScore = 0
		self._curTime = 0
		self._sliderAuto.fillAmount = 0

		self._petImgRect:DOKill(true)
		self._petImgRect:DOAnchorPosY(self._destinationPosY, 0.5):SetLoops(-1, DG.Tweening.LoopType.Yoyo):SetEase(DG.Tweening.Ease.InOutSine)
	end
end

function MakingMoonCakeView:_onClickClose()
	if self._makeInfo then
		self._puse = true

		TipsFacade.instance:openPopupWindow(lang("tip"), MakingMoonCakeController.instance:getText("TEXT_9"), function()
			MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeEndGameReq(-1, -1)

			self._score = -1

			self:close()
		end, function()
			self._puse = false
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeEndGameReq(-1, -1)

		self._score = -1

		self:close()
	end
end

function MakingMoonCakeView:_timer()
	if self._puse then
		return
	end

	self._time = self._time - 1

	if self._time == 5 then
		self._timeEff = UIEffectManager.instance:playEffect(self, "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_shuaxin.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
			eff:setParent(self._timeText.transform)
			eff:setLocalPos(0, 0, 0)

			eff._scaleX = 0.15
			eff._scaleY = 0.42

			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, eff._scaleX, eff._scaleY, 1)
		end)
	end

	if self._time <= 0 then
		local encryptedKey = GameUtil.getClientEncryptedKey(MakingMoonCakeModel.instance:getClientKey(), MakingMoonCakeModel.instance:getMixedKey(), {
			self._score
		})

		MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeEndGameReq(self._score, encryptedKey)
		FixedUpdateBeat:Remove(self._arrowMove, self)
		removetimer(self._timer, self)

		self._timeText.text = MakingMoonCakeController.instance:getText("TEXT_3", 0)

		UIEffectManager.instance:stopEffect(self._timeEff)

		return
	else
		self._timeText.text = MakingMoonCakeController.instance:getText("TEXT_3", self._time)
	end

	if self._time < 5 and self._timeEff and self._timeEff.effGo and self._timeEff.effGo.transform then
		self._timeEff:onEffectStart()
	end
end

function MakingMoonCakeView:_ruleTimer()
	self._ruleTime = self._ruleTime - 1

	if self._ruleTime > 0 then
		self._sureBtnText.text = MakingMoonCakeController.instance:getText("TEXT_10", "(" .. self._ruleTime .. ")")
	else
		self._sureBtnText.text = MakingMoonCakeController.instance:getText("TEXT_10", "")

		uGuiUtil.setGoGrayState(self._sureBtn.gameObject, false)
		removetimer(self._ruleTimer, self)
	end
end

function MakingMoonCakeView:_arrowMove()
	if self._puse then
		return
	end

	local old = self._curQuality / self._qualityTime

	self._curQuality = self._curQuality - UnityEngine.Time.fixedDeltaTime

	if self._curQuality < 0 then
		self._curQuality = 0

		FixedUpdateBeat:Remove(self._arrowMove, self)
	end

	local new = self._curQuality / self._qualityTime

	self._slider:SetValue(self._curQuality / self._qualityTime)

	if old > 0.6666666666666666 and new < 0.6666666666666666 or old > 0.3333333333333333 and new < 0.3333333333333333 then
		UIEffectManager.instance:stopEffect(self._qualityEff)

		self._qualityEff = UIEffectManager.instance:playEffect(self, "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_pinzhikuang.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
			if old > 0.6666666666666666 then
				self:_setEff(eff, self._quality[2].transform)
			else
				self:_setEff(eff, self._quality[3].transform)
			end
		end)
	end
end

function MakingMoonCakeView:_throwerSwitchAnim()
	return
end

function MakingMoonCakeView:_setEff(eff, parent)
	eff:setParent(parent)
	eff:setScale(1)
	eff:setLocalPos()
end

function MakingMoonCakeView:_handlePM_MakingMoonCakeEndGameRes()
	if self._score >= 0 then
		ViewBlockMgr.instance:blockClick(false, self)
		UIStateManager.instance:push(ViewName.MakingMoonCakePrizeView, self._score)
	end
end

return MakingMoonCakeView
