-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonChallengeView.lua

module("logic.extensions.dragonlords.view.DragonChallengeView", package.seeall)

local DragonChallengeView = class("DragonChallengeView", ViewComponent)

function DragonChallengeView:ctor()
	DragonChallengeView.super.ctor(self)

	self._stageType = {
		fight = 2,
		buff = 1
	}
end

function DragonChallengeView:unbindEvents()
	DragonChallengeView.super.unbindEvents(self)
	self._btnBuff:RemoveClickListener()
	self._btnOver:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	GameUtil.asBtn(self._allBuffs):RemoveClickListener()
	GameUtil.asBtn(self._petIcon):RemoveClickListener()
	self._btnResetBuff:RemoveClickListener()
end

function DragonChallengeView:bindEvents()
	DragonChallengeView.super.bindEvents(self)
	self._btnBuff:AddClickListener(self._myBuffsOnClick, self)
	self._btnOver:AddClickListener(self._btnOverOnClick, self)
	self._btnClose:AddClickListener(self._close, self)
	GameUtil.asBtn(self._allBuffs):AddClickListener(function()
		goutil.setActive(self._allBuffs, false)
	end)
	self._btnResetBuff:AddClickListener(self._updateInfo, self)
end

function DragonChallengeView:onExit()
	DragonChallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonChallenge, self._updateInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonChallengeOver, self._overEvent, self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonChallengeUpdate, self._sendToUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonChallengeSettlement, self._close, self)
	MaterialMgr.resetAll(self._petIcon)
	self:_clearFormationList()
end

function DragonChallengeView:buildUI()
	DragonChallengeView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnOver = self:getBtn("btnOver")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnClose = self:getBtn("btnClose")
	self._btnResetBuff = self:getBtn("btnResetBuff")
	self._petIcon = self:getGo("desc/txt/petIcon")
	self._levels = self:getGo("levels")
	self._cellRoot = self:getGo("cellRoot")
	self._cloneGrid = self:getGo("cellRoot/cell")
	self._chooseBuffTitle = self:getGo("chooseBuffTitle")
	self._allBuffs = self:getGo("allBuff")
	self._buffList = self:getGo("allBuff/ScrollView")
	self._buffCell = self:getGo("allBuff/cell")
	self._scoreTxt = self:getTxt("score/txt")
	self._descTxt = self:getTxt("desc/txt")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTime = self:getTxt("time/txt")
	self._stageList = {}

	for i = 1, 6 do
		local cls = {}

		cls.go = self:getGo("progress/btn_" .. i)
		cls.index = i
		cls.lock = goutil.findChild(cls.go, "lock")
		cls.select = goutil.findChild(cls.go, "select")
		cls.icon = goutil.findChildComponent(cls.go, "bg/img", "UIImageSpriteChange")
		cls.name = goutil.findChildTextComponent(cls.go, "Text")

		table.insert(self._stageList, cls)
	end

	self._formationBtns = {}
	self._formationList = {}

	for i = 1, 2 do
		local cell = self:getGo("levels/cell_" .. i)
		local list = {}

		for j = 1, 9 do
			local obj = goutil.findChild(cell, string.format("formation/cell_%s/con", j))

			MaterialMgr.resetAll(obj)
			obj.transform.parent.gameObject:SetActive(false)

			list[j] = obj
		end

		self._formationList[i] = list
		self._formationBtns[i] = self:getBtn("levels/cell_" .. i .. "/formation")
	end

	self._allBuffScrollView = ScrollerList.create(self._buffList, self._buffCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._allBuffScrollView:regGetCellSize(function()
		return 236, 384
	end)

	self._gridHeight = GameUtil.getHeight(self._cloneGrid)
	self._gridWidth = GameUtil.getWidth(self._cloneGrid)
	self._gridGap = 30
end

function DragonChallengeView:onEnter()
	DragonChallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DragonChallenge, self._updateInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.DragonChallengeOver, self._overEvent, self)
	GlobalDispatcher:addListener(GlobalNotify.DragonChallengeUpdate, self._sendToUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.DragonChallengeSettlement, self._close, self)

	self._actId = DrogonLordsModel.instance:getActivityId()

	if self._actId <= 0 then
		UIStateManager.instance:clear()
		FloatWordMgr.instance:show("活动已经结束")

		return
	end

	local param = self:getOpenParam()

	self._challengeId = param[1]
	self._buffIds = nil

	self:_isFinal()
	self:_sendToUpdate()
	self:_initGameObject()
	self:_setPetIcon()
	self:setActTime()

	local cfg = DragonLordsConfig.instance:getAllPeopleChallengeInfo()

	self._descTxt.text = DragonLordsConfig.instance:getCommonCfg("UNIVERSAL_CHALLENGE_BUFF_TEXT")
	self._txtTitle.text = cfg[self._challengeId].challengeName
end

function DragonChallengeView:_initGameObject()
	goutil.setActive(self._levels, false)
	goutil.setActive(self._allBuffs, false)
	goutil.setActive(self._cellRoot, false)
	goutil.setActive(self._cloneGrid, false)
	goutil.setActive(self._chooseBuffTitle, false)
	goutil.setActive(self._btnResetBuff.gameObject, false)
