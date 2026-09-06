-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcompose/view/PetComposeView.lua

module("logic.extensions.petcompose.view.PetComposeView", package.seeall)

local PetComposeView = class("PetComposeView", TableViewComponent)

PetComposeView.TabType = {
	SR_2_SSR = 2,
	R_2_SR = 1
}

function PetComposeView:ctor()
	PetComposeView.super.ctor(self)

	self._composeItemList = {}
end

function PetComposeView:_getPath()
	return {
		cellPath = "listView/Cell",
		viewPath = "listView/ScrollView"
	}
end

function PetComposeView:destroyUI()
	PetComposeView.super.destroyUI(self)
end

function PetComposeView:onExitFinished()
	PetComposeView.super.onExitFinished(self)
end

function PetComposeView:onEnterFinished()
	PetComposeView.super.onEnterFinished(self)
end

function PetComposeView:unbindEvents()
	PetComposeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._sr2ssrBtn:RemoveClickListener()
	self._r2srBtn:RemoveClickListener()
	self._onekeyBtn:RemoveClickListener()
	self._composeBtn:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
end

function PetComposeView:bindEvents()
	PetComposeView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._sr2ssrBtn:AddClickListener(self._onClickSR2SSR, self)
	self._r2srBtn:AddClickListener(self._onClickR2SR, self)
	self._onekeyBtn:AddClickListener(self._onClickOneKey, self)
	self._composeBtn:AddClickListener(self._onClickCompose, self)
	self._btnHelp:AddClickListener(self._onHelp, self)
end

function PetComposeView:onExit()
	PetComposeView.super.onExit(self)

	PetComposeController.instance.isViewOpen = false

	PetComposeController.instance:playGetPet()
	MaterialMgr.resetAll(self._tableview.gameObject)
	GlobalDispatcher:removeListener(PetAgent.PM_PetRareComposeRes, self._onPetComposeRes, self)

	for k, item in pairs(self._composeItemList) do
		item:onExit()
	end

	MaterialMgr.clearIcon(self._costIcon)
end

