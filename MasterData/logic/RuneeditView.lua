-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RuneeditView.lua

module("logic.extensions.rune.view.RuneeditView", package.seeall)

local RuneeditView = class("RuneeditView", ViewComponent)
local TYPE_INFO = 1
local TYPE_INSERT = 2
local TYPE_RUNE_INFO = 3
local TYPE_REPLACE = 4

function RuneeditView:ctor()
	RuneeditView.super.ctor(self)
end

function RuneeditView:buildUI()
	RuneeditView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnHelp = self:getGo("btnHelp")
	self.btnStarResolve = self:getGo("btnStarResolve")
	self.btnStarExchange = self:getGo("btnStarExchange")

	local scrollerGo = self:getGo("ScrollView")
	local cellGo = self:getGo("tabStar")

	self._tableview = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self))
	self.suitCon = self:getGo("suitCon/con")

	GameUtil.setLocalScale(self.suitCon, 0.7, 0.7, 0.7)

	self.rightView = self:getGo("right")
	self.starEdit = self:getGo("right/starEdit")
	self.txtEmptyTop = self:getGo("right/starEdit/txtEmptyTop")
	self.txtEmptyDown = self:getGo("right/starEdit/txtEmptyDown")
	self.txtRule = self:getTxt("right/starEdit/txtRule")
	self.txtStarName = self:getTxt("right/starEdit/txtStarName")
	self.txtDesc = self:getTxt("right/starEdit/txtDesc")
	self.txtPower = self:getTxt("right/starEdit/txtPower")
	self.txtLevel = self:getTxt("right/starEdit/levelUp/txtLevel")
	self.txtLevelNum = self:getTxt("right/starEdit/levelUp/txtLevelNum")
	self.btnTip = self:getGo("right/starEdit/levelUp/btnTip")
	self.btnEquip = self:getGo("btnEquip")
	self.btnUnload = self:getGo("btnUnload")
	self.ScrollTop = self:getGo("right/starEdit/ScrollTop")
	self.ScrollDown = self:getGo("right/starEdit/ScrollDown")
	self.attrItem = self:getGo("right/starEdit/attrItem")
	self._tableviewTop = ScrollerList.create(self.ScrollTop, self.attrItem, GameUtil.handler(self._updateCellTop, self))
	self._tableviewDown = ScrollerList.create(self.ScrollDown, self.attrItem, GameUtil.handler(self._updateCellDown, self))

	local cell = self:getGo("right/cell")

	self.starInsert = self:getGo("right/starInsert")
	self.btnCloseInsert = self:getGo("right/starInsert/btnClose")
	self.imgEmptyInsert = self:getGo("right/starInsert/imgEmpty")
	self.txtInsertLimit = self:getTxt("right/starInsert/txtInsertLimit")
	self.txtNeed = self:getTxt("right/starInsert/imgEmpty/txtNeed")

	local tableview = self:getGo("right/starInsert/ScrollTop")

	self._tableviewInsert = ScrollerList.create(tableview, cell, GameUtil.handler(self._updateInsert, self), GameUtil.handler(self._clearInsert, self))
	self.starInfo = self:getGo("right/starInfo")
	self.btnCloseRune = self:getGo("right/starInfo/btnClose")
	self.btnReplace = self:getGo("right/starInfo/btnReplace")
	self.btnLevelUp = self:getGo("right/starInfo/btnLevelUp")
	self.btnUnloadRune = self:getGo("right/starInfo/btnUnload")
	self.runeIcon = self:getGo("right/starInfo/cell")
	self.txtTypeRune = self:getTxt("right/starInfo/txtType")
	self.txtStarNameRune = self:getTxt("right/starInfo/txtStarName")
	self.txtPowerRune = self:getTxt("right/starInfo/txtPower")

	local tableview = self:getGo("right/starInfo/ScrollDown")

	self._tableviewRuneInfo = ScrollerList.create(tableview, self.attrItem, GameUtil.handler(self._updateRuneInfo, self))
	self.starReplace = self:getGo("right/starReplace")
	self.iconRep = self:getGo("right/starReplace/cell")
	self.txtPowerRep = self:getTxt("right/starReplace/txtPower")
	self.txtTypeRep = self:getTxt("right/starReplace/txtType")
	self.btnCloseRep = self:getGo("right/starReplace/btnClose")
	self.imgEmptyRep = self:getGo("right/starReplace/imgEmpty")
	self.txtTitleRep = self:getTxt("right/starReplace/txtTitle")

	local tableview = self:getGo("right/starReplace/ScrollTop")

	self._tableviewRep = ScrollerList.create(tableview, cell, GameUtil.handler(self._updateRep, self), GameUtil.handler(self._clearRep, self))
	self.cellList = {}
	self.btnAddList = {}

	for i = 1, 3 do
		local cell = goutil.findChild(self.mainGO, "right/cell_" .. i)
		local btnAdd = goutil.findChild(self.mainGO, "right/btnAdd_" .. i)

		table.insert(self.cellList, cell)
		table.insert(self.btnAddList, btnAdd)
	end
