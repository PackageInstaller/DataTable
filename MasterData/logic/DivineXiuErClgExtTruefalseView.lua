-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtTruefalseView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtTruefalseView", package.seeall)

local DivineXiuErClgExtTruefalseView = class("DivineXiuErClgExtTruefalseView", ViewComponent)

function DivineXiuErClgExtTruefalseView:buildUI()
	DivineXiuErClgExtTruefalseView.super.buildUI(self)

	self._progressCol = goutil.findChild(self.mainGO, "progressCol")
	self._progressCol_imgYes = goutil.findChild(self.mainGO, "progressCol/imgYes")
	self._progressCol_imgNo = goutil.findChild(self.mainGO, "progressCol/imgNo")
	self._progressCol_left = goutil.findChild(self.mainGO, "progressCol/left")
	self._progressCol_left_txtName = goutil.findChildTextComponent(self.mainGO, "progressCol/left/txtName")
	self._progressCol_left_txtScore = goutil.findChildTextComponent(self.mainGO, "progressCol/left/txtScore")
	self._progressCol_right = goutil.findChild(self.mainGO, "progressCol/left")
	self._progressCol_right_txtName = goutil.findChildTextComponent(self.mainGO, "progressCol/right/txtName")
	self._progressCol_right_txtScore = goutil.findChildTextComponent(self.mainGO, "progressCol/right/txtScore")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")

	GameUtil.SetActive(self._partCell, false)

	self._ruleCol = goutil.findChild(self.mainGO, "ruleCol")
	self._ruleCol_descScrollerview = goutil.findChild(self.mainGO, "ruleCol/descScrollerview/Viewport/Content")
	self._ruleCol_descCell = goutil.findChild(self.mainGO, "ruleCol/descCell")

	GameUtil.SetActive(self._ruleCol_descCell, false)

	self._ruleCol_petCol = goutil.findChild(self.mainGO, "ruleCol/petCol")
	self._petScrollerview = goutil.findChild(self.mainGO, "ruleCol/petCol/petScrollerview")
	self._petScrollercell = goutil.findChild(self.mainGO, "ruleCol/petCol/petScrollercell")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._petCol_imgPetEmpty = goutil.findChild(self.mainGO, "ruleCol/petCol/imgPetEmpty")
	self._btnRefresh = goutil.findChild(self.mainGO, "ruleCol/btnRefresh")
	self._btnEnter = goutil.findChild(self.mainGO, "ruleCol/btnEnter")
end

function DivineXiuErClgExtTruefalseView:bindEvents()
	DivineXiuErClgExtTruefalseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
end

function DivineXiuErClgExtTruefalseView:unbindEvents()
	DivineXiuErClgExtTruefalseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnEnter)
end

function DivineXiuErClgExtTruefalseView:onEnter()
	DivineXiuErClgExtTruefalseView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tierId = checknumber(params[2])
	self._tureFalseId = checknumber(params[3])
	self._activityType = DivineXiuErClgController.instance:getActivityType()

	local isInTime = DivineXiuErClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		printError(string.format("活动不在开启期限内( activityId = %d )", self._activityId))
		self:close()

		return
	end

	if self._tierId <= 0 then
		printError(string.format("传入参数有误( tierId = %d )", self._tierId))
		self:close()

		return
	end

	if self._tureFalseId <= 0 then
		printError(string.format("传入参数有误( tureFalseId = %d )", self._tureFalseId))
		self:close()

		return
	end

	self._tierData = DivineXiuErClgConfig.instance:getDxecExtTierData(self._activityId, self._tierId)
	self._tureFaleData = DivineXiuErClgConfig.instance:getDxecExtTierTruefalseData(self._tureFalseId)
	self._curDataBitId = self._curDataBitId or 0

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErExtremeFightConfirmRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErResetExtremeClgStageRes, self._onUpdate, self)
end

function DivineXiuErClgExtTruefalseView:onExit()
	DivineXiuErClgExtTruefalseView.super.onExit(self)
end

function DivineXiuErClgExtTruefalseView:_onSetUI()
	local typeDataOfFalse = DivineXiuErClgConfig.instance:getDxecExtStageTruefalseTypeData(self._activityId, DxecEnum.ExtStageType_False)
	local typeDataOfTrue = DivineXiuErClgConfig.instance:getDxecExtStageTruefalseTypeData(self._activityId, DxecEnum.ExtStageType_True)

	self._progressCol_left_txtName.text = typeDataOfTrue.progressTitle
	self._progressCol_right_txtName.text = typeDataOfFalse.progressTitle
