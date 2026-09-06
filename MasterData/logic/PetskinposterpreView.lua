-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetskinposterpreView.lua

module("logic.extensions.petskinpreview.view.PetskinposterpreView", package.seeall)

local PetskinposterpreView = class("PetskinposterpreView", ViewComponent)

PetskinposterpreView.FilterType = {
	Get = 2,
	All = 1,
	NotGet = 3
}

function PetskinposterpreView:bindEvents()
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._BtnClear:AddClickListener(self._onClickBtnClear, self)
	self._btnFliterType:AddClickListener(self._onClickbtnSort, self)
	self._Cell3:AddClickListener(self._onClickCell3, self)
	self._Cell2:AddClickListener(self._onClickCell2, self)
	self._Cell1:AddClickListener(self._onClickCell1, self)
end

function PetskinposterpreView:unbindEvents()
	self._inputSearch:RemoveOnValueChanged()
	self._BtnClear:RemoveClickListener()
	self._btnFliterType:RemoveClickListener()
	self._Cell3:RemoveClickListener()
	self._Cell2:RemoveClickListener()
	self._Cell1:RemoveClickListener()
end

function PetskinposterpreView:buildUI()
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
	self._BtnClear = self:getBtn("InputC_Search/BtnClear")
	self._btnFliterType = self:getBtn("btnFliterType")
	self._sortpanelGo = self:getGo("sortpanel")
	self._Cell3 = self:getBtn("sortpanel/content/Cell3")
	self._Cell2 = self:getBtn("sortpanel/content/Cell2")
	self._Cell1 = self:getBtn("sortpanel/content/Cell1")
	self._txtBtnFilterType = self:getTxt("btnFliterType/Text")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._slider = self:getSlider("progress/slider")
end

function PetskinposterpreView:onExit()
	self._scrollList:dispose()

	self._hadSkins = nil
end

function PetskinposterpreView:onEnter()
	self.addGEvent(self, GlobalNotify.PetSkinDataInited, self._onPetSkinDataInited, self)
	self.addGEvent(self, PetskinpreView.NotifyClickSubTab, self._onNotifyClickSubTab, self)

	self._searchStr = ""
	self._filterType = PetskinposterpreView.FilterType.All

	self:_setTxtBtnFilterType()
	goutil.setActive(self._sortpanelGo, false)

	local params = self:getOpenParam() or {}

	self._userId = checknumber(params[1])
	self._index = checknumber(params[2])
	self._showType = 0

	local cfg = PetskinpreviewConfig.instance:getSmallTabCfg(self._index)

	if cfg then
		self._showType = cfg.params.tabType
	end

	self._isOtherUser = self._userId > 0 and self._userId ~= checknumber(RoleModel.instance:getUserId())

	self:_updateUI()

	if self._isOtherUser then
		PetskinController.instance:sendGetInfo(nil, self._userId)
	else
		PetskinController.instance:sendGetInfo()
	end
end

function PetskinposterpreView:_onNotifyClickSubTab(index)
	self._index = index
	self._showType = 0

	local cfg = PetskinpreviewConfig.instance:getSmallTabCfg(self._index)

	if cfg then
		self._showType = cfg.params.tabType
	end

	PetSkinlPreviewController.instance:resetHadSkins()
	self:_updateUI()
end

function PetskinposterpreView:_updateUI()
	self:_reloadDatas()
	self:_setProgress()
end

function PetskinposterpreView:_reloadDatas()
	self._dataList = self:_getInitDataList()

	self._scrollList:reloadData(self._dataList)
end

function PetskinposterpreView:_getInitDataList()
	local list = {}
	local cfgs = CharacterConfig.instance:getPosterModelCos()

	for i = #cfgs, 1, -1 do
		if cfgs[i].tabType == self._showType then
			table.insert(list, cfgs[i])
		end
	end

	list = self:_filterCfgs(list)
	list = self:_sortCfgs(list)

	return list
end

