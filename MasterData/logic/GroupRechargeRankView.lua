-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GroupRechargeRankView.lua

module("logic.extensions.grouprecharge.view.GroupRechargeRankView", package.seeall)

local GroupRechargeRankView = class("GroupRechargeRankView", TableViewComponent)

function GroupRechargeRankView:_getPath()
	return {
		cellPath = "detailContainer/cell",
		viewPath = "detailContainer/tableview"
	}
end

function GroupRechargeRankView:_cellSize(view, index)
	return 1052, 100
end

function GroupRechargeRankView:ctor()
	GroupRechargeRankView.super.ctor(self)

	self._avatars = {}
	self._avatarTops = {}
	self._avatar2Handler = {}
end

function GroupRechargeRankView:unbindEvents()
	GroupRechargeRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnDetail)
end

function GroupRechargeRankView:bindEvents()
	GroupRechargeRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickDetail, self)
end

function GroupRechargeRankView:buildUI()
	GroupRechargeRankView.super.buildUI(self)

	self._goRole = self:getGo("topContainer/modsFrame")
	self._photoEff = AvatarPhotoShow.Get(goutil.findChild(self._goRole, "con"))

	self._photoEff:setRawWidthAndHeight(1280, 720)
	self._photoEff:setCameraPosition(-0.3, 0, -2)
	self._photoEff:setCamSize(3)
	self._photoEff:setRTAdjust(1, 1, 1, 0.007)

	self._topContainer = self:getGo("topContainer")
	self._detailContainer = self:getGo("detailContainer")
	self._roleTop = self:getGo("topContainer/roleTop")
	self._btnDetail = self:getBtn("topContainer/btnDetail")
	self._txtTip = self:getTxt("detailContainer/myRank/txtTip")
	self._empty = self:getGo("detailContainer/empty")
	self._titleChangeComp = self:getGo("detailContainer/title"):GetComponent("TestRecordPos")
	self._txtMyRank = self:getTxt("detailContainer/myRank/txtMyRank")
	self._txtMyRankTitle = self:getTxt("detailContainer/myRank/txtMyRankTitle")
	self._imgSloganGo = self:getGo("topContainer/bg/imgSlogan")
	self._totalBg = self:getGo("topContainer/totalBg")
	self._txtTotalChargeNum = self:getTxt("topContainer/txtTotalChargeNum")
	self._topRoleContainer = self:getGo("topContainer/container")
	self._poses = {}

	for i = 1, 6 do
		local posGo = self:getGo(string.format("topContainer/Pos/p%d", i))

		table.insert(self._poses, GameUtil.getPos(posGo))
	end

	goutil.setActive(self._roleTop, false)
	goutil.setActive(self._empty, false)
end

function GroupRechargeRankView:onExit()
	GroupRechargeRankView.super.onExit(self)

	local controller = GroupRechargeController.instance

	controller:unregisterLocalNotify(GroupRechargeController.E_PersonalRankRes, self._onCommonRankUpdated, self)
	controller:unregisterLocalNotify(GroupRechargeController.E_TeamRankRes, self._onCommonRankUpdated, self)
	controller:unregisterLocalNotify(GroupRechargeController.E_FirstTeamInfoRes, self._onTopRankUpdated, self)
	self._photoEff:clear()
end

function GroupRechargeRankView:onEnter()
	GroupRechargeRankView.super.onEnter(self)

	local controller = GroupRechargeController.instance

	controller:registerLocalNotify(GroupRechargeController.E_PersonalRankRes, self._onCommonRankUpdated, self)
	controller:registerLocalNotify(GroupRechargeController.E_TeamRankRes, self._onCommonRankUpdated, self)
	controller:registerLocalNotify(GroupRechargeController.E_FirstTeamInfoRes, self._onTopRankUpdated, self)

	local params = self:getOpenParam() or {}

	self._tabConf = params[1]
	self._rankType = checknumber(params[2])

	if self._rankType <= 0 then
		FloatWordMgr.instance:show(lang("参数错误"))
		self:close()

		return
	end

	self:_setTab(false)

	self._txtTip.text = self._tabConf.desc

	if self._rankType == GroupRechargeConfig.Personal then
		self._txtMyRankTitle.text = lang("我的排名")

		goutil.setActive(self._imgSloganGo, false)
	else
		self._txtMyRankTitle.text = lang("我的团队排名")

		goutil.setActive(self._imgSloganGo, true)
	end
