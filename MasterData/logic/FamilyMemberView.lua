-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyMemberView.lua

module("logic.extensions.family.view.FamilyMemberView", package.seeall)

local FamilyMemberView = class("FamilyMemberView", TableViewComponent)

function FamilyMemberView:ctor()
	FamilyMemberView.super.ctor(self)
end

function FamilyMemberView:unbindEvents()
	FamilyMemberView.super.unbindEvents(self)
	self._exitBtn:RemoveClickListener()
	self._expelBtn:RemoveClickListener()
end

function FamilyMemberView:bindEvents()
	FamilyMemberView.super.bindEvents(self)
	self._exitBtn:AddClickListener(self._onClickExitBtn, self)
	self._expelBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilyMemberExpel)
	end, self)
end

function FamilyMemberView:onExit()
	FamilyMemberView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KickUserOut, self._updataFamilyMemberSR, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChangeFamilyRole, self._updataFamilyMemberSR, self)
end

function FamilyMemberView:buildUI()
	FamilyMemberView.super.buildUI(self)

	local titleInfoGo = self:getGo("titleInfoGo")

	self._capacityTxt = goutil.findChildTextComponent(titleInfoGo, "capacityTxt")
	self._onlineTxt = goutil.findChildTextComponent(titleInfoGo, "onlineTxt")
	self._exitBtn = self:getBtn("exitBtn")
	self._exitTxt = self:getTxt("exitBtn/exitTxt")
	self._expelBtn = self:getBtn("expelBtn")

	GameUtil.SetActive(self._exitBtn, false)
	GameUtil.SetActive(self._expelBtn, false)
end

function FamilyMemberView:onEnter()
	FamilyMemberView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.KickUserOut, self._updataFamilyMemberSR, self)
	GlobalDispatcher:addListener(GlobalNotify.ChangeFamilyRole, self._updataFamilyMemberSR, self)

	self._curViewDatas = {}

	FamilyController.instance:getFamilyMemberListReq(self._updataFamilyMemberSR, self)
end

