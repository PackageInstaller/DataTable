-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyMemberExpelView.lua

module("logic.extensions.family.view.FamilyMemberExpelView", package.seeall)

local FamilyMemberExpelView = class("FamilyMemberExpelView", TableViewComponent)

function FamilyMemberExpelView:ctor()
	FamilyMemberExpelView.super.ctor(self)

	self._curSortIndex = nil
	self._curTimeIndex = nil
	self._maxCount = nil
	self._curViewDatas = nil
	self._tempViewDatas = nil
end

function FamilyMemberExpelView:unbindEvents()
	FamilyMemberExpelView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._onekeyBtn:RemoveClickListener()
	self._sortDrd:RemoveOnValueChanged()
	self._timeDrd:RemoveOnValueChanged()
end

function FamilyMemberExpelView:bindEvents()
	FamilyMemberExpelView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
	self._cancelBtn:AddClickListener(self.close, self)
	self._onekeyBtn:AddClickListener(function()
		self:_onClickOnekeyBtn(true)
	end, self)
	self._sortDrd:AddOnValueChanged(self._onSortValueChanged, self)
	self._timeDrd:AddOnValueChanged(self._onTimeValueChanged, self)
end

function FamilyMemberExpelView:onExit()
	FamilyMemberExpelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KickUserOut, self._updataFamilyMemberSR, self)

	self._curViewDatas = nil
	self._tempViewDatas = nil
end

function FamilyMemberExpelView:buildUI()
	FamilyMemberExpelView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._emptyGo = self:getGo("emptyGo")
	self._sureBtn = self:getBtn("sureBtn")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._onekeyBtn = self:getBtn("onekeyBtn")
	self._sortDrd = DropDownAdapter.Get(self:getGo("sortDrd"))
	self._timeDrd = DropDownAdapter.Get(self:getGo("timeDrd"))
	self._countTxt = self:getTxt("countTxt")
	self._countTxt.text = ""

	GameUtil.SetActive(self._emptyGo, false)
end

function FamilyMemberExpelView:onEnter()
	FamilyMemberExpelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.KickUserOut, self._updataFamilyMemberSR, self)

	local values = FamilyConfig.instance:getCommonValue("KICK_DEFAULT_SELECTION")

	self._maxCount = FamilyConfig.instance:getCommonValue("DAILY_KICK_LIMIT", true)
	self._curSortIndex = nil
	self._curTimeIndex = nil

	local sort, time = 1, 1

	if not string.nilorempty(values) then
		local list = string.split(values)

		sort = math.max(checknumber(list[1]), 1)
		time = math.max(checknumber(list[2]), 1)
	end

	self:_updataFamilyMemberSR(sort, time)
end

function FamilyMemberExpelView:_updataFamilyMemberSR(sort, time)
	local allMembers = FamilyModel.instance:getMembers()

	self._tempViewDatas = {}

	local myRole = FamilyModel.instance:getMyRole()

	for _, info in pairs(allMembers or {}) do
		if info and info.role and myRole < info.role and checknumber(info.lastOnlineTime) > 0 then
			table.insert(self._tempViewDatas, {
				isChoise = false,
				mebInfo = info
			})
		end
	end

	self._supCount = self._maxCount - FamilyModel.instance:getDailyKickCount()
	self._curCount = 0

	local timeValue = self._curTimeIndex

	self._curTimeIndex = nil
	sort = checknumber(sort)
	self._curSortIndex = checknumber(self._curSortIndex)

	if sort == 0 or self._curSortIndex == 0 or sort ~= self._curSortIndex then
		if sort == 0 and self._curSortIndex > 0 then
			sort = self._curSortIndex
		end

		self._curSortIndex = nil

		self._sortDrd:SetValue(sort - 1)
	end

	time = checknumber(time)
	timeValue = checknumber(timeValue)

	if time == 0 or timeValue == 0 or time ~= timeValue then
		if time == 0 and timeValue > 0 then
			time = timeValue
		end

		self._timeDrd:SetValue(time - 1)
	end

	self:_onSortValueChanged(sort - 1)
	self:_onTimeValueChanged(time - 1)
end

