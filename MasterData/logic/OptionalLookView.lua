-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/OptionalLookView.lua

module("logic.extensions.equipment.view.OptionalLookView", package.seeall)

local OptionalLookView = class("OptionalLookView", TableViewComponent)
local jobTypeEnum = {
	"疾速",
	"魔法",
	"利爪",
	"肉盾",
	"平衡",
	"治疗"
}

function OptionalLookView:ctor()
	OptionalLookView.super.ctor(self)

	self._jobItemsList = nil
	self._attrItemsList = nil
	self._chosJobStr = nil
	self._chosAttrNum = nil
end

function OptionalLookView:bindEvents()
	OptionalLookView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function OptionalLookView:unbindEvents()
	OptionalLookView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for _, item in pairs(self._jobItemsList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._attrItemsList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function OptionalLookView:onExit()
	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
	self._curViewDatas = nil
	self._chosJobStr = nil
	self._chosAttrNum = nil
end

function OptionalLookView:destroyUI()
	OptionalLookView.super.destroyUI(self)

	for _, item in pairs(self._jobItemsList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._jobItemsList = nil

	for _, item in pairs(self._attrItemsList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._attrItemsList = nil
end

function OptionalLookView:buildUI()
	OptionalLookView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._jobItemsTran = self:getGo("jobItemsTran").transform
	self._jobItem = self:getGo("jobItem")
	self._attrItemsTran = self:getGo("attrItemsTran").transform
	self._attrItem = self:getGo("attrItem")

	self._jobItem:SetActive(false)
	self._attrItem:SetActive(false)
end

function OptionalLookView:onEnter()
	OptionalLookView.super.onEnter(self)

	self._chosJobStr = ""
	self._chosAttrNum = 0

	self:_createAllItems()
	self:onClickJobAndAttrBtn(self._chosJobStr, self._chosAttrNum, true)

	local effPath = "fx_ui_lunhuitanbao/fx_ui_lunhuitanbao02.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

function OptionalLookView:_createAllItems()
	local jobCount = 7

	self._jobItemsList = self._jobItemsList or {}

	for i = 1, jobCount do
		if self._jobItemsList[i] == nil or self._jobItemsList[i].itemGo == nil then
			self._jobItemsList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._jobItem, self._jobItemsTran)

			go.name = "jobItem_" .. i - 1
			self._jobItemsList[i].itemGo = go
			self._jobItemsList[i].itemGro = go:GetComponent("UIChangeGroup")
			self._jobItemsList[i].nameTxt = goutil.findChildTextComponent(go, "nameTxt")
		end

		self._jobItemsList[i].itemGo:SetActive(true)

		local jobStr = ""

		if i > 1 then
			jobStr = jobTypeEnum[i - 1]
			self._jobItemsList[i].nameTxt.text = jobTypeEnum[i - 1]
		else
			self._jobItemsList[i].nameTxt.text = lang("text_equip_all")
		end

		self._jobItemsList[i].itemGro:SetState(0)
		GameUtil.asBtn(self._jobItemsList[i].itemGo):AddClickListener(function()
			self:onClickJobAndAttrBtn(jobStr)
		end, self)
	end

	local attrCount = 6

	self._attrItemsList = self._attrItemsList or {}

	for i = 1, attrCount do
		if self._attrItemsList[i] == nil or self._attrItemsList[i].itemGo == nil then
			self._attrItemsList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._attrItem, self._attrItemsTran)

			go.name = "attrItem_" .. i - 1
			self._attrItemsList[i].itemGo = go
			self._attrItemsList[i].iconIma = goutil.findChildComponent(go, "iconIma", "UIImageSpriteChange")
			self._attrItemsList[i].nameTxt = goutil.findChildTextComponent(go, "nameTxt")
			self._attrItemsList[i].selectGo = goutil.findChild(go, "selectGo")
		end

		self._attrItemsList[i].itemGo:SetActive(true)

		local attrNum = 0

		if i > 1 then
			attrNum = i - 1

			GameUtil.SetActive(self._attrItemsList[i].iconIma, true)
			self._attrItemsList[i].iconIma:SetState(i - 2)

			self._attrItemsList[i].nameTxt.text = ""
		else
			GameUtil.SetActive(self._attrItemsList[i].iconIma, false)

			self._attrItemsList[i].nameTxt.text = lang("text_equip_all")
		end

		GameUtil.SetActive(self._attrItemsList[i].selectGo, false)
		GameUtil.asBtn(self._attrItemsList[i].itemGo):AddClickListener(function()
			self:onClickJobAndAttrBtn(nil, attrNum)
		end, self)
	end
end

function OptionalLookView:onClickJobAndAttrBtn(jobStr, attrNum, isForce)
	jobStr = jobStr or self._chosJobStr
	attrNum = attrNum or self._chosAttrNum

	if jobStr == self._chosJobStr and attrNum == self._chosAttrNum and not isForce then
		return
	end

	if jobStr ~= self._chosJobStr then
		if string.nilorempty(self._chosJobStr) then
			self._jobItemsList[1].itemGro:SetState(0)
		else
			local index = table.indexof(jobTypeEnum, self._chosJobStr)

			self._jobItemsList[index + 1].itemGro:SetState(0)
		end
	end

	if string.nilorempty(jobStr) then
		self._jobItemsList[1].itemGro:SetState(1)
	else
		local index = table.indexof(jobTypeEnum, jobStr)

		self._jobItemsList[index + 1].itemGro:SetState(1)
	end

	if attrNum ~= self._chosAttrNum then
		if checknumber(self._chosAttrNum) <= 0 then
			GameUtil.SetActive(self._attrItemsList[1].selectGo, false)
		else
			GameUtil.SetActive(self._attrItemsList[self._chosAttrNum + 1].selectGo, false)
		end
	end

	if checknumber(attrNum) <= 0 then
		GameUtil.SetActive(self._attrItemsList[1].selectGo, true)
	else
		GameUtil.SetActive(self._attrItemsList[attrNum + 1].selectGo, true)
	end

	self._chosJobStr = jobStr
	self._chosAttrNum = attrNum
	self._curViewDatas = PetEquipModel.instance:getOptionalEquipList(self._chosJobStr, self._chosAttrNum)

	self._tableview:ReloadData()
	self._tableview:MoveCellInView(0, false)
end

function OptionalLookView:_getPath()
	return {
		cellPath = "equipItem",
		viewPath = "equipListSR"
	}
end

function OptionalLookView:_cellSize()
	return 110, 136
end

function OptionalLookView:_updateCell(view, cell, data)
	local equipPos = goutil.findChild(cell, "equipPos")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")

	MaterialMgr.resetAll(equipPos)
	MaterialMgr.setCellByData(data.matType, data, equipPos)

	local _, colorStr = PetEquipController.instance:GetQualityStrByNum(data.qualityBase)

	nameTxt.text = string.format("<color=%s>%s</color>", colorStr, data.name)
end

return OptionalLookView
