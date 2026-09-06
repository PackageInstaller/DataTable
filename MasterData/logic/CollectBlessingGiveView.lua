-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectBlessingGiveView.lua

module("logic.extensions.birthdaywishes.view.CollectBlessingGiveView", package.seeall)

local CollectBlessingGiveView = class("CollectBlessingGiveView", ViewComponent)
local FilterType = {
	PAF = 5,
	FGF = 4,
	RYF = 3,
	JXF = 1,
	AllType = 0,
	SYF = 2
}

function CollectBlessingGiveView:ctor()
	CollectBlessingGiveView.super.ctor(self)
end

function CollectBlessingGiveView:unbindEvents()
	CollectBlessingGiveView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnBack)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnPublish)
	GameUtil.rmClickHandler(self._btnRepeal)
	self._dropdown:RemoveOnValueChanged()
end

function CollectBlessingGiveView:bindEvents()
	CollectBlessingGiveView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickSearch, self)
	GameUtil.addClickHandler(self._btnBack, self._onClickBack, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnPublish, self._onClickPublish, self)
	GameUtil.addClickHandler(self._btnRepeal, self._onClickRepeal, self)
	self._dropdown:AddOnValueChanged(self._onValueChanged, self)
end

function CollectBlessingGiveView:buildUI()
	CollectBlessingGiveView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnSearch = self:getBtn("btnSearch")
	self._btnBack = self:getBtn("btnBack")
	self._btnRecord = self:getBtn("btnHistory")
	self._btnPublish = self:getBtn("btnPublish")
	self._btnRepeal = self:getBtn("btnRepeal")
	self._inputSearch = self:getInput("inputSearch")
	self._dropdown = DropDownAdapter.Get(self:getGo("dropdown_filter"))
	self._emptyTips = self:getGo("emptyTips")
	self._txtCount = self:getTxt("txtCount")
	self._tableview = self:getGo("tableView")
	self._tablecell = self:getGo("tableCell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._cell2TimeLabel = {}
end

function CollectBlessingGiveView:onExit()
	CollectBlessingGiveView.super.onExit(self)
	self._scrollList:dispose()
	removetimer(self._tickWishList, self)
	GlobalDispatcher:removeListener(GlobalNotify.BuddyWishListInfoRes, self._checkBuddyWishListInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendInfoGeted, self._checkFriendInfo, self)

	self._cell2TimeLabel = {}
	self._buddyWishListInfoData = nil
	self._friendInfoData = nil
end

function CollectBlessingGiveView:onEnter()
	CollectBlessingGiveView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._cfgs = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId)

	self._inputSearch:SetText("")

	self._filterType = 0

	self._dropdown:ClearOptions()
	self._dropdown:AddOptions("所有类型")

	local wishListCfgs = BirthdayWishesConfig.instance:getBirthdayWishesListCfgs(self._cfgs.wishlistPlanId)

	for i, value in ipairs(wishListCfgs) do
		self._dropdown:AddOptions(value.wishListName)
	end

	self._dropdown:SetValue(0)

	self._enablePrints = {}
	self._userId = tostring(RoleModel.instance:getUserId())

	settimer(1, self._tickWishList, self)
	GlobalDispatcher:addListener(GlobalNotify.BuddyWishListInfoRes, self._checkBuddyWishListInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendInfoGeted, self._checkFriendInfo, self)
	BirthdayWishesController.instance:sendBirthdayWishesGetAllWishListReq(self._activityId)
	FriendAgent.instance:sendGetBuddyInfoReq()
	BirthdayWishesController.instance:markDailyRedPoint()
end

function CollectBlessingGiveView:_checkBuddyWishListInfo()
	self._buddyWishListInfoData = true

	self:_checkData()
end

function CollectBlessingGiveView:_checkFriendInfo()
	self._friendInfoData = true

	self:_checkData()
end

function CollectBlessingGiveView:_checkData()
	if self._buddyWishListInfoData and self._friendInfoData then
		self:_refreshView()
	end
end

