-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodSelectView.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodSelectView", package.seeall)

local XiuNuoBrotherhoodSelectView = class("XiuNuoBrotherhoodSelectView", ViewComponent)

function XiuNuoBrotherhoodSelectView:ctor()
	self._gameViewName = ViewName.XiuNuoBrotherhoodGameView
end

function XiuNuoBrotherhoodSelectView:buildUI()
	XiuNuoBrotherhoodSelectView.super.buildUI(self)

	self._btnClose = GameUtil.asBtn(self:getGo("btnClose"))
	self._tabelView = self:getGo("tableview")
	self._tableCell = self:getGo("cell")
	self._goldBarCon = self:getGo("goldBarCon")
	self._scrollRect = goutil.findChildComponent(self.mainGO, "tableview", "ScrollRect")
end

function XiuNuoBrotherhoodSelectView:bindEvents()
	XiuNuoBrotherhoodSelectView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function XiuNuoBrotherhoodSelectView:unbindEvents()
	XiuNuoBrotherhoodSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function XiuNuoBrotherhoodSelectView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.XiuNuoBrotherhoodGetInfo, self._refreshView, self)

	self._scrollList = ScrollerList.create(self._tabelView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()
	self._cfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(self._activityId)

	XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodInfoReq(self._activityId, nil, self._cfg.gameId)
	XiuNuoBrotherhoodModel.instance:setDailyGameStart()
end

function XiuNuoBrotherhoodSelectView:onExit()
	XiuNuoBrotherhoodSelectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiuNuoBrotherhoodGetInfo, self._refreshView, self)
end

function XiuNuoBrotherhoodSelectView:_refreshView()
	self._passStageIds = XiuNuoBrotherhoodModel.instance:getPassStageIds()

	local cfgs = XiuNuoBrotherhoodConfig.instance:getStageCfgs(self._activityId)

	self._scrollList:reloadData(cfgs)
end

function XiuNuoBrotherhoodSelectView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnStart = goutil.findChildButtonComponent(go, "btnBegin")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local imgPreview = goutil.findChild(go, "item")
	local prizeConGo1 = goutil.findChild(go, "priezCon/prizeItemCon1")
	local prizeCon1 = goutil.findChild(go, "priezCon/prizeItemCon1/prizeItem")
	local prizeCon1Rev = goutil.findChild(go, "priezCon/prizeItemCon1/receive")
	local prizeConGo2 = goutil.findChild(go, "priezCon/prizeItemCon2")
	local prizeCon2 = goutil.findChild(go, "priezCon/prizeItemCon2/prizeItem")
	local prizeCon2Rev = goutil.findChild(go, "priezCon/prizeItemCon2/receive")
	local prizeConGo3 = goutil.findChild(go, "priezCon/prizeItemCon3")
	local prizeCon3 = goutil.findChild(go, "priezCon/prizeItemCon3/prizeItem")
	local prizeCon3Rev = goutil.findChild(go, "priezCon/prizeItemCon3/receive")
	local passGo = goutil.findChild(go, "pass")
	local lockGo = goutil.findChild(go, "lockTip")

	txtName.text = data.name

	if imgPreview then
		uGuiUtil.clearImage(imgPreview)
	end

	if not string.nilorempty(data.stagePreview) and imgPreview then
		uGuiUtil.setSpriteToImage(imgPreview, nil, GameUrl.getBigbgFolderUrl("xiunuobrotherhood", data.stagePreview))
	end

	GameUtil.SetActive(prizeConGo1, false)
	GameUtil.SetActive(prizeConGo2, false)
	GameUtil.SetActive(prizeConGo3, false)
	MaterialMgr.resetAll(prizeCon1)
	MaterialMgr.resetAll(prizeCon2)
	MaterialMgr.resetAll(prizeCon3)

	local prizeCfgs = string.split(data.prize, "#")

	if not string.nilorempty(prizeCfgs[1]) then
		MaterialMgr.setCellByCfg(prizeCfgs[1], prizeCon1)
		GameUtil.SetActive(prizeConGo1, true)
	end

	if not string.nilorempty(prizeCfgs[2]) then
		MaterialMgr.setCellByCfg(prizeCfgs[2], prizeCon2)
		GameUtil.SetActive(prizeConGo2, true)
	end

	if not string.nilorempty(prizeCfgs[3]) then
		MaterialMgr.setCellByCfg(prizeCfgs[3], prizeCon3)
		GameUtil.SetActive(prizeConGo3, true)
	end

	GameUtil.addClickHandler(btnStart, function()
		self:_onClickStart(data.stageId)
	end)

	local openLevel = XiuNuoBrotherhoodModel.instance:getMaxPassStage() + 1
	local pass = false

	if self._passStageIds then
		for i, v in ipairs(self._passStageIds) do
			if data.stageId == v then
				pass = true

				break
			end
		end
	end

	local isOpen = data.stageId == openLevel and XiuNuoBrotherhoodModel.instance:getStageOpen(data.stageId)

	GameUtil.SetActive(btnStart, not pass)
	GameUtil.SetActive(passGo, pass)
	GameUtil.SetActive(lockGo, not isOpen and not pass)
end

function XiuNuoBrotherhoodSelectView:_clearCell(cell)
	local go = cell.gameObject
	local btnStart = goutil.findChildButtonComponent(go, "btnBegin")
	local imgPreview = goutil.findChild(go, "item")
	local prizeCon1 = goutil.findChild(go, "priezCon/prizeItemCon1/prizeItem")
	local prizeCon2 = goutil.findChild(go, "priezCon/prizeItemCon2/prizeItem")
	local prizeCon3 = goutil.findChild(go, "priezCon/prizeItemCon3/prizeItem")

	if imgPreview then
		uGuiUtil.clearImage(imgPreview)
	end

	MaterialMgr.resetAll(prizeCon1)
	MaterialMgr.resetAll(prizeCon2)
	GameUtil.rmClickHandler(btnStart)
end

function XiuNuoBrotherhoodSelectView:_onClickClose()
	self:close()
end

function XiuNuoBrotherhoodSelectView:_onClickStart(stageId)
	local maxLevel = XiuNuoBrotherhoodModel.instance:getMaxPassStage()

	if stageId > maxLevel + 1 then
		FloatWordMgr.instance:show(lang("请通关前面的关卡"))
	elseif stageId == maxLevel + 1 then
		local isOpen = XiuNuoBrotherhoodModel.instance:getStageOpen(stageId)

		if isOpen == true then
			UIStateManager.instance:push(self._gameViewName, self._activityId, stageId, self._cfg.gameId)
		else
			local openTime = XiuNuoBrotherhoodModel.instance:getStageOpenTime(stageId)
			local date = GameUtil.time2date(openTime)

			FloatWordMgr.instance:show(langPara("该关卡暂未开放，开放时间为%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min))
		end
	elseif stageId <= maxLevel then
		FloatWordMgr.instance:show(lang("已通过"))
	end
end

function XiuNuoBrotherhoodSelectView:_setTopGoldBar()
	if not self._isSetGold then
		self._isSetGold = true

		local btn_list = {}

		for i, v in ipairs(self._cfg.showBar) do
			table.insert(btn_list, {
				showAdd = false,
				id = v
			})
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
	end
end

return XiuNuoBrotherhoodSelectView
