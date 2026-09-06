-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgPetView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgPetView", package.seeall)

local NuoYaSisterClgPetView = class("NuoYaSisterClgPetView", ViewComponent)

function NuoYaSisterClgPetView:ctor()
	NuoYaSisterClgPetView.super.ctor(self)
end

function NuoYaSisterClgPetView:unbindEvents()
	NuoYaSisterClgPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NuoYaSisterClgPetView:bindEvents()
	NuoYaSisterClgPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnAttr, self._onClickAttr, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
end

function NuoYaSisterClgPetView:buildUI()
	NuoYaSisterClgPetView.super.buildUI(self)

	self._btnClose = self:getGo("Btn_Close")
	self._tableView = self:getGo("SrlC_Pet")
	self._tableCell = self:getGo("petCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NuoYaSisterClgPetView:onExit()
	NuoYaSisterClgPetView.super.onExit(self)
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_ROGUE_LIKE)
end

function NuoYaSisterClgPetView:onEnter()
	NuoYaSisterClgPetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._pets = params[2]

	self:_refreshView()
end

function NuoYaSisterClgPetView:_refreshView()
	self._curViewDatas = {}

	for k, v in pairs(self._pets) do
		table.insert(self._curViewDatas, v)
	end

	table.sort(self._curViewDatas, function(a, b)
		local petInfoA = NuoYaSisterClgModel.instance:getPetInfo(self._activityId, a.petId)
		local petInfoB = NuoYaSisterClgModel.instance:getPetInfo(self._activityId, b.petId)
		local deadA = petInfoA and petInfoA.hp == 0 or false
		local deadB = petInfoB and petInfoB.hp == 0 or false

		if deadA ~= deadB then
			return deadB
		else
			return a.petId < b.petId
		end
	end)
	self._tableList:reloadData(self._curViewDatas)
end

function NuoYaSisterClgPetView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txtHp = goutil.findChildTextComponent(go, "txtHp")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local proxy = MaterialMgr.setCellByMo(data, con)
	local petCfg = CharacterConfig.instance:getPetCo(data.raceId)

	txtName.text = petCfg.name

	if NuoYaSisterClgModel.instance:IsInitTeam(self._activityId) then
		GameUtil.SetActive(txtHp, true)

		local petInfo = NuoYaSisterClgModel.instance:getPetInfo(self._activityId, data.petId)

		txtHp.text = lang("剩余血量：<color=#c34b50>100%</color>")

		if petInfo and petInfo.hp and petInfo.hp >= 0 then
			local petMo = BagPetsController.instance:getPet(data.petId)
			local rate = petInfo.hp / petMo._maxHp * 100

			txtHp.text = langPara("剩余血量：<color=#c34b50>%d", rate) .. lang("%</color>")
		end

		if petInfo and petInfo.hp == 0 then
			proxy.binder:setGray(true)
		else
			proxy.binder:setGray(false)
		end
	else
		GameUtil.SetActive(txtHp, false)
		proxy.binder:setGray(false)
	end

	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:openMaterialTips(go, MatType.Pet, data.petId)
	end)
end

function NuoYaSisterClgPetView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

return NuoYaSisterClgPetView