end

function RuneeditView:bindEvents()
	RuneeditView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.onClickClose, self)
	GameUtil.addClickHandler(self.btnHelp, self.onClickHelp, self)
	GameUtil.addClickHandler(self.btnTip, self.onTipsClick, self)
	GameUtil.addClickHandler(self.btnEquip, self.onEquip, self)
	GameUtil.addClickHandler(self.btnUnload, self.onUnload, self)
	GameUtil.addClickHandler(self.btnCloseInsert, self.onClickBg, self)
	GameUtil.addClickHandler(self.btnCloseRune, self.onClickBg, self)
	GameUtil.addClickHandler(self.btnUnloadRune, self.onUnloadRune, self)
	GameUtil.addClickHandler(self.btnCloseRep, self.showRuneInfoViewForce, self)
	GameUtil.addClickHandler(self.btnReplace, self.onReplaceClick, self)
	GameUtil.addClickHandler(self.btnLevelUp, self.onLvlupClick, self)
	GameUtil.addClickHandler(self.btnStarResolve, self.onResolveClick, self)
	GameUtil.addClickHandler(self.btnStarExchange, self.onExchange, self)

	for i = 1, #self.btnAddList do
		local cell = self.cellList[i]
		local btnAdd = self.btnAddList[i]

		self:initPetEvent(cell, btnAdd, i)
	end
end

function RuneeditView:unbindEvents()
	RuneeditView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnHelp)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnEquip)
	GameUtil.rmClickHandler(self.btnUnload)
	GameUtil.rmClickHandler(self.btnCloseRep)
	GameUtil.rmClickHandler(self.btnCloseInsert)
	GameUtil.rmClickHandler(self.btnCloseRune)
	GameUtil.rmClickHandler(self.btnReplace)
	GameUtil.rmClickHandler(self.btnLevelUp)
	GameUtil.rmClickHandler(self.btnStarResolve)
	GameUtil.rmClickHandler(self.btnStarExchange)
end

function RuneeditView:onResolveClick()
	UIStateManager.instance:push(ViewName.RuneresolveView, self.currSuitId)
end

function RuneeditView:onExchange()
	GotoMgr.gotoByString("func#470#Exchange3v3")
end

function RuneeditView:destroyUI()
	RuneeditView.super.destroyUI(self)
end

function RuneeditView:onEnter()
	RuneeditView.super.onEnter(self)

	self.hasPowinited = false
	self.rightViewType = RuneController.instance:getViewCurType()
	self.currRuneIdx = RuneController.instance:getViewCurRuneIdx()

	local param = self._viewPresentor:getOpenParam()
	local param = self._viewPresentor:getFirstParam()

	if param then
		local mo = param

		if mo and mo.runeSuit and mo.runeSuit.runeSuitId > 0 then
			self.currPetMo = mo
			self.currSuitId = mo.runeSuit.runeSuitId

			RuneModel.instance:setCurrTabIdx(self.currSuitId)
		end
	end

	if self.rightViewType == -1 then
		self.rightViewType = TYPE_INFO
	end

	RuneController.instance:initAllInfo(GameUtil.handler(self.firstInit, self))
	GameUtil.setLocalScale(self.suitCon, 0.7, 0.7, 0.7)
	GameUtil.setLocalPos(self.suitCon, 0, 0, 0)

	if self.currProxy and self.currRuneIdx > 0 then
		self.currProxy.binder:showSelected(self.currRuneIdx, self)
		self.currProxy.binder:getItemsCallBack(function(items)
			local container = items[self.currRuneIdx]
			local pos = GameUtil.getLocalPos(container)

			GameUtil.setLocalScale(self.suitCon, 1, 1, 1)
			GameUtil.setLocalPos(self.suitCon, -pos.x, -pos.y, 0)
		end)
	end

	self:setOnekeyEanble()

	self.currOnekeyTime = self.currOnekeyTime - 2

	local name = "fx_ui_runeview/fx_ui_runeview_bgeffects.prefab"
	local light = UIEffectManager.instance:playEffect(self, name, self.mainGO, 0, 0, true, nil, function()
		return
	end, function(ta, eff)
		eff:setVisible(true)
	end)

	light:setParent(self.mainGO.transform)
	light:setScale(1)

	self._fingerEff2 = light