end

function DragonChallengeView:_updateInfo()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local stageId = stageInfo.curStageId
	local stageCfg = DragonLordsConfig.instance:getNormolStageInfo(stageInfo.curstagePlanId, stageId)

	self:_initGameObject()

	if stageCfg.stageType == self._stageType.fight then
		goutil.setActive(self._levels, true)

		for i = 1, 2 do
			local teamCfg = DragonLordsConfig.instance:getteamPlanCfg(stageCfg.teamPlanId, i)
			local creepCfgs = DragonLordsConfig.instance:getCreepsMasterById(teamCfg.creepsMasterId)
			local cell = self:getGo("levels/cell_" .. i)
			local txtTip = goutil.findChildTextComponent(cell, "formation/txtTip")
			local txtNum = goutil.findChildTextComponent(cell, "txtNum")

			for k, v in pairs(creepCfgs) do
				local raceId, posId = v.raceId, v.posId
				local obj = self._formationList[i][posId]

				obj.transform.parent.gameObject:SetActive(true)
				MaterialMgr.setIcon(obj, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))

				obj.gameObject:GetComponent("Button").enabled = false
			end

			self._formationBtns[i]:RemoveClickListener()
			self._formationBtns[i]:AddClickListener(function()
				local customFmtMo = DrogonLordsModel.instance:getCustomFmtMo()

				customFmtMo:initParams(self._challengeId, i, stageInfo.curstagePlanId)
				CustomFmtController.instance:showMissionView(customFmtMo)
			end)

			txtTip.text = "难度:" .. teamCfg.difficulty
			txtNum.text = string.format("获得%s积分", teamCfg.score)
		end
	elseif stageCfg.stageType == self._stageType.buff then
		goutil.setActive(self._cellRoot, true)
		goutil.setActive(self._chooseBuffTitle, true)
		goutil.setActive(self._btnResetBuff.gameObject, true)

		local buffs = DragonLordsConfig.instance:getBuffs(stageCfg.buffPlanId)

		self:_setBuffGrid(buffs)
	end

	self._buffIds = stageInfo.buffIds

	self:_setProgressState(stageId)
	self:setStageName(stageInfo.curstagePlanId)

	self._scoreTxt.text = "今日最高积分:" .. stageInfo.dailyMaxScore
end

function DragonChallengeView:_getOneGrid()
	local grid = DragonBuffsItem.New(self._cloneGrid, self._cellRoot)

	return grid:getGrid()
end

function DragonChallengeView:setStageName(curstagePlanId)
	local cfg = DragonLordsConfig.instance:getNormolStageAllInfo(curstagePlanId)

	for i, v in pairs(self._stageList) do
		if cfg[v.index] then
			v.name.text = cfg[v.index].stageName

			v.icon:ChangeSprite(cfg[v.index].iconName)
		end
	end
end

function DragonChallengeView:setShowBuff(buffs)
	local num = checknumber(DragonLordsConfig.instance:getCommonCfg("SHOW_BUFF_NUM"))
	local buffList = {}

	for i = 1, num do
		local buffId = self:getBuffId(buffs, buffList)

		table.insert(buffList, buffs[buffId])
	end

	return buffList
end

function DragonChallengeView:getBuffId(buffs, buffList)
	local buffLen = #buffs
	local buffId = math.random(1, buffLen)

	if table.indexof(buffList, buffs[buffId]) then
		return self:getBuffId(buffs, buffList)
	else
		return buffId
	end
end

function DragonChallengeView:_setBuffGrid(buffs)
	local list = self:setShowBuff(buffs)

	for k, v in pairs(list) do
		local grid = self:_getOneGrid()
		local cfg = v

		grid.txtName.text = cfg.name
		grid.txtDesc.text = cfg.desc

		grid.bufIcon:SetImage(GameUrl.getExpEventUrl(cfg.icon))
		grid.buffLvIcon:SetNativeSize()
		grid.btn:RemoveClickListener()
		grid.btn:AddClickListener(function()
			self:_selectBtnOnClick(cfg.name, cfg.buffId)
		end, self)
		GameUtil.setLocalPos(grid.go, (k - 1) * (self._gridWidth + self._gridGap), 0, 0)
		Framework.TransformUtil.SetLocalPos(grid.content, 0, 0, 0)

		local sizeDelta = grid.content.sizeDelta

		sizeDelta.y = grid.txtDesc.preferredHeight + 8
		grid.content.sizeDelta = sizeDelta

		local preferredHeight = grid.txtName.preferredWidth
		local widthDelta = math.max(0, preferredHeight - 120) * 0.5

		Framework.TransformUtil.SetAnchoredPos(grid.leftSide.transform, -68 - widthDelta, -40)
		Framework.TransformUtil.SetAnchoredPos(grid.rightSide.transform, 72 + widthDelta, -40)
		goutil.setActive(grid.go, true)
	end

	local len = #list

	GameUtil.setLocalPos(self._cellRoot, -(len * self._gridWidth + (len - 1) * self._gridGap) * 0.5, GameUtil.getLocalPos(self._cellRoot).y, 0)
end

