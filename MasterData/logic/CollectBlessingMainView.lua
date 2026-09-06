-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectBlessingMainView.lua

module("logic.extensions.collectblessing.view.CollectBlessingMainView", package.seeall)

local CollectBlessingMainView = class("CollectBlessingMainView", ViewComponent)

CollectBlessingMainView.StoryKey = "CollectBlessingMainView.StoryKey"

local GoToType = {
	Give = 2,
	Task = 1,
	Record = 3
}
local ReasonType = {
	Deficiency = 1,
	Exceed = 2
}
local EffectPath = {
	LotteryEffect = "20230120/xingshicifu/fx_ui_xscf_tubiaoliang.prefab",
	ViewEffect = "20230120/xingshicifu/fx_ui_xscf_fw.prefab"
}

function CollectBlessingMainView:ctor()
	CollectBlessingMainView.super.ctor(self)
end

function CollectBlessingMainView:unbindEvents()
	CollectBlessingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnToggle)

	for i, v in ipairs(self._gotoBtnList) do
		GameUtil.rmClickHandler(v)
	end
end

function CollectBlessingMainView:bindEvents()
	CollectBlessingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickToggle, self)

	for i, v in ipairs(self._gotoBtnList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickGoto, self, i))
	end
end

function CollectBlessingMainView:buildUI()
	CollectBlessingMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._bg = self:getGo("bg")
	self._btnLottery = self:getBtn("midContainer/receiveBtn")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnToggle = self:getGo("btnToggle")
	self._imgSelect = self:getGo("btnToggle/imgSelect")
	self._blessingList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("midContainer/blessing_" .. i)
		cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")

		table.insert(self._blessingList, cell)
	end

	self._gotoBtnList = {}

	for i = 1, 3 do
		table.insert(self._gotoBtnList, self:getGo("rightContainer/itemCell_" .. i))
	end

	self._tableview = self:getGo("leftContainer/tableView")
	self._tablecell = self:getGo("leftContainer/tableCell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rpLottery = self:getGo("midContainer/receiveBtn/redpoint")
	self._rpTask = self:getGo("rightContainer/itemCell_1/redpoint")
	self._rpDaily = self:getGo("rightContainer/itemCell_2/redpoint")
end

function CollectBlessingMainView:onExit()
	CollectBlessingMainView.super.onExit(self)
	self._scrollList:dispose()
	self._removeCellEff(self._bg)
	self._removeCellEff(self._btnLottery)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesInfo, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesOpenGift, self._gainPrize, self)
	RedPointController.instance:unregRedPoint(self._rpTask)
end

function CollectBlessingMainView:onEnter()
	CollectBlessingMainView.super.onEnter(self)

	self._isPlayingEff = false

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._isFirstPlayAnimKey = "CollectBlessingMainView_first" .. self._activityId
	self._playAnimKey = "CollectBlessingMainView" .. self._activityId
	self._cfgs = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId)

	self:_initView()
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesInfo, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesOpenGift, self._gainPrize, self)
	BirthdayWishesController.instance:csGetBirthdayWishesUserInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._rpTask, RedPointModel.ID_COLLECTBLESSING_TASK)
	self:_playStoryOnece()
end

function CollectBlessingMainView:_initView()
	if self._activityId then
		BirthdayWishesModel.instance:setActivityId(self._activityId)

		local actCfg = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId)
		local giftPlanCfg = BirthdayWishesConfig.instance:getBirthdayWishesPlanCfgs(actCfg.giftPlan)

		self._giftType = 0

		for i, v in pairs(giftPlanCfg) do
			if self._giftType < v.giftType then
				self._giftType = v.giftType
			end
		end

		BirthdayWishesModel.instance:setGiftType(self._giftType)
	else
		self:close()
	end

	self._txtTime.text = self._cfgs.timeShow

	GameUtil.SetActive(self._rpDaily, RedPointModel.instance:isActive(RedPointModel.ID_COLLECTBLESSING_DAILY_RED))
	self:_playCellEff(self._bg, EffectPath.ViewEffect, 0, 0, true, nil)

	local isDaySkipAnim = GameUtil.getUserData(self._playAnimKey)

	GameUtil.SetActive(self._imgSelect, isDaySkipAnim)
end

function CollectBlessingMainView:_refreshView()
	local isCanLottery = BirthdayWishesController.instance:isCanLottery()

	GameUtil.SetActive(self._rpLottery, isCanLottery)
	self:_refreshBlessingState()
	self:_refreshPrize()
end

