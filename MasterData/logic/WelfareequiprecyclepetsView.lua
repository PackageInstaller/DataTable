-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/view/WelfareequiprecyclepetsView.lua

module("logic.extensions.welfareequiprecycle.view.WelfareequiprecyclepetsView", package.seeall)

local WelfareequiprecyclepetsView = class("WelfareequiprecyclepetsView", ViewComponent)

function WelfareequiprecyclepetsView:ctor()
	WelfareequiprecyclepetsView.super.ctor(self)
end

function WelfareequiprecyclepetsView:unbindEvents()
	WelfareequiprecyclepetsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnClear)
	InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):RemoveLuaHandler(self._onInputSearchValueChangedHandler)
end

function WelfareequiprecyclepetsView:bindEvents()
	WelfareequiprecyclepetsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickClearSearch, self)

	self._onInputSearchValueChangedHandler = InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):AddLuaHandler(function(go, text)
		self:_OnSearchTextChanged(text)
	end)
end

function WelfareequiprecyclepetsView:buildUI()
	WelfareequiprecyclepetsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnFilter = self:getGo("right/tableview/btnFilter")
	self._InputC_Search = self:getGo("right/tableview/InputC_Search"):GetComponent("InputField")
	self._btnClear = self:getGo("right/tableview/InputC_Search/BtnClear")
	self._tableview = self:getGo("right/tableview")

	local cell = self:getGo("right/cell")

	self._scrollList = ScrollerList.create(self._tableview, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function WelfareequiprecyclepetsView:onExit()
	WelfareequiprecyclepetsView.super.onExit(self)
end

function WelfareequiprecyclepetsView:onEnter()
	WelfareequiprecyclepetsView.super.onEnter(self)

	local data = self:getFirstParam()

	self._activityId = checknumber(data)
	self._SearchText = nil

	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_EQUIP_RECYCLE)
	self:_refreshUI()
end

function WelfareequiprecyclepetsView:_clearTableview(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

function WelfareequiprecyclepetsView:_getPosAndSizeDelta(go)
	local sizeDelta = {
		0,
		0
	}
	local rect = go:GetComponent("RectTransform")

	sizeDelta = {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}

	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, sizeDelta
end

function WelfareequiprecyclepetsView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local select = goutil.findChild(cell, "btnClick")
	local noGet = goutil.findChild(cell, "noGet")

	txtName.text = ""

	MaterialMgr.resetAll(icon)

	local raceId = data
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

	goutil.setActive(select, false)
	MaterialMgr.setCell(MatType.Pet, raceId, icon)

	txtName.text = petSkinCfg.name

	goutil.setActive(noGet, false)
	goutil.setActive(btnClick, false)
end

function WelfareequiprecyclepetsView:_refreshUI()
	local cfg = WelfareRecycleConfig.instance:getReplaceCfgByActId(self._activityId) or {}

	self._initList = {}

	local tmp = {}

	for type, map in pairs(cfg) do
		for k, v in pairs(map) do
			if checknumber(v.isLimit) == 0 then
				local equipCfg = MaterialMgr.getMatCfg(v.materialType, v.defineId)

				if equipCfg and checknumber(equipCfg.throneRelatedSkinId) > 0 and tmp[checknumber(equipCfg.throneRelatedSkinId)] == nil then
					table.insert(self._initList, checknumber(equipCfg.throneRelatedSkinId))

					tmp[checknumber(equipCfg.throneRelatedSkinId)] = true
				end
			end
		end
	end

	self:_refreshFilterPetList()
end

function WelfareequiprecyclepetsView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_EQUIP_RECYCLE, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function WelfareequiprecyclepetsView:_updateFilterData(starList, jobList, rareList)
	self:_refreshFilterPetList()
end

function WelfareequiprecyclepetsView:_refreshFilterPetList()
	local list = {}

	for k, v in ipairs(self._initList) do
		if self:_onFilter(v) then
			table.insert(list, v)
		end
	end

	self._scrollList:reloadData(list)

	if #list > 0 then
		self._scrollList:MoveCellToBegin(0, false)
	end
end

function WelfareequiprecyclepetsView:_onFilter(raceId)
	local petCo = MaterialMgr.getMatCfg(MatType.PET_SKIN, raceId)

	if petCo == nil then
		return false
	end

	local isHit = false
	local rare = 1

	isHit = self:_isMatch(petCo, rare, raceId)

	if not string.nilorempty(self._SearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._SearchText)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function WelfareequiprecyclepetsView:_isMatch(cfg, rare, skinId)
	return (PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_EQUIP_RECYCLE, cfg, rare, skinId))
end

function WelfareequiprecyclepetsView:_OnSearchTextChanged(text)
	if text ~= self._SearchText then
		self._SearchText = text

		self:_refreshFilterPetList()
	end
end

function WelfareequiprecyclepetsView:_onClickClearSearch()
	self._InputC_Search.text = ""
end

return WelfareequiprecyclepetsView
