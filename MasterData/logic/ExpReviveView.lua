-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpReviveView.lua

module("logic.extensions.expedition.view.ExpReviveView", package.seeall)

local ExpReviveView = class("ExpReviveView", ViewComponent)

function ExpReviveView:buildUI()
	ExpReviveView.super.buildUI(self)

	self._closeButton = self:getBtn("Btns/BtnClose")
	self._useButton = self:getBtn("Btns/BtnUse")
	self._txtHeartNum = self:getTxt("heart/Num")
	self._emptyTips = self:getTxt("Txt_Msg")
	self._tableview = self:getGo("ScrollView"):GetComponent(typeof(UITableview))
	self._tableCell = self:getGo("TableCell")

	self._tableCell:SetActive(false)

	local title = self:getTxt("Txt_Title")
	local tips = self:getTxt("Txt_Tips")

	self._emptyTips.text = lang("exprevive_empty")
	title.text = lang("exprevive_title")
	tips.text = lang("exprevive_tips")
end

function ExpReviveView:unbindEvents()
	ExpReviveView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._useButton:RemoveClickListener()
	self._tableview:UnRegisterCallback()
end

function ExpReviveView:bindEvents()
	ExpReviveView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._useButton:AddClickListener(self._onClickUse, self)
	self._tableview:RegisterCallback(self._numPetsInView, nil, self._petCellAtIndex, self)
end

function ExpReviveView:onExit()
	ExpReviveView.super.onExit(self)

	self._revivePets = nil

	GlobalDispatcher:removeListener(GlobalNotify.OnReviveAllPets, self._onReviveAllPets, self)
	self._tableview:Travel(function(cell)
		local go = goutil.findChild(cell.gameObject, "IconParent")

		ItemPet.Remove(go)
	end, nil)
end

function ExpReviveView:onEnter()
	self:_setupHearNum()
	self:_reloadPets()
	GlobalDispatcher:addListener(GlobalNotify.OnReviveAllPets, self._onReviveAllPets, self)
end

function ExpReviveView:_onClickClose()
	self:close()
end

function ExpReviveView:_onClickUse()
	if not self._revivePets or #self._revivePets == 0 then
		FloatWordMgr.instance:show(lang("exprevive_emptytips"))

		return
	end

	local itemNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, ExpeditionConfig.ReviveItemId)

	if itemNum == 0 then
		FloatWordMgr.instance:show(lang("expreviveitem_empty"))

		return
	end

	ExpeditionAgent.instance:sendPM_ExpeditionReviveAllPetReq()
end

function ExpReviveView:_setupHearNum()
	local itemCo = ItemConfig.instance:getCfgById(ExpeditionConfig.ReviveItemId)
	local itemNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, ExpeditionConfig.ReviveItemId)

	self._txtHeartNum.text = itemCo.name .. "x" .. itemNum
end

function ExpReviveView:_reloadPets()
	self._revivePets = ExpeditionModel.instance:getDeadPets()

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()

	local isEmpty = not self._revivePets or #self._revivePets == 0

	self._emptyTips.gameObject:SetActive(isEmpty)
	GameUtil.SetGray(self._useButton, isEmpty)
end

function ExpReviveView:_numPetsInView()
	if not self._revivePets then
		return 0
	end

	return #self._revivePets
end

function ExpReviveView:_petCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local go = goutil.findChild(cell.gameObject, "IconParent")
	local pet = self._revivePets[idx + 1]
	local data = ExpeditionFmtModel.instance:getPet(pet.petId)

	data.isDead = ExpeditionModel.instance:isPetDead(data.petId)

	local component = ItemPet.AddOnce(go)

	component:Init(data)
	component:setSelected(false)

	local inTeamId = ExpeditionFmtModel.instance:getPetIdInTeamByRaceId(data.raceId)

	component:removeAllListener(ItemPet.Events.Click)
	component:addListener(ItemPet.Events.Click, function(data)
		self:_onClickPet(data, cell)
	end)

	return cell
end

function ExpReviveView:_onClickPet(data)
	CommonTipsMgr.instance:showPetTips(data)
end

function ExpReviveView:_onReviveAllPets()
	self:close()
	FloatWordMgr.instance:show(lang("expedition_reviveall"))
end

return ExpReviveView