end

function RuneeditView:onEnterFinished()
	RuneeditView.super.onEnterFinished(self)
end

function RuneeditView:onExit()
	RuneeditView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)
	self._tableview:dispose()
	self._tableviewDown:dispose()
	self._tableviewInsert:dispose()
	self._tableviewRep:dispose()
	self._tableviewRuneInfo:dispose()
	self._tableviewTop:dispose()

	self.currProxy = nil

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	if self.tweenSc then
		self.tweenSc:Kill(false)

		self.tweenSc = nil
	end

	if self.tweenMv then
		self.tweenMv:Kill(false)

		self.tweenMv = nil
	end

	GameUtil.setLocalScale(self.suitCon, 0.7, 0.7, 0.7)
	GameUtil.setLocalPos(self.suitCon, 0, 0, 0)

	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	if self._fingerEff2 then
		UIEffectManager.instance:stopEffect(self._fingerEff2)

		self._fingerEff2 = nil
	end

	RuneAgent.instance:reset()
end

function RuneeditView:close()
	RuneModel.instance:setCurrTabIdx(nil)
	RuneeditView.super.close(self)
end

function RuneeditView:onExitFinished()
	RuneeditView.super.onExitFinished(self)
end

function RuneeditView:_updateCell(view, cell, data)
	local state = GameUtil.getUIImageSpriteChange(cell)
	local txtStarName = goutil.findChildTextComponent(cell, "txtStarName")
	local lock = goutil.findChild(cell, "lock")

	txtStarName.text = data.name

	local isOpen = FuncOpenModel.instance:getFuncIsOpen(data.unlockCondition)

	GameUtil.SetActive(lock, not isOpen)
	state:SetState(0)

	if data.suitId == self.currSuitId then
		state:SetState(1)
	end

	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickTab, self, data))
end

function RuneeditView:onClickTab(data)
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(data.unlockCondition)

	if isOpen then
		self.hasPowinited = false
		self.currSuitId = data.suitId

		RuneModel.instance:setCurrTabIdx(self.currSuitId)

		self.currRuneIdx = -1

		RuneController.instance:setViewCurRuneIdx(self.currRuneIdx)

		self.rightViewType = TYPE_INFO

		self:refresh()
	else
		local suitmo = RuneModel.instance:getSuitMo(data.suitId)

		UIStateManager.instance:push(ViewName.RunegainView, suitmo)
	end
end

function RuneeditView:initPetEvent(cell, btnAdd, idx)
	local pet = goutil.findChild(cell, "pet")
	local con = goutil.findChild(cell, "pet/con")
	local reduceBtn = goutil.findChild(cell, "pet/reduceBtn")

	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self.onAddPet, self, idx))
end

function RuneeditView:_upatePetCell(cell, btnAdd, data, limitPetCount)
	local pet = goutil.findChild(cell, "pet")
	local con = goutil.findChild(cell, "pet/con")
	local reduceBtn = goutil.findChild(cell, "pet/reduceBtn")

	GameUtil.SetActive(btnAdd, false)
	GameUtil.SetActive(pet, false)
	GameUtil.rmClickHandler(reduceBtn)
	MaterialMgr.resetAll(con)

	if data == nil then
		GameUtil.SetActive(btnAdd, true)
	else
		GameUtil.SetActive(pet, true)
		GameUtil.addClickHandler(reduceBtn, GameUtil.handler(self.onReduceClick, self, data))
		MaterialMgr.setCellByData(MatType.Pet, data, con)
	end
end

