-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/view/OriginEternalDragonClgLevelView.lua

module("logic.extensions.origineternaldragonclg.view.OriginEternalDragonClgLevelView", package.seeall)

local OriginEternalDragonClgLevelView = class("OriginEternalDragonClgLevelView", ViewComponent)

function OriginEternalDragonClgLevelView:ctor()
	OriginEternalDragonClgLevelView.super.ctor(self)
end

function OriginEternalDragonClgLevelView:unbindEvents()
	OriginEternalDragonClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnDrag)
end

function OriginEternalDragonClgLevelView:bindEvents()
	OriginEternalDragonClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnDrag, self._onClickBtnDrag, self)
end

function OriginEternalDragonClgLevelView:buildUI()
	OriginEternalDragonClgLevelView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._effClip = self:getGo("statePanel/tableview/effClip")
	self._stageGoList = {}

	for i = 1, 4 do
		local stage = self:getGo("stages/stage" .. i)

		table.insert(self._stageGoList, stage)
	end

	self._seasonGoList = {}

	for i = 1, 4 do
		local season = self:getGo("statePanel/season/season" .. i)

		table.insert(self._seasonGoList, season)
	end

	self._statePanel = self:getGo("statePanel")
	self._btnReset = self:getGo("statePanel/btnReset")
	self._btnDrag = self:getGo("statePanel/btnDrag")
	self._txtBuff = self:getTxt("statePanel/tips_scr/scrView/Viewport/Content")
	self._tableview = self:getGo("statePanel/tableview")
	self._tablecell = self:getGo("statePanel/tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginEternalDragonClgLevelView:onExit()
	OriginEternalDragonClgLevelView.super.onExit(self)

	for i, stageGo in ipairs(self._stageGoList) do
		GameUtil.rmClickHandler(stageGo)
	end

	for type, seasonGo in ipairs(self._seasonGoList) do
		local btnSeanson = goutil.findChild(seasonGo, "btnSeanson")

		GameUtil.rmClickHandler(btnSeanson)
	end

	self._scrollList:dispose()
end

function OriginEternalDragonClgLevelView:onEnter()
	OriginEternalDragonClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginEternalDragonClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginEternalDragonClgUnlockComboRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginEternalDragonClgResetRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 551001
	end

	self._showIdx = 1
	self._showDuration = 0.3
	self._isMoving = false
	self._panelPos = {
		Vector3.New(0, -194.3, 0),
		Vector3.New(0, -526, 0)
	}
	self._effMap = {}
	self._actCfg = OriginEternalDragonClgConfig.instance:getActCfg(self._activityId)
	self._comboCfgs = OriginEternalDragonClgConfig.instance:getComboCfgs(self._activityId)

	OriginEternalDragonClgController.instance:sendPM_OriginEternalDragonClgGetInfoReq(self._activityId)
end

function OriginEternalDragonClgLevelView:_onUpdate()
	self._info = OriginEternalDragonClgModel.instance:getInfo(self._activityId)
	self._typeInfoMap = OriginEternalDragonClgModel.instance:getTypeInfoMap(self._activityId)

	for i, stageGo in ipairs(self._stageGoList) do
		local imgFinish = goutil.findChild(stageGo, "imgFinish")
		local txtProgress = goutil.findChildTextComponent(stageGo, "progress/txtProgress")
		local txtName = goutil.findChildTextComponent(stageGo, "txtName")
		local typeInfo = self._typeInfoMap[i]
		local stageCfgs = OriginEternalDragonClgConfig.instance:getStageCfgsByType(self._activityId, i)

		if typeInfo then
			if not typeInfo.curStageId then
				local curPassStageId = 0
				local challengeStageId = curPassStageId + 1
				local totalStageNum = #stageCfgs
				local canChallenge = challengeStageId <= totalStageNum

				txtProgress.text = string.format("%d/%d", curPassStageId, totalStageNum)

				GameUtil.SetActive(imgFinish, not canChallenge)
				GameUtil.addClickHandler(stageGo, function()
					if not canChallenge then
						FloatWordMgr.instance:show("已通关，无需重复挑战")

						return
					end

					OriginEternalDragonClgController.instance:enterBattleClg(self._activityId, i, challengeStageId)
				end)
			end
		end
	end

	if not self._actCfg.seasonMatStr then
		local seasonMatStrArr = {}

		for type, seasonGo in ipairs(self._seasonGoList) do
			local btnSeason = goutil.findChild(seasonGo, "btnSeason")
			local txtSeasonNum = goutil.findChildTextComponent(seasonGo, "seasonNum/txtSeasonNum")
			local seasonMatStr = seasonMatStrArr[type]
			local stageCfgs = OriginEternalDragonClgConfig.instance:getStageCfgsByType(self._activityId, type)
			local leftNum = OriginEternalDragonClgController.instance:getLeftStampNum(self._activityId, type)
			local hasUsedNum = OriginEternalDragonClgController.instance:getHasUseStampNum(self._activityId, type)
			local totalStampNum = #stageCfgs

			txtSeasonNum.text = string.format("%d/%d", leftNum, totalStampNum - hasUsedNum)

			if seasonMatStr then
				local matType, matId, matNum = MaterialMgr.getMatParams(seasonMatStr)

				GameUtil.addClickHandler(btnSeason, function()
					CommonTipsMgr.instance:openMaterialTips(seasonGo, matType, matId, matNum)
				end, self)
			end
		end

		local curBuffDesc = OriginEternalDragonClgController.instance:getCurBuffDesc(self._activityId)

		self._txtBuff.text = curBuffDesc

		if string.nilorempty(curBuffDesc) then
			self._txtBuff.text = "-- 请先获得印记 --"
		end

		self._scrollList:reloadData(self._comboCfgs)
	end
end

function OriginEternalDragonClgLevelView:_updateCell(view, cell, data)
	local eff1 = goutil.findChild(cell, "season1/eff")
	local eff2 = goutil.findChild(cell, "season2/eff")
	local effBuff = goutil.findChild(cell, "buff/eff")
	local btnActive = goutil.findChild(cell, "btnActive")
	local imgLine = goutil.findChild(cell, "imgLine")
	local season1 = goutil.findChild(cell, "season1")
	local season2 = goutil.findChild(cell, "season2")
	local bg1 = goutil.findChild(cell, "season1/bg")
	local bg2 = goutil.findChild(cell, "season2/bg")
	local bgBuff = goutil.findChild(cell, "buff/bg")
	local season1Gradient = goutil.findChild(cell, "season1/txtSeason1"):GetComponent(ComponentType.UIGradient)
	local season2Gradient = goutil.findChild(cell, "season2/txtSeason2"):GetComponent(ComponentType.UIGradient)
	local imgCanActiveBuff = goutil.findChild(cell, "buff/imgCanActive")
	local txtName = goutil.findChildTextComponent(cell, "buff/txtName")
	local txtBuff = goutil.findChildTextComponent(cell, "buff/txtBuff")
	local txtSeason1 = goutil.findChildTextComponent(cell, "season1/txtSeason1")
	local txtSeason2 = goutil.findChildTextComponent(cell, "season2/txtSeason2")
	local txtSeason1Gray = goutil.findChildTextComponent(cell, "season1/txtSeason1Gray")
	local txtSeason2Gray = goutil.findChildTextComponent(cell, "season2/txtSeason2Gray")
	local txtNameGray = goutil.findChildTextComponent(cell, "buff/txtNameGray")
	local typeIds = data.typeIds
	local seasonName1 = OriginEternalDragonClgController.SeasonText[typeIds[1]]
	local seasonName2 = OriginEternalDragonClgController.SeasonText[typeIds[2]]
	local leftNum1 = OriginEternalDragonClgController.instance:getLeftStampNum(self._activityId, typeIds[1])
	local leftNum2 = OriginEternalDragonClgController.instance:getLeftStampNum(self._activityId, typeIds[2])
	local hasActive = table.indexof(self._info.effectComboIds, data.comboId)
	local canActive = leftNum1 > 0 and leftNum2 > 0

	txtSeason1.text = seasonName1
	txtSeason2.text = seasonName2
	txtSeason1Gray.text = seasonName1
	txtSeason2Gray.text = seasonName2
	txtNameGray.text = data.name
	txtBuff.text = data.desc
	txtName.text = data.name

	self:_setGradientColor(season1Gradient, season2Gradient, typeIds)
	GameUtil.SetGray(bg1, not hasActive)
	GameUtil.SetGray(bg2, not hasActive)
	GameUtil.SetGray(bgBuff, not hasActive)
	GameUtil.SetActive(txtSeason1Gray.gameObject, not (leftNum1 > 0) and not hasActive)
	GameUtil.SetActive(txtSeason2Gray.gameObject, not (leftNum2 > 0) and not hasActive)
	GameUtil.SetActive(txtNameGray.gameObject, not hasActive)
	GameUtil.SetActive(imgCanActiveBuff, hasActive)
	GameUtil.SetActive(imgLine, cell.index + 1 ~= #self._comboCfgs)
	GameUtil.addClickHandler(btnActive, function()
		if not canActive or hasActive then
			if not string.nilorempty(data.matStr) then
				local matType, matId, matNum = MaterialMgr.getMatParams(data.matStr)

				CommonTipsMgr.instance:openMaterialTips(btnActive, matType, matId, matNum)
			end

			return
		end

		OriginEternalDragonClgController.instance:sendPM_OriginEternalDragonClgUnlockComboReq(self._activityId, data.comboId)

		local tip = string.format("成功解锁%s印记！", data.name)

		FloatWordMgr.instance:show(tip)
	end)
	self:stopViewEffectUniGo(eff1)

	if leftNum1 > 0 and not hasActive then
		self:_playCellEffect(eff1)
	end

	self:stopViewEffectUniGo(eff2)

	if leftNum2 > 0 and not hasActive then
		self:_playCellEffect(eff2)
	end

	self:stopViewEffectUniGo(effBuff)

	if canActive and not hasActive then
		self:_playCellEffect(effBuff)
	end
end

function OriginEternalDragonClgLevelView:_clearCell(cell)
	local eff1 = goutil.findChild(cell, "season1/eff")
	local eff2 = goutil.findChild(cell, "season2/eff")
	local effBuff = goutil.findChild(cell, "buff/eff")

	self:stopViewEffectUniGo(eff1)
	self:stopViewEffectUniGo(eff2)
	self:stopViewEffectUniGo(effBuff)
end

function OriginEternalDragonClgLevelView:_setGradientColor(gradientComp1, gradientComp2, typeIds)
	local gradientColorArr1 = OriginEternalDragonClgController.SeasonGradientColor[typeIds[1]]
	local gradientColorArr2 = OriginEternalDragonClgController.SeasonGradientColor[typeIds[2]]
	local color1Top = GameUtil.getColorByHexColor(gradientColorArr1[1], true)
	local color1Bottom = GameUtil.getColorByHexColor(gradientColorArr1[2], true)
	local color2Top = GameUtil.getColorByHexColor(gradientColorArr2[1], true)
	local color2Bottom = GameUtil.getColorByHexColor(gradientColorArr2[2], true)

	gradientComp1.TopColor = UnityEngine.Color32.New(color1Top.r, color1Top.g, color1Top.b, color1Top.a)
	gradientComp1.BottomColor = UnityEngine.Color32.New(color1Bottom.r, color1Bottom.g, color1Bottom.b, color1Bottom.a)
	gradientComp2.TopColor = UnityEngine.Color32.New(color2Top.r, color2Top.g, color2Top.b, color2Top.a)
	gradientComp2.BottomColor = UnityEngine.Color32.New(color2Bottom.r, color1Bottom.g, color2Bottom.b, color2Bottom.a)
end

local effPath = "fx_ui_shouchong/fx_ui_shouchong_clip.prefab"

function OriginEternalDragonClgLevelView:_playCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)

	local eff = self:playViewEffectUniGo(effPath, effGo, self._tableview.transform, true, nil, nil)
end

function OriginEternalDragonClgLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginEternalDragonClgLevelView:_onClickBtnReset()
	TipsFacade.instance:openPopupWindow("提示", "是否重置所有关卡", function()
		OriginEternalDragonClgController.instance:sendPM_OriginEternalDragonClgResetReq(self._activityId)
	end, nil, "确定", "取消")
end

function OriginEternalDragonClgLevelView:_onClickBtnDrag()
	if self._isMoving then
		return
	end

	local paths = {}

	if self._showIdx == 1 then
		table.insert(paths, self._panelPos[1])
		table.insert(paths, self._panelPos[2])
	else
		table.insert(paths, self._panelPos[2])
		table.insert(paths, self._panelPos[1])
	end

	self._showIdx = self._showIdx % 2 + 1
	self._isMoving = true
	self._tween = TweenUtil.DOTweenMovePath(self._statePanel.transform, false, paths, self._showDuration, function()
		self._isMoving = false
	end, self, DG.Tweening.Ease.Linear)
end

return OriginEternalDragonClgLevelView
