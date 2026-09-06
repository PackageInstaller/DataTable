-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetPresetBuddyView.lua

module("logic.extensions.cutepet.view.CutePetPresetBuddyView", package.seeall)

local CutePetPresetBuddyView = class("CutePetPresetBuddyView", ViewComponent)

function CutePetPresetBuddyView:ctor()
	CutePetPresetBuddyView.super.ctor(self)
end

function CutePetPresetBuddyView:unbindEvents()
	CutePetPresetBuddyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPrivate)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnInvite)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnTip)
end

function CutePetPresetBuddyView:bindEvents()
	CutePetPresetBuddyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPrivate, self._onClickPrivate, self)
	GameUtil.addClickHandler(self._btnInvite, self._onClickbtnInvite, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function CutePetPresetBuddyView:buildUI()
	CutePetPresetBuddyView.super.buildUI(self)

	self._buddyInfo = self:getGo("buddyInfo")
	self._petInfo = self:getGo("petInfo")
	self._showInfo = self:getGo("showInfo")
	self._btnClose = self:getGo("topLeft/btnClose")
	self._headIcon = self:getGo("buddyInfo/imgHeadIcon")
	self._txtName = self:getTxt("buddyInfo/txtName")
	self._imgPetType = goutil.findChildComponent(self.mainGO, "petInfo/imgType", "UIImageSpriteChange")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._petCon = self:getGo("con")
	self._txtTime = self:getTxt("showInfo/txtTime")
	self._txtNeedType = self:getTxt("showInfo/txtNeedType")
	self._imgNeedType = goutil.findChildComponent(self.mainGO, "showInfo/txtNeedType/imgType", "UIImageSpriteChange")
	self._btnPrivate = self:getGo("buddyInfo/btnPrivate")
	self._btnInvite = self:getGo("btnInvite")

	local tableviewGoPet = self:getGo("tableviewPet")
	local tablecellGoPet = self:getGo("tableviewPet/tablecell")

	self._tableviewPet = ScrollerList.create(tableviewGoPet, tablecellGoPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._btnFilter = self:getGo("btnFilter")
	self._goEmpty = self:getGo("goEmpty")
	self._filterPos = self:getGo("filterPos")
	self._btnTip = self:getGo("topLeft/btnTip")
end

function CutePetPresetBuddyView:onExit()
	CutePetPresetBuddyView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	HeadItemController.instance:resetHeadCell(self._headIcon)
	self._tableviewPet:dispose()
	CutePetFilterMgr.instance:resetDataByType(CutePetFilterMgr.TYPE_PRESETBUDDY)
end

function CutePetPresetBuddyView:onEnter()
	CutePetPresetBuddyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.CutePetBuddyInfoSyncComplete, self._handleSyncComplete, self)
	self:addGEvent(GlobalNotify.PlayerInfoJumpToOtherView, self.close)

	self._curSelectData = nil
	self._allPetInfoList = {}
	self._currentPetInfoList = {}
	self._dailyTravelCount = CutePetConfig.instance:getCommonValue("TravelDailyMaxCount", true)

	local isInTime, txtTime = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_TravelDailyMaxCount", false))

	if isInTime == true then
		self._dailyTravelCount = CutePetConfig.instance:getPrivilegeCommonValue("Privilege_TravelDailyMaxCount", true)
	end

	GameUtil.SetActive(self._typeContent, false)
	self:_updateLeftList()
	CutePetController.instance:resetAllOnlineBuddyInfo()
	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)
end

function CutePetPresetBuddyView:_handleSyncComplete()
	self._allPetInfoList = self:_getAllBuddyPetInfoList()

	self:_updateLeftList()
end

function CutePetPresetBuddyView:_getAllBuddyPetInfoList()
	local dataList = {}
	local buddyInfoMap = CutePetModel.instance:getAllBuddyTravelInfo() or {}

	for userId, v in pairs(buddyInfoMap) do
		local isCanTravel = checknumber(v.todayHasTravelCount) < self._dailyTravelCount

		if isCanTravel then
			if not v.cutePet then
				for _, petInfo in ipairs(v.cutePet) do
					local data = {}

					data.cutePetInfo = petInfo
					data.ownerUserId = userId

					table.insert(dataList, data)
				end
			end
		end
	end

	return dataList
end

function CutePetPresetBuddyView:_getCurrentBuddyPetInfoList()
	local dataList = {}

	for _, v in ipairs(self._allPetInfoList) do
		local cutePetInfo = v.cutePetInfo.cutePet
		local cutePetDefineId = cutePetInfo.cutePetId

		if self:_isMatch(cutePetDefineId) then
			table.insert(dataList, v)
		end
	end

	return dataList
end

