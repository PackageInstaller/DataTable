-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GroupRechargeTeamView.lua

module("logic.extensions.grouprecharge.view.GroupRechargeTeamView", package.seeall)

local GroupRechargeTeamView = class("GroupRechargeTeamView", ViewComponent)

function GroupRechargeTeamView:ctor()
	GroupRechargeTeamView.super.ctor(self)
end

function GroupRechargeTeamView:unbindEvents()
	GroupRechargeTeamView.super.unbindEvents(self)
end

function GroupRechargeTeamView:bindEvents()
	GroupRechargeTeamView.super.bindEvents(self)
end

function GroupRechargeTeamView:buildUI()
	GroupRechargeTeamView.super.buildUI(self)

	self._txtTip = self:getTxt("txtTip")
	self._items = {}
	self._posConfigs = GroupRechargeConfig.instance:getPositionConfigs()

	for i = 1, 6 do
		local itemGroup = {}
		local item = self:getGo(string.format("container/item_%d", i))

		itemGroup.item = item
		itemGroup.imgIcon = goutil.findChild(item, "imgIcon")
		itemGroup.btnAddGo = goutil.findChild(item, "btnAdd")
		itemGroup.imgEmpty = goutil.findChild(item, "imgEmpty")
		itemGroup.btnAction = goutil.findChildButtonComponent(item, "btnAction")
		itemGroup.txtAction = goutil.findChildTextComponent(item, "btnAction/Text")
		itemGroup.txtCharge = goutil.findChildTextComponent(item, "txtCharge")
		itemGroup.txtName = goutil.findChildTextComponent(item, "txtName")
		itemGroup.txtCaptainGo = goutil.findChild(item, "txtCaptain")
		itemGroup.txtEmptyGo = goutil.findChild(item, "txtEmpty")

		local btnActionChange = goutil.findChildComponent(item, "btnAction", "UIImageSpriteChange")
		local posType = self._posConfigs[i].type

		if posType == GroupRechargeConfig.LT_Match then
			btnActionChange:SetState(1)
		else
			btnActionChange:SetState(0)
		end

		table.insert(self._items, itemGroup)
	end
end

function GroupRechargeTeamView:onExit()
	GroupRechargeTeamView.super.onExit(self)

	local controller = GroupRechargeController.instance

	controller:unregisterLocalNotify(GroupRechargeController.E_InfoRes, self._updateTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onFriendSelected, self)

	for i, itemGroup in ipairs(self._items) do
		GameUtil.rmClickHandler(itemGroup.btnAction)
		HeadItemController.instance:resetHeadCell(itemGroup.imgIcon)
	end
end

function GroupRechargeTeamView:onEnter()
	GroupRechargeTeamView.super.onEnter(self)

	local controller = GroupRechargeController.instance

	controller:registerLocalNotify(GroupRechargeController.E_InfoRes, self._updateTeams, self)

	local params = self:getOpenParam() or {}

	self._tabConf = params[1]
	self._txtTip.text = self._tabConf.desc

	self:_updateTeams()
end

function GroupRechargeTeamView:_updateTeams()
	local teamInfo = GroupRechargeModel.instance:getTeamInfo()
	local bInTeam = teamInfo:isInTeam()
	local bCaptain = teamInfo:isCaptain()

	for i, itemGroup in ipairs(self._items) do
		local memberInfo = teamInfo:getMemberByPosId(i)

		if memberInfo then
			self:_updateMemberInfo(itemGroup, memberInfo, i, bCaptain)
		else
			self:_updateMemberEmpty(itemGroup, i, bCaptain, bInTeam)
		end
	end
end

function GroupRechargeTeamView:_updateMemberInfo(itemGroup, memberInfo, index, bCaptain)
	GameUtil.SetActive(itemGroup.imgEmpty, false)
	GameUtil.SetActive(itemGroup.btnAddGo, false)
	GameUtil.SetActive(itemGroup.imgIcon, true)
	GameUtil.SetActive(itemGroup.btnAction, false)
	GameUtil.SetActive(itemGroup.txtEmptyGo, false)

	local posType = self._posConfigs[index].type

	GameUtil.SetActive(itemGroup.txtCaptainGo, posType == GroupRechargeConfig.LT_Captain)
	HeadItemController.instance:resetHeadCell(itemGroup.imgIcon)

	local proxy = HeadItemController.instance:setHeadCellByInfo(itemGroup.imgIcon, memberInfo.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if memberInfo.headInfo.userId then
				FriendController.instance:showInfoView(memberInfo.headInfo.userId, itemGroup.imgIcon)
			end
		end)
	end

	GameUtil.SetActive(itemGroup.txtCharge, true)
	GameUtil.SetActive(itemGroup.txtName, true)

	itemGroup.txtCharge.text = langPara("充值金额：<color=#4abf8b>%s</color>元", memberInfo.recharge or "0")
	itemGroup.txtName.text = string.format("%s\n%s", memberInfo.areaName, memberInfo.headInfo.userName)

	GameUtil.rmClickHandler(itemGroup.btnAction)
