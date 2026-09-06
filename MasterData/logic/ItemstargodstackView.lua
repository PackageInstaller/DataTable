-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItemstargodstackView.lua

module("logic.extensions.itembag.stack.ItemstargodstackView", package.seeall)

local ItemstargodstackView = class("ItemstargodstackView", ViewComponent)

function ItemstargodstackView:ctor()
	ItemstargodstackView.super.ctor(self)
end

function ItemstargodstackView:buildUI()
	ItemstargodstackView.super.buildUI(self)

	self.layoutGroup = self:getGo("info/btnsGrid"):GetComponent("GridLayoutGroup")
	self.layoutGroup.enabled = false
	self._sellButton = self:getBtn("info/btnsGrid/BtnSell")
	self._useButton = self:getBtn("info/btnsGrid/BtnUse")
	self._mergeButton = self:getBtn("info/btnsGrid/BtnMerge")
	self._sourceBtn = self:getBtn("info/btnSource")
	self._nameTxt = self:getTxt("info/txtName")
	self.group = self:getGo("info/txtName"):GetComponent("UIChangeGroup")
	self._descTxt = self:getGo("info/bottom/ScrollView/Viewport/content/txtDesc"):GetComponent("Text")
	self.itemCell = self:getGo("info/icon")
	self.txtNum = self:getTxt("info/txtPower")
	self.ImgC_Line = self:getGo("info/ImgC_Line")
	self.jobcell = self:getGo("info/jobcell")
	self.attrcell = self:getGo("info/attrcell")
	self.attrupcell = self:getGo("info/attrupcell")
	self.txtJob = self:getTxt("info/jobcell/txtJob")
	self.txtAttr = self:getTxt("info/attrcell/txtAttr")
	self.txtDesc = self:getTxt("info/attrupcell/txtDesc")

	GameUtil.SetActive(self.attrcell, false)

	self.cell = self:getGo("info/cell")
	self.ScrollView = self:getGo("info/ScrollView")
	self._tableview = ScrollerList.create(self.ScrollView, self.cell, GameUtil.handler(self._updateCell, self))
end

function ItemstargodstackView:bindEvents()
	ItemstargodstackView.super.bindEvents(self)
	self._sellButton:AddClickListener(self._onClickSell, self)
	self._useButton:AddClickListener(self._onClickUse, self)
	self._mergeButton:AddClickListener(self._onClickMerge, self)
	self._sourceBtn:AddClickListener(self._onClickSource, self)
end

function ItemstargodstackView:unbindEvents()
	ItemstargodstackView.super.unbindEvents(self)
	self._sellButton:RemoveClickListener()
	self._useButton:RemoveClickListener()
	self._mergeButton:RemoveClickListener()
	self._sourceBtn:RemoveClickListener()
end

function ItemstargodstackView:destroyUI()
	ItemstargodstackView.super.destroyUI(self)
end

function ItemstargodstackView:onEnter()
	ItemstargodstackView.super.onEnter(self)
	self:_refreshList()
	GlobalDispatcher:addListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
end

function ItemstargodstackView:onEnterFinished()
	ItemstargodstackView.super.onEnterFinished(self)
end

function ItemstargodstackView:onExit()
	ItemstargodstackView.super.onExit(self)
	GlobalDispatcher:removeListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
	self._tableview:dispose()
end

function ItemstargodstackView:onExitFinished()
	ItemstargodstackView.super.onExitFinished(self)
end

function ItemstargodstackView:_onClickSell()
	return
end

function ItemstargodstackView:_onClickUse()
	local data = ItemBagModel.instance:getCurrItem()

	if data then
		UIStateManager.instance:push(ViewName.RunelevelupView, data.runeId)
	end
end

function ItemstargodstackView:_onClickMerge()
	return
end

function ItemstargodstackView:_onClickSource()
	return
end

function ItemstargodstackView:_updateCell(view, cell, data)
	local colorSp = GameUtil.getUIImageColorChange(cell)
	local attrIconSpt = goutil.findChildComponent(cell, "attrIcon", "UIImageSpriteChange")
	local qhNameTxt = goutil.findChildTextComponent(cell, "attrName")
	local qhNowCountTxt = goutil.findChildTextComponent(cell, "txtNum")
	local name = data.name
	local value = data.value
	local idx = table.indexof(GameEnum.AttrTypeName, name)

	attrIconSpt:SetState(idx - 1)
	colorSp:SetState((1 + cell.data) % 2)

	qhNameTxt.text = name
	qhNowCountTxt.text = GameUtil.getValueOrPercent(value)
end

function ItemstargodstackView:_refreshList()
	local data = ItemBagModel.instance:getCurrItem()
	local type = MaterialMgr.getMoType(data)

	if type == MatType.Rune then
		self:_refreshTip(data)
	end
end

function ItemstargodstackView:_refreshTip(data)
	self._nameTxt.text = data:getName()
	self.txtJob.text = data:getTypeName()

	local cfgId = data:getDefineId()
	local cfg = MaterialMgr.getMatCfg(MatType.Rune, cfgId)

	self.group:SetState(cfg.quality or 0)

	self.txtDesc.text = cfg.desc
	self.txtNum.text = data:getZDL()

	MaterialMgr.setIcon(self.itemCell, MatType.Rune, cfgId)

	local curArr = GameUtil.propToList({
		data:getProp()
	})

	self._tableview:reloadData(curArr)
	self._sellButton.gameObject:SetActive(false)
	self._useButton.gameObject:SetActive(false)
	self._mergeButton.gameObject:SetActive(false)

	if FuncOpenModel.instance:getFuncIsOpen(72) then
		local maxLvl = RuneConfig.instance:getRuneMaxLevel(cfgId)

		if maxLvl > data.level then
			self._useButton.gameObject:SetActive(true)
		end
	end

	self.layoutGroup:CalculateLayoutInputHorizontal()
	self.layoutGroup:CalculateLayoutInputVertical()
	self.layoutGroup:SetLayoutHorizontal()
	self.layoutGroup:SetLayoutVertical()
end

return ItemstargodstackView