function FamilyMemberExpelView:_onSortValueChanged(value)
	if value + 1 == checknumber(self._curSortIndex) then
		return
	end

	self._curSortIndex = value + 1

	if self._tempViewDatas and #self._tempViewDatas > 1 then
		if self._curSortIndex == 1 then
			table.sort(self._tempViewDatas, FamilyMemberExpelView.sortOfflineTimePve)
		elseif self._curSortIndex == 2 then
			table.sort(self._tempViewDatas, FamilyMemberExpelView.sortOfflineTimeRse)
		elseif self._curSortIndex == 3 then
			table.sort(self._tempViewDatas, function(a, b)
				if a.mebInfo.maxZdl == b.mebInfo.maxZdl then
					return a.mebInfo.totoalConstruction > b.mebInfo.totoalConstruction
				end

				return a.mebInfo.maxZdl > b.mebInfo.maxZdl
			end)
		elseif self._curSortIndex == 4 then
			table.sort(self._tempViewDatas, function(a, b)
				if a.mebInfo.maxZdl == b.mebInfo.maxZdl then
					return a.mebInfo.totoalConstruction < b.mebInfo.totoalConstruction
				end

				return a.mebInfo.maxZdl < b.mebInfo.maxZdl
			end)
		elseif self._curSortIndex == 5 then
			table.sort(self._tempViewDatas, function(a, b)
				if a.mebInfo.totoalConstruction == b.mebInfo.totoalConstruction then
					return a.mebInfo.maxZdl > b.mebInfo.maxZdl
				end

				return a.mebInfo.totoalConstruction > b.mebInfo.totoalConstruction
			end)
		elseif self._curSortIndex == 6 then
			table.sort(self._tempViewDatas, function(a, b)
				if a.mebInfo.totoalConstruction == b.mebInfo.totoalConstruction then
					return a.mebInfo.maxZdl < b.mebInfo.maxZdl
				end

				return a.mebInfo.totoalConstruction < b.mebInfo.totoalConstruction
			end)
		end
	end

	if checknumber(self._curTimeIndex) <= 0 then
		return
	end

	local timeValue = self._curTimeIndex

	self._curTimeIndex = nil

	self:_onTimeValueChanged(timeValue - 1)
end

function FamilyMemberExpelView.sortOfflineTimePve(a, b)
	local timeA = math.max(checknumber(a.mebInfo.lastOnlineTime), 0)
	local timeB = math.max(checknumber(b.mebInfo.lastOnlineTime), 0)

	if timeA == timeB then
		return a.mebInfo.maxZdl < b.mebInfo.maxZdl
	end

	return timeA < timeB
end

function FamilyMemberExpelView.sortOfflineTimeRse(a, b)
	local timeA = math.max(checknumber(a.mebInfo.lastOnlineTime), 0)
	local timeB = math.max(checknumber(b.mebInfo.lastOnlineTime), 0)

	if timeA == timeB then
		return a.mebInfo.maxZdl > b.mebInfo.maxZdl
	end

	return timeB < timeA
end

function FamilyMemberExpelView:_onTimeValueChanged(value)
	if value + 1 == checknumber(self._curTimeIndex) then
		return
	end

	local times = {
		7,
		14,
		28
	}

	self._curTimeIndex = value + 1

	local nowTime = ServerTime.now()
	local timer = times[self._curTimeIndex] * 24 * 60 * 60
	local tempList = {}

	for i = 1, #self._tempViewDatas do
		if self._tempViewDatas[i].mebInfo and checknumber(self._tempViewDatas[i].mebInfo.lastOnlineTime) >= 0 and timer <= nowTime - self._tempViewDatas[i].mebInfo.lastOnlineTime / 1000 then
			table.insert(tempList, self._tempViewDatas[i])
		end
	end

	self._curViewDatas = {}
	self._curCount = 0

	if #tempList == 0 then
		GameUtil.SetActive(self._emptyGo, true)
	else
		GameUtil.SetActive(self._emptyGo, false)

		for i = 1, #tempList do
			if self._curCount < self._supCount then
				self._curCount = self._curCount + 1
				tempList[i].isChoise = true
			else
				tempList[i].isChoise = false
			end

			table.insert(self._curViewDatas, tempList[i])
		end
	end

	self:reloadData()

	local useCount = FamilyModel.instance:getDailyKickCount()

	self._countTxt.text = langPara("text_family_desc_31", useCount, self._curCount, self._maxCount)
end

