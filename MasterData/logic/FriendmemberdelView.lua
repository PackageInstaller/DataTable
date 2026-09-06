-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendmemberdelView.lua

module("logic.extensions.friend.view.FriendmemberdelView", package.seeall)

local FriendmemberdelView = class("FriendmemberdelView", ViewComponent)
local times = {
	7,
	14,
	28
}

function FriendmemberdelView:ctor()
	FriendmemberdelView.super.ctor(self)
end

function FriendmemberdelView:unbindEvents()
	FriendmemberdelView.super.unbindEvents(self)
	self._timeDrd:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._closeBtn)
	GameUtil.rmClickHandler(self._cancelBtn)
	GameUtil.rmClickHandler(self._onekeyBtn)
	GameUtil.rmClickHandler(self._sureBtn)
end

function FriendmemberdelView:bindEvents()
	FriendmemberdelView.super.bindEvents(self)
	self._timeDrd:AddOnValueChanged(self._onTimeValueChanged, self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
	GameUtil.addClickHandler(self._cancelBtn, self.close, self)
	GameUtil.addClickHandler(self._onekeyBtn, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._sureBtn, self._onClickSure, self)
end

function FriendmemberdelView:buildUI()
	FriendmemberdelView.super.buildUI(self)

	self._closeBtn = self:getGo("closeBtn")
	self._emptyGo = self:getGo("emptyGo")
	self._sureBtn = self:getGo("sureBtn")
	self._cancelBtn = self:getGo("cancelBtn")
	self._onekeyBtn = self:getGo("onekeyBtn")
	self._sortDrd = DropDownAdapter.Get(self:getGo("sortDrd"))
	self._timeDrd = DropDownAdapter.Get(self:getGo("timeDrd"))
	self._countTxt = self:getTxt("countTxt")
	self._countTxt.text = ""

	GameUtil.SetActive(self._emptyGo, false)

	self._itemListSR = self:getGo("itemListSR")
	self._itemCell = self:getGo("itemCell")
	self._scrollList = ScrollerList.create(self._itemListSR, self._itemCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function FriendmemberdelView:onExit()
	FriendmemberdelView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.FriendRemoveList, self._onRefreshUI, self)
end

function FriendmemberdelView:onEnter()
	FriendmemberdelView.super.onEnter(self)

	self._curTimeIndex = 1
	self._maxCount = 10

	self:_onRefreshUI()
	GlobalDispatcher:addListener(GlobalNotify.FriendRemoveList, self._onRefreshUI, self)
end

function FriendmemberdelView:_onTimeValueChanged(value)
	if value + 1 == checknumber(self._curTimeIndex) then
		return
	end

	self._curTimeIndex = value + 1

	self:_onRefreshList()
end

function FriendmemberdelView:_onRefreshList()
	local nowTime = ServerTime.now()
	local timer = times[self._curTimeIndex] * 24 * 60 * 60
	local tempList = {}
	local group = GameEnum.FriendGroup.Friend
	local list = FriendModel.instance:getGroupDatas(group) or {}

	for i, data in ipairs(list) do
		if not data:getIsOnline() and timer <= nowTime - data._lastOpTime / 1000 then
			table.insert(tempList, data)
		end
	end

	ArraySort.sortOn(tempList, "_lastOpTime", ArraySort.NUMERIC)
	self._scrollList:reloadData(tempList)
	GameUtil.SetActive(self._emptyGo, #tempList == 0)
	self._scrollList:MoveCellToBegin(0)
end

function FriendmemberdelView:_onRefreshUI()
	self._selectPool = {}
	self._curCount = 0
	self._nowTime = ServerTime.nowServerLook()

	self:_onRefreshList()
	self:_updateSelectCount()
end

function FriendmemberdelView:_updateSelectCount()
	self._curCount = 0

	for k, v in pairs(self._selectPool) do
		if v then
			self._curCount = self._curCount + 1
		end
	end

	self._countTxt.text = langPara("当前可选人数：%s/%s", self._curCount, self._maxCount)
end

function FriendmemberdelView:_updateCell(view, cell, data)
	local headGo = goutil.findChild(cell, "headGo")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local contributeTxt = goutil.findChildTextComponent(cell, "contributeTxt")
	local positionGoIcc = goutil.findChildComponent(cell, "positionGo", "UIImageColorChange")
	local positionTxt = goutil.findChildTextComponent(cell, "positionGo/positionTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local levelTxt = goutil.findChildTextComponent(cell, "levelTxt")
	local onlineTxt = goutil.findChildTextComponent(cell, "onlineTxt")
	local choiseBtnGo = goutil.findChild(cell, "choiseBtn")
	local returnGo = goutil.findChild(cell, "returnGo")
	local choiseGo = goutil.findChild(cell, "choiseBtn/choiseIma/choiseGo")
	local area = goutil.findChild(cell, "nameTxt/area")
	local txtArea = goutil.findChildTextComponent(cell, "nameTxt/area/txt")
	local relationshipTab = goutil.findChild(cell, "relationshipTab")
	local txtRelationshipTab = goutil.findChildTextComponent(cell, "relationshipTab/txt")

	GameUtil.asBtn(choiseBtnGo):RemoveClickListener()
	GameUtil.asBtn(choiseBtnGo):AddClickListener(function()
		self:_onClickChoiseItemBtn(data)
	end, self)
	GameUtil.SetActive(area, false)

	nameTxt.text = data._name

	if data.headInfo and not string.nilorempty(data.headInfo.areaName) then
		GameUtil.SetActive(area, true)

		txtArea.text = data.headInfo.areaName
	end

	returnGo:SetActive(data:getRegressEndTime() > self._nowTime)
	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	powerTxt.text = data._zdl
	levelTxt.text = "等级：" .. data:getLevel()

	if data:getIsOnline() then
		onlineTxt.text = "在线"

		GameUtil.setUITextColorIdx(onlineTxt, 1)
	else
		GameUtil.setUITextColorIdx(onlineTxt, 0)

		onlineTxt.text = ""
	end

	contributeTxt.text = self:getLeftTime(data._lastOpTime)

	goutil.setActive(choiseGo, self._selectPool[tostring(data._id)] == true)

	local relTypeList = FriendModel.instance:getRelTypeList(data.headInfo.userId)
	local str = ""

	for _, relType in ipairs(relTypeList) do
		str = ""

		if relType == GameEnum.RelTypeByFriend.Tutor then
			local relId = FriendModel.instance:getRelIdByTutor(data.headInfo.userId)

			if relId == GameEnum.RelIdByTutor.Teacher then
				str = "师傅"

				break
			end

			if relId == GameEnum.RelIdByTutor.Student then
				str = "学生"
			end

			break
		end
	end

	txtRelationshipTab.text = str

	GameUtil.SetActive(relationshipTab, not string.nilorempty(str))
end

function FriendmemberdelView:clearCell(cell)
	local headGo = goutil.findChild(cell, "headGo")
	local choiseBtnGo = goutil.findChild(cell, "choiseBtn")

	HeadItemController.instance:resetHeadCell(headGo)
	GameUtil.asBtn(choiseBtnGo):RemoveClickListener()
end

function FriendmemberdelView:_onClickChoiseItemBtn(data)
	local key = tostring(data._id)

	if not self._selectPool[key] and self._curCount >= self._maxCount then
		TipsFacade.instance:openCommonTips(langPara("一次删除好友不能超过%s个", self._maxCount))

		return
	end

	self._selectPool[key] = not self._selectPool[key]

	self:_updateSelectCount()
	self._scrollList:refresh()
end

function FriendmemberdelView:_onClickSure()
	if self._curCount > 0 then
		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("是否确认要删除选中的%s个好友？", self._curCount), function()
			local idList = {}

			for k, v in pairs(self._selectPool) do
				table.insert(idList, k)
			end

			FriendController.instance:DeleteFriendList(idList)
		end)
	else
		TipsFacade.instance:openCommonTips("请选择要删除的好友")
	end
end

function FriendmemberdelView:_onClickOneKey()
	local list = self._scrollList:getData() or {}

	self._curCount = 0
	self._selectPool = {}

	for i, data in ipairs(list) do
		if self._curCount < self._maxCount then
			local key = tostring(data._id)
			local result, tips = FriendController.instance:getDeleteResultAndTips(key)

			if result == GameEnum.ResultCode.Success then
				self._curCount = self._curCount + 1
				self._selectPool[key] = true
			end
		else
			break
		end
	end

	self:_updateSelectCount()
	self._scrollList:refresh()
end

function FriendmemberdelView:getLeftTime(time, isFriend)
	time = checknumber(time) / 1000

	local leftTime = ServerTime.now() - time

	if leftTime <= 0 then
		return "<1分钟"
	elseif leftTime >= 86400 then
		return string.format("%d天前", math.floor(leftTime / 86400))
	elseif leftTime >= 3600 then
		return string.format("%d小时前", math.floor(leftTime / 3600))
	elseif leftTime >= 60 then
		return string.format("%d分钟前", math.floor(leftTime / 60))
	else
		return "<1分钟"
	end
end

return FriendmemberdelView