function CollectBlessingGiveView:_refreshView()
	local dailyTimes = self._cfgs.dailyPutOutTimes - BirthdayWishesModel.instance:getDailyPutOutTimes()

	self._txtCount.text = string.format("每日发布次数：<color=#FFFF00FF>%s/%s</color>", math.max(0, dailyTimes), self._cfgs.dailyPutOutTimes)

	local maxWishType = self._filterType

	if self._filterType == FilterType.AllType then
		local wishListCfgs = BirthdayWishesConfig.instance:getBirthdayWishesListCfgs(self._cfgs.wishlistPlanId)
		local maxNum = 0

		for i, v in ipairs(wishListCfgs) do
			local matCfg = string.split(BirthdayWishesConfig.instance:getTokenCfgByTokenId(v.tokenId).reward, ":")
			local type, id = matCfg[1], matCfg[2]
			local haveNum = MaterialFacade.instance:getMatNumber(type, id)

			if maxNum < haveNum then
				maxNum = haveNum
				maxWishType = v.id
			end
		end
	end

	local buddyWishListInfos = BirthdayWishesModel.instance:getBuddyWishListInfos()
	local list = {}
	local myWish

	for i, v in ipairs(buddyWishListInfos) do
		if tostring(v.headInfo.userId) == self._userId then
			myWish = v
		elseif self._filterType == FilterType.AllType then
			table.insert(list, v)
		elseif v.wishListId == maxWishType then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		if a.wishListId == maxWishType ~= (b.wishListId == maxWishType) then
			return a.wishListId == maxWishType
		else
			local friendA, friendB = FriendModel.instance:getFriendMo(a.headInfo.userId), FriendModel.instance:getFriendMo(b.headInfo.userId)

			if friendA and friendB then
				local isOnlineA, isOnlineB = friendA:getIsOnline(), friendB:getIsOnline()

				if isOnlineA and isOnlineB then
					return a.headInfo.userId < b.headInfo.userId
				end

				if not isOnlineA and not isOnlineB then
					return checknumber(friendA:lastOpTime()) > checknumber(friendB:lastOpTime())
				end

				return isOnlineA
			end
		end

		return false
	end)

	if myWish and self._filterType == FilterType.AllType then
		table.insert(list, 1, myWish)
	end

	GameUtil.SetActive(self._emptyTips, #list == 0)
	self._scrollList:reloadData(list)
end

function CollectBlessingGiveView:_updateCell(view, goCell, data, tag)
	local index = goCell.data
	local cell = self:_clearCell(goCell)

	if self._cfgs then
		if not self._cfgs.wishlistPlanId then
			local wishlistPlanId = 0

			if data then
				if not data.wishListId then
					local wishListId = 0
					local wishesListCfg = BirthdayWishesConfig.instance:getBirthdayWishesListCfgsById(wishlistPlanId, wishListId)

					if wishesListCfg then
						if not wishesListCfg.tokenId then
							local tokenId = 0
							local tokenCfg = BirthdayWishesConfig.instance:getTokenCfgByTokenId(tokenId)
							local haveNum = 0

							if not self._enablePrints[1] and self._cfgs == nil then
								self._enablePrints[1] = true

								printError(string.format("index:%s -> self._cfgs is nil", index))
							end

							if not self._enablePrints[2] then
								local wishesListCfg = BirthdayWishesConfig.instance:getBirthdayWishesListCfgsById(wishlistPlanId, wishListId)

								if wishesListCfg == nil then
									self._enablePrints[2] = true

									printError(string.format("index:%s -> wishesListCfg is nil, wishlistPlanId:%s, wishListId:%s", index, wishlistPlanId, wishListId))
								end
							end

							if not self._enablePrints[3] then
								local tokenCfg = BirthdayWishesConfig.instance:getTokenCfgByTokenId(tokenId)

								if tokenCfg == nil then
									self._enablePrints[3] = true

									printError(string.format("index:%s -> tokenCfg is nil, wishlistPlanId:%s, wishListId:%s, tokenId:%s", index, wishlistPlanId, wishListId, tokenId))
								end
							end

							if tokenCfg and not string.nilorempty(tokenCfg.reward) then
								local type, id = MaterialMgr.getMatParams(tokenCfg.reward)

								haveNum = MaterialFacade.instance:getMatNumber(type, id)

								local matCfg = type .. ":" .. id

								MaterialMgr.setCellByCfg(matCfg, cell.imgBlessing)
								MaterialMgr.setCellByCfg(matCfg, cell.imgMyBlessing)
							else
								MaterialMgr.resetAll(cell.imgBlessing)
								MaterialMgr.resetAll(cell.imgMyBlessing)
							end

							cell.txtBlessingNum.text = "x" .. haveNum
							cell.txtName.text = data.headInfo.userName

							HeadItemController.instance:setHeadCellByInfo(cell.icon, data.headInfo)

							local isMe = tostring(data.headInfo.userId) == self._userId

							if isMe then
								cell.txtServer.text = RoleModel.instance:getAreaName()
								cell.txtOnline.text = "在线"

								GameUtil.setUITextColorIdx(cell.txtOnline, 1)
							else
								local friendMo = FriendModel.instance:getFriendMo(data.headInfo.userId)

								if not self._enablePrints[4] and friendMo == nil then
									self._enablePrints[4] = true

									printError(string.format("index:%s -> friendMo is nil, userId:%s", index, data.headInfo.userId))
								end

								if friendMo then
									if friendMo:getIsOnline() then
										cell.txtOnline.text = "在线"

										GameUtil.setUITextColorIdx(cell.txtOnline, 1)
									else
										cell.txtOnline.text = TimeUtil.getLeftTime(friendMo:lastOpTime(), true)

										GameUtil.setUITextColorIdx(cell.txtOnline, 0)
									end

									cell.txtServer.text = friendMo.areaName
								else
									cell.txtOnline.text = "离线"
									cell.txtServer.text = ""

									GameUtil.setUITextColorIdx(cell.txtOnline, 0)
								end
							end

							GameUtil.addClickHandler(cell.btnIcon, function()
								local userId = data.headInfo.userId

								if userId == RoleModel.instance:getUserId() then
									RoleController.instance:openMyInfoCard()
								else
									RoleController.instance:openCardByUserId(data.headInfo.userId)
								end
							end)
							GameUtil.SetActive(cell.btnGive, not isMe)
							GameUtil.SetActive(cell.txtTime, isMe)

							if isMe then
								GameUtil.SetActive(cell.btnGive, false)
								GameUtil.SetActive(cell.txtTime, true)

								self._cell2TimeLabel[cell.go] = {
									txt = cell.txtTime,
									timestamp = data.wishListExpireTime
								}
							else
								GameUtil.SetActive(cell.btnGive, true)
								GameUtil.SetActive(cell.txtTime, false)
							end

							GameUtil.addClickHandler(cell.btnGive, function()
								if haveNum <= 1 then
									TipsFacade.instance:openCommonTips("拥有2个及以上的心愿字，才能赠送哦")

									return
								end

								local function okFunc()
									local offsetTime = math.ceil((data.wishListExpireTime - ServerTime.nowMs()) / 1000)

									if offsetTime <= 0 then
										local dataTime = GameUtil.time2date(data.wishListExpireTime)
										local content = string.format("该心愿单已于%d月%d日 %02d:%02d:%02d过期，无法赠送！", dataTime.year, dataTime.month, dataTime.day, dataTime.hour, dataTime.min, dataTime.sec)

										TipsFacade.instance:openCommonTips(content)

										return
									end

									local targetUserId = data.headInfo.userId

									BirthdayWishesController.instance:sendBirthdayWishesFinishBuddyWishListReq(self._activityId, targetUserId)
									TipsFacade.instance:openCommonTips("赠送成功!")
									self._scrollList:refresh()
								end

								local fuName = BirthdayWishesConfig.instance:getBirthdayWishesListCfgsById(self._cfgs.wishlistPlanId, data.wishListId).wishListName
								local content = string.format("确定将【%s】赠予好友【%s】吗？\n持有【%s】数量：%s", fuName, data.headInfo.userName, fuName, haveNum)

								TipsFacade.instance:openPopupWindow("提示", content, okFunc, nil, "确定", "取消")
							end)
						end
					end
				end
			end
		end
	end
end

function CollectBlessingGiveView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.icon = goutil.findChild(cell.go, "ImgC_Icon")
	cell.btnIcon = goutil.findChild(cell.go, "btnIcon")
	cell.btnGive = goutil.findChild(cell.go, "btnGive")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtServer = goutil.findChildTextComponent(cell.go, "txtName/area/txt")
	cell.txtOnline = goutil.findChildTextComponent(cell.go, "txtOnline")
	cell.imgBlessing = goutil.findChild(cell.go, "imgBlessing")
	cell.imgMyBlessing = goutil.findChild(cell.go, "imgMyBlessing/icon")
	cell.txtBlessingNum = goutil.findChildTextComponent(cell.go, "imgMyBlessing/txtNum")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")

	GameUtil.SetActive(cell.btnGive, false)
	GameUtil.SetActive(cell.txtTime, false)
	HeadItemController.instance:resetHeadCell(cell.icon)
	MaterialMgr.resetAll(cell.imgBlessing)
	MaterialMgr.resetAll(cell.imgMyBlessing)

	self._cell2TimeLabel[cell.go] = nil

	return cell
end

function CollectBlessingGiveView:_tickWishList()
	local nowMs = ServerTime.nowMs()

	for k, v in pairs(self._cell2TimeLabel) do
		local timestamp = v.timestamp
		local d = timestamp - nowMs
		local content = ""

		if d > 0 then
			local hour, min, sec = GameUtil.getTimeHHMMSS(math.ceil(d / 1000))

			content = string.format("剩余时间：%02d:%02d:%02d", hour, min, sec)
		end

		v.txt.text = content
	end
end

function CollectBlessingGiveView:_onClickClose()
	self:close()
end

function CollectBlessingGiveView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "collectblessinggive_rule")
end

