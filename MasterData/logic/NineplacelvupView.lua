-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacelvupView.lua

module("logic.extensions.nineplace.view.NineplacelvupView", package.seeall)

local NineplacelvupView = class("NineplacelvupView", ViewComponent)

function NineplacelvupView:ctor()
	NineplacelvupView.super.ctor(self)
end

function NineplacelvupView:buildUI()
	NineplacelvupView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnPlayAni = self:getBtn("btnPlayAni")
	self._goldBarCon = self:getGo("goldBarCon")
	self._cellFormation = self:getGo("top/cellFormation")
	self._topTable = self:getGo("top/tableView")
	self._topTableview = ScrollerList.create(self._topTable, self._cellFormation, GameUtil.handler(self._updateCellFormation, self), GameUtil.handler(self._clearCellFormation, self))
	self._txtCurFormationDes = self:getTxt("middle/title/desText")
	self._txtNowLv = self:getTxt("middle/lv/txtNow")
	self._txtNextLv = self:getTxt("middle/lv/txtNext")
	self._active = self:getGo("middle/active/changeAttrs")
	self._activeAttrs = {}

	for i = 1, 2 do
		local attr = {}
		local go = goutil.findChild(self._active, "attr" .. i)

		attr.go = go

		local nowAttr = {}

		nowAttr.go = goutil.findChild(go, "nowAttr")
		nowAttr.icon = goutil.findChild(nowAttr.go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		nowAttr.name = goutil.findChildTextComponent(nowAttr.go, "txtName")
		nowAttr.value = goutil.findChildTextComponent(nowAttr.go, "txtValue")
		nowAttr.tipUnlock = goutil.findChild(go, "tipUnlock")
		attr.nowAttr = nowAttr

		local nextAttr = {}

		nextAttr.go = goutil.findChild(go, "nextAttr")
		nextAttr.icon = goutil.findChild(nextAttr.go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		nextAttr.name = goutil.findChildTextComponent(nextAttr.go, "txtName")
		nextAttr.value = goutil.findChildTextComponent(nextAttr.go, "txtValue")
		attr.nextAttr = nextAttr
		self._activeAttrs[i] = attr
	end

	self._entire = self:getGo("middle/entire/changeAttrs")
	self._entireAttrs = {}

	for i = 1, 2 do
		local attr = {}
		local go = goutil.findChild(self._entire, "attr" .. i)

		attr.go = go

		local nowAttr = {}

		nowAttr.go = goutil.findChild(go, "nowAttr")
		nowAttr.icon = goutil.findChild(nowAttr.go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		nowAttr.name = goutil.findChildTextComponent(nowAttr.go, "txtName")
		nowAttr.value = goutil.findChildTextComponent(nowAttr.go, "txtValue")
		nowAttr.tipUnlock = goutil.findChild(go, "tipUnlock")
		attr.nowAttr = nowAttr

		local nextAttr = {}

		nextAttr.go = goutil.findChild(go, "nextAttr")
		nextAttr.icon = goutil.findChild(nextAttr.go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		nextAttr.name = goutil.findChildTextComponent(nextAttr.go, "txtName")
		nextAttr.value = goutil.findChildTextComponent(nextAttr.go, "txtValue")
		attr.nextAttr = nextAttr
		self._entireAttrs[i] = attr
	end

	self._tipMaxLv = self:getGo("bottom/tipMaxLv")
	self._imgLine = self:getGo("bottom/imgLLine")
	self._conUp = self:getGo("bottom/conUp")
	self._btnUp = GameUtil.asBtn(goutil.findChild(self._conUp, "btnUpGrade"))
	self._btnUpDot = goutil.findChild(self._conUp, "btnUpGrade/red_point")
	self._costCore = goutil.findChild(self._conUp, "costCore")
	self._txtCostCore = goutil.findChildTextComponent(self._costCore, "txtCost")
	self._iconCostCore = goutil.findChild(self._costCore, "iconCon")
	self._btnCostCore = GameUtil.asBtn(goutil.findChild(self._costCore, "btnShowSource"))
	self._costPrices = goutil.findChild(self._conUp, "costPrices")
	self._txtCostPrices = goutil.findChildTextComponent(self._costPrices, "txtCost")
	self._iconCostPrices = goutil.findChild(self._costPrices, "iconCon")
	self._btnCostPrices = GameUtil.asBtn(goutil.findChild(self._costPrices, "btnShowSource"))
	self._conUnlock = self:getGo("bottom/conUnlock")
	self._goBtnUnlock = goutil.findChild(self._conUnlock, "btnUnlock")
	self._btnUnlock = GameUtil.asBtn(self._goBtnUnlock)
	self._txtUnlockTip = goutil.findChildTextComponent(self._conUnlock, "txtShow")
	self._btnGotoChallenge = self:getBtn("left/btnGotoChallenge")
	self._tipWithoutBuff = self:getGo("left/leftbg/tipWithoutBuff")
	self._cellAttrAdd = self:getGo("left/cellAttrAdd")
	self._leftTable = self:getGo("left/tableView")
	self._leftTableview = ScrollerList.create(self._leftTable, self._cellAttrAdd, GameUtil.handler(self._updateCellAttr, self))
end

function NineplacelvupView:bindEvents()
	NineplacelvupView.super.bindEvents(self)
	self._btnPlayAni:AddClickListener(self._playAni, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickBtnRule, self)
	self._btnUp:AddClickListener(self._onClickBtnUp, self)
	self._btnUnlock:AddClickListener(self._onClickBtnUnlock, self)
	self._btnCostCore:AddClickListener(self._onClickBtnCostCore, self)
	self._btnCostPrices:AddClickListener(self._onClickBtnCostPrices, self)
	self._btnGotoChallenge:AddClickListener(self._onClickBtnGotoChallenge, self)
end

function NineplacelvupView:unbindEvents()
	NineplacelvupView.super.unbindEvents(self)
	self._btnPlayAni:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnUp:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
	self._btnCostCore:RemoveClickListener()
	self._btnCostPrices:RemoveClickListener()
	self._btnGotoChallenge:RemoveClickListener()
end

function NineplacelvupView:destroyUI()
	NineplacelvupView.super.destroyUI(self)
end

function NineplacelvupView:onEnter()
	NineplacelvupView.super.onEnter(self)

	self._ableToClick = true

	local isFirstOpen = UnityEngine.PlayerPrefs.GetInt("NineplaceLvup_" .. LoginModel.instance.userId)

	if isFirstOpen == 0 then
		self:_playAni()
		UnityEngine.PlayerPrefs.SetInt("NineplaceLvup_" .. LoginModel.instance.userId, 1)
	end

	self._curSelectId = self:getFirstParam() or self._curSelectId or 1

	self:_onClickFormationCell(self._curSelectId)
	GlobalDispatcher:addListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self._onClickFormationCell, self)
	GlobalDispatcher:addListener(GlobalNotify.BuffFormStrengthSuccessed, self._onClickFormationCell, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateBottomPart, self)
end

function NineplacelvupView:onEnterFinished()
	NineplacelvupView.super.onEnterFinished(self)
end

function NineplacelvupView:onExit()
	NineplacelvupView.super.onExit(self)
	MaterialMgr.resetAll(self._iconCostCore)
	MaterialMgr.resetAll(self._iconCostPrices)
	self._leftTableview:dispose()
	self._topTableview:dispose()
	GlobalDispatcher:removeListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self._onClickFormationCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.BuffFormStrengthSuccessed, self._onClickFormationCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateBottomPart, self)
end

function NineplacelvupView:onExitFinished()
	NineplacelvupView.super.onExitFinished(self)
end

function NineplacelvupView:_onClickBtnRule()
	if not self._ableToClick then
		return
	end

	TipsFacade.instance:openRulesView("nineplaceupgrade")
end

function NineplacelvupView:_playAni()
	return
end

function NineplacelvupView:_onFinishedPlayAni()
	self._ableToClick = true
end

function NineplacelvupView:_initFormationView()
	local cfgs = NinePlaceConfig.instance:getStageCfgs()
	local dataList = {}
	local attrsDataList = {}

	for _, v in pairs(cfgs) do
		if v.stageId then
			local data = {}

			data.id = v.stageId
			data.info = FormationNewModel.instance:getFormStrengthInfo(data.id)
			data.name = v.name

			table.insert(dataList, data)

			if data.info then
				local cfg = BattleConfig.instance:getFormStrengthLvCfg(data.id, data.info.formStrengthLv)

				if cfg and cfg.passiveProperties then
					local attrList = FightingPowerFormula.instance:parseAttrValues(cfg.passiveProperties)

					for k, value in pairs(attrList) do
						local attr = {}

						attr.key = k
						attr.value = value

						table.insert(attrsDataList, attr)
					end
				end
			end
		end
	end

	self._topTableview:reloadData(dataList)
	self._leftTableview:reloadData(attrsDataList)
	goutil.setActive(self._tipWithoutBuff, #attrsDataList < 1)
end

function NineplacelvupView:_updateCellFormation(view, cell, data)
	local icon = goutil.findChild(cell, "formation/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local markSelect = goutil.findChild(cell, "markSelect")
	local dot = goutil.findChild(cell, "dot")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local lv = goutil.findChild(cell, "lv")
	local txtLv = goutil.findChildTextComponent(lv, "txt")
	local unLock = goutil.findChild(cell, "unLock")

	goutil.setActive(markSelect, data.id == self._curSelectId)

	local dotState = FormationNewModel.instance:checkStageCanUpgrade(data.id) or NinePlaceModel.instance:checkCanUnlockRedById(data.id)

	goutil.setActive(dot, dotState)

	local btn = GameUtil.asBtn(goutil.findChild(cell, "btnSelect"))

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickFormationCell, self, data.id))
	icon:SetState(data.id - 1)

	txtName.text = data.name

	if data.info then
		if not data.info.formStrengthLv then
			goutil.setActive(unLock, not data.info)

			if data.info then
				txtLv.text = "Lv." .. data.info.formStrengthLv
			end
		end
	end
end

function NineplacelvupView:_clearCellFormation(cell)
	local btn = GameUtil.asBtn(goutil.findChild(cell, "btnSelect"))

	GameUtil.rmClickHandler(btn)
end

function NineplacelvupView:_updateCellAttr(view, cell, data)
	local icon = goutil.findChild(cell, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local name, value = GameUtil.getPropertyInfo(data.key, data.value)

	icon:SetState(data.key - 1)

	txtName.text = name
	txtValue.text = "+" .. value
end

function NineplacelvupView:_onClickFormationCell(selectId)
	self._curSelectId = selectId or self._curSelectId
	self._curStageCfg = NinePlaceConfig.instance:getStageCfgById(self._curSelectId)
	self._curInfo = FormationNewModel.instance:getFormStrengthInfo(self._curSelectId)

	if self._curInfo then
		self._curLv = self._curInfo.formStrengthLv or 0
	end

	self._curIsMaxLv = BattleConfig.instance:getFormStrengthMaxLv(self._curSelectId) == self._curLv
	self._curLvCfg = BattleConfig.instance:getFormStrengthLvCfg(self._curSelectId, self._curLv)
	self._nextLvCfg = BattleConfig.instance:getFormStrengthLvCfg(self._curSelectId, self._curLv + 1)

	self:_initFormationView()
	self:_updateMiddlePart()
	self:_updateBottomPart()
	self:_checkRedDot()
end

function NineplacelvupView:_updateMiddlePart()
	if self._curLvCfg then
		self._txtNowLv.text = "Lv." .. self._curLv

		for i = 1, 2 do
			goutil.setActive(self._activeAttrs[i].nowAttr.go, true)
			goutil.setActive(self._entireAttrs[i].nowAttr.go, true)
			goutil.setActive(self._activeAttrs[i].nowAttr.tipUnlock, false)
			goutil.setActive(self._entireAttrs[i].nowAttr.tipUnlock, false)
		end

		local dataList = self:_dealAttrStr(self._curLvCfg.properties)

		for i = 1, 2 do
			goutil.setActive(self._activeAttrs[i].go, dataList[i])

			if dataList[i] then
				local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

				self._activeAttrs[i].nowAttr.icon:SetState(dataList[i].key - 1)

				self._activeAttrs[i].nowAttr.name.text = name
				self._activeAttrs[i].nowAttr.value.text = value

				self._activeAttrs[i].nextAttr.icon:SetState(dataList[i].key - 1)

				self._activeAttrs[i].nextAttr.name.text = name
			end
		end

		dataList = self:_dealAttrStr(self._curLvCfg.passiveProperties)

		for i = 1, 2 do
			goutil.setActive(self._entireAttrs[i].go, dataList[i])

			if dataList[i] then
				local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

				self._entireAttrs[i].nowAttr.icon:SetState(dataList[i].key - 1)

				self._entireAttrs[i].nowAttr.name.text = name
				self._entireAttrs[i].nowAttr.value.text = value

				self._entireAttrs[i].nextAttr.icon:SetState(dataList[i].key - 1)

				self._entireAttrs[i].nextAttr.name.text = name
			end
		end
	else
		self._txtNowLv.text = lang("未解锁")

		for i = 1, 2 do
			goutil.setActive(self._activeAttrs[i].nowAttr.go, false)
			goutil.setActive(self._entireAttrs[i].nowAttr.go, false)
			goutil.setActive(self._activeAttrs[i].nowAttr.tipUnlock, true)
			goutil.setActive(self._entireAttrs[i].nowAttr.tipUnlock, true)
		end

		local dataList = self:_dealAttrStr(self._nextLvCfg.properties)

		for i = 1, 2 do
			goutil.setActive(self._activeAttrs[i].go, dataList[i])

			if dataList[i] then
				local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

				self._activeAttrs[i].nowAttr.icon:SetState(dataList[i].key - 1)

				self._activeAttrs[i].nowAttr.name.text = name
				self._activeAttrs[i].nowAttr.value.text = value

				self._activeAttrs[i].nextAttr.icon:SetState(dataList[i].key - 1)

				self._activeAttrs[i].nextAttr.name.text = name
			end
		end

		dataList = self:_dealAttrStr(self._nextLvCfg.passiveProperties)

		for i = 1, 2 do
			goutil.setActive(self._entireAttrs[i].go, dataList[i])

			if dataList[i] then
				local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

				self._entireAttrs[i].nowAttr.icon:SetState(dataList[i].key - 1)

				self._entireAttrs[i].nowAttr.name.text = name
				self._entireAttrs[i].nowAttr.value.text = value

				self._entireAttrs[i].nextAttr.icon:SetState(dataList[i].key - 1)

				self._entireAttrs[i].nextAttr.name.text = name
			end
		end
	end

	if self._nextLvCfg then
		self._txtNextLv.text = "Lv." .. self._curLv + 1

		local dataList = self:_dealAttrStr(self._nextLvCfg.properties)

		for i = 1, 2 do
			if dataList[i] then
				local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

				self._activeAttrs[i].nextAttr.value.text = value
			end
		end

		dataList = self:_dealAttrStr(self._nextLvCfg.passiveProperties)

		for i = 1, 2 do
			if dataList[i] then
				local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

				self._entireAttrs[i].nextAttr.value.text = value
			end
		end
	else
		self._txtNextLv.text = lang("已满级")

		for i = 1, 2 do
			self._activeAttrs[i].nextAttr.value.text = "已满级"
			self._entireAttrs[i].nextAttr.value.text = "已满级"
		end
	end
end

function NineplacelvupView:_updateBottomPart()
	if self._curIsMaxLv then
		goutil.setActive(self._conUp, false)
		goutil.setActive(self._conUnlock, false)
		goutil.setActive(self._imgLine, false)
		goutil.setActive(self._tipMaxLv, true)

		return
	end

	if self._curInfo then
		goutil.setActive(self._conUp, true)
		goutil.setActive(self._conUnlock, false)
		goutil.setActive(self._imgLine, true)
		goutil.setActive(self._tipMaxLv, false)

		local prizeStr = string.split(self._nextLvCfg.upgradeCost, "#")
		local num, ownNum = 0, 0

		self._curCostPricesStr = prizeStr[1]
		num, ownNum = self:_dealCellByStr(self._iconCostPrices, self._curCostPricesStr)
		self._isChipsEnough = num <= ownNum
		self._txtCostPrices.text = string.format("%s/%s", (not self._isChipsEnough or nil) and string.format("<color=red>%s</color>", ownNum), num)
		self._curCostItemStr = prizeStr[2]
		num, ownNum = self:_dealCellByStr(self._iconCostCore, self._curCostItemStr)
		self._isCoresEnough = num <= ownNum
		self._txtCostCore.text = string.format("%s/%s", (not self._isCoresEnough or nil) and string.format("<color=red>%s</color>", ownNum), num)
	else
		goutil.setActive(self._conUp, false)
		goutil.setActive(self._conUnlock, true)
		goutil.setActive(self._imgLine, true)
		goutil.setActive(self._tipMaxLv, false)

		local str = string.split(self._curStageCfg.lockTip, "\n")
		local reach = FuncOpenController.instance:getConditionReached(self._curStageCfg.openCondition)

		self._txtUnlockTip.text = lang((reach or nil) and (str[2] or str[1]))

		GameUtil.SetGray(self._goBtnUnlock, not reach)
	end
end

function NineplacelvupView:_dealCellByStr(go, str)
	local itemParms = string.split(str, ":")
	local num = checkint(itemParms[#itemParms])

	MaterialMgr.resetAll(go)

	local proxy = MaterialMgr.setCellByCfg(str, go)

	if proxy then
		proxy.binder:setNum(0)
	end

	return num, (MaterialMgr.getMatCount(str))
end

function NineplacelvupView:_onClickBtnUnlock()
	if not self._ableToClick then
		return
	end

	local reach = FuncOpenController.instance:getConditionReached(self._curStageCfg.openCondition)

	if not reach then
		return
	end

	TaskController.instance:foreceClearState()
	UIStateManager.instance:clear(true)

	local cfg = NinePlaceConfig.instance:getStageCfgById(self._curSelectId)

	TaskController.instance:gotoNpc(cfg.NpcId)
end

function NineplacelvupView:_onClickBtnUp()
	if not self._ableToClick then
		return
	end

	local showstr = ""

	if not self._isCoresEnough then
		showstr = string.format("%s不足", MaterialMgr.getMatCfgByStr(self._curCostItemStr).name)

		MaterialMgr.openGetSourceByStr(self._costCoresStr)
		FloatWordMgr.instance:show(lang(showstr))

		return
	end

	if not self._isChipsEnough then
		showstr = string.format("%s碎片不足", self._curStageCfg.name)

		FloatWordMgr.instance:show(lang(showstr))

		return
	end

	FormationFacade.instance:upgradeNinePlaceForm(self._curSelectId)
end

function NineplacelvupView:_onClickBtnCostCore()
	if not self._ableToClick then
		return
	end

	MaterialMgr.openGetSourceByStr(self._curCostItemStr)
end

function NineplacelvupView:_onClickBtnCostPrices()
	MaterialMgr.openGetSourceByStr(self._curCostPricesStr)
end

function NineplacelvupView:_onClickBtnGotoChallenge()
	if not self._ableToClick then
		return
	end

	UIStateManager.instance:clear(true)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	mainPlayer:gotoScene(104)
end

function NineplacelvupView:_dealAttrStr(str)
	local data = {}
	local attrList = FightingPowerFormula.instance:parseAttrValues(str)

	for k, value in pairs(attrList) do
		local attr = {}

		attr.key = k
		attr.value = value

		table.insert(data, attr)
	end

	return data
end

function NineplacelvupView:_checkRedDot()
	goutil.setActive(self._btnUpDot, FormationNewModel.instance:checkStageCanUpgrade(self._curSelectId))
end

return NineplacelvupView
