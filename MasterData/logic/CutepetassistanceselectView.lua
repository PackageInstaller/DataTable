-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetassistanceselectView.lua

module("logic.extensions.cutepet.view.CutepetassistanceselectView", package.seeall)

local CutepetassistanceselectView = class("CutepetassistanceselectView", ViewComponent)

function CutepetassistanceselectView:ctor()
	CutepetassistanceselectView.super.ctor(self)
end

function CutepetassistanceselectView:unbindEvents()
	CutepetassistanceselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSure)

	if self._togOnlyShowSame then
		self._togOnlyShowSame:RemoveOnValueChanged()
	end
end

function CutepetassistanceselectView:bindEvents()
	CutepetassistanceselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFileter, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._togOnlyShowSame:AddOnValueChanged(self._onOnlyShowSameChanged, self)
end

function CutepetassistanceselectView:buildUI()
	CutepetassistanceselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goFilter = self:getGo("btnFilter")
	self._btnFilter = self:getGo("btnFilter/bg")
	self._btnSure = self:getGo("btnSure")
	self._selectInfo = self:getGo("selectInfo")
	self._petCon = self:getGo("selectInfo/petCon")
	self._txtName = self:getTxt("selectInfo/txtName")
	self._txtDesc = self:getTxt("selectInfo/txtDesc")
	self._empty = self:getGo("empty")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._togOnlyShowSame = self:getToggle("ToggleOnlyShowSame")
end

function CutepetassistanceselectView:onExit()
	CutepetassistanceselectView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_EnterGameLoadInfoResp, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)
end

function CutepetassistanceselectView:onEnter()
	CutepetassistanceselectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._currSelectCutePetId = checknumber(params[1])
	self._currUpCutePetId = self._currSelectCutePetId
	self._callBack = params[2]
	self._filterType = CutePetFilterMgr.TYPE_ASSISTSELECT
	self._fillterTypes = nil
	self._togOnlyShowSame.isOn = false

	GlobalDispatcher:addListener(GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_EnterGameLoadInfoResp, self._refreshUI, self)
	self:_refreshUI()
end

function CutepetassistanceselectView:_onFilterSelect(typeIds)
	self._fillterTypes = #(typeIds or {}) > 0 and typeIds or nil

	self:_refreshUI()
end

function CutepetassistanceselectView:_refreshUI()
	local list = {}
	local allCutePet = CutePetModel.instance:getAllCutePet()
	local map = {}
	local isNil = true

	for i, v in ipairs(self._fillterTypes or {}) do
		map[v] = true
		isNil = false
	end

	for i, mo in pairs(allCutePet) do
		if CutePetFilterMgr.instance:checkIsMatch(self._filterType, mo.cfg, mo.id) == true then
			table.insert(list, mo)
		end
	end

	if self._togOnlyShowSame.isOn then
		list = self:_filterHighestQualitySameRace(list)
	end

	ArraySort.sortOn(list, {
		"curLvl",
		"curQuality",
		"curStar",
		"gainTime",
		"id"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NUMERIC,
		ArraySort.NUMERIC
	})
	self._scrollList:reloadData(list)
	GameUtil.SetActive(self._empty, self._currSelectCutePetId == 0)
	GameUtil.SetActive(self._selectInfo, self._currSelectCutePetId ~= 0)

	if self._currSelectCutePetId ~= 0 then
		local cutePetMo = CutePetModel.instance:getCutePeMo(self._currSelectCutePetId)

		if cutePetMo then
			MaterialMgr.setCellByMo(cutePetMo, self._petCon)

			self._txtName.text = cutePetMo.name
			self._txtDesc.text = ""

			local assistanceCfg = CutePetConfig.instance:getAssistanceCfgByRaceId(cutePetMo.raceId, cutePetMo.curQuality)

			if assistanceCfg then
				self._txtDesc.text = assistanceCfg.desc
			end
		end
	end
end

function CutepetassistanceselectView:_filterHighestQualitySameRace(list)
	local raceMap = {}

	for i, mo in ipairs(list or {}) do
		local raceId = mo.raceId
		local oldMo = raceMap[raceId]

		if oldMo == nil or self:_isBetterSameRaceCutePet(mo, oldMo) then
			raceMap[raceId] = mo
		end
	end

	local result = {}

	for i, mo in pairs(raceMap) do
		table.insert(result, mo)
	end

	return result
end

function CutepetassistanceselectView:_isBetterSameRaceCutePet(a, b)
	if a.curQuality ~= b.curQuality then
		return a.curQuality > b.curQuality
	end

	if a.curLvl ~= b.curLvl then
		return a.curLvl > b.curLvl
	end

	if a.curStar ~= b.curStar then
		return a.curStar > b.curStar
	end

	if a.gainTime ~= b.gainTime then
		return a.gainTime < b.gainTime
	end

	return a.id < b.id
end

function CutepetassistanceselectView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local team = goutil.findChild(cell, "team")
	local btnClick = goutil.findChild(cell, "btnClick")

	MaterialMgr.setCellByMo(data, con)

	txtName.text = data.name

	GameUtil.SetActive(imgSelect, data.id == self._currSelectCutePetId)
	GameUtil.SetActive(team, data.id == self._currUpCutePetId)
	GameUtil.addClickHandler(btnClick, GameUtil.handler(self._onClickCutePet, self, data))
end

function CutepetassistanceselectView:clearCell(cell)
	local con = goutil.findChild(cell, "con")
	local txtName = goutil.findChild(cell, "txtName")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local team = goutil.findChild(cell, "team")
	local btnClick = goutil.findChild(cell, "btnClick")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btnClick)
end

function CutepetassistanceselectView:_onClickCutePet(cutePetMo)
	self._currSelectCutePetId = self._currSelectCutePetId == cutePetMo.id and 0 or cutePetMo.id

	self:_refreshUI()
end

function CutepetassistanceselectView:_onClickFileter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._goFilter)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._refreshUI, self))
end

function CutepetassistanceselectView:_onOnlyShowSameChanged(go, isOn)
	self:_refreshUI()
end

function CutepetassistanceselectView:_onClickSure()
	self:close()
	GameUtil.callBack(self._callBack, self._currSelectCutePetId)
end

function CutepetassistanceselectView:_onClickClose()
	CutePetFilterMgr.instance:resetDataByType(self._filterType)
	self:close()
end

function CutepetassistanceselectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

return CutepetassistanceselectView
