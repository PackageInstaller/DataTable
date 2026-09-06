-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackGrabView.lua

module("logic.extensions.groupredpack.view.GroupRedpackGrabView", package.seeall)

local GroupRedpackGrabView = class("GroupRedpackGrabView", ViewComponent)
local RedpackType = {
	Expire = 5,
	GetCoin = 4,
	GetRedpack = 3,
	Remain = 1,
	Empty = 2
}
local EffectPath = {
	RemainEffect = "20230303/hongbao/fx_ui_hongbao_kelingqu.prefab"
}

function GroupRedpackGrabView:ctor()
	GroupRedpackGrabView.super.ctor(self)
end

function GroupRedpackGrabView:unbindEvents()
	GroupRedpackGrabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSend)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnTips)
end

function GroupRedpackGrabView:bindEvents()
	GroupRedpackGrabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSend, self._onClickSend, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
end

function GroupRedpackGrabView:buildUI()
	GroupRedpackGrabView.super.buildUI(self)

	self._btnSend = self:getBtn("container/btnSend")
	self._btnRecord = self:getBtn("container/btnRecord")
	self._btnClose = self:getBtn("container/leftTop/btnClose")
	self._btnTips = self:getBtn("container/btnHelp")
	self._txtTips = self:getTxt("container/txtTips")
	self._txtTime = self:getTxt("container/timeTips/txt")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtBubble = self:getTxt("tip/txtDesc")
	self._petCon = self:getGo("petCard/pet/petIcon")
	self._redpackCountList = {}

	for i = 1, 3 do
		local cell = self:getTxt("container/mid/redPackCountInfo/redpack_" .. i)

		table.insert(self._redpackCountList, cell)
	end

	self._tableview = self:getGo("container/mid/tableview")
	self._tablecell = self:getGo("container/mid/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollRect = self._tableview:GetComponent(ComponentType.ScrollRect)
end

function GroupRedpackGrabView:onExit()
	GroupRedpackGrabView.super.onExit(self)
	self._scrollList:dispose()
	removetimer(self._tickSpine, self)

	if self._advertisementTween then
		self._advertisementTween:Kill(false)

		self._advertisementTween = nil
	end

	uGuiUtil.clearImage(self._petCon)
	MaterialMgr.resetAll(self._txtName)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackGetInfoRes, self._refreshView, self)
end

function GroupRedpackGrabView:onEnter()
	GroupRedpackGrabView.super.onEnter(self)
	self:_initView()

	self._cfgs = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId)
	self._curIndex = 1

	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackGetInfoRes, self._refreshView, self)
	GroupRedpackController.instance:sendGroupRedPackGetInfoReq(self._activityId)
	settimer(5, self._tickSpine, self)
end

function GroupRedpackGrabView:_initView()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.GROUP_RED_PACK)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GROUP_RED_PACK, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtTime then
		self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	local cfgs = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId)
	local popularValue = cfgs.gainParam

	self._txtTips.text = string.format("累计人气值达到<color=#6DFC9DFF>%s</color>后可领取", popularValue)
end

