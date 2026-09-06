-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowRevivalView.lua

module("logic.extensions.summontower.view.SummontowRevivalView", package.seeall)

local SummontowRevivalView = class("SummontowRevivalView", ViewComponent)

function SummontowRevivalView:buildUI()
	SummontowRevivalView.super.buildUI(self)

	self._btnClose = self:getBtn("btns/btnCancel")
	self._btnSure = self:getBtn("btns/btnSure")
	self._cells = {}
	self._cells[1] = self:getGo("petGroup/cell")
	self._coinIcon = self:getGo("coin/icon")
	self._coinNum = self:getTxt("coin/txtNum")

	local txtTip = self:getTxt("tip/txtTip")

	txtTip.text = lang("txt_summontower_revivetips")
end

function SummontowRevivalView:bindEvents()
	SummontowRevivalView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function SummontowRevivalView:unbindEvents()
	SummontowRevivalView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function SummontowRevivalView:onEnter()
	SummontowRevivalView.super.onEnter(self)

	self._gridData = self:getFirstParam()
	self._petList = self._gridData.extInfo
	self._selectPetIds = {}

	self:_refreshPetsView()

	local itemType = SummonTowerItemsModel.ItemType.ReviveStone
	local gameItemCo = SummontowerConfig.instance:getGameItemCo(itemType)

	MaterialMgr.setIcon(self._coinIcon, MatType.Item_Fake, gameItemCo.itemId)
	self:_updateCoinNum()
	GlobalDispatcher:addListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
end

function SummontowRevivalView:_refreshPetsView()
	local cnt = #self._petList

	while cnt > #self._cells do
		table.insert(self._cells, UGUIToolHelper.AddChild(self._cells[1].transform.parent.gameObject, self._cells[1]))
	end

	for i = 1, cnt do
		local go = self._cells[i]

		go:SetActive(true)

		local petId = self._petList[i]
		local pet = goutil.findChild(go, "pet/item")
		local txtName = goutil.findChildTextComponent(go, "pet/txtName")
		local txtLevel = goutil.findChildTextComponent(go, "pet/txtLevel")
		local petCo = SummontowerConfig.instance:getPetCo(petId)

		txtName.text = petCo.creepsName
		txtLevel.text = "Lv:" .. tostring(petCo.lv)

		local item = MatType.Pet .. ":" .. petCo.raceId .. ":" .. petCo.lv

		MaterialMgr.resetAll(pet)

		local proxy = MaterialMgr.setCellByCfg(item, pet)

		if proxy then
			local curFaceId = checknumber(petCo.faceId)

			if curFaceId == 0 then
				curFaceId = checknumber(petCo.raceId)
			end

			proxy.binder:setStars(petCo.awakenLv)
			proxy.binder:setSkin(curFaceId)
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				local fightingPower = FightingPowerPetMo.New(petCo.raceId, level)

				fightingPower:fromChallengeCreepCo(petCo, cfgs)

				local petMo = {
					contractSkillId = 0,
					raceId = petCo.raceId,
					curFaceId = curFaceId,
					level = level,
					name = petCo.creepsName,
					_curZdl = fightingPower:getFightingPower(),
					awakenLv = petCo.awakenLv
				}

				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		end

		local imgSelect = goutil.findChild(go, "btnSelect/select")
		local btnSelect = Framework.ButtonAdapter.GetFrom(go, "btnSelect")

		btnSelect:RemoveClickListener()
		btnSelect:AddClickListener(function()
			self:_selectPet(petId)
			imgSelect:SetActive(self._selectPetIds[petId] or false)
		end)
		imgSelect:SetActive(self._selectPetIds[petId] or false)
	end

	for i = cnt + 1, #self._cells do
		local go = self._cells[i]

		go:SetActive(false)
	end
end

function SummontowRevivalView:_selectPet(petId)
	if self._selectPetIds[petId] then
		self._selectPetIds[petId] = nil
	else
		local itemNum = SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.ReviveStone)

		self._coinNum.text = string.format("%d/%d", table.nums(self._selectPetIds), itemNum)

		if itemNum <= table.nums(self._selectPetIds) then
			local gameItemCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.ReviveStone)

			FloatWordMgr.instance:show(string.format(lang("petzoo_feed_items_noenough"), gameItemCo.name))
		else
			self._selectPetIds[petId] = true
		end
	end

	self:_updateCoinNum()
end

function SummontowRevivalView:_updateCoinNum()
	local itemNum = SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.ReviveStone)

	self._coinNum.text = string.format("%d/%d", table.nums(self._selectPetIds), itemNum)
end

function SummontowRevivalView:onExit()
	SummontowRevivalView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)

	for i = 1, #self._cells do
		local go = self._cells[i]
		local pet = goutil.findChild(go, "pet/item")
		local btnSelect = Framework.ButtonAdapter.GetFrom(go, "btnSelect")

		MaterialMgr.resetAll(pet)
		btnSelect:RemoveClickListener()
	end

	MaterialMgr.clearIcon(self._coinIcon)

	self._selectPetIds = nil
end

function SummontowRevivalView:_onClickClose()
	TipsFacade.instance:openPopupWindow(lang("tip"), "确认不复活已阵亡的精灵吗？", function()
		SummontowerController.instance:giveupRevivePet(self._gridData.gridId)
	end, function()
		return
	end, "确定", "取消")
end

function SummontowRevivalView:_onClickSure()
	local list = {}

	for k, v in pairs(self._selectPetIds) do
		table.insert(list, k)
	end

	if #list == 0 then
		FloatWordMgr.instance:show("请选择要复活的精灵！")

		return
	end

	SummontowerController.instance:revivePet(self._gridData.gridId, list)
end

function SummontowRevivalView:_onSommonTowerDoGrid()
	self:close()
end

return SummontowRevivalView
