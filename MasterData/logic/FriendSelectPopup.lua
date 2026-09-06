-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/FriendSelectPopup.lua

module("logic.extensions.birthdaywishes.view.FriendSelectPopup", package.seeall)

local FriendSelectPopup = class("FriendSelectPopup", TableViewComponent)

function FriendSelectPopup:ctor()
	FriendSelectPopup.super.ctor(self)

	self._matItemList = nil
	self._curFriendId = nil
end

function FriendSelectPopup:onExit()
	FriendSelectPopup.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesGiveaway, self._updataShowGiftInfo, self)
	MaterialController.instance:unregisterLocalNotify("ItemUsed", self._showMatItemInfo, self)
	removetimer(self._calculationSurplusTime, self)

	for _, item in pairs(self._matItemList or {}) do
		if item and item.iconGo then
			MaterialMgr.resetAll(item.iconGo)
		end
	end
end

function FriendSelectPopup:destroyUI()
	FriendSelectPopup.super.destroyUI(self)

	self._matItemList = nil
	self._curFriendId = nil
end

function FriendSelectPopup:bindEvents()
	FriendSelectPopup.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sendBtn:AddClickListener(self._onClickSendBtn, self)

	for i = 1, #self._matItemList do
		GameUtil.asBtn(self._matItemList[i].itemGo):AddClickListener(function()
			self:_onClickMatItemBtn(i)
		end, self)
	end
end

function FriendSelectPopup:unbindEvents()
	FriendSelectPopup.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sendBtn:RemoveClickListener()

	for _, item in pairs(self._matItemList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function FriendSelectPopup:buildUI()
	FriendSelectPopup.super.buildUI(self)

	self._emptyGo = self:getGo("emptyGo")
	self._closeBtn = self:getBtn("closeBtn")
	self._sendBtn = self:getBtn("sendBtn")
	self._sendTxtGo = self:getGo("sendBtn/sendTxt")
	self._descTxt = self:getTxt("descTxt")
	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._matItemList = {}
	self._matItemList[1] = {
		itemGo = goutil.findChild(self.mainGO, "matItem1"),
		iconGo = goutil.findChild(self.mainGO, "matItem1/iconGo"),
		chosieGo = goutil.findChild(self.mainGO, "matItem1/chosieGo"),
		countTxt = goutil.findChildTextComponent(self.mainGO, "matItem1/countTxt")
	}
	self._matItemList[2] = {
		itemGo = goutil.findChild(self.mainGO, "matItem2"),
		iconGo = goutil.findChild(self.mainGO, "matItem2/iconGo"),
		chosieGo = goutil.findChild(self.mainGO, "matItem2/chosieGo"),
		countTxt = goutil.findChildTextComponent(self.mainGO, "matItem2/countTxt")
	}
	self._matItemList[3] = {
		itemGo = goutil.findChild(self.mainGO, "matItem3"),
		iconGo = goutil.findChild(self.mainGO, "matItem3/iconGo"),
		chosieGo = goutil.findChild(self.mainGO, "matItem3/chosieGo"),
		countTxt = goutil.findChildTextComponent(self.mainGO, "matItem3/countTxt")
	}
	self._timeTxt.text = ""
end

function FriendSelectPopup:onEnter()
	FriendSelectPopup.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesGiveaway, self._updataShowGiftInfo, self)
	MaterialController.instance:registerLocalNotify("ItemUsed", self._showMatItemInfo, self)

	self._curViewDatas = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	table.sort(self._curViewDatas, FriendSelectPopup._sortFriends)

	self._isEmpty = #self._curViewDatas == 0

	goutil.setActive(self._emptyGo, self._isEmpty)
	uGuiUtil.setTextGrayState(self._sendTxtGo, self._isEmpty)
	uGuiUtil.setImageGrayState(self._sendBtn.gameObject, self._isEmpty)

	self._matInfos = self._viewPresentor._openParam[1]
	self._actCfg = self._viewPresentor._openParam[3]

	self:_updataShowGiftInfo()

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.BirthdayWishes, self._actCfg.activityId) then
		self:close()

		return
	end

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.BirthdayWishes, self._actCfg.activityId)

	self._supTime = GameUtil.string2time(cfg.endTime) - ServerTime.now()

	settimer(1, self._calculationSurplusTime, self, true)
end

function FriendSelectPopup._sortFriends(a, b)
	local isOnlineA = a._onlineZoneId > 0
	local isOnlineB = b._onlineZoneId > 0

	if isOnlineA == isOnlineB then
		if isOnlineA then
			if a._zdl ~= b._zdl then
				return checknumber(a._zdl) > checknumber(b._zdl)
			end

			if a:getLevel() ~= b:getLevel() then
				return checknumber(a:getLevel()) > checknumber(b:getLevel())
			end
		else
			return checknumber(a:lastOpTime()) > checknumber(b:lastOpTime())
		end
	else
		return isOnlineA
	end
end