function CutePetPresetBuddyView:_updateLeftList()
	self._currentPetInfoList = self:_getCurrentBuddyPetInfoList()

	local isNeedReset = true

	for i, v in ipairs(self._currentPetInfoList) do
		if v == self._curSelectData then
			isNeedReset = false

			break
		end
	end

	if isNeedReset then
		self._curSelectData = #self._currentPetInfoList > 0 and self._currentPetInfoList[1] or nil
	end

	self._tableviewPet:reloadData(self._currentPetInfoList)
	self:_updateRightUI()
	GameUtil.SetActive(self._goEmpty, #self._currentPetInfoList == 0)
end

function CutePetPresetBuddyView:_updateRightUI()
	if self._curSelectData then
		goutil.setActive(self._showInfo, true)
		goutil.setActive(self._buddyInfo, true)
		goutil.setActive(self._petInfo, true)
		goutil.setActive(self._petCon, true)
		goutil.setActive(self._btnInvite, true)

		local playerMo = FriendModel.instance:getFriendMo(self._curSelectData.ownerUserId)

		HeadItemController.instance:resetHeadCell(self._headIcon)
		HeadItemController.instance:setHeadCellByInfo(self._headIcon, playerMo.headInfo, true)

		self._txtName.text = playerMo.headInfo.userName

		local cutePetInfo = self._curSelectData.cutePetInfo.cutePet
		local cutePetDefineId = cutePetInfo.cutePetId
		local raceCfg = CutePetConfig.instance:getCutePetById(cutePetDefineId)

		self._imgPetType:SetState(raceCfg.type - 1)

		self._txtPetName.text = raceCfg.name

		CutePetModelMgr.instance:resetModel(1, raceCfg.modelId)
		CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(cutePetDefineId))

		if not cutePetInfo.travelCountNeeds then
			self._txtTime.text = langPara("%d次", cutePetInfo.travelCountNeeds)

			if not cutePetInfo.cutePetTypeNeeds then
				local cutePetTypeNeeds = 0

				if checknumber(cutePetTypeNeeds) > 0 then
					local typeCfg = CutePetConfig.instance:getPetTypeCfg(cutePetTypeNeeds)

					GameUtil.SetActive(self._imgNeedType, true)
					self._imgNeedType:SetState(cutePetTypeNeeds - 1)

					self._txtNeedType.text = typeCfg.name
				else
					GameUtil.SetActive(self._imgNeedType, false)

					self._txtNeedType.text = "无"
				end
			end
		end
	else
		goutil.setActive(self._showInfo, false)
		goutil.setActive(self._buddyInfo, false)
		goutil.setActive(self._petInfo, false)
		goutil.setActive(self._petCon, false)
		goutil.setActive(self._btnInvite, false)
	end
end

function CutePetPresetBuddyView:_onClickPrivate()
	if not ViewMgr.instance:isOpen(ViewName.Friend) then
		FriendController.instance:setSelectedGroup(GameEnum.FriendGroup.Friend)
	end

	local preId = FriendController.instance:getCurSelectedId()

	if self._curSelectData == nil then
		return
	end

	FriendController.instance:setCurSelctedId(self._curSelectData.ownerUserId)
	FriendController.instance:localNotify("SelectedIdChange", preId)
	FriendController.instance:OpenFriendView(self._curSelectData.ownerUserId)
end

function CutePetPresetBuddyView:_onClickbtnInvite()
	if not self._curSelectData then
		FloatWordMgr.instance:show("请先选择配对的宠物")

		return
	end

	UIStateManager.instance:push(ViewName.CutePetSelectMatchView, self._curSelectData.ownerUserId, self._curSelectData.cutePetInfo)
end

function CutePetPresetBuddyView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local icon = goutil.findChild(go, "icon")
	local select = goutil.findChild(go, "select")

	goutil.setActive(select, data == self._curSelectData)

	local cutePetInfo = data.cutePetInfo.cutePet
	local cutePetDefineId = cutePetInfo.cutePetId

	MaterialMgr.setCell(MatType.CutePet, cutePetDefineId, icon)

	local raceCfg = CutePetConfig.instance:getCutePetById(cutePetDefineId)
	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = raceCfg.name

	local txtTime = goutil.findChildTextComponent(go, "txtTime")

	if not cutePetInfo.travelCountNeeds then
		txtTime.text = langPara("出行次数：%d次", cutePetInfo.travelCountNeeds)

		GameUtil.rmClickHandler(btnSelect)
		GameUtil.addClickHandler(btnSelect, function()
			self._curSelectData = data

			self._tableviewPet:reloadData(self._currentPetInfoList)
			self:_updateRightUI()
		end, self)

		local imgTypeChange = goutil.findChildComponent(go, "imgType", "UIImageSpriteChange")

		imgTypeChange:SetState(raceCfg.type - 1)

		local txtNeed = goutil.findChildTextComponent(go, "txtNeed")

		if not cutePetInfo.cutePetTypeNeeds then
			local cutePetTypeNeeds = 0
			local needTypeStr = "无"

			if checknumber(cutePetTypeNeeds) > 0 then
				local typeCfg = CutePetConfig.instance:getPetTypeCfg(cutePetTypeNeeds)

				needTypeStr = typeCfg.name
			end

			txtNeed.text = string.format("期望：%s", needTypeStr)
		end
	end
end

function CutePetPresetBuddyView:_clearCellPet(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)

	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
end

function CutePetPresetBuddyView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterPos)

	UIStateManager.instance:open(ViewName.CutepetcommunityfilterView, pos, sizeDelta, self._viewPresentor, CutePetFilterMgr.TYPE_PRESETBUDDY, GameUtil.handler(self._updateFilterData, self))
end

function CutePetPresetBuddyView:_updateFilterData()
	local data = CutePetFilterMgr.instance:getFilterData(CutePetFilterMgr.TYPE_PRESETBUDDY)

	self:_updateLeftList()
end

function CutePetPresetBuddyView:_isMatch(raceId)
	return CutePetFilterMgr.instance:checkIsMatchByRaceId(CutePetFilterMgr.TYPE_PRESETBUDDY, raceId)
end

function CutePetPresetBuddyView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutePetPresetBuddyView:_onClickTip()
	TipsFacade.instance:openRulesView("CutePet_Preset_Buddy_Rule")
end

return CutePetPresetBuddyView
