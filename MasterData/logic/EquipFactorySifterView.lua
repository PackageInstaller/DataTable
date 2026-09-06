-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFactorySifterView.lua

module("logic.extensions.equipment.view.EquipFactorySifterView", package.seeall)

local EquipFactorySifterView = class("EquipFactorySifterView", ViewComponent)

function EquipFactorySifterView:ctor()
	EquipFactorySifterView.super.ctor(self)

	self._choiseList = nil
end

function EquipFactorySifterView:bindEvents()
	EquipFactorySifterView.super.bindEvents(self)
	GameUtil.asBtn(self._clickGo):AddClickListener(self.close, self)
end

function EquipFactorySifterView:unbindEvents()
	EquipFactorySifterView.super.unbindEvents(self)
	GameUtil.asBtn(self._clickGo):RemoveClickListener()
end

function EquipFactorySifterView:onExit()
	EquipFactorySifterView.super.onExit(self)

	self._choiseList = nil
end

function EquipFactorySifterView:destroyUI()
	EquipFactorySifterView.super.destroyUI(self)
end

function EquipFactorySifterView:buildUI()
	EquipFactorySifterView.super.buildUI(self)

	self._clickGo = self:getGo("clickGo")
	self._adjustPosition = self:getGo("sifterBgGo"):GetComponent("UIAdjustPosition")

	local typeShowGo = self:getGo("sifterBgGo/typeShowGo")

	self._titleTxt = goutil.findChildTextComponent(typeShowGo, "titleImaGo/titleTxt")
	self._subParentGo = goutil.findChild(typeShowGo, "subParentGo")
	self._subCell = goutil.findChild(self._subParentGo, "subCell")

	GameUtil.SetActive(self._subCell, false)
	GameUtil.SetActive(self._adjustPosition, false)
end

function EquipFactorySifterView:onEnterFinished()
	EquipFactorySifterView.super.onEnterFinished(self)
end

function EquipFactorySifterView:onEnter()
	EquipFactorySifterView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.alchemyType == nil or self._params.btnTabInfo == nil then
		printError("sr---筛选     EquipFactorySifterView:onEnter()   请正确传入参数！！")
		self:close()

		return
	end

	self._choiseList = {}

	if self._params.choList and #self._params.choList > 0 then
		for i = 1, #self._params.choList do
			table.insert(self._choiseList, self._params.choList[i])
		end
	end

	local isCreateObj = self:_updateSifterCol()

	if self._params.itemGo then
		local sizeDelta = {
			0,
			0
		}
		local rect = self._params.itemGo:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
		local pos = uiCamera:WorldToScreenPoint(self._params.itemGo.transform.position)

		GameUtil.SetActive(self._adjustPosition, false)
		settimer(0.02, function()
			GameUtil.SetActive(self._adjustPosition, true)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._adjustPosition.transform)
			GameUtil.SetActive(self._adjustPosition, false)
		end, self, false)
		settimer((isCreateObj == true or nil) and 0.1, function()
			GameUtil.SetActive(self._adjustPosition, true)
			self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
		end, self, false)
	else
		GameUtil.SetActive(self._adjustPosition, true)
		Framework.TransformUtil.SetLocalPos(self._adjustPosition.gameObject.transform, 0, 0, 0)
	end
end

function EquipFactorySifterView:_updateSifterCol()
	local condDataList = {}
	local isCreateObj = false

	for _, cfg in pairs(self._params.btnTabInfo.subList or {}) do
		if cfg and cfg.sortId > 0 then
			table.insert(condDataList, cfg)
		end
	end

	for _, item in pairs(self._typeCellList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	if #condDataList > 1 then
		table.sort(condDataList, function(a, b)
			return a.sortId < b.sortId
		end)
	end

	self._titleTxt.text = self._params.btnTabInfo.subName
	self._typeCellList = self._typeCellList or {}

	for i = 1, #condDataList do
		if self._typeCellList[i] == nil or self._typeCellList[i].itemGo == nil then
			self._typeCellList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._subCell, self._subParentGo.transform)

			isCreateObj = true
			go.name = string.format("subCell_%d", i)
			self._typeCellList[i].itemGo = go
			self._typeCellList[i].itemGrp = go:GetComponent(ComponentType.UIChangeGroup)
			self._typeCellList[i].subTxt = goutil.findChildTextComponent(go, "subTxt")
			self._typeCellList[i].subImaSchg = goutil.findChild(go, "subImaGo"):GetComponent(ComponentType.UIImageSpriteChange)
			self._typeCellList[i].subImaCchg = goutil.findChild(go, "subImaGo"):GetComponent(ComponentType.UIImageColorChange)
		end

		GameUtil.SetActive(self._typeCellList[i].itemGo, true)

		self._typeCellList[i].subTxt.text = condDataList[i].name

		if string.nilorempty(condDataList[i].icon) then
			GameUtil.SetActive(self._typeCellList[i].subImaSchg, false)
		else
			GameUtil.SetActive(self._typeCellList[i].subImaSchg, true)
			self._typeCellList[i].subImaSchg:ChangeSprite(condDataList[i].icon)
			self._typeCellList[i].subImaCchg:SetState(isSelected and 1 or 0)
		end

		if condDataList[i].showType < 3 then
			if not condDataList[i].value then
				local value = checknumber(condDataList[i].value)

				self._typeCellList[i].itemGrp:SetState((self._choiseList and table.indexof(self._choiseList, value) or nil) and true and 1 or 0)
				GameUtil.asBtn(self._typeCellList[i].itemGo):AddClickListener(function()
					self:_setSifterSelected(value)
				end, self)
			end
		end
	end

	return isCreateObj
end

function EquipFactorySifterView:_setSifterSelected(stateKey)
	self._choiseList = self._choiseList or {}

	local value = table.indexof(self._choiseList, stateKey)

	if value == false then
		table.insert(self._choiseList, stateKey)
	else
		table.remove(self._choiseList, value)
	end

	self:_updateSifterCol()
	GlobalDispatcher:dispatch(GlobalNotify.Factory_UpdataShowSifter, self._params.btnTabInfo.viewName, self._params.alchemyType, self._params.btnTabInfo.planId, self._choiseList, false)
end

return EquipFactorySifterView