function DragonChallengeView:_selectBtnOnClick(name, buffId)
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local tipsContent = lang("text_dragon_select_buff")

	local function okFunc()
		DragonRespectChallengeAgent.instance:sendPM_UniversalChallengeReq(self._actId, self._challengeId, nil, buffId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow(name, tipsContent, okFunc, cencelFunc, "确定", "再想想")
end

function DragonChallengeView:_myBuffsOnClick()
	if not self._buffIds then
		FloatWordMgr.instance:show("正在加载，请稍等~")

		return
	end

	goutil.setActive(self._allBuffs, true)
	self._allBuffScrollView:reloadData(self._buffIds)
end

function DragonChallengeView:_btnOverOnClick()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local name = "是否结算"
	local tipsContent = DragonLordsConfig.instance:getCommonCfg("FIGHT_FAIL_TEXT")

	local function okFunc()
		return
	end

	local function cencelFunc()
		local actId = DrogonLordsModel.instance:getActivityId()

		DragonRespectChallengeAgent.instance:sendPM_UniversalChallengeSettlementReq(actId, self._challengeId)
	end

	TipsFacade.instance:openPopupWindow(name, tipsContent, okFunc, cencelFunc, "再想想", "结算")
end

function DragonChallengeView:_updateTabCell(view, cell, data)
	local cfg = DragonLordsConfig.instance:getBuffsById(data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local goSelect = goutil.findChild(cell, "imgSelect")
	local bufIcon = Framework.ImageBigBG.GetFrom(cell.gameObject, "BuffIcon")
	local buffLv = goutil.findChildComponent(cell, "level", "UIImageSpriteChange")
	local buffLvState = goutil.findChildComponent(cell, "icon", "UIImageSpriteChange")
	local buffLvIcon = buffLv:GetComponent(typeof(UnityEngine.UI.Image))

	txtName.text = cfg.name
	txtDesc.text = cfg.desc

	local preferredWidth = txtName.preferredWidth
	local scale = 130 / preferredWidth

	if scale > 1 then
		scale = 1
	end

	Framework.TransformUtil.SetLocalScale(txtName.transform, scale, scale, scale)

	if goSelect then
		goSelect:SetActive(isSelect)
	end

	bufIcon:SetImage(GameUrl.getExpEventUrl(cfg.icon))
	buffLvIcon:SetNativeSize()
end

function DragonChallengeView:_clearTabCell(cell)
	local bufIcon = Framework.ImageBigBG.GetFrom(cell, "BuffIcon")

	bufIcon:ClearImage()
end

function DragonChallengeView:_adjustFontSize()
	local preferredWidth = self.txtName.preferredWidth
	local scale = 130 / preferredWidth

	if scale > 1 then
		scale = 1
	end

	Framework.TransformUtil.SetLocalScale(self.txtName.transform, scale, scale, scale)
end

function DragonChallengeView:_close()
	self:close()
end

function DragonChallengeView:_setProgressState(stageId)
	for i, v in ipairs(self._stageList) do
		goutil.setActive(v.select, v.index == stageId)
		goutil.setActive(v.lock, stageId > v.index)
	end
end

function DragonChallengeView:_overEvent()
	self:close()
	UIStateManager.instance:push(ViewName.DragonOverChallengView)
end

function DragonChallengeView:_sendToUpdate()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()

	DragonRespectChallengeAgent.instance:sendPM_GetSingleChallengeInfoReq(self._actId, self._challengeId)
end

function DragonChallengeView:_isFinal()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local stageInfoEnd = DrogonLordsModel.instance:getNormalChallengeEnd()
	local stageId = stageInfoEnd.curStageId

	if stageId and DragonLordsConfig.instance:normolStageIsFinal(stageInfo.curstagePlanId, stageId) then
		self:_overEvent()
	end
end

function DragonChallengeView:_setPetIcon()
	local raceId = checknumber(DragonLordsConfig.instance:getCommonCfg("UNIVERSAL_CHALLENGE_PET_ID"))

	MaterialMgr.setIcon(self._petIcon, MatType.PET_SKIN, raceId)
	GameUtil.asBtn(self._petIcon):RemoveClickListener()
	GameUtil.asBtn(self._petIcon):AddClickListener(function()
		MaterialMgr.openGetSource(MatType.Pet, raceId)
	end)
end

function DragonChallengeView:setActTime()
	local commonTimes = string.split(DragonLordsConfig.instance:getCommonCfg("UNIVERSAL_CHALLENGE_OPEN_TIME"), "#")
	local commonStart = GameUtil.string2date(commonTimes[1])
	local commonEnd = GameUtil.string2date(commonTimes[2])

	self._txtTime.text = string.format("活动时间: %s.%s %s:00 - %s.%s %s:00", commonStart.month, commonStart.day, commonStart.hour, commonEnd.month, commonEnd.day, commonEnd.hour)
end

function DragonChallengeView:_clearFormationList()
	for k, v in pairs(self._formationList) do
		for i, obj in ipairs(v) do
			MaterialMgr.resetAll(obj)
			obj.transform.parent.gameObject:SetActive(false)
		end
	end
end

return DragonChallengeView