end

function GroupRechargeRankView:_setTab(bCommon)
	self._bCommon = bCommon

	goutil.setActive(self._topContainer, not bCommon)
	goutil.setActive(self._detailContainer, bCommon)
	self:updateListData({})
	goutil.setActive(self._empty, true)
	GameUtil.SetActive(self._txtTotalChargeNum, false)
	self:_destroyAvatars()
	self:_reqRankData()
end

function GroupRechargeRankView:_reqRankData()
	if self._bCommon then
		self:updateListData({})
		goutil.setActive(self._empty, true)
	end

	if self._rankType == GroupRechargeConfig.Personal then
		if self._bCommon then
			self._titleChangeComp:LoadPlan(0)
		end

		GroupRechargeAgent.instance:sendPM_GroupRechargePersonalRankReq()
	elseif self._bCommon then
		self._titleChangeComp:LoadPlan(1)
		GroupRechargeAgent.instance:sendPM_GroupRechargeTeamRankReq()
	else
		GroupRechargeAgent.instance:sendPM_GroupRechargeFirstTeamInfoReq()
	end
end

function GroupRechargeRankView:_onCommonRankUpdated(status, msg)
	goutil.setActive(self._empty, true)

	if status == 0 then
		local rankInfos = {}

		for i, rankInfo in ipairs(msg.rankInfo) do
			table.insert(rankInfos, {
				rank = i,
				data = rankInfo
			})
		end

		if self._bCommon then
			goutil.setActive(self._empty, #msg.rankInfo <= 0)
			self:updateListData(rankInfos)
			self:_updateMyRank(msg.myRank)
		else
			local teamMember = {}

			if not msg.rankInfo then
				local rankInfos = {}

				for i = 1, 6 do
					local rankInfo = rankInfos[i]

					if rankInfo then
						rankInfo = rankInfo.playerDisplayer

						table.insert(teamMember, {
							rechangeNum = rankInfo.rechangeNum,
							headInfo = rankInfo.headInfo,
							gender = rankInfo.gender,
							clothes = rankInfo.clothes
						})
					end
				end

				local msgT = {
					teamMember = teamMember
				}

				self:_onTopRankUpdated(0, msgT)
			end
		end
	end
end

function GroupRechargeRankView:_onTopRankUpdated(status, msg)
	self:_destroyAvatars()

	if not msg.teamMember then
		local rankInfoList = {}

		if self._rankType == GroupRechargeConfig.Personal then
			GameUtil.SetActive(self._txtTotalChargeNum, false)
			GameUtil.SetActive(self._totalBg, false)
		elseif not rankInfoList or #rankInfoList == 0 then
			GameUtil.SetActive(self._txtTotalChargeNum, false)
			GameUtil.SetActive(self._totalBg, false)
		else
			GameUtil.SetActive(self._totalBg, true)
			GameUtil.SetActive(self._txtTotalChargeNum, true)

			self._txtTotalChargeNum.text = tostring(msg.totalRecharge) or "0"
		end

		if #rankInfoList == 0 then
			self:_onClickDetail()

			return
		end

		for i = 1, 6 do
			self:_updateOneTopRole(rankInfoList[i], i)
		end
	end
end

function GroupRechargeRankView:_updateMyRank(myRank)
	myRank = checknumber(myRank)
	self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")
end

function GroupRechargeRankView:_updateOneTopRole(rankInfo, index)
	local topGo = goutil.cloneAndSetParent(self._roleTop, self._topRoleContainer.transform)

	goutil.setActive(topGo, true)

	self._avatarTops[index] = topGo

	local txtChargeNum = goutil.findChildTextComponent(topGo, "txtChargeNum")
	local txtOrder = goutil.findChildTextComponent(topGo, "txtOrder")
	local txtName = goutil.findChildTextComponent(topGo, "txtName")
	local empty = goutil.findChild(topGo, "empty")

	txtOrder.text = tostring(index)

	local pos = self._poses[index]

	GameUtil.setPos(topGo, pos.x, pos.y, pos.z)
	goutil.setActive(empty, rankInfo == nil)
	GameUtil.SetActive(txtName, rankInfo ~= nil)

	if rankInfo then
		if rankInfo.gender ~= nil and rankInfo.clothes ~= nil then
			local mo = rankInfo.gender == GameEnum.Gender.Female and AvatarConfig.instance:getAvatarMoByCfgId(1) or AvatarConfig.instance:getAvatarMoByCfgId(2)

			mo:dressSuit(rankInfo.clothes)

			local avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)

			local function handler(_, avatarT)
				self:_onAvatarLoaded(avatarT, rankInfo, index)
			end

			self._avatar2Handler[avatar] = handler

			avatar:addListener(AvatarNotify.OnSetParentFinish, handler, self)
			self._photoEff:addShowAvatarEffect(avatar)
		end

		txtChargeNum.text = langPara("充值金额：%s", tostring(rankInfo.rechangeNum))
		txtName.text = rankInfo.headInfo.userName
	else
		txtChargeNum.text = lang("虚位以待")
	end