function FamilyMemberExpelView:_onClickOnekeyBtn(isTips)
	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		FloatWordMgr.instance:show(lang("text_family_desc_32"))

		return
	end

	if self._curCount >= self._supCount then
		FloatWordMgr.instance:show(lang("text_family_desc_29"))

		return
	end

	self._curCount = 0

	for i = 1, #self._curViewDatas do
		if self._curCount < self._supCount then
			self._curCount = self._curCount + 1
			self._curViewDatas[i].isChoise = true
		else
			self._curViewDatas[i].isChoise = false
		end
	end

	self:reloadData()

	local useCount = FamilyModel.instance:getDailyKickCount()

	self._countTxt.text = langPara("text_family_desc_31", useCount, self._curCount, self._maxCount)
end

function FamilyMemberExpelView:_onClickSureBtn()
	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		FloatWordMgr.instance:show("没有该离线时长的家族成员")

		return
	end

	if self._curCount > self._supCount then
		FloatWordMgr.instance:show(lang("text_family_desc_32"))

		return
	end

	if self._curCount == 0 then
		FloatWordMgr.instance:show(lang("text_family_desc_33"))

		return
	end

	local userIds = {}

	for _, info in pairs(self._curViewDatas or {}) do
		if info and info.isChoise and info.mebInfo then
			table.insert(userIds, info.mebInfo.simpleInfo.userId)
		end
	end

	local textTips = langPara("text_family_desc_34", self._curCount, self._supCount, self._maxCount)

	TipsFacade.instance:openPopupWindow(lang("text_family_desc_35"), textTips, function()
		FamilyController.instance:kickUserOutFamilyReq(userIds)
	end, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function FamilyMemberExpelView:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "itemListSR"
	}
end

function FamilyMemberExpelView:_updateCell(view, cell, data)
	local headGo = goutil.findChild(cell, "headGo")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local contributeTxt = goutil.findChildTextComponent(cell, "contributeTxt")
	local positionGoIcc = goutil.findChildComponent(cell, "positionGo", "UIImageColorChange")
	local positionTxt = goutil.findChildTextComponent(cell, "positionGo/positionTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local levelTxt = goutil.findChildTextComponent(cell, "levelTxt")
	local onlineTxt = goutil.findChildTextComponent(cell, "onlineTxt")
	local choiseBtnGo = goutil.findChild(cell, "choiseBtn")
	local choiseGo = goutil.findChild(choiseBtnGo, "choiseIma/choiseGo")

	GameUtil.asBtn(choiseBtnGo):RemoveClickListener()
	HeadItemController.instance:resetHeadCell(headGo)

	local simpleInfo = data.mebInfo.simpleInfo

	HeadItemController.instance:setHeadCellByInfo(headGo, simpleInfo)

	nameTxt.text = simpleInfo.userName
	powerTxt.text = data.mebInfo.maxZdl
	contributeTxt.text = data.mebInfo.totoalConstruction

	positionGoIcc:SetState(data.mebInfo.role)

	positionTxt.text = lang("tip_family_position_" .. data.mebInfo.role)
	onlineTxt.text = checknumber(data.mebInfo.lastOnlineTime) < 0 and "<color=#3BB647>在线</color>" or TimeUtil.getLeftTime(data.mebInfo.lastOnlineTime)
	levelTxt.text = simpleInfo.playerLv .. "级"

	GameUtil.SetActive(choiseGo, data.isChoise)
	GameUtil.asBtn(choiseBtnGo):AddClickListener(function()
		self:_onClickChoiseItemBtn(cell.data)
	end, self)
end

function FamilyMemberExpelView:_clearTableview(cell)
	local headGo = goutil.findChild(cell, "headGo")
	local choiseBtnGo = goutil.findChild(cell, "choiseBtn")

	HeadItemController.instance:resetHeadCell(headGo)
	GameUtil.asBtn(choiseBtnGo):RemoveClickListener()
end

function FamilyMemberExpelView:_onClickChoiseItemBtn(index)
	if self._curViewDatas == nil or self._curViewDatas[index] == nil then
		return
	end

	if not self._curViewDatas[index].isChoise then
		if self._curCount >= self._supCount then
			FloatWordMgr.instance:show(lang("text_family_desc_29"))

			return
		end

		self._curViewDatas[index].isChoise = true
		self._curCount = self._curCount + 1
	else
		self._curViewDatas[index].isChoise = false
		self._curCount = math.max(self._curCount - 1, 0)
	end

	self._tableview:UpdateCellAtIndex(index - 1)

	local useCount = FamilyModel.instance:getDailyKickCount()

	self._countTxt.text = langPara("text_family_desc_31", useCount, self._curCount, self._maxCount)
end

return FamilyMemberExpelView
