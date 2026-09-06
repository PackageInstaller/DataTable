-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/PetChoiseAddView.lua

module("logic.extensions.petassist.view.PetChoiseAddView", package.seeall)

local PetChoiseAddView = class("PetChoiseAddView", TableViewComponent)

function PetChoiseAddView:ctor()
	PetChoiseAddView.super.ctor(self)

	self.petIndex = nil
	self.attrItemList = nil
end

function PetChoiseAddView:bindEvents()
	PetChoiseAddView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.sureBtn:AddClickListener(function()
		if self._curViewDatas[self.petIndex] and self.paramInfo then
			local petId = self._curViewDatas[self.petIndex].petId

			PetAssistController.instance:CSSetPetTeamPositionReq(self.paramInfo.teamType, petId, self.paramInfo.pos)
		end

		self:close()
	end, self)
end

function PetChoiseAddView:unbindEvents()
	PetChoiseAddView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.sureBtn:RemoveClickListener()
end

function PetChoiseAddView:destroyUI()
	PetChoiseAddView.super.destroyUI(self)

	self._curViewDatas = nil
	self.petIndex = nil

	for _, item in pairs(self.attrItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.attrItemList = nil
end

function PetChoiseAddView:buildUI()
	PetChoiseAddView.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")
	self.petAttrTran = self:getGo("petAttrTran").transform
	self.attrGo = self:getGo("attrGo")
	self.sureBtn = self:getBtn("sureBtn")
	self.noPetTxt = self:getGo("noPetTxt"):GetComponent("Text")
	self.teamNameTxt = self:getGo("teamNameTxt"):GetComponent("Text")

	self.attrGo:SetActive(false)

	self.noPetTxt.text = ""
	self.teamNameTxt.text = ""
end

function PetChoiseAddView:onEnter()
	PetChoiseAddView.super.onEnter(self)

	if self._viewPresentor._openParam == nil then
		return
	end

	self.paramInfo = self._viewPresentor._openParam[1]

	if self.paramInfo == nil or self.paramInfo.teamType == nil then
		return
	end

	local cfg = PetAssistConfig.instance:GetPetTeamCfg(self.paramInfo.teamType)

	if cfg == nil then
		printError("sr--- PetChoiseAddView:onEnter()    战队配置空  teamType = ", self.paramInfo.teamType)

		return
	end

	self.teamNameTxt.text = cfg.teamName
	self.petIndex = 0

	self:ChoisePetIndex(1)

	if self._curViewDatas and #self._curViewDatas >= 10 then
		self._tableview:MoveCellInView(0, false)
	end
end

function PetChoiseAddView:ChoisePetIndex(index)
	self.noPetTxt.text = ""

	local tempIndex = self.petIndex

	self.petIndex = 0

	if tempIndex ~= index then
		self.petIndex = index
	end

	self._curViewDatas = PetAssistModel.instance:GetTeamTypeAllPets(self.paramInfo.teamType, self.paramInfo.pos)

	self._tableview:ReloadData()

	if self.attrItemList and #self.attrItemList > 0 then
		for i = 1, #self.attrItemList do
			if self.attrItemList[i] and self.attrItemList[i].itemGo.activeSelf then
				self.attrItemList[i].itemGo:SetActive(false)
			end
		end
	end

	if tempIndex == index then
		return
	end

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		local cfg = PetAssistConfig.instance:GetPetTeamCfg(self.paramInfo.teamType)

		self.noPetTxt.text = string.format("%s需要%s属性精灵方可助战，当前没有可助战的精灵", cfg.teamName, cfg.teamAttr)

		return
	end

	if self._curViewDatas[self.petIndex] == nil then
		return
	end

	local attrList = PetAssistModel.instance:GetChoisePetAttrsList(self._curViewDatas[self.petIndex].petId)

	if attrList == nil or #attrList == 0 then
		return
	end

	self.attrItemList = self.attrItemList or {}

	for i = 1, #attrList do
		if self.attrItemList[i] == nil then
			local attrGo = UnityEngine.GameObject.Instantiate(self.attrGo, self.petAttrTran)

			self.attrItemList[i] = {}
			self.attrItemList[i].itemGo = attrGo
			self.attrItemList[i].iconIma = goutil.findChildComponent(attrGo, "iconIma", "UIImageSpriteChange")
			self.attrItemList[i].countTxt = goutil.findChildTextComponent(attrGo, "countTxt")
		end

		self.attrItemList[i].itemGo:SetActive(true)
		self.attrItemList[i].iconIma:SetState(attrList[i].index)

		self.attrItemList[i].countTxt.text = attrList[i].name .. "+" .. attrList[i].value
	end
end

function PetChoiseAddView:_getPath()
	return {
		cellPath = "petItem",
		viewPath = "petListSR"
	}
end

function PetChoiseAddView:_cellSize()
	return 120, 120
end

function PetChoiseAddView:_updateCell(view, cell, data)
	local index = cell.data
	local subLua = MaterialMgr.setCellByData(MatType.Pet, data, cell)

	subLua.binder:setAutoTips(false)
	subLua.binder:setSelected(self.petIndex == index)
	subLua.binder:SetInTeam(false)
	subLua.binder:setCallBack(function()
		self:ChoisePetIndex(index)
	end)
end

return PetChoiseAddView
