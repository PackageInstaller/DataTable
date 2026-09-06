-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgTeamPetView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgTeamPetView", package.seeall)

local NuoYaSisterClgTeamPetView = class("NuoYaSisterClgTeamPetView", ViewComponent)

function NuoYaSisterClgTeamPetView:ctor()
	NuoYaSisterClgTeamPetView.super.ctor(self)
end

function NuoYaSisterClgTeamPetView:unbindEvents()
	NuoYaSisterClgTeamPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NuoYaSisterClgTeamPetView:bindEvents()
	NuoYaSisterClgTeamPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NuoYaSisterClgTeamPetView:buildUI()
	NuoYaSisterClgTeamPetView.super.buildUI(self)

	self._btnClose = self:getGo("Btn_Close")
	self._tableView = self:getGo("SrlC_Pet")
	self._tableCell = self:getGo("petCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NuoYaSisterClgTeamPetView:onExit()
	NuoYaSisterClgTeamPetView.super.onExit(self)
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_ROGUE_LIKE)
end

function NuoYaSisterClgTeamPetView:onEnter()
	NuoYaSisterClgTeamPetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._teamId = params[2]
	self._pets = params[3]

	self:_refreshView()
end

function NuoYaSisterClgTeamPetView:_refreshView()
	self._curViewDatas = {}

	for k, v in pairs(self._pets) do
		table.insert(self._curViewDatas, v)
	end

	self._tableList:reloadData(self._curViewDatas)
end

function NuoYaSisterClgTeamPetView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txtHp = goutil.findChildTextComponent(go, "txtHp")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local proxy = MaterialMgr.setCellByMo(data, con)
	local btnRemove = goutil.findChild(go, "btnRemove")
	local petCfg = CharacterConfig.instance:getPetCo(data.raceId)

	txtName.text = petCfg.name

	GameUtil.addClickHandler(btnRemove, function()
		self:_onClickRemove(data)
	end)
	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:openMaterialTips(go, MatType.Pet, data.petId)
	end)
end

function NuoYaSisterClgTeamPetView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function NuoYaSisterClgTeamPetView:_onClickRemove(petMo)
	GlobalDispatcher:dispatch(GlobalNotify.NuoYaSisterExtremeClgRemoveTeamPet, self._teamId, petMo.petId)

	for i, v in ipairs(self._pets) do
		if v.petId == petMo.petId then
			self._pets[i] = nil

			break
		end
	end

	self:_refreshView()
end

return NuoYaSisterClgTeamPetView