end

function DivineXiuErClgExtTruefalseView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DivineXiuErClgExtTruefalseView:_onUpdateData()
	local isNeedUpdate = true

	if checknumber(self._curDataBitId) > 0 then
		local result, tips = DivineXiuErClgController.instance:getTryFightExtClgResultAndTips(self._activityId, self._tierId, self._curDataBitId)

		if result == GameEnum.ResultCode.Success then
			isNeedUpdate = false
		end
	end

	if isNeedUpdate then
		local cfg = DivineXiuErClgConfig.instance:getDxecExtStageCfg(self._activityId, self._tierId)

		self._curDataBitId = #cfg > 0 and 1 or 0

		for _, data in ipairs(cfg) do
			local result, tips = DivineXiuErClgController.instance:getTryFightExtClgResultAndTips(self._activityId, self._tierId, data.dataBitId)

			if result == GameEnum.ResultCode.Success then
				self._curDataBitId = data.dataBitId

				break
			end
		end
	end
end

function DivineXiuErClgExtTruefalseView:_onUpdateUI()
	self:_onUpdatePartColUI()
	self:_onUpdateProgressColUI()
	self:_onUpdateRuleColUI()
end

function DivineXiuErClgExtTruefalseView:_onClear()
	self:_onClearPartCol()
	self:_onClearProgressCol()
	self:_onClearRuleCol()
end

function DivineXiuErClgExtTruefalseView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local childGo = self._partCell
	local cfg = DivineXiuErClgConfig.instance:getDxecExtStageCfg(self._activityId, self._tierId)

	if cfg then
		if not #cfg then
			local length = 0

			if cfg then
				for idx, data in ipairs(cfg) do
					local mainGo = children[idx]

					if mainGo == nil then
						mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))

						local tfData = DivineXiuErClgConfig.instance:getDxecExtStageTruefalseData(data.tureFalseStageId)
						local pos = tfData.pos
						local x, y = checknumber(pos[1]), checknumber(pos[2])

						GameUtil.setLocalPos(mainGo, x, y, 0)
					end

					self:_updatePartCell(mainGo, data.dataBitId)
				end
			end

			for idx = 1, parentTran.childCount do
				local mainGo = parentTran:GetChild(idx - 1)

				if idx <= length then
					GameUtil.SetActive(mainGo, true)
				else
					self:_clearPartCell(mainGo)
					GameUtil.SetActive(mainGo, false)
				end
			end
		end
	end
end

function DivineXiuErClgExtTruefalseView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearPartCell(mainGo)
	end
end

function DivineXiuErClgExtTruefalseView:_updatePartCell(mainGo, dataBitId)
	local stageData = DivineXiuErClgConfig.instance:getDxecExtStageData(self._activityId, self._tierId, dataBitId)
	local tfData = DivineXiuErClgConfig.instance:getDxecExtStageTruefalseData(stageData.tureFalseStageId)
	local isPass = DivineXiuErClgController.instance:isPassTierStageOfExt(self._activityId, self._tierId, dataBitId)
	local score = DivineXiuErClgController.instance:getStageScoreOfTruefalseOfExt(self._activityId, dataBitId)
	local head = goutil.findChild(mainGo, "head")
	local icon = goutil.findChild(mainGo, "head/icon")
	local imgPass = goutil.findChild(mainGo, "head/imgPass")
	local imgSelected = goutil.findChild(mainGo, "head/imgSelected")
	local desc = goutil.findChild(mainGo, "desc")
	local desc_txt = goutil.findChildTextComponent(mainGo, "desc/txt")

	desc_txt.text = string.format(tfData.desc, score)

	local isSelected = self._curDataBitId == dataBitId

	GameUtil.SetActive(imgSelected, isSelected)
	self:_loadBigBg(icon, tfData.iconPath)
	GameUtil.SetActive(imgPass, isPass)
	GameUtil.addClickHandler(head, GameUtil.handler(self._onClickPartCell, self, dataBitId))
end