function CollectBlessingGiveView:_onClickSearch()
	local content = self._inputSearch:GetText()

	if content and #content > 0 then
		local buddyWishListInfo = BirthdayWishesModel.instance:getBuddyWishListInfoByNameOrId(content)
		local list = {}

		if buddyWishListInfo then
			table.insert(list, buddyWishListInfo)
		end

		self._scrollList:reloadData(list)
		self._scrollList:refresh()
		GameUtil.SetActive(self._emptyTips, not buddyWishListInfo)
	end
end

function CollectBlessingGiveView:_onClickBack()
	GameUtil.SetActive(self._emptyTips, false)
	self._inputSearch:SetText("")
	self:_refreshView()
end

function CollectBlessingGiveView:_onClickRecord()
	UIStateManager.instance:push(ViewName.CollectBlessingRecordView, self._activityId)
end

function CollectBlessingGiveView:_onValueChanged(value)
	self._filterType = value

	self:_refreshView()
end

function CollectBlessingGiveView:_onClickPublish()
	local canPublish = self._cfgs.dailyPutOutTimes - BirthdayWishesModel.instance:getDailyPutOutTimes() > 0
	local isPublish = BirthdayWishesModel.instance:getBuddyWishListInfoByNameOrId(self._userId)
	local isCD = BirthdayWishesController.instance:isWishListCD()
	local CD = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId).wishListCD

	if not canPublish then
		TipsFacade.instance:openCommonTips("今日已无剩余发布次数")
	elseif isPublish then
		TipsFacade.instance:openCommonTips("当前已有发布中的心愿单啦")
	elseif isCD then
		local wishListCD = BirthdayWishesModel.instance:getWishListCD()
		local offsetMs = wishListCD - ServerTime.nowMs()
		local hour, min, sec = GameUtil.getTimeHHMMSS(math.ceil(offsetMs / 1000))

		if min == 0 then
			FloatWordMgr.instance:show("需要上一次操作后的" .. sec .. "秒后才能继续操作心愿单。")
		else
			FloatWordMgr.instance:show("需要上一次操作后的" .. min .. "分钟后才能继续操作心愿单")
		end
	else
		UIStateManager.instance:push(ViewName.CollectBlessingPublishView, self._activityId)
	end
end

function CollectBlessingGiveView:_onClickRepeal()
	local CD = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId).wishListCD
	local isPublish = BirthdayWishesModel.instance:getBuddyWishListInfoByNameOrId(self._userId)

	if not isPublish then
		TipsFacade.instance:openCommonTips("当前没有发布中的心愿单")
	else
		local function okFunc()
			BirthdayWishesController.instance:sendBirthdayWishesRepealWishListReq(self._activityId)
			self._scrollList:refresh()
		end

		local content = string.format("确定要撤销该心愿单吗？撤销后需要%d分钟后才能继续操作心愿单。", CD)

		TipsFacade.instance:openPopupWindow("提示", content, okFunc, nil, "确定", "取消")
	end
end

return CollectBlessingGiveView