function FamilyMemberView:_updataFamilyMemberSR()
	local familyInfo = FamilyModel.instance:getMyFamilyInfo()

	self._curViewDatas = {}

	local members = FamilyModel.instance:getMembers()

	for _, v in pairs(members or {}) do
		if v and v.simpleInfo then
			table.insert(self._curViewDatas, v)
		end
	end

	table.sort(self._curViewDatas, FamilyMemberView.sortMembers)
	self:reloadData()

	local level, curVal, needVal = FamilyConfig.instance:getCurLvProgress(familyInfo.score)
	local lvCfg = FamilyConfig.instance:getLvCfgByLv(level)

	self._capacityTxt.text = langPara("text_family_desc_19", #self._curViewDatas, (lvCfg or nil) and (lvCfg.maxAllMemberCount or 0))

	local onlineCount = 0

	for _, v in ipairs(self._curViewDatas) do
		if checknumber(v.lastOnlineTime) < 0 then
			onlineCount = onlineCount + 1
		end
	end

	self._onlineTxt.text = langPara("text_family_desc_20", onlineCount)

	local myRole = FamilyModel.instance:getMyRole()

	if #self._curViewDatas == 1 then
		GameUtil.SetActive(self._exitBtn, true)

		self._exitTxt.text = lang("text_family_desc_21")
	elseif myRole ~= GameEnum.FamilyMemberType.ChiefMain then
		GameUtil.SetActive(self._exitBtn, true)

		self._exitTxt.text = lang("text_family_desc_22")
	else
		GameUtil.SetActive(self._exitBtn, false)
	end

	local isAuthority = FamilyConfig.instance:isHasAuthority("KICK_MEMBER", myRole)

	if not isAuthority or #self._curViewDatas <= 1 then
		GameUtil.SetActive(self._expelBtn, false)

		return
	end

	for i = 1, #self._curViewDatas do
		if self._curViewDatas[i] and myRole < self._curViewDatas[i].role then
			GameUtil.SetActive(self._expelBtn, true)

			return
		end
	end

	GameUtil.SetActive(self._expelBtn, false)
end

function FamilyMemberView.sortMembers(a, b)
	if a.role ~= b.role then
		return a.role < b.role
	end

	local lastOnlineTimeA = checknumber(a.lastOnlineTime)
	local lastOnlineTimeB = checknumber(b.lastOnlineTime)
	local isOnlineA = lastOnlineTimeA < 0
	local isOnlineB = lastOnlineTimeB < 0

	if isOnlineA ~= isOnlineB then
		return isOnlineA
	elseif isOnlineA then
		if a.maxZdl ~= b.maxZdl then
			return checknumber(a.maxZdl) > checknumber(b.maxZdl)
		else
			return checknumber(a.joinDate) < checknumber(b.joinDate)
		end
	else
		return lastOnlineTimeB < lastOnlineTimeA
	end
end

function FamilyMemberView:_getPath()
	return {
		cellPath = "userItem",
		viewPath = "userListSR"
	}
end

function FamilyMemberView:_updateCell(view, cell, data)
	local myImaGo = goutil.findChild(cell, "myImaGo")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local positionGoIcc = goutil.findChildComponent(cell, "positionGo", "UIImageColorChange")
	local positionTxt = goutil.findChildTextComponent(cell, "positionGo/positionTxt")
	local totalTxt = goutil.findChildTextComponent(cell, "totalTxt")
	local todayTxt = goutil.findChildTextComponent(cell, "todayTxt")
	local onlineTxt = goutil.findChildTextComponent(cell, "onlineTxt")
	local levelTxt = goutil.findChildTextComponent(cell, "levelTxt")

	GameUtil.asBtn(cell):RemoveClickListener()
	MaterialMgr.resetAll(headGo)

	local isMy = checknumber(data.simpleInfo.userId) == checknumber(LoginModel.instance.userId)

	goutil.setActive(myImaGo, isMy)

	local simpleInfo = data.simpleInfo

	HeadItemController.instance:setHeadCellByInfo(headGo, simpleInfo)

	nameTxt.text = simpleInfo.userName
	powerTxt.text = data.maxZdl
	todayTxt.text = data.todayConstruction
	totalTxt.text = data.totoalConstruction

	positionGoIcc:SetState(data.role)

	positionTxt.text = lang("tip_family_position_" .. data.role)
	onlineTxt.text = checknumber(data.lastOnlineTime) < 0 and "<color=#3BB647>在线</color>" or TimeUtil.getLeftTime(data.lastOnlineTime)
	levelTxt.text = simpleInfo.playerLv .. "级"

	GameUtil.asBtn(cell):AddClickListener(function()
		if isMy then
			RoleController.instance:openCardByUserId(checknumber(data.simpleInfo.userId))
		else
			UIStateManager.instance:open(ViewName.FamilyMemberInfo, data)
		end
	end, self)
end

function FamilyMemberView:_clearTableview(cell)
	local headGo = goutil.findChild(cell, "headGo")

	HeadItemController.instance:resetHeadCell(headGo)
	GameUtil.asBtn(cell):RemoveClickListener()
end

function FamilyMemberView:_onClickExitBtn(isDismiss)
	local myRole = FamilyModel.instance:getMyRole()

	if #self._curViewDatas > 1 and myRole == GameEnum.FamilyMemberType.ChiefMain then
		return
	end

	local familyInfo = FamilyModel.instance:getMyFamilyInfo()
	local settingInfo = FamilyModel.instance:getMyFamilySettingInfo()
	local joinDate = GameUtil.time2date(checknumber(familyInfo.joinDate) / 1000)
	local lastTime = ServerTime.now() - checknumber(familyInfo.joinDate) / 1000
	local days = math.max(1, math.ceil(lastTime / 24 / 3600))
	local iconTips = TipsFacade.instance:getContentMatStr(string.format("%s:%s", MatType.Coin, 5), 50, -10, true)
	local textTips = langPara("text_family_desc_27", joinDate.year, joinDate.month, joinDate.day, settingInfo.familyName, days, iconTips, familyInfo.totalContribution, familyInfo.contributeFamilyScore)
	local isDismiss = #self._curViewDatas == 1

	if isDismiss then
		textTips = langPara("text_family_desc_26", textTips)
	end

	TipsFacade.instance:openPopupWindow(lang("text_family_desc_25"), textTips, function()
		if isDismiss then
			FamilyController.instance:dismissFamily()
		else
			FamilyController.instance:leaveFamilyReq(function()
				UIStateManager.instance:clear(true)
			end, self)
		end
	end, nil, lang("text_family_desc_23"), lang("text_family_desc_24"))
end

return FamilyMemberView