function DivineXiuErClgExtTruefalseView:_clearPartCell(mainGo)
	local head = goutil.findChild(mainGo, "head")
	local icon = goutil.findChild(mainGo, "head/icon")

	GameUtil.rmClickHandler(head)
	self:_unLoadBigBg(icon)
end

function DivineXiuErClgExtTruefalseView:_onClickPartCell(dataBitId)
	self._curDataBitId = dataBitId

	self:_onUpdatePartColUI()
	self:_onUpdateRuleColUI()
end

function DivineXiuErClgExtTruefalseView:_onUpdateProgressColUI()
	self._progressCol_left_txtScore.text = DivineXiuErClgController.instance:getTotalScoreOfTruefalseOfExt(self._activityId, self._tierId, DxecEnum.ExtStageType_True)
	self._progressCol_right_txtScore.text = DivineXiuErClgController.instance:getTotalScoreOfTruefalseOfExt(self._activityId, self._tierId, DxecEnum.ExtStageType_False)

	local isHasBalance = DivineXiuErClgController.instance:isHasBalanceOfTruefalseOfExt(self._activityId, self._tierId)

	GameUtil.SetActive(self._progressCol_imgYes, isHasBalance)
	GameUtil.SetActive(self._progressCol_imgNo, not isHasBalance)
end

function DivineXiuErClgExtTruefalseView:_onClearProgressCol()
	return
end

function DivineXiuErClgExtTruefalseView:_onUpdateRuleColUI()
	local parentTran = self._ruleCol_descScrollerview.transform
	local childGo = self._ruleCol_descCell
	local children = GameUtil.getChildren(parentTran)
	local ruleDescArray = self._tureFaleData.ruleDesc
	local length = #ruleDescArray

	for idx, ruleDesc in ipairs(ruleDescArray) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

		txtDesc.text = ruleDesc
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentTran:GetComponent(goutil.Type_RectTransform))

	local allLockedRaceId = DivineXiuErClgController.instance:getRaceIdListOfLockedOfTruefalseStageOfExt(self._activityId, self._curDataBitId)

	self._petScrollList:reloadData(allLockedRaceId)
	self._petScrollList:MoveCellInView(0, true)

	local isEmpty = #allLockedRaceId <= 0

	GameUtil.SetActive(self._petScrollerview, not isEmpty)
	GameUtil.SetActive(self._petCol_imgPetEmpty, isEmpty)

	local refreshResult = DivineXiuErClgController.instance:getTryRefreshExtTierStageClgResultAndTips(self._activityId, self._tierId, self._curDataBitId)

	GameUtil.SetGray(self._btnRefresh, refreshResult ~= GameEnum.ResultCode.Success)

	local clgResult = DivineXiuErClgController.instance:getTryFightExtClgResultAndTips(self._activityId, self._tierId, self._curDataBitId)

	GameUtil.SetGray(self._btnEnter, clgResult ~= GameEnum.ResultCode.Success)
end

function DivineXiuErClgExtTruefalseView:_onClearRuleCol()
	self._petScrollList:dispose()
end

function DivineXiuErClgExtTruefalseView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setIcon(item, MatType.Pet, raceId, nil, nil)

	local function callBack()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function DivineXiuErClgExtTruefalseView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(mainGo)
end

function DivineXiuErClgExtTruefalseView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function DivineXiuErClgExtTruefalseView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function DivineXiuErClgExtTruefalseView:_onClickBtnRefresh()
	local result, tips = DivineXiuErClgController.instance:getTryRefreshExtTierStageClgResultAndTips(self._activityId, self._tierId, self._curDataBitId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否重置本关的挑战记录，并且解锁被封印的精灵？"

	local function okFunc()
		DivineXiuErClgController.instance:sendPM_DivineXiuErResetExtremeClgStageReq(self._activityId, self._curDataBitId)
	end

	local function cencelFunc()
		return
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", alignment)
end

function DivineXiuErClgExtTruefalseView:_onClickBtnEnter()
	local result, tips = DivineXiuErClgController.instance:getTryFightExtClgResultAndTips(self._activityId, self._tierId, self._curDataBitId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.DivineXiuErClgMainView, nil)
	UIJumper.instance:pushOneStack(ViewName.DivineXiuErClgExtView, nil, self._activityId)
	DivineXiuErClgController.instance:enterBattleOfExtClg(self._activityId, self._tierId, self._curDataBitId)
end

return DivineXiuErClgExtTruefalseView