function FriendSelectPopup:_calculationSurplusTime()
	self._supTime = self._supTime - 1

	if self._supTime < 0 then
		removetimer(self._calculationSurplusTime, self)
		FloatWordMgr.instance:show(lang("text_activity_end"))
		self:close()

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function FriendSelectPopup:_updataShowGiftInfo()
	self._curFriendId = nil

	self:reloadData()

	local matIndex = self._curMatIndex

	if checknumber(matIndex) <= 0 then
		matIndex = math.max(checknumber(self._viewPresentor._openParam[2]), 1)
	end

	self:_showMatItemInfo()

	local matType, matId, matNum = MaterialMgr.getMatParams(self._matInfos[matIndex].reward)

	if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
		matIndex = 0

		for i = 1, #self._matItemList do
			matType, matId, matNum = MaterialMgr.getMatParams(self._matInfos[i].reward)

			if matNum <= MaterialModel.instance:getMaterialsNumber(matType, matId) then
				matIndex = i

				break
			end
		end
	end

	local baseInfo = BirthdayWishesModel.instance:getBirthdayWishesBaseInfo()

	self._descTxt.text = string.format("每日前%s次赠送给其他玩家，即可获得[自选信物*1]，当前第%s次，每日最多可以赠送%s次", self._actCfg.dailyRewardNum, baseInfo.giveNum, self._actCfg.dailyGiveLimitNum)

	if checknumber(matIndex) <= 0 then
		self._curMatIndex = nil

		for i = 1, #self._matItemList do
			GameUtil.SetActive(self._matItemList[i].chosieGo, false)
		end
	else
		self:_onClickMatItemBtn(matIndex, true)
	end
end

function FriendSelectPopup:_onClickSendBtn()
	local baseInfo = BirthdayWishesModel.instance:getBirthdayWishesBaseInfo()

	if baseInfo.giveNum >= self._actCfg.dailyGiveLimitNum then
		FloatWordMgr.instance:show("今日赠送已超上限！")

		return
	end

	if self._isEmpty then
		FloatWordMgr.instance:show("好友列表空空的！")

		return
	end

	if self._curFriendId == nil then
		FloatWordMgr.instance:show("请选中一名好友进行发送！")

		return
	end

	if checknumber(self._curMatIndex) <= 0 then
		FloatWordMgr.instance:show("请选择要赠送的信物！")

		return
	end

	if self._matInfos == nil or self._matInfos[self._curMatIndex] == nil or string.nilorempty(self._matInfos[self._curMatIndex].reward) then
		FloatWordMgr.instance:show("当前信物数量不足赠送好友！")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._matInfos[self._curMatIndex].reward)

	if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
		FloatWordMgr.instance:show("当前信物数量不足赠送好友！")

		return
	end

	local tokenId = self._actCfg.tokenIds[self._curMatIndex]
	local tokenCfg = BirthdayWishesConfig.instance:getBirthdayWishesTokenCfg(tokenId)

	BirthdayWishesController.instance:csGetBirthdayWishesGiveFriendReq(self._actCfg.activityId, self._curFriendId, tokenCfg.tokenId)
end

function FriendSelectPopup:_showMatItemInfo()
	for i = 1, #self._matItemList do
		MaterialMgr.resetAll(self._matItemList[i].iconGo)

		if self._matInfos and self._matInfos[i] then
			GameUtil.SetActive(self._matItemList[i].itemGo, true)
			MaterialMgr.updateItemByStr(self._matItemList[i].iconGo, self._matInfos[i].reward)

			local haveNum = MaterialMgr.getMatCount(self._matInfos[i].reward)

			self._matItemList[i].countTxt.text = tostring(haveNum)

			GameUtil.SetActive(self._matItemList[i].chosieGo, false)
		else
			GameUtil.SetActive(self._matItemList[i].itemGo, false)
		end
	end
end

function FriendSelectPopup:_onClickMatItemBtn(index, isForce)
	if not isForce and self._curMatIndex == index then
		return
	end

	if self._matInfos == nil or self._matInfos[index] == nil or string.nilorempty(self._matInfos[index].reward) then
		FloatWordMgr.instance:show("当前信物数量不足赠送好友！")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._matInfos[index].reward)

	if not isForce and matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
		FloatWordMgr.instance:show("当前信物数量不足赠送好友！")

		return
	end

	self._curMatIndex = index

	for i = 1, #self._matItemList do
		GameUtil.SetActive(self._matItemList[i].chosieGo, i == self._curMatIndex)
	end
end

function FriendSelectPopup:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "itemListSR"
	}
end

function FriendSelectPopup:_updateCell(view, cell, data)
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local levelTxt = goutil.findChildTextComponent(cell, "levelTxt")
	local onlineTxt = goutil.findChildTextComponent(cell, "onlineTxt")
	local onlineChange = onlineTxt:GetComponent("UITextColorChange")
	local choiseBtnGo = goutil.findChild(cell, "choiseBtn")
	local choiseTog = Framework.ToggleAdapter.GetFrom(choiseBtnGo, "choiseTog")

	MaterialMgr.resetAll(headGo)
	GameUtil.asBtn(choiseBtnGo):RemoveClickListener()

	choiseTog.isOn = not not (self._curFriendId and data._id == self._curFriendId)
	nameTxt.text = data._name

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	powerTxt.text = data._zdl
	levelTxt.text = "Lv." .. data:getLevel()

	if data:getIsOnline() then
		onlineTxt.text = "在线"

		onlineChange:SetState(1)
	else
		onlineTxt.text = TimeUtil.getLeftTime(data._lastOpTime, true)

		onlineChange:SetState(0)
	end

	GameUtil.asBtn(choiseBtnGo):AddClickListener(function()
		self:_onClickChoiseToggle(data._id)
	end, self)
end

function FriendSelectPopup:_onClickChoiseToggle(friendId)
	if self._curFriendId and self._curFriendId == friendId then
		self._curFriendId = nil
	else
		self._curFriendId = friendId
	end

	self:reloadData()
end

return FriendSelectPopup