function GroupRedpackGrabView:_refreshView()
	local isDailyGainLimits = {}
	local countList = GroupRedpackModel.instance:getCountList()

	for i, v in ipairs(self._redpackCountList) do
		local redpackCfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, i)
		local name = redpackCfg.name
		local dailyGainLimit = redpackCfg.dailyGainLimit
		local leftGainTime = math.max(0, dailyGainLimit - countList[i].todayGainTimes)

		v.text = string.format("%s:<color=#76fca4>%s</color>/%s", name, leftGainTime, dailyGainLimit)
		isDailyGainLimits[i] = leftGainTime <= 0
	end

	self._groupId = GroupRedpackModel.instance:getGroupId()

	if self._groupId == -1 then
		TipsFacade.instance:openPopupWindow(lang("tip"), "您还没有加入女神团，加入之后才能开启本活动哦！", function()
			GotoMgr.gotoByString("event#Goddess_Contest_Open_Event#251001")
		end, nil, "前往加入")
		self:close()

		return
	end

	self:_playPetSpine()

	local redpackList = GroupRedpackModel.instance:getRedpackList()
	local needSortRedpackList = {}
	local dailyGainLimitList = {}

	for i, v in ipairs(redpackList) do
		if isDailyGainLimits[v.type] then
			table.insert(dailyGainLimitList, v)
		else
			table.insert(needSortRedpackList, v)
		end
	end

	table.sort(needSortRedpackList, function(a, b)
		local isOpenA, isOpenB = a.state == 1, b.state == 1
		local isExpireA, isExpireB = GroupRedpackController.instance:isExpire(a), GroupRedpackController.instance:isExpire(b)
		local isRemainA, isRemainB = a.remainCount > 0, b.remainCount > 0

		if isExpireA ~= isExpireB then
			return not isExpireA
		elseif not isExpireA and not isExpireB then
			if isOpenA ~= isOpenB then
				return not isOpenA
			elseif not isOpenA and not isOpenB then
				if isRemainA ~= isRemainB then
					return isRemainA
				elseif checknumber(a.type) == checknumber(b.type) then
					return a.timestamp > b.timestamp
				else
					return checknumber(a.type) > checknumber(b.type)
				end
			else
				return a.timestamp > b.timestamp
			end
		else
			return a.timestamp > b.timestamp
		end
	end)
	table.insertto(needSortRedpackList, dailyGainLimitList)
	self._scrollList:reloadData(needSortRedpackList)
end

function GroupRedpackGrabView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)

	HeadItemController.instance:setHeadCellByInfo(cell.headCon, data.headInfo)

	cell.txtName.text = string.format("%s-%s", data.areaId, data.headInfo.userName)

	local redpackCfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, data.type)
	local type, id, num = MaterialMgr.getMatParams(redpackCfg.sendItem)

	cell.txtNum.text = num

	local redpackType = self:_getRedpackType(data)
	local isOpen = false
	local content = ""

	if redpackType == RedpackType.Remain then
		self:_playCellEff(cell.effectCon, EffectPath.RemainEffect, 0, 0, true, nil)

		content = string.format("剩余%s个", data.remainCount)
	elseif redpackType == RedpackType.Empty then
		content = "已抢完"
	elseif redpackType == RedpackType.GetRedpack then
		isOpen = true
		content = "成功领取"
	else
		content = redpackType == RedpackType.GetCoin and "已领完" or "已过期"
	end

	cell.txtCount.text = content

	GameUtil.SetGray(cell.redpack, redpackType == RedpackType.Expire)

	if isOpen then
		if not cell.goddessHeadConOpen then
			local petCon = cell.goddessHeadConClose
			local proxy = MaterialMgr.setIcon(petCon, MatType.PET_SKIN, data.coverId)

			if proxy then
				proxy.binder:setAutoTips(false)
			end

			GameUtil.SetActive(cell.goOpen, isOpen)
			GameUtil.SetActive(cell.goClose, not isOpen)

			local imgPath = string.split(redpackCfg.imgPath, "#")
			local closeImg, openImg = imgPath[1], imgPath[2]

			uGuiUtil.setSpriteToImage(cell.redpack, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(isOpen and openImg or closeImg))
			GameUtil.addClickHandler(cell.redpack, GameUtil.handler(self._onClickRedpack, self, data, redpackType))
		end
	end
end

function GroupRedpackGrabView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.goOpen = goutil.findChild(cell.go, "container/open")
	cell.goddessHeadConOpen = goutil.findChild(cell.go, "container/open/goddessHeadGo/headIcon")
	cell.goClose = goutil.findChild(cell.go, "container/close")
	cell.goddessHeadConClose = goutil.findChild(cell.go, "container/close/goddessHeadGo/headIcon")
	cell.headCon = goutil.findChild(cell.go, "container/headGo")
	cell.txtName = goutil.findChildTextComponent(cell.go, "container/name/txtName")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "container/get/txtGet")
	cell.txtCount = goutil.findChildTextComponent(cell.go, "container/count/txtCount")
	cell.redpack = goutil.findChild(cell.go, "container/redPack")
	cell.effectCon = goutil.findChild(cell.go, "container/redPack/effectCon")

	MaterialMgr.clearIcon(cell.goddessHeadConOpen)
	MaterialMgr.clearIcon(cell.goddessHeadConClose)
	HeadItemController.instance:resetHeadCell(cell.headCon)
	uGuiUtil.clearImage(cell.redpack)
	GameUtil.rmClickHandler(cell.redPack)
	self:_removeCellEff(cell.effectCon)

	return cell
