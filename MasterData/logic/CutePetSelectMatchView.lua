-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSelectMatchView.lua

module("logic.extensions.cutepet.view.CutePetSelectMatchView", package.seeall)

local CutePetSelectMatchView = class("CutePetSelectMatchView", ViewComponent)

function CutePetSelectMatchView:ctor()
	CutePetSelectMatchView.super.ctor(self)
end

function CutePetSelectMatchView:unbindEvents()
	CutePetSelectMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnFilter)
end

function CutePetSelectMatchView:bindEvents()
	CutePetSelectMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
end

function CutePetSelectMatchView:buildUI()
	CutePetSelectMatchView.super.buildUI(self)

	self._txtNeedType = self:getTxt("txtNeedType")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")

	local tableviewGoPet = self:getGo("tableviewPet")
	local tablecellGoPet = self:getGo("tableviewPet/tablecell")

	self._tableviewPet = ScrollerList.create(tableviewGoPet, tablecellGoPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._btnFilter = self:getGo("btnFilter")
	self._goEmpty = self:getGo("goEmpty")
end

function CutePetSelectMatchView:onExit()
	CutePetSelectMatchView.super.onExit(self)
end

function CutePetSelectMatchView:onEnter()
	CutePetSelectMatchView.super.onEnter(self)

	self._curSelectData = nil
	self._selectType = 0
	self._dailyTravelCount = CutePetConfig.instance:getCommonValue("TravelDailyMaxCount", true)

	local isInTime, txtTime = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_TravelDailyMaxCount", false))

	if isInTime == true then
		self._dailyTravelCount = CutePetConfig.instance:getPrivilegeCommonValue("Privilege_TravelDailyMaxCount", true)
	end

	GameUtil.SetActive(self._typeContent, false)

	local params = self:getOpenParam()

	self._ownerUserId = params[1]
	self._matchPetData = params[2]

	local cutePetTypeNeeds = 0

	if not self._matchPetData then
		self:close()

		return
	end

	cutePetTypeNeeds = self._matchPetData.cutePet.cutePetTypeNeeds or 0
	self._selectType = cutePetTypeNeeds
	self._enterSelectType = cutePetTypeNeeds

	if checknumber(self._enterSelectType) > 0 then
		local typeCfg = CutePetConfig.instance:getPetTypeCfg(self._enterSelectType)

		self._txtNeedType.text = string.format("好友期望出游萌宠类型：<color=#cd7800>%s</color>,已为您完成筛选", (typeCfg or nil) and (typeCfg.name or ""))
	else
		self._txtNeedType.text = "好友期望出游萌宠类型：<color=#cd7800>无要求</color>,已为您完成筛选"
	end

	self._filterType = CutePetFilterMgr.TYPE_PRESETSELECTMATCH

	local filterData = CutePetFilterMgr.instance:getFilterData(self._filterType)

	if not filterData.typeSelectList then
		local typeSelectList = {}

		if not filterData.typeClickAble then
			local typeClickAble = {}

			if self._selectType == 0 then
				for i = 1, #typeClickAble do
					typeClickAble[i] = true
					typeSelectList[i] = false
				end
			else
				for i = 1, #typeClickAble do
					typeClickAble[i] = false
					typeSelectList[i] = i == self._selectType
				end
			end

			self:_refreshList()
		end
	end
end

function CutePetSelectMatchView:_refreshList()
	self._curSelectData = nil
	self._currentPetInfoList = self:_getCurrentBuddyPetInfoList()

	self._tableviewPet:reloadData(self._currentPetInfoList)
	GameUtil.SetActive(self._goEmpty, #self._currentPetInfoList == 0)
end

function CutePetSelectMatchView:_getCurrentBuddyPetInfoList()
	return (CutePetModel.instance:getAllCutePetsList(GameUtil.handler(self._filterPet, self)))
end

function CutePetSelectMatchView:_filterPet(petMo)
	local travelCount = CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true)
	local isMatch = CutePetFilterMgr.instance:checkIsMatch(self._filterType, petMo.cfg, petMo.id) == true

	return travelCount - petMo.travelCount > 0 and isMatch
end

function CutePetSelectMatchView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local icon = goutil.findChild(go, "icon")
	local select = goutil.findChild(go, "select")

	goutil.setActive(select, data == self._curSelectData)
	MaterialMgr.setCellByMo(data, icon)

	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = data.name

	local txtTime = goutil.findChildTextComponent(go, "txtTime")

	txtTime.text = langPara("剩余次数：%d", CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - data.travelCount)

	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self._curSelectData = data

		self._tableviewPet:reloadData(self._currentPetInfoList)
	end, self)
end

function CutePetSelectMatchView:_clearCellPet(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)

	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
end

function CutePetSelectMatchView:_onClickSure()
	if not self._curSelectData then
		FloatWordMgr.instance:show("请先选择配对的宠物")

		return
	end

	if not self._matchPetData.cutePet.cutePetId then
		local cutePetId = 1
		local raceCfg = CutePetConfig.instance:getCutePetById(cutePetId)
		local typeCfg = CutePetConfig.instance:getPetTypeCfg(raceCfg.type)

		if typeCfg then
			if not typeCfg.name then
				local typeName = "未知类型"
				local playerMo = FriendModel.instance:getFriendMo(self._ownerUserId)
				local connect = string.format("是否与%s的%s进行组队出游？", playerMo.headInfo.userName, typeName)

				local function okFunc()
					CutePetController.instance:sendPM_CutePetTravelQuickPairingReq(self._ownerUserId, self._matchPetData.uniqueId, cutePetId, self._curSelectData.id)
				end

				TipsFacade.instance:openPopupWindow("提示", connect, okFunc)
			end
		end
	end
end

function CutePetSelectMatchView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._refreshList, self))
end

function CutePetSelectMatchView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

return CutePetSelectMatchView
