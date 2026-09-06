-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontraildeveloptaskView.lua

module("logic.extensions.dragontrial.view.DragontraildeveloptaskView", package.seeall)

local DragontraildeveloptaskView = class("DragontraildeveloptaskView", TableViewComponent)

function DragontraildeveloptaskView:ctor()
	DragontraildeveloptaskView.super.ctor(self)
end

function DragontraildeveloptaskView:unbindEvents()
	DragontraildeveloptaskView.super.unbindEvents(self)
	self._btnCheck:RemoveClickListener()
end

function DragontraildeveloptaskView:bindEvents()
	DragontraildeveloptaskView.super.bindEvents(self)
	self._btnCheck:AddClickListener(self._onClickbtnCheck, self)
end

function DragontraildeveloptaskView:buildUI()
	DragontraildeveloptaskView.super.buildUI(self)

	self._tabCfgs = DragontrialConfig.instance:getDevelopTaskTabCfgs()
	self._scrollList = {}
	self._btnCheck = self:getBtn("btnCheck")

	self:_buildTabBtns()
end

function DragontraildeveloptaskView:_buildTabBtns()
	self._btnGo = self:getGo("btns/btn")
	self._btnsGo = self:getGo("btns")

	goutil.setActive(self._btnGo, false)

	self._btnCells = {}

	for i = 1, #self._tabCfgs do
		local cell = goutil.cloneAndSetParent(self._btnGo, self._btnsGo.transform)

		goutil.setActive(cell, true)

		local goRedpoint = goutil.findChild(cell.gameObject, "redpoint")
		local goSelect = goutil.findChild(cell.gameObject, "select")
		local goBg = goutil.findChild(cell.gameObject, "bg")
		local imgChangeIcon = goutil.findChild(cell.gameObject, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		local txtName = goutil.findChildTextComponent(cell.gameObject, "txt")
		local btn = Framework.ButtonAdapter.Get(cell)

		self._btnCells[i] = {
			goRedpoint = goRedpoint,
			goSelect = goSelect,
			imgChangeIcon = imgChangeIcon,
			txtName = txtName,
			btn = btn,
			goBg = goBg
		}
	end
end

function DragontraildeveloptaskView:onExit()
	DragontraildeveloptaskView.super.onExit(self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialGainCultivateTaskPrizeRes, self._PM_DragonTrialGainCultivateTaskPrizeRes, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialValidatePetStrengthenRes, self._PM_DragonTrialValidatePetStrengthenRes, self)
end

function DragontraildeveloptaskView:onEnter()
	DragontraildeveloptaskView.super.onEnter(self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialValidatePetStrengthenRes, self._PM_DragonTrialValidatePetStrengthenRes, self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialGainCultivateTaskPrizeRes, self._PM_DragonTrialGainCultivateTaskPrizeRes, self)

	self._activityId = DragontrialModel.instance:getCurrActivityId()

	self:_setTabData()

	self._currTabId = self._currTabId or self._tabCfgs[1].raceId

	self:_switchTab(self._currTabId, true)
end

function DragontraildeveloptaskView:_setTabData()
	local cfgs = self._tabCfgs

	for i, v in ipairs(cfgs) do
		local btnCell = self._btnCells[i]

		btnCell.txtName.text = v.tabName

		btnCell.imgChangeIcon:ChangeSprite(v.icon)

		local isRed = DragontrialModel.instance:checkDevelopTaskRedPointByRaceId(v.raceId)

		goutil.setActive(btnCell.goRedpoint, isRed)
		btnCell.btn:AddClickListener(function()
			self:_switchTab(v.raceId)
		end)
	end
end

function DragontraildeveloptaskView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DragontraildeveloptaskView:_updateCell(view, cell, data)
	local btnGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGoto")
	local btnReceive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReceive")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local goReceive = goutil.findChild(cell.gameObject, "receive")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goNoPass = goutil.findChild(cell.gameObject, "noPass")
	local isGain = DragontrialModel.instance:isGainDreamTaskPrize(data.raceId, data.taskId)
	local isCanGain = DragontrialModel.instance:checkCanGainDevelopPrizeByTaskId(data.raceId, data.taskId)

	self._scrollList[goItemcon] = self._scrollList[goItemcon] or ItemGroup.New(goItemcon, goItem, nil, nil, true)

	local rewards = string.split(data.prize, "#")

	self._scrollList[goItemcon]:updateWithMoArray(rewards, self._updateRewardCell, self)

	txtDesc.text = data.desc
	txtName.text = data.name

	goutil.setActive(goReceive, isGain)
	goutil.setActive(goNoPass, not isGain and not isCanGain)

	local showJump = not isGain and not isCanGain and not string.nilorempty(data.jumpTo)

	goutil.setActive(btnGoto.gameObject, showJump)
	btnGoto:AddClickListener(function()
		if string.find(data.jumpTo, "func#471") then
			GlobalDispatcher:dispatch(DragontrialController.ForceSelectMainViewTab, DragontrialmainView.TabEnum.Battle)
		else
			GotoMgr.gotoByString(data.jumpTo)
		end
	end)
	goutil.setActive(btnReceive.gameObject, not isGain and isCanGain)
	btnReceive:AddClickListener(function()
		DragontrialController.instance:sendPM_DragonTrialGainCultivateTaskPrizeReq(self._activityId, data.raceId, data.taskId)
	end)
end

function DragontraildeveloptaskView:_clearTableview(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")

	if self._scrollList[goItemcon] then
		self._scrollList[goItemcon]:dispose(function(item)
			self:_clearRewardCell(item)
		end)
	end
end

function DragontraildeveloptaskView:_updateRewardCell(item, cfgStr)
	MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
end

function DragontraildeveloptaskView:_clearRewardCell(item)
	MaterialMgr.resetAll(item.mainGO)
end

function DragontraildeveloptaskView:_switchTab(tabId, force)
	if self._currTabId == tabId and not force then
		return
	end

	local cfg = DragontrialConfig.instance:getDevelopTaskTabCfg(tabId)

	if not string.nilorempty(cfg.openTime) then
		local time = GameUtil.string2time(cfg.openTime)

		if time > ServerTime.nowServerLook() then
			FloatWordMgr.instance:show(cfg.lockTip)

			return
		end
	end

	self._currTabId = tabId

	self:_setSelectTab()
	self:_updateView()
end

function DragontraildeveloptaskView:_setSelectTab()
	local cfgs = self._tabCfgs

	for i, v in ipairs(cfgs) do
		local btnCell = self._btnCells[i]

		goutil.setActive(btnCell.goSelect, v.raceId == self._currTabId)
		goutil.setActive(btnCell.goBg, v.raceId ~= self._currTabId)
	end
end

function DragontraildeveloptaskView:_updateView()
	self:_formatCurViewDatas()
	self:reloadData()
end

function DragontraildeveloptaskView:_PM_DragonTrialGainCultivateTaskPrizeRes(status)
	if status == 0 then
		self:_setTabData()
		self:_updateView()
	end
end

function DragontraildeveloptaskView:_formatCurViewDatas()
	local list = DragontrialModel.instance:getDevelopTaskCfgsByRaceId(self._activityId, self._currTabId)
	local isGainList = {}
	local canGainList = {}
	local norList = {}

	for i, v in ipairs(list) do
		local isGain = DragontrialModel.instance:isGainDreamTaskPrize(v.raceId, v.taskId)

		if isGain then
			table.insert(isGainList, v)
		else
			local isCanGain = DragontrialModel.instance:checkCanGainDevelopPrizeByTaskId(v.raceId, v.taskId)

			if isCanGain then
				table.insert(canGainList, v)
			else
				table.insert(norList, v)
			end
		end
	end

	table.insertto(canGainList, norList)
	table.insertto(canGainList, isGainList)

	self._curViewDatas = canGainList
end

function DragontraildeveloptaskView:_onClickbtnCheck()
	if self._currTabId then
		PetSelectController.instance:OpenView(true, "选择一只精灵验证", function(pet)
			return pet:isExist() and pet.raceId == self._currTabId
		end, function(id)
			if id and id > 0 then
				DragontrialController.instance:sendPM_DragonTrialValidatePetStrengthenReq(self._activityId, id)
			end
		end)
	end
end

function DragontraildeveloptaskView:_PM_DragonTrialValidatePetStrengthenRes(status)
	if status == 0 then
		self:_setTabData()
		self:_updateView()
	end
end

return DragontraildeveloptaskView
