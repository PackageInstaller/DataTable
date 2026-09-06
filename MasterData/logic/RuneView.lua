-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RuneView.lua

module("logic.extensions.rune.view.RuneView", package.seeall)

local RuneView = class("RuneView", ViewComponent)
local TYPE_INFO = 1
local TYPE_PET = 2

function RuneView:ctor()
	RuneView.super.ctor(self)
end

function RuneView:buildUI()
	RuneView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnHelp = self:getGo("btnHelp")
	self.btnStarResolve = self:getGo("btnStarResolve")
	self.btnStarExchange = self:getGo("btnStarExchange")
	self.suitCon = self:getGo("suitCon/con")

	GameUtil.setLocalScale(self.suitCon, 0.7, 0.7, 0.7)

	local scrollerGo = self:getGo("ScrollView")
	local cellGo = self:getGo("tabStar")

	self._tableview = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self))
	self.rightView = self:getGo("right")
	self.apply = self:getGo("right/apply")
	self.txtName = self:getTxt("right/apply/txtName")
	self.btnCloseApply = self:getGo("right/apply/btnClose")
	self.btnCloseBg = self:getGo("right/apply/btnCloseBg")
	self.imgEmpty = self:getGo("right/apply/imgEmpty")
	self.scrollList = self:getGo("right/apply/ScrollList")
	self.cell = self:getGo("right/apply/cell")
	self._tableviewPet = ScrollerList.create(self.scrollList, self.cell, GameUtil.handler(self._upatePetCell, self), GameUtil.handler(self.clearPetCell, self))
	self.starEdit = self:getGo("right/starEdit")
	self.txtEmptyTop = self:getGo("right/starEdit/txtEmptyTop")
	self.txtEmptyDown = self:getGo("right/starEdit/txtEmptyDown")
	self.txtStarName = self:getTxt("right/starEdit/txtStarName")
	self.txtDesc = self:getTxt("right/starEdit/txtDesc")
	self.txtPower = self:getTxt("right/starEdit/txtPower")
	self.txtLevel = self:getTxt("right/starEdit/levelUp/txtLevel")
	self.txtLevelNum = self:getTxt("right/starEdit/levelUp/txtLevelNum")
	self.btnTip = self:getGo("right/starEdit/levelUp/btnTip")
	self.btnStarEdit = self:getGo("right/starEdit/btnStarEdit")
	self.btnApply = self:getGo("right/starEdit/btnApply")
	self.ScrollTop = self:getGo("right/starEdit/ScrollTop")
	self.ScrollDown = self:getGo("right/starEdit/ScrollDown")
	self.attrItem = self:getGo("right/starEdit/attrItem")
	self._tableviewTop = ScrollerList.create(self.ScrollTop, self.attrItem, GameUtil.handler(self._updateCellTop, self))
	self._tableviewDown = ScrollerList.create(self.ScrollDown, self.attrItem, GameUtil.handler(self._updateCellDown, self))
end

function RuneView:bindEvents()
	RuneView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnHelp, self.onClickHelp, self)
	GameUtil.addClickHandler(self.btnStarResolve, self.onResolveClick, self)
	GameUtil.addClickHandler(self.btnStarExchange, self.onExchange, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickTip, self)
	GameUtil.addClickHandler(self.btnStarEdit, self.onEditClick, self)
	GameUtil.addClickHandler(self.btnApply, self.onApplyClick, self)
	GameUtil.addClickHandler(self.btnCloseApply, self.onCloseApplyClick, self)
	GameUtil.addClickHandler(self.btnCloseBg, self.onCloseApplyClick, self)
end

function RuneView:unbindEvents()
	RuneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnHelp)
	GameUtil.rmClickHandler(self.btnStarResolve)
	GameUtil.rmClickHandler(self.btnStarExchange)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnStarEdit)
	GameUtil.rmClickHandler(self.btnApply)
	GameUtil.rmClickHandler(self.btnCloseApply)
	GameUtil.rmClickHandler(self.btnCloseBg)
end

function RuneView:close()
	RuneModel.instance:setCurrTabIdx(nil)
	RuneView.super.close(self)
end

function RuneView:destroyUI()
	RuneView.super.destroyUI(self)
end

