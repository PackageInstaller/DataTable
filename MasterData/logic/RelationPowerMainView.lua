-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/view/RelationPowerMainView.lua

module("logic.extensions.relationpower.view.RelationPowerMainView", package.seeall)

local RelationPowerMainView = class("RelationPowerMainView", ViewComponent)

function RelationPowerMainView:ctor()
	RelationPowerMainView.super.ctor(self)
end

function RelationPowerMainView:buildUI()
	RelationPowerMainView.super.buildUI(self)

	self._taskcell = self:getGo("taskcell")
	self._taskTab = self:getGo("tasktableview")
	self._taskTabView = ScrollerList.create(self._taskTab, self._taskcell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._petcell = self:getGo("from/cell")
	self._fromTab_1 = self:getGo("from/tableview_1")
	self._fromTab_2 = self:getGo("from/tableview_2")
	self._fromTabView_1 = ScrollerList.create(self._fromTab_1, self._petcell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._fromTabView_2 = ScrollerList.create(self._fromTab_2, self._petcell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._txtTime = self:getGo("time/txt"):GetComponent("Text")
	self._txtTeamB = self:getTxt("txtTeamB")
	self._txtTeamA = self:getTxt("txtTeamA")
end

function RelationPowerMainView:onEnter()
	RelationPowerMainView.super.onEnter(self)

	self._curActId = checkint(self:getFirstParam())

	if self._curActId and not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.RelationPower, self._curActId) then
		FloatWordMgr.instance:show("活动时间结束")
		self:close()

		return
	end

	self:_initActivityTime()

	self._formCfgs = RelationPowerConfig.instance:getFormCfgsByActId(self._curActId)
	self._taskCfgs = RelationPowerConfig.instance:getTaskCfgs(self._curActId)

	self:_updateView()
	GlobalDispatcher:addListener(GlobalNotify.RelationPowerGetInfo, self._updateTaskView, self)
	GlobalDispatcher:addListener(GlobalNotify.RelationPowerGainPrize, self._updateTaskView, self)
	RelationPowerController.instance:getInfo(self._curActId)
end

function RelationPowerMainView:onExit()
	RelationPowerMainView.super.onExit(self)
	self._taskTabView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.RelationPowerGetInfo, self._updateTaskView, self)
	GlobalDispatcher:removeListener(GlobalNotify.RelationPowerGainPrize, self._updateTaskView, self)

	for i, btn in ipairs(self._btnVerifyList) do
		GameUtil.rmClickHandler(btn)
		goutil.setActive(btn, false)
	end
end

function RelationPowerMainView:bindEvents()
	RelationPowerMainView.super.bindEvents(self)
end

function RelationPowerMainView:unbindEvents()
	RelationPowerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnVerify_1)
	GameUtil.rmClickHandler(self._btnVerify_2)
	GameUtil.rmClickHandler(self._btnVerify_3)
end

function RelationPowerMainView:_updateTaskCell(view, cellGo, data)
	local cell = self:_clearTaskCell(cellGo)

	if data then
		GameUtil.SetGray(cell.btnGain, not RelationPowerModel.instance:getTaskIsFinish(data.taskId))
		goutil.setActive(cell.btnGain, not RelationPowerModel.instance:getPrizeIsGain(data.taskId))
		goutil.setActive(cell.markGain, RelationPowerModel.instance:getPrizeIsGain(data.taskId))
		MaterialMgr.setCellListByCfg(data.prize, cell.prizeCom)

		cell.txtTitle.text = data.task

		GameUtil.addClickHandler(cell.btnGain, GameUtil.handler(self._onClickGainPrize, self, data.taskId))
	end
end

function RelationPowerMainView:_clearTaskCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnGain = goutil.findChild(cell.go, "btnGain")
	cell.markGain = goutil.findChild(cell.go, "markGain")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")

	GameUtil.rmClickHandler(cell.btnGain)

	cell.prizeCom = goutil.findChild(cell.go, "prizeCom")

	MaterialMgr.resetAll(cell.prizeCom)

	return cell
end

function RelationPowerMainView:_updateView()
	self:_updateTaskView()
	self:_updateBtnVerifyList()
	self._fromTabView_1:reloadData(self._formCfgs[1].raceIds)
	self._fromTabView_2:reloadData(self._formCfgs[2].raceIds)

	self._txtTeamA.text = self._formCfgs[1].teamName
	self._txtTeamB.text = self._formCfgs[2].teamName
end

function RelationPowerMainView:_updateBtnVerifyList()
	self._btnVerifyList = {}

	for i, data in ipairs(self._taskCfgs) do
		if data.type == "verify" then
			if #self._btnVerifyList < 3 then
				local idx = #self._btnVerifyList + 1
				local btnVerify = self:getGo("btnVerifyList/btnVerify_" .. idx)

				goutil.setActive(btnVerify, true)
				GameUtil.addClickHandler(btnVerify, GameUtil.handler(self._onClickVerify, self, data.taskParam), self)
				table.insert(self._btnVerifyList, btnVerify)
			else
				FloatWordMgr.instance:show("最多显示3个验证战力阵容，请修改配置或在预制中添加按钮。")

				break
			end
		end
	end
end

function RelationPowerMainView:_updateTaskView()
	self._taskTabView:reloadData(self._taskCfgs)
end

function RelationPowerMainView:_onClickGainPrize(taskId)
	if RelationPowerModel.instance:getTaskIsFinish(taskId) and not RelationPowerModel.instance:getPrizeIsGain(taskId) then
		RelationPowerController.instance:gainPrize(self._curActId, taskId)
	end
end

function RelationPowerMainView:_onClickVerify(formId)
	local customFmtMo = RelationPowerModel.instance:getFmtCustomFmtMo(formId)

	customFmtMo:updateCfg(self._curActId, formId)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function RelationPowerMainView:_updatePetCell(view, cellGo, data)
	local cell = self:_clearPetCell(cellGo)

	if data then
		local modelCo = CharacterConfig.instance:getModelCo(data)

		uGuiUtil.setSpriteToImage(cell.petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

		local isGain = HandbookModel.instance:isHasPet(data)

		GameUtil.SetGray(cell.petIcon, not isGain)
		goutil.setActive(cell.gainMark, not isGain)
		goutil.setActive(cell.mask, not isGain)
		GameUtil.addClickHandler(cell.btn, function()
			MaterialMgr.openGetSource(MatType.Pet, data)
		end, self)
	end
end

function RelationPowerMainView:_clearPetCell(cellGo)
	local btn = goutil.findChild(cellGo, "btn")

	GameUtil.rmClickHandler(btn)

	local cell = {}

	cell.go = cellGo
	cell.petIcon = goutil.findChild(cell.go, "pet/petIcon")

	uGuiUtil.clearImage(cell.petIcon)

	cell.gainMark = goutil.findChild(cell.go, "gainMark")
	cell.mask = goutil.findChild(cell.go, "pet/mask")
	cell.btn = btn

	return cell
end

function RelationPowerMainView:_initActivityTime()
	local startTimeStemp, endTimeStemp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.RelationPower, self._curActId)
	local startTime = GameUtil.time2date(startTimeStemp)
	local endTime = GameUtil.time2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

return RelationPowerMainView