function RuneeditView:onAddPet(idx)
	local function onSeletCallBack(mo, data)
		if data and #data > 0 then
			local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, self.currSuitId)
			local content = langPara("是否确定将如下精灵修改为应用 <color=#1177CEFF><size=28>%s</size></color> ？\n", cfg.name)

			for i, petId in ipairs(data) do
				content = content .. MaterialMgr.getContentMatCfg(MatType.Pet, petId, 110, -10, MaterialMgr.ICON_TYPE_MATID) .. "   "
			end

			TipsFacade.instance:openPopupWindow(lang("修改应用星辉"), content, function()
				RuneAgent.instance:sendPM_RuneBatchEquipSuitReq(self.currSuitId, data, function(msg)
					self:showCurrSuitInfo(self.currSuitId)
				end)
			end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
		end
	end

	local function filterFunc(petMo)
		if petMo.runeSuit and petMo.runeSuit.runeSuitId == self.currSuitId then
			return false
		end

		return true
	end

	local list = RuneModel.instance:findUseSuitPets(self.currSuitId)
	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, self.currSuitId)
	local mo = RuneModel.instance:getSuitMo(self.currSuitId)

	if list then
		if not #list then
			local curNum = 0
			local petcount = mo:getSuitLimitPetCount()

			if petcount < idx then
				local tem = RuneConfig.instance:getSuitPetCountCfg(mo:getDefineId())
				local star = tem[idx].needLevel

				TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("总等级达到%s时开放第%s个应用精灵", star, idx))
			else
				PetSelectController.instance:OpenView(petcount - curNum, langPara("请选择使用%s的精灵", cfg.name), filterFunc, onSeletCallBack, nil)
			end
		end
	end
end

function RuneeditView:onReduceClick(petMo)
	TipsFacade.instance:openPopupWindow(lang("tip"), "确定要卸载此精灵身上的星座吗？", function()
		RuneAgent.instance:sendPM_RunePetUnEquipSuitReq(petMo.petId, function(msg)
			self:showCurrSuitInfo(self.currSuitId)
		end)
	end)
end

function RuneeditView:firstInit()
	self.currSuitId = RuneModel.instance:getCurrTabIdx()

	local conf = RuneConfig.instance:getAllSuit()
	local list = {}

	for i, v in ipairs(conf) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, function(data)
		local isOpen = FuncOpenModel.instance:getFuncIsOpen(data.unlockCondition)

		if isOpen then
			return data.sortValue
		else
			return #list + #list / data.sortValue
		end
	end)

	if list and list[1] and self.currSuitId == nil then
		local data = list[1]

		self.currSuitId = data.suitId
	end

	self._tableview:reloadData(list)
	self:showSuit(self.currSuitId)
	self:changeSuitInfo(self.rightViewType)
	GlobalDispatcher:addListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)
end

function RuneeditView:refresh()
	local list = self._tableview:getData()

	ArraySort.sortOn(list, function(data)
		local isOpen = FuncOpenModel.instance:getFuncIsOpen(data.unlockCondition)

		if isOpen then
			return data.sortValue
		else
			return #list + #list / data.sortValue
		end
	end)
	self._tableview:reloadData(list)
	self:showSuit(self.currSuitId)
	self:changeSuitInfo(self.rightViewType)
end

function RuneeditView:showSuit(suitId)
	local data = MaterialMgr.getModel(MatType.Rune_Suit, suitId)

	self.suitmo = data

	local proxy = data and MaterialMgr.setCellByData(MatType.Rune_Suit, data, self.suitCon) or MaterialMgr.setCell(MatType.Rune_Suit, suitId, self.suitCon)

	self.currProxy = proxy

	if proxy then
		proxy.binder:setCallBack(GameUtil.handler(self.onClickBg, self))
		proxy.binder:setClickItemCallBack(GameUtil.handler(self.onClickCell, self))
	end

	local index = self:getCellIdx(suitId)

	self._tableview:MoveCellInView(index - 1)
end

function RuneeditView:getCellIdx(suitId)
	local list = self._tableview:getData()

	for i, v in ipairs(list) do
		if v.suitId == suitId then
			return i
		end
	end
end

function RuneeditView:changeSuitInfo(type)
	if self.rightViewType ~= type then
		if self.tween then
			self.tween:Kill(false)

			self.tween = nil
		end

		local cur = 975

		GameUtil.setAnchoredPos(self.rightView, cur, 14)

		self.tween = TweenUtil.ValueTo(cur, 450, 0.2, function(val)
			GameUtil.setAnchoredPos(self.rightView, val, 14)
		end, function()
			self.tween = nil
		end, self)
	end

	self.rightViewType = type

	RuneController.instance:setViewCurType(type)

	local params = self._viewPresentor:getOpenParam()

	if params then
		params[2] = type

		UIStateManager.instance:updateParms(self._viewPresentor.viewName, params)
	end

	self:showCurrSuitInfo(self.currSuitId)