function RuneView:onEnter()
	RuneView.super.onEnter(self)

	self.rightViewType = TYPE_INFO
	self.firstType = TYPE_INFO

	local param = self._viewPresentor:getFirstParam()

	if param then
		local mo = param

		if mo and mo.runeSuit and mo.runeSuit.runeSuitId > 0 then
			self.currPetMo = mo
			self.currSuitId = mo.runeSuit.runeSuitId
			self.firstType = TYPE_PET
		end
	end

	RuneController.instance:initAllInfo(GameUtil.handler(self.firstInit, self))

	local name = "fx_ui_runeview/fx_ui_runeview_bgeffects.prefab"
	local light = UIEffectManager.instance:playEffect(self, name, self.mainGO, 0, 0, true, nil, function()
		return
	end, function(ta, eff)
		eff:setVisible(true)
	end)

	light:setParent(self.mainGO.transform)
	light:setScale(1)
	light:setVisible(true)

	self._fingerEff = light
end

function RuneView:onEnterFinished()
	RuneView.super.onEnterFinished(self)
end

function RuneView:onExit()
	RuneView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)
	self._tableview:dispose()
	self._tableviewDown:dispose()
	self._tableviewPet:dispose()
	self._tableviewTop:dispose()

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end
end

function RuneView:onExitFinished()
	RuneView.super.onExitFinished(self)
end

function RuneView:firstInit()
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
	self:changeSuitInfo(self.firstType)
	GlobalDispatcher:addListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)
end

function RuneView:refresh()
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

function RuneView:clearPetCell(cell)
	local con = goutil.findChild(cell, "pet/con")

	MaterialMgr.resetAll(con)
end

function RuneView:_upatePetCell(view, cell, data)
	local btnAdd = goutil.findChild(cell, "btnAdd")
	local pet = goutil.findChild(cell, "pet")
	local con = goutil.findChild(cell, "pet/con")
	local reduceBtn = goutil.findChild(cell, "pet/reduceBtn")

	GameUtil.SetActive(btnAdd, false)
	GameUtil.SetActive(pet, false)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(reduceBtn)
	MaterialMgr.resetAll(con)

	if type(data) == "number" then
		GameUtil.SetActive(btnAdd, true)
		GameUtil.addClickHandler(btnAdd, self.onAddPet, self)
	else
		GameUtil.SetActive(pet, true)
		GameUtil.addClickHandler(reduceBtn, GameUtil.handler(self.onReduceClick, self, data))
		MaterialMgr.setCellByData(MatType.Pet, data, con)
	end
end

function RuneView:_updateCellTop(view, cell, data)
	self:setAttrData(cell, cell.index, data)
end

function RuneView:_updateCellDown(view, cell, data)
	self:setAttrData(cell, cell.index, data)
end

function RuneView:setAttrData(container, idx, data)
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

	txtRate.text = GameUtil.getValueOrPercent(data.value)
end

function RuneView:_updateCell(view, cell, data)
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

function RuneView:onClickTab(data)
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(data.unlockCondition)

	if isOpen then
		self.currSuitId = data.suitId

		RuneModel.instance:setCurrTabIdx(self.currSuitId)
		self:refresh()
	else
		local suitmo = RuneModel.instance:getSuitMo(data.suitId)

		UIStateManager.instance:push(ViewName.RunegainView, suitmo)
	end
end

function RuneView:showSuit(suitId)
	RuneModel.instance:setCurrTabIdx(suitId)

	local data = MaterialMgr.getModel(MatType.Rune_Suit, suitId)
	local proxy = data and MaterialMgr.setCellByData(MatType.Rune_Suit, data, self.suitCon) or MaterialMgr.setCell(MatType.Rune_Suit, suitId, self.suitCon)

	if proxy then
		proxy.binder:setAllItemActive(false)
		proxy.binder:setCallBack(GameUtil.handler(self.onEditClick, self))
	end

	local index = self:getCellIdx(suitId)

	self._tableview:MoveCellInView(index - 1)
end

function RuneView:getCellIdx(suitId)
	local list = self._tableview:getData()

	for i, v in ipairs(list) do
		if v.suitId == suitId then
			return i
		end
	end
end

function RuneView:changeSuitInfo(type)
	local guiding = GuideController.instance:checkBranchIsGuiding(GuideConst.BRANCH_XINGSHEN_65)

	if self.rightViewType ~= type and not guiding then
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

	self:showCurrSuitInfo(self.currSuitId)