function CollectBlessingMainView:_refreshBlessingState()
	local cost = BirthdayWishesConfig.instance:getBirthdayWishesPlanCfgsById(self._cfgs.giftPlan, self._giftType).cost
	local costList = string.split(cost, "#")

	for i, v in ipairs(self._blessingList) do
		local type, id, num = MaterialMgr.getMatParams(costList[i])

		v.txtDesc.text = BirthdayWishesConfig.instance:getBirthdayWishesListCfgsById(self._cfgs.wishlistPlanId, i).wishListName

		GameUtil.SetGray(v.go, not MaterialModel.instance:IsEnough(type, id, num))
	end

	local isCanLottery = BirthdayWishesController.instance:isCanLottery()

	GameUtil.SetGray(self._btnLottery, not isCanLottery)
end

function CollectBlessingMainView:_refreshPrize()
	local prizeList = BirthdayWishesConfig.instance:getBirthdayWishesLotteryPlanCfgs(self._giftType)

	self._scrollList:reloadData(prizeList)
end

function CollectBlessingMainView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellByCfg(data.reward, cell.icon)

	local info = BirthdayWishesModel.instance:getBirthdayWishesBaseInfo().giftInfos[self._giftType] or {}
	local content = ""
	local gifeNumInfos = BirthdayWishesModel.instance:getBirthdayWishesBaseInfo().gifeNumInfos

	if checknumber((gifeNumInfos and gifeNumInfos[self._giftType] or nil) and checknumber(gifeNumInfos[self._giftType][data.insertId])) == 0 and data.times > 0 and data.times > checknumber(info.openTime) then
		content = string.format("%s次后必得", data.times - checknumber(info.openTime))
	end

	if data.times > 0 then
		if string.nilorempty(content) then
			content = "已抽完"
		end
	else
		GameUtil.SetActive(cell.goLottery, false)
	end

	cell.txtLottery.text = content
end

function CollectBlessingMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.icon = goutil.findChild(goCell, "goodsPos")
	cell.txtLottery = goutil.findChildTextComponent(goCell, "lottery_1/txtLottery")
	cell.goLottery = goutil.findChild(goCell, "lottery_1")

	MaterialMgr.resetAll(cell.icon)
	GameUtil.SetActive(cell.goLottery, true)

	return cell
end

function CollectBlessingMainView:_gainPrize(changeSetId, prizeStrList)
	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function CollectBlessingMainView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function CollectBlessingMainView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function CollectBlessingMainView:_onClickClose()
	if self._isPlayingEff == false then
		self:close()
	end
end

function CollectBlessingMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "collectblessing_rule")
end

function CollectBlessingMainView:_onClickGoto(type)
	if type == GoToType.Task then
		UIStateManager.instance:push(ViewName.CollectBlessingTaskView, self._activityId)
	elseif type == GoToType.Give then
		UIStateManager.instance:push(ViewName.CollectBlessingGiveView, self._activityId)
	elseif type == GoToType.Record then
		UIStateManager.instance:push(ViewName.CollectBlessingRecordView, self._activityId)
	end
end

function CollectBlessingMainView:_onClickLottery()
	local isCanLottery, reason = BirthdayWishesController.instance:isCanLottery()

	if isCanLottery then
		if self._isPlayingEff == false then
			local firstPlayAnim = GameUtil.getUserData(self._isFirstPlayAnimKey)
			local isSkipAnim = GameUtil.getUserData(self._playAnimKey)

			if not firstPlayAnim or not isSkipAnim then
				local function callback()
					UIStateManager.instance:push(ViewName.CollectBlessingLionView, self._activityId)

					self._isPlayingEff = false
				end

				self._isPlayingEff = true

				self:_playCellEff(self._btnLottery, EffectPath.LotteryEffect, 0, 0, nil, callback)
				GameUtil.saveUserData(self._isFirstPlayAnimKey, true)
			else
				local giftType = BirthdayWishesModel.instance:getGiftType()

				BirthdayWishesController.instance:csGetBirthdayWishesGiftOpenReq(self._activityId, giftType)

				return
			end
		end
	else
		TipsFacade.instance:openCommonTips(reason == ReasonType.Deficiency and "未集满福噢！" or "超过最大抽奖次数！")
	end
end

function CollectBlessingMainView:_onClickToggle()
	local firstPlayAnim = GameUtil.getUserData(self._isFirstPlayAnimKey)

	if not firstPlayAnim then
		FloatWordMgr.instance:show("第一次播放后可跳过动画")

		return
	end

	local isSkipAnim = GameUtil.getUserData(self._playAnimKey)

	GameUtil.saveUserData(self._playAnimKey, not isSkipAnim)
	GameUtil.SetActive(self._imgSelect, not isSkipAnim)
end

function CollectBlessingMainView:_playStoryOnece()
	local key = CollectBlessingMainView.StoryKey .. self._activityId
	local isPlay = GameUtil.getUserData(key)

	if isPlay then
		return
	end

	GameUtil.saveUserData(key, true)

	local cfg = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId)

	if cfg and cfg.plotId ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, cfg.plotId)
	end
end

return CollectBlessingMainView