function PetComposeView:buildUI()
	PetComposeView.super.buildUI(self)

	self._closeButton = self:getBtn("closeBG/btnClose")
	self._sr2ssrBtn = self:getBtn("btnSR2SSR")
	self._r2srBtn = self:getBtn("btnR2SR")
	self._sr2ssrBtnChange = self._sr2ssrBtn.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	self._r2srBtnChange = self._r2srBtn.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	self._onekeyBtn = self:getBtn("btnOneKey")
	self._composeBtn = self:getBtn("btnCompose")
	self._composeTipText = goutil.findChildTextComponent(self.mainGO, "composeTip")
	self._costText = goutil.findChildTextComponent(self.mainGO, "txtMoney")
	self._costIcon = self:getGo("txtMoney/icon_diamotask")
	self._composeParent = self:getGo("composeCon").transform
	self._composeItemCell = self:getGo("composeCon/cell")
	self._composeItemCellCon = self:getGo("composeCon/itemCon").transform
	self._composeItemLayout = self:getGo("composeCon/itemCon"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._nonSpriteGo = self:getGo("listView/NonSprite")
	self._blockMask = self:getGo("blockMask")
	self._targetGo = self:getGo("composeCon/targetPoint")
	self._btnHelp = self:getBtn("btnHelp")
	self._goldBarCon = self:getGo("goldBarCon")
	self._targetBgChange = self:getGo("composeCon/targetBg"):GetComponent(ComponentType.UIImageSpriteChange)
end

function PetComposeView:onEnter()
	PetComposeView.super.onEnter(self)

	PetComposeController.instance.isViewOpen = true

	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Tili
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
	GlobalDispatcher:addListener(PetAgent.PM_PetRareComposeRes, self._onPetComposeRes, self)
	self:_switchTab(PetComposeView.TabType.R_2_SR, true)
end

function PetComposeView:_onClickClose()
	self:close()
end

function PetComposeView:_onClickSR2SSR()
	self:_switchTab(PetComposeView.TabType.SR_2_SSR)
end

function PetComposeView:_onClickR2SR()
	self:_switchTab(PetComposeView.TabType.R_2_SR)
end

function PetComposeView:_onClickOneKey()
	local pets = BagModel.instance:getPets()
	local list = {}
	local currNum = self:_getCurrSelectNum()

	if currNum >= self._MaxSelectNum then
		FloatWordMgr.instance:show("一键放入成功")

		return
	end

	if pets then
		for k, v in pairs(pets) do
			if currNum < self._MaxSelectNum and v:isExist() and not self._selectIdList[v.petId] and self:_getCurNeedRare() == v:getRare() and not v:isLocked() then
				table.insert(list, v)

				currNum = currNum + 1
			end
		end
	end

	if #list <= 0 then
		FloatWordMgr.instance:show("无符合精灵")

		return
	end

	for i, v in ipairs(list) do
		self:_onClickRightPet(v)
	end

	FloatWordMgr.instance:show("一键放入成功")
end

function PetComposeView:_onClickCompose()
	local num = self:_getCurrSelectNum()

	if num < self._MaxSelectNum then
		FloatWordMgr.instance:show("未满足合成条件")

		return
	end

	local matStr = PetComposeConfig.instance:getCostStrByRare(self:_getCurNeedRare())
	local isEnough = MaterialFacade.instance:isMatsEnough(matStr)

	if not isEnough then
		FloatWordMgr.instance:show("钻石不足")
		MaterialMgr.openGetSource(MatType.Diamond, MatType.Diamond_Binding)

		return
	end

	local list = {}

	for k, v in pairs(self._selectIdList) do
		if v then
			table.insert(list, k)
		end
	end

	if #list > 0 then
		PetAgent.instance:sendPM_PetRareComposeReq(list)
	else
		FloatWordMgr.instance:show("未选中精灵")
	end
end

function PetComposeView:_onHelp()
	TipsFacade.instance:openRulesView("petcompose")
end

function PetComposeView:_doComposeAnim()
	goutil.setActive(self._blockMask, true)

	self._composeItemLayout.enabled = false

	self._targetGo.transform:SetParent(self._composeItemCellCon)

	local callNum = 0

	local function finishCall()
		callNum = callNum + 1

		if callNum >= self._MaxSelectNum then
			self._targetGo.transform:SetParent(self._composeParent)

			self._composeItemLayout.enabled = false

			goutil.setActive(self._blockMask, false)
			self:_switchTab(self._currTabType, true)
		elseif callNum + 1 >= self._MaxSelectNum then
			PetComposeController.instance:playGetPet(true)
		end
	end

	for k, item in pairs(self._composeItemList) do
		item:doTweenTo(self._targetGo.transform.localPosition, finishCall)
	end
end

function PetComposeView:_getCurNeedRare(tabType)
	return ((tabType or self._currTabType) == PetComposeView.TabType.R_2_SR or nil) and (GameEnum.PetRare.R or GameEnum.PetRare.SR)
end

function PetComposeView:_switchTab(tabType, force)
	if tabType == self._currTabType and not force then
		return
	end

	self._selectPetList = {}
	self._selectIdList = {}
	self._currTabType = tabType

	self:_updateBtnState(tabType)
	self:_updateComposeItems(tabType)
	self:_updatePetView(tabType)
end

function PetComposeView:_updateBtnState(tabType)
	self._r2srBtnChange:SetState(tabType == PetComposeView.TabType.R_2_SR and 1 or 0)
	self._sr2ssrBtnChange:SetState(tabType == PetComposeView.TabType.SR_2_SSR and 1 or 0)
	self._targetBgChange:SetState(tabType == PetComposeView.TabType.SR_2_SSR and 1 or 0)
end

function PetComposeView:_updateComposeItems(tabType)
	local needRare = self:_getCurNeedRare(tabType)
	local num = PetComposeConfig.instance:getNeedPetNumByRare(needRare)

	self._MaxSelectNum = num

	for i, item in ipairs(self._composeItemList) do
		item:setVisible(false)
	end

	for i = 1, num do
		local item = self._composeItemList[i]

		if not item then
			local cell = goutil.cloneAndSetParent(self._composeItemCell, self._composeItemCellCon)

			GameUtil.setLocalScale(cell, 0.8)

			item = PetComposeItem.AddOnce(cell)
			self._composeItemList[i] = item
		end

		item:clear()
		item:setVisible(true)
	end

	local index = 1

	for k, v in pairs(self._selectPetList) do
		if v then
			local item = self._composeItemList[index]

			if item then
				item:onEnter()
				item:setData(v, self._onClickComposeItem, self)
			else
				printInfo("肯定是逻辑错了===", index, self._MaxSelectNum)
			end

			index = index + 1
		end
	end

	self._composeItemLayout.enabled = true

	local currRareStr = tabType == PetComposeView.TabType.R_2_SR and "幻兽" or "超能"
	local nextRareStr = tabType == PetComposeView.TabType.R_2_SR and "超能" or "传说"

	self._composeTipText.text = string.format("需要%s个%s精灵，随机合成1个%s精灵", self._MaxSelectNum, currRareStr, nextRareStr)

	local matStr = PetComposeConfig.instance:getCostStrByRare(self:_getCurNeedRare())
	local list = string.split(matStr, ":")

	self._costText.text = list[3]

	MaterialMgr.setIcon(self._costIcon, checknumber(list[1]), checknumber(list[2]))
end

function PetComposeView:_updatePetView(tabType)
	local pets = BagModel.instance:getPets()
	local list = {}
	local needRare = self:_getCurNeedRare(tabType)

	if pets then
		for k, v in pairs(pets) do
			if v:isExist() and v:getRare() == needRare then
				table.insert(list, v)
			end
		end
	end

	goutil.setActive(self._nonSpriteGo, #list <= 0)

	self._curViewDatas = list

	self:reloadData()
end

function PetComposeView:_updateCell(view, cell, data)
	local selectGo = goutil.findChild(cell.gameObject, "Selected")
	local iconCon = goutil.findChild(cell.gameObject, "Icon")
	local proxy = MaterialMgr.setCellByMo(data, iconCon)

	goutil.setActive(selectGo, self._selectIdList[data.petId])
	proxy.binder:setCallBack(function()
		self:_onClickRightPet(data, selectGo)
	end)
end

function PetComposeView:_onClickRightPet(data)
	local petId = data.petId

	if not self._selectIdList[petId] then
		local num = self:_getCurrSelectNum()

		if num >= self._MaxSelectNum then
			FloatWordMgr.instance:show("可选精灵已满")

			return
		end
	end

	local function onSure()
		self._selectIdList[petId] = not self._selectIdList[petId]

		self:reloadData()
		self:_selectPet(data)
	end

	if data:isLocked() and not self._selectIdList[petId] then
		local content = string.format("[%s]已被锁定，确定要将其放入合成吗？", data:getName())

		local function okFunc()
			onSure()
		end

		TipsFacade.instance:openPopupWindow("提示", content, okFunc)
	else
		onSure()
	end
end

function PetComposeView:_onPetComposeRes(status, msg)
	if status == 0 then
		self:_doComposeAnim()
	else
		goutil.setActive(self._blockMask, false)
	end
end

function PetComposeView:_selectPet(petMo)
	if self._selectPetList[petMo.petId] then
		self._selectPetList[petMo.petId] = nil
	else
		self._selectPetList[petMo.petId] = petMo
	end

	self:_updateComposeItems(self._currTabType)
end

function PetComposeView:_onClickComposeItem(petId)
	if petId then
		self._selectIdList[petId] = not self._selectIdList[petId]
		self._selectPetList[petId] = nil

		self:reloadData()
		self:_updateComposeItems(self._currTabType)
	end
end

function PetComposeView:_getCurrSelectNum()
	local num = 0

	for k, v in pairs(self._selectIdList) do
		if v then
			num = num + 1
		end
	end

	return num
end

return PetComposeView
