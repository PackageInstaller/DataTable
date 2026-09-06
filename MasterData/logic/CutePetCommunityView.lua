-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/community/CutePetCommunityView.lua

module("logic.extensions.cutepet.view.CutePetCommunityView", package.seeall)

local CutePetCommunityView = class("CutePetCommunityView", ViewComponent)

CutePetCommunityView.SortType = {
	Friends = 3,
	Earliest = 2,
	Latest = 1
}

function CutePetCommunityView:ctor()
	CutePetCommunityView.super.ctor(self)
end

function CutePetCommunityView:unbindEvents()
	CutePetCommunityView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._btnPublish)
	self._btnMyPublish:RemoveClickListener()
end

function CutePetCommunityView:bindEvents()
	CutePetCommunityView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnPublish, self._onClickPublish, self)
	self._btnMyPublish:AddClickListener(self._onClickbtnMyPublish, self)
end

function CutePetCommunityView:buildUI()
	CutePetCommunityView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTips = self:getGo("leftTop/btnTip")
	self._btnPublish = self:getGo("btnPublish")
	self._tableView = self:getGo("ScrollView")
	self._tableCell = self:getGo("Cell")
	self._btnFilterGo = self:getGo("btnFilter")
	self._btnFilter = self:getGo("btnFilter")
	self._txtFilter = self:getTxt("btnFilter/text")
	self._imgFilterNomal = goutil.findChild(self._btnFilterGo, "head/arrow")
	self._imgFilterType = goutil.findChildComponent(self._btnFilterGo, "head/imgType", "UIImageSpriteChange")
	self._empty = self:getGo("empty")
	self._btnSort = self:getGo("btnSort")
	self._txtSort = self:getTxt("btnSort/text")
	self._btnMyPublish = self:getBtn("btnMyPublish")
end

function CutePetCommunityView:onExit()
	CutePetCommunityView.super.onExit(self)
end

function CutePetCommunityView:onEnter()
	CutePetCommunityView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_LoadCutePetCommunityNewsResp, self._refreshView, self)

	self._isLock = false
	self._sortType = CutePetCommunityView.SortType.Friends
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	CutePetGardenAgent.instance:sendPM_LoadCutePetCommunityNewsReq()
end

