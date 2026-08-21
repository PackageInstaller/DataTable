-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/AirWorkBattleCalculateTagView.lua

module("logic.extensions.airworkshop.view.calculate.AirWorkBattleCalculateTagView", package.seeall)

local M = class("AirWorkBattleCalculateTagView", ViewComponent)

M.MIN_COUNT = 1
M.MAX_COUNT = 2

function M:buildUI()
	self._btnClose = self:getBtn("2&universal_second_tips_common_bg_1201003252")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("3&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("4&btn_right_1251431307"), CommButton)
	self._scroll = self:getUIComponent("air_workshop_calculate_tab_tips_1176207974", UIComponentType.ScrollRect)
	self._rectTrContent = self:getUIComponent("air_workshop_calculate_tab_tips_2111704189", UIComponentType.RectTransform)
	self._goItemPrefab = self:getGo("air_workshop_calculate_tab_tips_-1885894833")
end

function M:destroyUI()
	for _, cell in pairs(self._toggleCell or {}) do
		cell.destroyUI()
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local info = self:getFirstParam()

	self._isInit = true
	self._tagIds = {}
	self._mapId = info.id

	TableUtil.addRange(self._tagIds, info.tagIds or {})
	self:prepareData()
	self:_updateSelected()

	self._isInit = false
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	local len = self._tagIds and #self._tagIds or 0

	if len < M.MIN_COUNT then
		FloatWordMgr.instance:show(lang("tip_air_workshop_flag_min_limit"))

		return
	end

	if len > M.MAX_COUNT then
		FloatWordMgr.instance:show(lang("tip_air_workshop_setting_maxflag"))

		return
	end

	AirWorkShopAtkAgent.instance:sendTagRequest(self._mapId, self._tagIds)
	self:close()
end

function M:_toggleClick(toggleCell, isOn)
	local id = toggleCell.getId()

	if isOn then
		if not self._isInit and #self._tagIds >= M.MAX_COUNT then
			toggleCell.setSelect(false)
			FloatWordMgr.instance:show(lang("tip_air_workshop_setting_maxflag"))

			return
		end

		if not table.indexof(self._tagIds, id) then
			table.insert(self._tagIds, id)
		end
	else
		local newTagId = {}

		for _, tagId in ipairs(self._tagIds or {}) do
			if id ~= tagId then
				table.insert(newTagId, tagId)
			end
		end

		self._tagIds = newTagId
	end

	self:_updateSelected()
end

function M:_updateSelected()
	local tagCount = 0

	for _, cell in pairs(self._toggleCell or {}) do
		local selected = false

		if table.indexof(self._tagIds, cell.getId()) then
			selected = true
		end

		cell.setSelect(selected)

		if selected then
			tagCount = tagCount + 1
		end
	end

	for _, cell in pairs(self._toggleCell or {}) do
		cell.setAlpha(tagCount > 1 and 0.2 or 1)
	end
end

function M:prepareData()
	local _type
	local index = 0

	self._cfgByTypeList = {}

	for _, cfg in ipairs(AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioTag) or {}) do
		if cfg.type ~= _type then
			_type = cfg.type
			index = index + 1
			self._cfgByTypeList[index] = {}
		end

		table.insert(self._cfgByTypeList[index], cfg)
	end

	while self._rectTrContent.childCount < #self._cfgByTypeList do
		goutil.cloneAndSetParent(self._goItemPrefab, self._rectTrContent)
	end

	for i = 0, self._rectTrContent.childCount - 1 do
		local go = self._rectTrContent:GetChild(i).gameObject
		local cfgLst = self._cfgByTypeList[i + 1]
		local len = cfgLst and #cfgLst or 0

		if len > 0 then
			local txtTabTypeName = goutil.findChildComponent(go, "txtTab", UIComponentType.Text)

			txtTabTypeName.text = cfgLst[1].typeName

			local goTabItemPrefab = goutil.findChild(go, "tabItem").gameObject

			while go.transform.childCount < len + 1 do
				goutil.cloneAndSetParent(goTabItemPrefab, go.transform)
			end

			for childIndex = 1, go.transform.childCount - 1 do
				local _cfg = cfgLst[childIndex]
				local goChild = go.transform:GetChild(childIndex).gameObject

				if _cfg then
					self:_buildTagToggleCell(goChild, _cfg)
				end

				goutil.setActive(goChild, _cfg)
			end
		end

		goutil.setActive(go, len > 0)
	end
end

function M:_buildTagToggleCell(go, cfg)
	if not self._toggleCell then
		self._toggleCell = {}
	end

	local cell = {}

	cell.id = cfg.id
	cell.toggle = go:GetComponent(UIComponentType.SpaceXToggle)

	cell.toggle:AddListener(function(_, isOn)
		self:_toggleClick(cell, isOn)
	end, nil)

	function cell.setSelect(selected)
		cell.toggle.IsOn = selected
	end

	function cell.getId()
		return cell.id
	end

	function cell.destroyUI()
		cell.toggle:RemoveListener()
	end

	self._toggleCell[cfg.id] = cell

	local txtName1 = goutil.findChildComponent(go, "normal/txtTitle", UIComponentType.Text)
	local txtName2 = goutil.findChildComponent(go, "select/txtTitle2", UIComponentType.Text)

	txtName1.text = cfg.tagName
	txtName2.text = cfg.tagName
	cell.canvasGroup = goutil.addComponentOnce(go, ComponentType.CanvasGroup)

	function cell.setAlpha(alphaValue)
		cell.canvasGroup.alpha = 1

		if not cell.toggle.IsOn then
			cell.canvasGroup.alpha = alphaValue
		end
	end
end

return M
