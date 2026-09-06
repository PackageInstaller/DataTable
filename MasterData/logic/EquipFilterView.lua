-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFilterView.lua

module("logic.extensions.equipment.view.EquipFilterView", package.seeall)

local EquipFilterView = class("EquipFilterView", ViewComponent)

function EquipFilterView:ctor()
	EquipFilterView.super.ctor(self)
end

function EquipFilterView:unbindEvents()
	EquipFilterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function EquipFilterView:bindEvents()
	EquipFilterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function EquipFilterView:onExit()
	EquipFilterView.super.onExit(self)
end

function EquipFilterView:buildUI()
	EquipFilterView.super.buildUI(self)

	self._raceFilter = self:getGo("content/RaceFilter")
	self._jobFilter = self:getGo("content/JobFilter")
	self._qualityFilter = self:getGo("content/QualityFilter")
	self._posFilter = self:getGo("content/PosFilter")
	self._content = self:getGo("content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._closeBtn = self:getGo("clickGo")
end

function EquipFilterView:onEnter()
	EquipFilterView.super.onEnter(self)

	self._params = self:getFirstParam()

	self:_adjustView()
	self:_initFilter()
end

function EquipFilterView:_initFilter()
	self:_initList(1, self._raceFilter)
	self:_initList(2, self._jobFilter)
	self:_initList(3, self._qualityFilter)
	self:_initList(4, self._posFilter)
end

function EquipFilterView:_initList(index, parent)
	local info = self._params.btnTabInfo[index]

	if not info or not info.subList then
		return
	end

	self._params.choList[info.planId] = self._params.choList[info.planId] or {}

	local condDataList = {}
	local choList = self._params.choList[info.planId]

	for _, cfg in pairs(info.subList or {}) do
		if cfg and cfg.sortId > 0 then
			table.insert(condDataList, cfg)
		end
	end

	if #condDataList > 0 then
		table.sort(condDataList, function(a, b)
			return a.sortId < b.sortId
		end)
	end

	for i, v in ipairs(condDataList) do
		local temp = {}

		temp.go = goutil.findChild(parent, "Cell" .. i)
		temp.select = goutil.findChild(temp.go, "Mark")
		temp.name = goutil.findChildTextComponent(temp.go, "txt")
		temp.maskName = goutil.findChildTextComponent(temp.select, "txt")

		local value = checknumber(v.value) > 0 and checknumber(v.value) or v.value

		goutil.setActive(temp.select, (choList and table.indexof(choList, value) or nil) and true)

		temp.name.text = v.name
		temp.maskName.text = v.name

		GameUtil.asBtn(temp.go):RemoveClickListener()
		GameUtil.asBtn(temp.go):AddClickListener(function()
			self:_setSifterSelected(value, info, choList)
		end)
	end
end

function EquipFilterView:_setSifterSelected(stateKey, info, choList)
	local value = table.indexof(choList, stateKey)

	if value == false then
		table.insert(choList, stateKey)
	else
		table.remove(choList, value)
	end

	self:_initFilter()
	GlobalDispatcher:dispatch(GlobalNotify.Factory_UpdataShowSifter, info.viewName, self._params.alchemyType, info.planId, choList, false)
end

function EquipFilterView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function EquipFilterView:_adjustView()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._params.itemGo)

	self.pos = pos
	self.sizeDelta = sizeDelta

	if pos then
		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

return EquipFilterView