end

function GroupRedpackGrabView:_getRedpackType(data)
	local isExpire = GroupRedpackController.instance:isExpire(data)

	if isExpire then
		return RedpackType.Expire
	elseif data.state == 0 then
		return (data.remainCount > 0 or nil) and (RedpackType.Remain or RedpackType.Empty)
	elseif data.state == 1 then
		return RedpackType.GetRedpack
	else
		return RedpackType.GetCoin
	end
end

function GroupRedpackGrabView:_playPetSpine()
	local bubbleNum = GroupRedpackConfig.instance:getGroupRedpackBubbleNum()
	local cfgs = GroupRedpackConfig.instance:getGroupRedpackCoverCfgsById(self._cfgs.coverPlanId, self._groupId)
	local petIds = string.split(cfgs.coverIds, ";")
	local petId = checknumber(petIds[self._curIndex])
	local petCo = CharacterConfig.instance:getModelCo(petId)

	uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(petCo.cardName))

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petId)
	self._txtBubble.text = GroupRedpackConfig.instance:getGroupRedpackBubbleCfgs(math.random(1, bubbleNum)).des
end

function GroupRedpackGrabView:_tickSpine()
	self._curIndex = self._curIndex + 1

	local len = GroupRedpackConfig.instance:getGroupRedpackPetLen(self._cfgs.coverPlanId, self._groupId)

	if len < self._curIndex then
		self._curIndex = 1
	end

	local image = self._petCon:GetComponent("Image")
	local sequence = DG.Tweening.DOTween.Sequence()
	local twenner = image:DOFade(0, 0.5):SetEase(DG.Tweening.Ease.InQuart)

	local function startHandler()
		self:_playPetSpine()
		Game.ImageUtil.SetImageAlpha(image, 0)
	end

	local twenner2 = image:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.InQuart):OnStart(startHandler)

	sequence:Append(twenner)
	sequence:Append(twenner2)

	self._advertisementTween = sequence
end

function GroupRedpackGrabView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setScrollRectClipping(self._scrollRect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function GroupRedpackGrabView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function GroupRedpackGrabView:_onClickClose()
	self:close()
end

function GroupRedpackGrabView:_onClickSend()
	UIStateManager.instance:push(ViewName.GroupRedpackSendView, self._activityId)
end

function GroupRedpackGrabView:_onClickRecord()
	UIStateManager.instance:push(ViewName.GroupRedpackRecordView, self._activityId)
end

function GroupRedpackGrabView:_onClickRedpack(data, redpackType)
	if redpackType == RedpackType.Remain then
		local popularValue = GroupRedpackModel.instance:getPopularValue()
		local grabLimitValue = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId).gainParam

		if checknumber(popularValue) < checknumber(grabLimitValue) then
			TipsFacade.instance:openCommonTips(string.format("累计为女神增加的人气值达到%s后可领取红包", grabLimitValue))

			return
		end

		local dailyLimit = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, data.type).dailyGainLimit
		local countList = GroupRedpackModel.instance:getCountList()
		local todayGainTimes = countList[data.type].todayGainTimes
		local isLimit = dailyLimit <= todayGainTimes

		if isLimit then
			TipsFacade.instance:openCommonTips("当日领取该类型红包已达上限")

			return
		end

		UIStateManager.instance:push(ViewName.GroupRedpackPopupView, data)
	elseif redpackType == RedpackType.Empty then
		TipsFacade.instance:openCommonTips("该红包已抢完")
	elseif redpackType == RedpackType.GetRedpack or redpackType == RedpackType.GetCoin then
		TipsFacade.instance:openCommonTips("该红包已抢完！")
	else
		TipsFacade.instance:openCommonTips("本红包已过期，无法领取")
	end
end

function GroupRedpackGrabView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, "groupredpack_rule")
end

return GroupRedpackGrabView
