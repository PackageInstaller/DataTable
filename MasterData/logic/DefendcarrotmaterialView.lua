-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendcarrotmaterialView.lua

module("logic.extensions.defendcarrot.view.DefendcarrotmaterialView", package.seeall)

local DefendcarrotmaterialView = class("DefendcarrotmaterialView", ViewComponent)

function DefendcarrotmaterialView:ctor()
	DefendcarrotmaterialView.super.ctor(self)
end

function DefendcarrotmaterialView:unbindEvents()
	DefendcarrotmaterialView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DefendcarrotmaterialView:bindEvents()
	DefendcarrotmaterialView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function DefendcarrotmaterialView:buildUI()
	DefendcarrotmaterialView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtLeft = self:getTxt("txtLeft")
	self._itemcell = self:getGo("itemcell")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goldBarCon = self:getGo("goldcon")
end

function DefendcarrotmaterialView:onExit()
	DefendcarrotmaterialView.super.onExit(self)
	self._scrollList:dispose()

	self._scrollMap = nil
end

function DefendcarrotmaterialView:onEnter()
	DefendcarrotmaterialView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = 517001
	end

	self._scrollMap = {}

	self.addGEvent(self, GlobalNotify.DefendCarrotGetInfo, self._refreshUI, self)
	DefendCarrotController.instance:getInfo(self._activityId)

	self._curActCfg = DefendCarrotConfig.instance:getActivityCfg(self._activityId) or {}

	local btn_list = {
		{
			showAdd = false,
			id = self._curActCfg.costItem
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
	self:_refreshUI()
	DefendCarrotController.instance:showCI()
end

function DefendcarrotmaterialView:_refreshUI()
	local info = DefendCarrotModel.instance:getBaseInfo(self._activityId) or {}

	if not info.weapons then
		self._materialStageId = checknumber(info.materialStageId)
		self._dailyMaterialTimes = checknumber(info.dailyMaterialTimes)

		if not info.materialStages then
			self._stageMap = {}

			for i, v in ipairs(info.materialStages) do
				self._stageMap[v.stageId] = v.maxWaveId
			end

			self._activityCfg = DefendCarrotConfig.instance:getActivityCfg(self._activityId) or {}

			local total = checknumber(self._activityCfg.dailyTimes)

			self._curTime = math.max(0, total - self._dailyMaterialTimes)
			self._txtLeft.text = langPara("今日剩余次数：%s/%s", self._curTime, total)
			self._maxLvl = 0

			local baseInfo = DefendCarrotModel.instance:getBaseInfo(self._activityId)

			if baseInfo and baseInfo.stages then
				if not #baseInfo.stages then
					local curMaxStageId = 0
					local weaponCfgs = DefendCarrotConfig.instance:getAllWeaponCfgs(self._activityId) or {}

					for _, data in ipairs(weaponCfgs) do
						local isLock = curMaxStageId < data.unlockStageId

						self._maxLvl = self._maxLvl + ((not isLock or nil) and DefendCarrotModel.instance:getWeaponLevel(self._activityId, data.weaponId))
					end

					local cfgList = DefendCarrotConfig.instance:getMaterialClgs(self._activityId) or {}

					self._scrollList:reloadData(cfgList)

					if self._materialStageId == 0 then
						self._scrollList:MoveCellToBegin(0)
					else
						self._scrollList:MoveCellToBegin(self._materialStageId - 1)
					end
				end
			end
		end
	end
end

function DefendcarrotmaterialView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtMaxCount = goutil.findChildTextComponent(cell, "txtMaxCount")
	local tableview = goutil.findChild(cell, "tableview")
	local lock = goutil.findChild(cell, "lock")
	local btnEnter = goutil.findChild(cell, "btnEnter")
	local scrollList = self._scrollMap[cell]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableview, self._itemcell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._scrollMap[cell] = scrollList
	end

	GameUtil.SetActive(lock, false)

	txtName.text = data.stagename

	local count = checknumber(self._stageMap[data.stageId])
	local list = DefendCarrotConfig.instance:getMaterialClgPrizeList(self._activityId, data.stageId) or {}
	local temp = {}

	for i, v in ipairs(list) do
		local matType, id, matNum = MaterialMgr.getMatParams(v.prize)
		local content = MaterialMgr.getContentMatCfg(matType, id, 28, -5, true)
		local next = list[i + 1]

		if next then
			table.insert(temp, langPara("击杀<color=#F4DAA0>%s-%s波</color>小怪，每波可获得%s %s", v.waveNum, next.waveNum - 1, matNum, content))
		else
			table.insert(temp, langPara("击杀<color=#F4DAA0>%s波</color>小怪以上，每波可获得%s %s", v.waveNum, matNum, content))
		end
	end

	scrollList:reloadData(temp)

	if data.stageId <= self._materialStageId + 1 then
		if data.weaponLevel > self._maxLvl then
			GameUtil.SetActive(lock, true)

			txtMaxCount.text = langPara("武器总等级%s/%s时解锁", self._maxLvl, data.weaponLevel)
		else
			txtMaxCount.text = langPara("历史最高波次:%s", count)
		end
	else
		txtMaxCount.text = "通关前置关卡解锁"

		GameUtil.SetActive(lock, true)
	end

	GameUtil.addClickHandler(btnEnter, GameUtil.handler(self._onClickCell, self, data))

	local iconPath = data.picRath
	local emojiImg = goutil.findChildComponent(cell, "emoji", goutil.Type_UIImage)

	uGuiUtil.setSpriteToImage(emojiImg.gameObject, uGuiUtil.SpriteType.BigBg, iconPath, function()
		emojiImg:SetNativeSize()

		emojiImg.raycastTarget = false
	end)
end

function DefendcarrotmaterialView:_updateItemCell(view, cell, data, tag)
	local txtDesc = MaterialMgr.findGraphicText(cell, "txtDesc")

	txtDesc.text = data
end

function DefendcarrotmaterialView:_clearItemCell(cell)
	return
end

function DefendcarrotmaterialView:_clearCell(cell)
	local scrollList = self._scrollMap[cell]

	if scrollList then
		scrollList:dispose()
	end

	local emojiGo = goutil.findChild(cell, "emoji")

	uGuiUtil.clearImage(emojiGo)
end

function DefendcarrotmaterialView:_onClickCell(data)
	if self._curTime <= 0 then
		TipsFacade.instance:openCommonTips("今日挑战次数已经用完，下次再来吧")

		return
	end

	if data.stageId <= self._materialStageId + 1 then
		if data.weaponLevel > self._maxLvl then
			TipsFacade.instance:openCommonTips(langPara("武器总等级达到%s后解锁", data.weaponLevel))
		else
			DefendCarrotController.instance:startMaterialGame(self._activityId, data.stageId)
		end
	else
		TipsFacade.instance:openCommonTips("通关前置关卡解锁")
	end
end

function DefendcarrotmaterialView:_onClickTips()
	TipsFacade.instance:openRulesView("defendcarrotmaterialview_rule")
end

return DefendcarrotmaterialView