end

function RuneeditView:showCurrSuitInfo(suitId)
	GameUtil.SetActive(self.starEdit, false)
	GameUtil.SetActive(self.starInsert, false)
	GameUtil.SetActive(self.starInfo, false)
	GameUtil.SetActive(self.starReplace, false)
	GameUtil.SetActive(self.btnStarResolve, false)
	GameUtil.SetActive(self.btnStarExchange, false)
	GameUtil.SetActive(self.btnEquip, false)
	GameUtil.SetActive(self.btnUnload, false)

	local mo = RuneModel.instance:getSuitMo(suitId)
	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, suitId)
	local limitPetCount = 0

	if mo then
		if self.rightViewType == TYPE_INFO then
			self:showInfoView(mo, cfg)
			GameUtil.SetActive(self.btnStarResolve, true)
			GameUtil.SetActive(self.btnStarExchange, true)
			GameUtil.SetActive(self.btnEquip, true)
			GameUtil.SetActive(self.btnUnload, true)
		elseif self.rightViewType == TYPE_INSERT then
			self:showInsertView(mo, cfg)
		elseif self.rightViewType == TYPE_RUNE_INFO then
			self:showRuneInfoView(mo, cfg)
		elseif self.rightViewType == TYPE_REPLACE then
			self:showReplaceView(mo, cfg)
		end

		limitPetCount = mo:getSuitLimitPetCount()
	end

	local list = RuneModel.instance:findUseSuitPets(suitId)

	GuideController.instance:setViewVar("rune_suit_haspet", #list)

	local max = RuneConfig.instance:getSuitPetMax(suitId)

	for i = 1, 3 do
		local cell = self.cellList[i]
		local btnAdd = self.btnAddList[i]

		if max < i then
			GameUtil.SetActive(cell, false)
			GameUtil.SetActive(btnAdd, false)
		else
			GameUtil.SetActive(cell, true)
			GameUtil.SetActive(btnAdd, true)

			local lock = goutil.findChild(btnAdd, "imgLock")

			GameUtil.SetActive(lock, limitPetCount < i)

			local data = list[i]

			self:_upatePetCell(cell, btnAdd, data, limitPetCount)
		end
	end
end

function RuneeditView:showRuneInfoView(mo, cfg)
	GameUtil.SetActive(self.starInfo, true)

	local runeMo = mo:getRuneMoByIdx(self.currRuneIdx)

	if runeMo then
		MaterialMgr.setCellByData(MatType.Rune, runeMo, self.runeIcon)

		self.txtTypeRune.text = lang("类型：") .. RuneConfig.instance:getTypeName(runeMo:getType())
		self.txtStarNameRune.text = runeMo:getName()
		self.txtPowerRune.text = runeMo:getZDL()

		local list = GameUtil.propToList({
			runeMo:getProp()
		})

		self._tableviewRuneInfo:reloadData(list)
	else
		MaterialMgr.resetAll(self.runeIcon)

		self.txtTypeRune.text = ""
		self.txtStarNameRune.text = ""
		self.txtPowerRune.text = ""

		self._tableviewRuneInfo:reloadData({})
	end
end

function RuneeditView:showInsertView(mo, cfg)
	GameUtil.SetActive(self.starInsert, true)

	local attType = cfg.position[self.currRuneIdx]
	local runeMo = mo:getRuneMoByIdx(self.currRuneIdx)
	local list = RuneModel.instance:getAllTypeItems(attType, self.currSuitId, runeMo)

	ArraySort.sortOn(list, {
		"getZDL",
		"getQuality"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})
	self._tableviewInsert:reloadData(list)

	if #list > 0 then
		self._tableviewInsert:MoveCellInView(0)
	end

	local colorName = ""

	self.txtInsertLimit.text = ""

	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, self.currSuitId)

	if cfg and cfg.qualityLimit then
		local qualityLimit = cfg.qualityLimit

		colorName = GameUtil.HtmlColorTxt(ConstString.Quality[qualityLimit] .. lang("品质"), GameUtil.GetGoodsColor(qualityLimit - 1))
		colorName = colorName .. lang("及以下")
		self.txtInsertLimit.text = langPara("%s可镶嵌%s星辉", cfg.name, colorName)
	end

	self.txtNeed.text = attType == -1 and langPara("【任意%s星辉】", colorName) or langPara("【%s%s星辉】", colorName, RuneConfig.instance:getTypeName(attType))

	GameUtil.SetActive(self.imgEmptyInsert, list == nil or #list == 0)
end

function RuneeditView:showReplaceView(mo, cfg)
	GameUtil.SetActive(self.starReplace, true)

	local attType = cfg.position[self.currRuneIdx]
	local runeMo = mo:getRuneMoByIdx(self.currRuneIdx)

	if runeMo then
		self.txtPowerRep.text = runeMo:getZDL()
		self.txtTypeRep.text = lang("类型：") .. RuneConfig.instance:getTypeName(runeMo:getType())

		MaterialMgr.setCellByData(MatType.Rune, runeMo, self.iconRep)
	else
		MaterialMgr.resetAll(self.iconRep)

		self.txtPowerRep.text = ""
		self.txtTypeRep.text = ""
	end

	local list = RuneModel.instance:getAllTypeItems(attType, self.currSuitId, runeMo)

	ArraySort.sortOn(list, {
		"getZDL",
		"getQuality"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})
	self._tableviewRep:reloadData(list)

	if #list > 0 then
		self._tableviewRep:MoveCellInView(0)
	end

	GameUtil.SetActive(self.imgEmptyRep, list == nil or #list == 0)
end

function RuneeditView:tweenScale(from, to, callBack)
	local scale = GameUtil.getLocalScale(self.suitCon)

	if math.abs(to - scale.x) < 1e-05 then
		GameUtil.callBack(callBack)

		return
	end

	if self.tweenSc then
		self.tweenSc:Kill(false)

		self.tweenSc = nil
	end

	GameUtil.setLocalScale(self.suitCon, from, from, from)

	self.tweenSc = TweenUtil.ValueTo(from, to, 0.3, function(val)
		GameUtil.setLocalScale(self.suitCon, val, val, val)
	end, function()
		GameUtil.callBack(callBack)

		self.tweenSc = nil
	end, self)
end

function RuneeditView:tweenMove(fromX, fromY, toX, toY)
	local pos = GameUtil.getLocalPos(self.suitCon)

	if toX == pos.x and toY == pos.y then
		return
	end

	if self.tweenMv then
		self.tweenMv:Kill(false)

		self.tweenMv = nil
	end

	GameUtil.setLocalPos(self.suitCon, fromX, fromY, 0)

	local from = Vector2.New(fromX, fromY)
	local to = Vector2.New(toX, toY)

	self.tweenMv = TweenUtil.ValueTo(0, 1, 0.3, function(val)
		local pos = Vector2.Lerp(from, to, val)

		GameUtil.setLocalPos(self.suitCon, pos.x, pos.y, 0)
	end, function()
		self.tweenMv = nil
	end, self)
end

function RuneeditView:showInfoView(mo, cfg)
	self:tweenScale(1, 0.7)

	local pos = GameUtil.getLocalPos(self.suitCon)

	self:tweenMove(pos.x, pos.y, 0, 0)

	if self.currProxy then
		self.currProxy.binder:clearEff()
	end

	GameUtil.SetActive(self.starEdit, true)
	GameUtil.SetActive(self.txtEmptyTop, false)
	GameUtil.SetActive(self.txtEmptyDown, false)

	self.txtStarName.text = cfg.name
	self.txtRule.text = cfg.posDesc

	self:addEffect(mo:getSuitZDL())

	self.txtDesc.text = ""

	local lvl, tem, count = mo:getCurLvl()

	if lvl > 0 then
		self.txtLevelNum.text = "总等级：" .. count .. lang("级")
		self.txtLevel.text = GameUtil.getChineseNumber(lvl) .. "阶星座增益"
		self.txtDesc.text = "" .. tem.buff_desc
	else
		self.txtLevelNum.text = ""
		self.txtLevel.text = lang("未激活星座增益")

		local temp = RuneConfig.instance:getSuitEffById(mo:getDefineId())

		self.txtDesc.text = langPara("<color='#eb4642'>当前所有装备星辉总等级为：<color='#1cc2ff'>%s级</color>\n总等级达<color='#1cc2ff'> %s级 </color>后获得一阶星座增益</color>", count, temp[1].needLevel)
	end

	local arr

	arr = tem and GameUtil.propToList({
		tem.propertyApp
	}) or arr

	local list = mo:getExtProps()

	list = self:combineArr(list, arr)

	self._tableviewDown:reloadData(list)
	self._tableviewDown:MoveCellInView(0)
	GameUtil.SetActive(self.txtEmptyDown, list == nil or #list == 0)
end

function RuneeditView:combineArr(arr, ext)
	arr = arr or {}
	ext = ext or {}

	local temp = {}

	for k, ex in ipairs(ext) do
		local has = false

		for _k, v in ipairs(arr) do
			if v.name == ex.name then
				v.ext = ex.value
				has = true

				break
			end
		end

		if has == false then
			table.insert(temp, ex)
		end
	end

	for i, v in ipairs(temp) do
		v.ext = v.value
		v.value = 0

		table.insert(arr, v)
	end

	return arr
end

function RuneeditView:addEffect(power)
	local last = checknumber(self.txtPower.text)
	local power = checknumber(power)

	if self.hasPowinited == false or last == power then
		self.txtPower.text = power
	else
		local name = "fx_ui_runeview/fx_ui_runeeditview_powerupdowneffects.prefab"
		local go = self:getGo("right/starEdit/txtPower/imgPower")

		self.txtPower.text = ""

		local light = UIEffectManager.instance:playEffect(self, name, go, 40, 0, false, nil, function()
			self.txtPower.text = power
		end, function(ta, eff)
			local effGo = eff.effGo
			local down = goutil.findChild(effGo, "numberdown")
			local up = goutil.findChild(effGo, "numberup")

			GameUtil.SetActive(down, last > power)
			GameUtil.SetActive(up, last < power)
		end)

		light:setParent(go.transform)
		light:setScale(1)

		self._fingerEff = light
	end

	self.hasPowinited = true
end

function RuneeditView:onClickBg()
	self.currRuneIdx = -1

	RuneController.instance:setViewCurRuneIdx(self.currRuneIdx)
	self:changeSuitInfo(TYPE_INFO)
end

function RuneeditView:onClickCell(posIdx, data, container)
	self:tweenScale(0.7, 1, function()
		if self.currProxy then
			self.currProxy.binder:showSelected(posIdx, self)
		end
	end)

	local pos1 = GameUtil.getLocalPos(self.suitCon)
	local pos = GameUtil.getLocalPos(container)

	self:tweenMove(pos1.x, pos1.y, -pos.x, -pos.y)

	self.currRuneIdx = posIdx

	RuneController.instance:setViewCurRuneIdx(self.currRuneIdx)

	local params = self._viewPresentor:getOpenParam()

	if params then
		params[3] = posIdx

		UIStateManager.instance:updateParms(self._viewPresentor.viewName, params)
	end

	if data == nil then
		self:showRuneInsertViewForce()
	else
		self:showRuneInfoViewForce()
	end
end

function RuneeditView:_updateRep(view, cell, data)
	self:setRuneCell(cell, data, 1)
end

function RuneeditView:_clearRep(cell)
	self:clearRuneCell(cell)
end

function RuneeditView:_clearInsert(cell)
	self:clearRuneCell(cell)
end

function RuneeditView:_updateInsert(view, cell, data)
	self:setRuneCell(cell, data)
end

function RuneeditView:clearRuneCell(cell, data, type)
	local con = goutil.findChild(cell, "con")
	local btnInsert = goutil.findChild(cell, "btnInsert")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btnInsert)
end

function RuneeditView:setRuneCell(cell, data, type)
	local starIcon = goutil.findChild(cell, "starIcon")
	local iconEquiped = goutil.findChild(cell, "iconEquiped")
	local con = goutil.findChild(cell, "con")
	local btnInsert = goutil.findChild(cell, "btnInsert")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")
	local txtType = goutil.findChildTextComponent(cell, "txtType")
	local txtOp = goutil.findChildTextComponent(cell, "btnInsert/Text")

	MaterialMgr.setCellByData(MatType.Rune, data, con)

	txtPower.text = data:getZDL()
	txtType.text = lang("类型：") .. RuneConfig.instance:getTypeName(data:getType())

	GameUtil.SetActive(starIcon, false)
	GameUtil.SetActive(iconEquiped, false)

	if data.suitId > 0 then
		GameUtil.SetActive(starIcon, true)
		GameUtil.SetActive(iconEquiped, true)
		GameUtil.setUIImageSpriteIdx(starIcon, data.suitId - 1)

		txtOp.text = lang("替换")
	else
		txtOp.text = type == 1 and lang("替换") or lang("镶嵌")
	end

	GameUtil.addClickHandler(btnInsert, GameUtil.handler(self.onInsertClick, self, data))
end

function RuneeditView:_updateRuneInfo(view, cell, data)
	self:setAttrData(cell, cell.index, data)
end

function RuneeditView:_updateCellTop(view, cell, data)
	self:setAttrData(cell, cell.index, data)
end

function RuneeditView:_updateCellDown(view, cell, data)
	self:setAttrData(cell, cell.index, data)
end

function RuneeditView:setAttrData(container, idx, data)
	local img = container:GetComponent(goutil.Type_UIImage)
	local icon = goutil.findChild(container, "icon")
	local iconState = GameUtil.getUIImageSpriteChange(icon)
	local txtAttrName = goutil.findChildTextComponent(container, "txtAttrName")
	local txtRate = goutil.findChildTextComponent(container, "txtRate")

	if idx % 2 == 0 then
		Framework.ColorUtil.SetImageColor(img, "#00000020")
	else
		Framework.ColorUtil.SetImageColor(img, "#00000000")
	end

	txtAttrName.text = data.name

	local idx = table.indexof(GameEnum.AttrTypeName, data.name)

	iconState:SetState((idx ~= false or nil) and idx - 1)

	txtRate.text = data.ext and GameUtil.getValueOrPercent(data.value) .. " <color='#60EE85'>+" .. GameUtil.getValueOrPercent(data.ext) .. "</color>" or GameUtil.getValueOrPercent(data.value)
end

function RuneeditView:setOnekeyEanble(type)
	self.currOnekeyTime = ServerTime.now()

	if type then
		GameUtil.SetGray(self.btnEquip, true)
		settimer(1, function()
			GameUtil.SetGray(self.btnEquip, false)
		end, nil, false)
		self:changeSuitInfo(type)
	end
end

function RuneeditView:onEquip()
	if ServerTime.now() - self.currOnekeyTime > 1 then
		RuneController.instance:sendOneKeyRune(self.currSuitId, GameUtil.handler(self.setOnekeyEanble, self, TYPE_INFO))
	end
end

function RuneeditView:onUnload()
	RuneController.instance:oneKeyUninstallAll(self.currSuitId, GameUtil.handler(self.changeSuitInfo, self, TYPE_INFO))
end

function RuneeditView:onUnloadRune()
	RuneController.instance:uninstallRune(self.currSuitId, self.currRuneIdx, GameUtil.handler(self.showRuneInsertViewForce, self))
end

function RuneeditView:onReplaceClick()
	self:changeSuitInfo(TYPE_REPLACE)
end

function RuneeditView:onLvlupClick()
	local mo = RuneModel.instance:getSuitMo(self.currSuitId)

	if mo then
		local runeMo = mo:getRuneMoByIdx(self.currRuneIdx)

		if runeMo then
			UIStateManager.instance:push(ViewName.RunelevelupView, runeMo.runeId)
		end
	end
end

function RuneeditView:onInsertClick(runeMo)
	RuneController.instance:onInsertClick(self.currSuitId, self.currRuneIdx, runeMo, GameUtil.handler(self.showRuneInfoViewForce, self))
end

function RuneeditView:showRuneInfoViewForce()
	self:changeSuitInfo(TYPE_RUNE_INFO)
end

function RuneeditView:showRuneInsertViewForce()
	self:changeSuitInfo(TYPE_INSERT)
end

function RuneeditView:onTipsClick()
	local data = self.suitmo
	local suitmo = RuneModel.instance:getSuitMo(data.suitId)

	UIStateManager.instance:push(ViewName.RunegainView, suitmo)
end

function RuneeditView:onClickHelp()
	UIStateManager.instance:push(ViewName.RulesView, "rune_help_tips")
end

function RuneeditView:onClickClose()
	RuneController.instance:setViewCurType(-1)
	RuneController.instance:setViewCurRuneIdx(-1)
	self:close()
end

return RuneeditView