end

function RuneView:showCurrSuitInfo(suitId)
	GameUtil.SetActive(self.starEdit, false)
	GameUtil.SetActive(self.apply, false)

	local mo = RuneModel.instance:getSuitMo(suitId)
	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, suitId)

	if mo then
		if self.rightViewType == TYPE_INFO then
			self:showInfoView(mo, cfg)
		else
			GameUtil.SetActive(self.apply, true)

			self.txtName.text = cfg.name .. lang("的应用精灵")

			local list = RuneModel.instance:findUseSuitPets(suitId)

			table.insert(list, 1, 0)
			self._tableviewPet:reloadData(list)

			if self.currPetMo then
				local idx = table.indexof(list, self.currPetMo)

				if idx ~= false then
					self._tableviewPet:MoveCellInView(idx - 1)

					self.currPetMo = nil
				end
			end

			GameUtil.SetActive(self.imgEmpty, #list == 1)
		end
	end
end

function RuneView:showInfoView(mo, cfg)
	GameUtil.SetActive(self.starEdit, true)
	GameUtil.SetActive(self.txtEmptyTop, false)
	GameUtil.SetActive(self.txtEmptyDown, false)

	self.txtStarName.text = cfg.name
	self.txtPower.text = mo:getSuitZDL()

	local lvl, tem, count = mo:getCurLvl()

	self.txtDesc.text = ""

	if lvl > 0 then
		self.txtLevelNum.text = count .. lang("级")
		self.txtLevel.text = GameUtil.getChineseNumber(lvl) .. "阶属性增益"
		self.txtDesc.text = "" .. tem.buff_desc
	else
		self.txtLevelNum.text = ""
		self.txtLevel.text = "额外属性增益"
	end

	if tem then
		local arr = GameUtil.propToList({
			tem.propertyApp
		})

		self._tableviewTop:reloadData(arr)
	else
		self._tableviewTop:reloadData({})
		GameUtil.SetActive(self.txtEmptyTop, true)
	end

	local list = mo:getExtProps()

	self._tableviewDown:reloadData(list)
	self._tableviewDown:MoveCellInView(0)
	self._tableviewTop:MoveCellInView(0)
	GameUtil.SetActive(self.txtEmptyDown, list == nil or #list == 0)
end

function RuneView:onApplyClick()
	self:changeSuitInfo(TYPE_PET)
end

function RuneView:onCloseApplyClick()
	self:changeSuitInfo(TYPE_INFO)
end

function RuneView:onEditClick()
	UIStateManager.instance:push(ViewName.RuneEditView, self.currSuitId)
end

function RuneView:onClickTip()
	local suitmo = RuneModel.instance:getSuitMo(self.currSuitId)

	UIStateManager.instance:push(ViewName.RunegainView, suitmo)
end

function RuneView:onResolveClick()
	UIStateManager.instance:push(ViewName.RuneresolveView, self.currSuitId)
end

function RuneView:onExchange()
	GotoMgr.gotoByString("func#470#Exchange3v3")
end

function RuneView:onClickHelp()
	UIStateManager.instance:push(ViewName.RulesView, "rune_help_tips")
end

function RuneView:onAddPet()
	local function onSeletCallBack(data)
		if data and #data > 0 then
			UIStateManager.instance:push(ViewName.RunechangeapplyView, self.currSuitId, data, function()
				RuneAgent.instance:sendPM_RuneBatchEquipSuitReq(self.currSuitId, data, function(msg)
					self:showCurrSuitInfo(self.currSuitId)
				end)
			end)
		end
	end

	local function filterFunc(petMo)
		if petMo.runeSuit and petMo.runeSuit.runeSuitId == self.currSuitId then
			return false
		end

		return true
	end

	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, self.currSuitId)

	PetSelectController.instance:OpenView(false, langPara("请选择使用%s的精灵", cfg.name), filterFunc, onSeletCallBack, nil)
end

function RuneView:onReduceClick(petMo)
	TipsFacade.instance:openPopupWindow(lang("tip"), "确定要卸载此精灵身上的星座吗？", function()
		RuneAgent.instance:sendPM_RunePetUnEquipSuitReq(petMo.petId, function(msg)
			self:showCurrSuitInfo(self.currSuitId)
		end)
	end)
end

return RuneView