function PetskinposterpreView:_filterCfgs(posterCfgs)
	local list = {}

	for _, cfg in ipairs(posterCfgs) do
		local hasData = true

		for i, v in ipairs(cfg.skinId) do
			if not self:_isHadSkin(v) then
				hasData = false

				break
			end
		end

		local isSearchMatch = string.nilorempty(self._searchStr) or string.find(cfg.name, self._searchStr)

		if isSearchMatch and (self._filterType == PetskinposterpreView.FilterType.All or self._filterType == PetskinposterpreView.FilterType.Get and hasData or self._filterType == PetskinposterpreView.FilterType.NotGet and not hasData) then
			table.insert(list, cfg)
		end
	end

	return list
end

function PetskinposterpreView:_sortCfgs(posterCfgs)
	local list = {}
	local notGetList = {}

	for i, v in ipairs(posterCfgs) do
		local isGet = true

		for _, sid in ipairs(v.skinId) do
			if not self:_isHadSkin(sid) then
				isGet = false

				break
			end
		end

		if isGet then
			table.insert(list, v)
		else
			table.insert(notGetList, v)
		end
	end

	table.insertto(list, notGetList)

	return list
end

function PetskinposterpreView:_updateCell(view, cell, data, tag)
	local component = PetSkinPosterPreviewCell.Get(cell.gameObject)

	component:init(data)
end

function PetskinposterpreView:_clearCell(cell)
	local component = PetSkinPosterPreviewCell.Get(cell.gameObject)

	component:clear()
end

function PetskinposterpreView:_onClickBtnClear()
	self._inputSearch:SetText("")
end

function PetskinposterpreView:_onClickbtnSort()
	goutil.setActive(self._sortpanelGo, true)
end

function PetskinposterpreView:_onClickCell3()
	self:_onCliclFilterType(PetskinposterpreView.FilterType.NotGet)
end

function PetskinposterpreView:_onClickCell2()
	self:_onCliclFilterType(PetskinposterpreView.FilterType.Get)
end

function PetskinposterpreView:_onClickCell1()
	self:_onCliclFilterType(PetskinposterpreView.FilterType.All)
end

function PetskinposterpreView:_onCliclFilterType(fType)
	goutil.setActive(self._sortpanelGo, false)

	self._filterType = fType

	self:_setTxtBtnFilterType()
	self:_reloadDatas()
end

function PetskinposterpreView:_setTxtBtnFilterType()
	local str = ""

	if self._filterType == PetskinposterpreView.FilterType.All then
		str = "全部"
	elseif self._filterType == PetskinposterpreView.FilterType.Get then
		str = "已拥有"
	elseif self._filterType == PetskinposterpreView.FilterType.NotGet then
		str = "未拥有"
	end

	self._txtBtnFilterType.text = str
end

function PetskinposterpreView:_onPetSkinDataInited()
	PetSkinlPreviewController.instance:resetHadSkins()
	self:_updateUI()
end

function PetskinposterpreView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if self._searchStr == text then
		return
	end

	self._searchStr = text

	self:_reloadDatas()
end

function PetskinposterpreView:_onClickBtnClear()
	self._inputSearch:SetText("")
end

function PetskinposterpreView:_setProgress()
	local cfgs = CharacterConfig.instance:getPosterModelCos()
	local progress = 0

	for i, v in ipairs(cfgs) do
		local isGet = true

		for _, sid in ipairs(v.skinId) do
			if not self:_isHadSkin(sid) then
				isGet = false

				break
			end
		end

		if isGet and v.tabType == self._showType then
			progress = progress + 1
		end
	end

	local totalProgress = 0

	for i = #cfgs, 1, -1 do
		if cfgs[i].tabType == self._showType then
			totalProgress = totalProgress + 1
		end
	end

	self._txtProgress.text = string.format("<color=#2e395e><size=24>%s</size></color>/%s", progress, totalProgress)

	self._slider:SetValue(progress / totalProgress)
end

function PetskinposterpreView:_isHadSkin(skinId)
	return PetSkinlPreviewController.instance:isHadSkin(skinId)
end

return PetskinposterpreView