function CutePetCommunityView:_refreshView()
	local list = {}

	for i, v in ipairs(CutePetModel.instance:getCommunityNewsInfo() or {}) do
		if self:_isMatch(v.cutePetRaceId) then
			table.insert(list, v)
		end
	end

	local filterData = CutePetFilterMgr.instance:getFilterData(CutePetFilterMgr.TYPE_COMMUNITY)
	local selectCnt = 0
	local selectIdx = 0

	if filterData then
		for i, v in ipairs(filterData) do
			if v then
				selectCnt = selectCnt + 1
				selectIdx = i
			end
		end
	end

	if selectCnt > 0 then
		if #selectCnt == 1 then
			local typeCfg = CutePetConfig.instance:getPetTypeCfg(selectIdx)

			self._txtFilter.text = typeCfg.name

			GameUtil.SetActive(self._imgFilterNomal, false)
			GameUtil.SetActive(self._imgFilterType, true)
			self._imgFilterType:SetState(typeCfg.type - 1)
		else
			GameUtil.SetActive(self._imgFilterNomal, true)
			GameUtil.SetActive(self._imgFilterType, false)

			self._txtFilter.text = lang("多选")
		end
	else
		GameUtil.SetActive(self._imgFilterNomal, true)
		GameUtil.SetActive(self._imgFilterType, false)

		self._txtFilter.text = lang("种类筛选")
	end

	if self._sortType == CutePetCommunityView.SortType.Latest then
		self._tableList:reloadData(list)

		self._txtSort.text = lang("最新")
	elseif self._sortType == CutePetCommunityView.SortType.Earliest then
		self._tableList:reloadData(GameUtil.reverse(list))

		self._txtSort.text = lang("最早")
	elseif self._sortType == CutePetCommunityView.SortType.Friends then
		local listFriend = {}
		local listNormal = {}

		for i, data in ipairs(list) do
			local groupType = FriendModel.instance:getGroupTypeById(data.userHeadInfo.userId)
			local isFriend = groupType == GameEnum.FriendGroup.Friend

			if isFriend then
				table.insert(listFriend, data)
			else
				table.insert(listNormal, data)
			end
		end

		table.insertto(listFriend, listNormal)
		self._tableList:reloadData(listFriend)

		self._txtSort.text = lang("好友")
	end

	GameUtil.SetActive(self._empty, #list <= 0)
end

function CutePetCommunityView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgType = goutil.findChildComponent(go, "container/cover/imgType", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(go, "container/cover/txtName")
	local con = goutil.findChild(go, "container/mask/con")
	local btnClick = goutil.findChild(go, "container")
	local goHead = goutil.findChild(cell.gameObject, "container/info/head")
	local goFriend = goutil.findChild(cell.gameObject, "container/info/goFriend")
	local txtUserName = goutil.findChildTextComponent(cell.gameObject, "container/info/txtUserName")
	local raceCfg = CutePetConfig.instance:getCutePetById(data.cutePetRaceId)

	imgType:SetState(raceCfg.type - 1)

	local typeCfg = CutePetConfig.instance:getPetTypeCfg(raceCfg.type)

	txtName.text = typeCfg.name

	MaterialMgr.setIcon(con, MatType.CutePet, data.cutePetRaceId)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickPet(data)
	end, self)

	local groupType = FriendModel.instance:getGroupTypeById(data.userHeadInfo.userId)
	local isFriend = groupType == GameEnum.FriendGroup.Friend

	HeadItemController.instance:setHeadCellByInfo(goHead, data.userHeadInfo)

	txtUserName.text = data.userHeadInfo.userName

	goutil.setActive(goFriend, isFriend)
end

function CutePetCommunityView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "container/mask/con")
	local btnClick = goutil.findChild(go, "container")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btnClick)
end

function CutePetCommunityView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutePetCommunityView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, "cute_pet_community_rule")
end

function CutePetCommunityView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter)

	UIStateManager.instance:open(ViewName.CutepetcommunityfilterView, pos, sizeDelta, self._viewPresentor, CutePetFilterMgr.TYPE_COMMUNITY, GameUtil.handler(self._updateFilterData, self))
end

function CutePetCommunityView:_updateFilterData()
	local data = CutePetFilterMgr.instance:getFilterData(CutePetFilterMgr.TYPE_COMMUNITY)

	self:_refreshView()
end

function CutePetCommunityView:_isMatch(raceId)
	return CutePetFilterMgr.instance:checkIsMatchByRaceId(CutePetFilterMgr.TYPE_COMMUNITY, raceId)
end

function CutePetCommunityView:_onClickSort()
	self._sortType = self._sortType + 1

	local maxNum = 3

	if maxNum < self._sortType then
		self._sortType = self._sortType - maxNum
	end

	self:_refreshView()
end

function CutePetCommunityView:_onClickClose()
	if self._isLock == true then
		return
	end

	self:close()
end

function CutePetCommunityView:_onClickPublish()
	if self._isLock == true then
		return
	end

	UIStateManager.instance:push(ViewName.CutePetCommunityPublishView)
end

function CutePetCommunityView:_onClickPet(data)
	if self._isLock == true then
		return
	end

	self._isLock = true

	FriendAgent.instance:sendSearchUserReq(nil, data.userHeadInfo.userId, function()
		self._isLock = false

		local mos = FriendModel.instance:GetSearchs()
		local groupType = FriendModel.instance:getGroupTypeById(data.userHeadInfo.userId)

		if #mos == 1 then
			UIStateManager.instance:push(ViewName.CutePetCommunityInfoView, mos[1], groupType, data)
		end
	end)
end

function CutePetCommunityView:_onClickbtnMyPublish()
	UIStateManager.instance:push(ViewName.CutepetmypublicView)
end

return CutePetCommunityView