end

function GroupRechargeRankView:_destroyAvatars()
	if self._avatars then
		for i, avatar in ipairs(self._avatars) do
			AvatarsMgrNew.instance:removeAvatar(avatar)

			local handler = self._avatar2Handler[avatar]

			avatar:removeListener(AvatarNotify.OnSetParentFinish, handler, self)
		end

		self._avatars = {}
		self._avatar2Handler = {}
	end

	if self._avatarTops then
		for i, go in ipairs(self._avatarTops) do
			goutil.destroy(go)
		end

		self._avatarTops = {}
	end
end

local AvatarPos = {
	{
		z = 0,
		x = 0.41,
		y = -0.94
	},
	{
		z = 0,
		x = 3.51,
		y = -1.61
	},
	{
		z = 0,
		x = -2.53,
		y = -1.61
	},
	{
		z = 0,
		x = 2.1,
		y = -2.29
	},
	{
		z = 0,
		x = -1.29,
		y = -2.29
	},
	{
		z = 0,
		x = 0.35,
		y = -2.96
	}
}

function GroupRechargeRankView:_onAvatarLoaded(avatar, rankInfo, index)
	local pos = AvatarPos[index]
	local avatarGo = avatar:getGameObject()

	if avatarGo and pos then
		GameUtil.setLocalPos(avatarGo, pos.x, pos.y, pos.z)
	end
end

function GroupRechargeRankView:_updateCell(view, cell, data)
	local cellChangeComp = cell:GetComponent("TestRecordPos")
	local imgRank = goutil.findChildComponent(cell, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgIcon = goutil.findChild(cell, "head")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtMemberNum = goutil.findChildTextComponent(cell, "txtMemberNum")
	local txtCharge = goutil.findChildTextComponent(cell, "txtCharge")
	local rank = data.rank
	local rankInfo = data.data

	if self._rankType == GroupRechargeConfig.Personal then
		rankInfo = data.data.playerDisplayer

		cellChangeComp:LoadPlan(0)
	else
		rankInfo = data.data

		cellChangeComp:LoadPlan(1)
	end

	txtName.text = rankInfo.headInfo.userName

	local isTop3 = rank <= 3

	goutil.setActive(imgRank.gameObject, isTop3)
	goutil.setActive(txtRank.gameObject, not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtRank.text = tostring(rank)
	txtCharge.text = self._rankType == GroupRechargeConfig.Personal and (tostring(rankInfo.rechangeNum) or "0") or tostring(rankInfo.recharge) or "0"
	txtMemberNum.text = tostring(rankInfo.memberNum)

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if rankInfo.headInfo.userId then
				FriendController.instance:showInfoView(rankInfo.headInfo.userId, imgIcon)
			end
		end)
	end
end

function GroupRechargeRankView:_clearTableview(cell)
	local imgIcon = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

function GroupRechargeRankView:_onClickDetail()
	self:_setTab(true)
end

return GroupRechargeRankView