end

function GroupRechargeTeamView:_updateMemberEmpty(itemGroup, index, bCaptain, bInTeam)
	local bCanOperate = bCaptain or not bInTeam
	local posType = self._posConfigs[index].type

	GameUtil.SetActive(itemGroup.txtCaptainGo, false)

	if posType == GroupRechargeConfig.LT_Captain then
		GameUtil.SetActive(itemGroup.imgEmpty, false)
		GameUtil.SetActive(itemGroup.btnAddGo, false)
		GameUtil.SetActive(itemGroup.imgIcon, true)
		HeadItemController.instance:resetHeadCell(itemGroup.imgIcon)
		HeadItemController.instance:setMyHeadCell(itemGroup.imgIcon)
		GameUtil.SetActive(itemGroup.txtCharge, true)
		GameUtil.SetActive(itemGroup.txtName, true)
		GameUtil.SetActive(itemGroup.txtEmptyGo, false)

		itemGroup.txtCharge.text = langPara("充值金额：<color=#4abf8b>%s</color>元", GroupRechargeModel.instance:getChargeNum(GroupRechargeConfig.Personal or "0"))
		itemGroup.txtName.text = string.format("%s\n%s", RoleModel.instance:getAreaName(), RoleModel.instance:getUserName())

		GameUtil.SetActive(itemGroup.btnAction, false)
	elseif posType == GroupRechargeConfig.LT_Friend then
		GameUtil.SetActive(itemGroup.btnAddGo, bCanOperate)
		GameUtil.SetActive(itemGroup.imgEmpty, not bCanOperate)
		GameUtil.SetActive(itemGroup.imgIcon, false)
		HeadItemController.instance:resetHeadCell(itemGroup.imgIcon)
		GameUtil.SetActive(itemGroup.txtName, false)
		GameUtil.SetActive(itemGroup.txtCharge, false)
		GameUtil.SetActive(itemGroup.txtEmptyGo, not bCanOperate)
		GameUtil.SetActive(itemGroup.btnAction, bCanOperate)

		itemGroup.txtAction.text = lang("邀请好友")
	else
		GameUtil.SetActive(itemGroup.btnAddGo, false)
		GameUtil.SetActive(itemGroup.imgEmpty, true)
		GameUtil.SetActive(itemGroup.imgIcon, false)
		HeadItemController.instance:resetHeadCell(itemGroup.imgIcon)
		GameUtil.SetActive(itemGroup.txtName, false)
		GameUtil.SetActive(itemGroup.txtCharge, false)
		GameUtil.SetActive(itemGroup.txtEmptyGo, not bCanOperate)
		GameUtil.SetActive(itemGroup.btnAction, bCanOperate)

		itemGroup.txtAction.text = lang("匹配队友")
	end

	GameUtil.rmClickHandler(itemGroup.btnAction)
	GameUtil.addClickHandler(itemGroup.btnAction, function()
		if bCanOperate then
			if posType == GroupRechargeConfig.LT_Friend then
				self:_chooseFriend()
			elseif posType == GroupRechargeConfig.LT_Match then
				self:_startMatch(posType)
			end
		end
	end, self)
end

function GroupRechargeTeamView:_chooseFriend()
	GlobalDispatcher:addListener(GlobalNotify.FriendSelected, self._onFriendSelected, self)
	GroupRechargeController.instance:reqChooseFriend()
end

function GroupRechargeTeamView:_onFriendSelected(friendIds)
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onFriendSelected, self)
	GroupRechargeAgent.instance:sendPM_GroupRechargeSendRequestReq(friendIds)
end

function GroupRechargeTeamView:_startMatch(posType)
	local model = GroupRechargeModel.instance
	local matchNeedRecharge = checknumber(model.activityConf.matchNeedRecharge)
	local hasCharge = checknumber(model:getMyRechargeNum())

	if matchNeedRecharge <= hasCharge then
		TipsFacade.instance:openTipWindow(lang("tip"), langPara("进入匹配后，将随机匹配<color=#ff0000>全服</color>正在匹配的玩家，匹配成功后，无法取消或更换匹配玩家，是否确认进入匹配？"), function()
			UIStateManager.instance:push(ViewName.GroupRechargeMatchView)
		end, lang("confirm"))
	else
		local remain = matchNeedRecharge - hasCharge

		TipsFacade.instance:openTipWindow(lang("tip"), langPara("充值金额达到%s元后可进行匹配队友，当前还差%d元", matchNeedRecharge, remain), function()
			PayShopController.instance:openView(GameEnum.PayShopEasyJump.GodDiamond)
		end, "前往充值")
	end
end

return GroupRechargeTeamView
