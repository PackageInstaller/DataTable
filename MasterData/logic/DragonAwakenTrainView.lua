-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenTrainView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenTrainView", package.seeall)

local DragonAwakenTrainView = class("DragonAwakenTrainView", ViewComponent)

function DragonAwakenTrainView:ctor()
	DragonAwakenTrainView.super.ctor(self)
end

function DragonAwakenTrainView:unbindEvents()
	DragonAwakenTrainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DragonAwakenTrainView:bindEvents()
	DragonAwakenTrainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DragonAwakenTrainView:buildUI()
	DragonAwakenTrainView.super.buildUI(self)

	self._roleCon = self:getGo("roleCon")

	local cellGo = self:getGo("tablecell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("time/txtTime")
end

function DragonAwakenTrainView:onExit()
	DragonAwakenTrainView.super.onExit(self)
	self._tableview:dispose()

	if self._url then
		removeresl(self._url, self._onResloadFinish, self)

		self._url = nil
	end

	if self._res then
		self._res:Release()

		self._res = nil
	end
end

function DragonAwakenTrainView:onEnter()
	DragonAwakenTrainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._trainCfgs = DragonAwakenConfig.instance:getTrainingCfgs(self._activityId)
	self._actCfg = DragonAwakenConfig.instance:getActivityCfg(self._activityId)

	self:_updateByInfo()
	self.addGEvent(self, GlobalNotify.DragonAwakenUpdateTrainInfo, self._updateByInfo, self)

	self._url = GameUrl.getSpineUIUrl("20020_maomao")

	getres(self._url, self._onResloadFinish, self, ResType.AssetBundle, true)

	if DragonAwakenController.instance:getIsNeedPupResultView() then
		local result = DragonAwakenModel.instance:getLastTrainResult()

		if result then
			UIStateManager.instance:push(ViewName.DragonAwakenTipsView, result)
		end

		DragonAwakenController.instance:resetNeedPupResultView()
	end
end

function DragonAwakenTrainView:_updateByInfo()
	self._timeNow = ServerTime.now()

	local baseInfo = DragonAwakenModel.instance:getBaseInfoByActId(self._activityId)

	self._saveHard = DragonAwakenModel.instance:getCurTrainingHard(self._activityId)
	self._leftTime = self._actCfg.dailyTrainingTimes - baseInfo.todayTrainingTimes
	self._txtTime.text = string.format("今日剩余次数：%s/%s", self._leftTime, self._actCfg.dailyTrainingTimes)

	self._tableview:reloadData(self._trainCfgs)
end

function DragonAwakenTrainView:_onResloadFinish(res)
	local resPath = self._url

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._res = res

		self._res:Retain()

		local prefab = self._res:GetMainAsset()

		if prefab then
			self._bigImg = goutil.clone(prefab)

			goutil.clearChildren(self._roleCon)
			goutil.addChildToParent(self._bigImg, self._roleCon)
			GameUtil.setAnchoredPos(self._bigImg, 0, 0)
			GameUtil.setLocalScale(self._bigImg, 1, 1, 1)
			RoleObjectPool.instance:playAnimation(self._bigImg, "talk_idle", true)
		end
	end
end

function DragonAwakenTrainView:_updateCell(view, cell, data)
	local mask = goutil.findChild(cell.gameObject, "mask")
	local timeTips = goutil.findChild(cell.gameObject, "timeTips")
	local txtTimeTips = goutil.findChildTextComponent(cell.gameObject, "timeTips/txtTimeTips")
	local btn = goutil.findChild(cell.gameObject, "btn")
	local bgSpriteChange = goutil.findChildComponent(cell.gameObject, "bg", "UIImageSpriteChange")
	local spriteColorChange = goutil.findChildComponent(cell.gameObject, "mask", "UIImageColorChange")
	local txtColorChange = goutil.findChildComponent(cell.gameObject, "mask/txt", "UITextColorChange")
	local prizeCom = goutil.findChild(cell.gameObject, "prizeCom")
	local prizeItem = goutil.findChild(cell.gameObject, "prizeItem")
	local tableview = ScrollerList.create(prizeCom, prizeItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	if not data.prize then
		local prize = ""
		local itemList = string.split(prize, "#")

		tableview:reloadData(itemList)
		tableview:MoveCellToBegin(0)
		goutil.setActive(mask, false)

		for i = 1, 3 do
			local txtDesc = goutil.findChild(cell.gameObject, "desc/hard_" .. i)

			goutil.setActive(txtDesc, data.hard == i)
		end

		if self._saveHard ~= 0 and self._saveHard ~= data.hard then
			goutil.setActive(mask, true)
		end

		local isTimeMatch = self._timeNow >= GameUtil.string2time(data.openTime)

		if isTimeMatch then
			goutil.setActive(timeTips, false)
		else
			local openDate = GameUtil.string2date(data.openTime)

			goutil.setActive(timeTips, true)

			txtTimeTips.text = string.format("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour)
		end

		bgSpriteChange:SetState(data.hard - 1)
		spriteColorChange:SetState(data.hard - 1)
		txtColorChange:SetState(data.hard - 1)
		GameUtil.rmClickHandler(btn)
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnTrain, self, data))
	end
end

function DragonAwakenTrainView:_clearCell(cell)
	local prizeCom = goutil.findChild(cell.gameObject, "prizeCom")
	local prizeItem = goutil.findChild(cell.gameObject, "prizeItem")
	local tableview = ScrollerList.create(prizeCom, prizeItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	tableview:dispose()

	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function DragonAwakenTrainView:_updateItemCell(view, cell, data)
	local proxy = MaterialMgr.setCellByCfg(data, cell.gameObject)

	if proxy then
		proxy.binder:setEffStatus(false)
	end
end

function DragonAwakenTrainView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DragonAwakenTrainView:_onClickBtnTrain(data)
	if self._leftTime <= 0 then
		TipsFacade.instance:openCommonTips(lang("今日已无训练次数"))

		return
	end

	local isTimeMatch = self._timeNow >= GameUtil.string2time(data.openTime)

	if not isTimeMatch then
		TipsFacade.instance:openCommonTips(lang("暂未开启哦~"))

		return
	end

	local isExistTrain = self._saveHard ~= 0 and self._saveHard ~= data.hard

	if isExistTrain then
		TipsFacade.instance:openCommonTips(lang("正在挑战其他难度"))

		return
	end

	DragonAwakenController.instance:openTrainMissionView(self._activityId, data.hard)
end

return DragonAwakenTrainView
