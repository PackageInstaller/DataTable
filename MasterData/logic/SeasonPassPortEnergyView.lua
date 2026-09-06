-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortEnergyView.lua

module("logic.extensions.season.view.SeasonPassPortEnergyView", package.seeall)

local SeasonPassPortEnergyView = class("SeasonPassPortEnergyView", ViewComponent)

function SeasonPassPortEnergyView:ctor()
	SeasonPassPortEnergyView.super.ctor(self)

	self._nowSelectTab = 1
	self._bgChangeTime = 0
	self._changeTime = 6
end

function SeasonPassPortEnergyView:bindEvents()
	SeasonPassPortEnergyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnAchievement, self._onClickAchievement, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function SeasonPassPortEnergyView:unbindEvents()
	SeasonPassPortEnergyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnAchievement)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function SeasonPassPortEnergyView:buildUI()
	SeasonPassPortEnergyView.super.buildUI(self)

	self._effect = self:getGo("effect")
	self._pet = self:getGo("pet")
	self._role = self:getGo("role")
	self._btnTask = self:getBtn("btnTask")
	self._btnAchievement = self:getBtn("btnAchievement")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._goTaskRP = self:getGo("btnTask/imgredpoint")
	self._goAchievementRP = self:getGo("btnAchievement/imgredpoint")
	self._changeTabTask = self._btnTask.gameObject:GetComponent(typeof(UIChangeGroup))
	self._changeTabAchievement = self._btnAchievement.gameObject:GetComponent(typeof(UIChangeGroup))
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	goutil.setActive(self._goTaskRP, false)
	goutil.setActive(self._goAchievementRP, false)
end

function SeasonPassPortEnergyView:onExit()
	SeasonPassPortEnergyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonPassPortEnergyUpdate, self._refreshView, self)
	removetimer(self.updateTimer, self)
	self._tableView:dispose()

	self._model = nil

	self:_setViewEffect(false)
	self:_unLoadBigBg(self._pet)
	self:_unLoadRole()
end

function SeasonPassPortEnergyView:onEnter()
	SeasonPassPortEnergyView.super.onEnter(self)

	self._model = SeasonPassPortModel.instance

	GlobalDispatcher:addListener(GlobalNotify.SeasonPassPortEnergyUpdate, self._refreshView, self)
	settimer(1, self.updateTimer, self)

	self._viewData = self._model:GetSeasonPassPortEnergyViewData()

	if self._viewData then
		self:_refreshView(self._viewData)
	end
end

function SeasonPassPortEnergyView:_refreshView(data)
	if not data then
		return
	end

	self._viewData = data

	local showTaskRP = false

	for _, v in pairs(data.dailyTaskData) do
		if v.isFinish and not v.gainPrize then
			showTaskRP = true

			break
		end
	end

	local showAchievementRP = false

	for _, v in pairs(data.allTimeTaskData) do
		if v.isFinish and not v.gainPrize then
			showAchievementRP = true

			break
		end
	end

	goutil.setActive(self._goTaskRP, showTaskRP)
	goutil.setActive(self._goAchievementRP, showAchievementRP)
	self:_selectTabByIndex(self._nowSelectTab)

	if self._viewData.baseCfg.textureNameB == self._viewData.baseCfg.textureNameA then
		self:_changeShowTab(2)
	else
		self:_changeShowTab(1)
	end
end

function SeasonPassPortEnergyView:_selectTabByIndex(index)
	self._nowSelectTab = index

	self._changeTabTask:SetState(index == 1 and 1 or 0)
	self._changeTabAchievement:SetState(index == 2 and 1 or 0)

	if index == 1 then
		self._tableView:reloadData(self._viewData.dailyTaskData)
	else
		self._tableView:reloadData(self._viewData.allTimeTaskData)
	end
end

function SeasonPassPortEnergyView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local goodsItem = MaterialMgr.setCellByCfg(data.reward, cell.item)

	goutil.setActive(cell.goBtnRecieve, not data.gainPrize and data.isFinish)
	goutil.setActive(cell.goBtnGoto, not data.gainPrize and not data.isFinish)
	GameUtil.addClickHandler(cell.btnRecieve, GameUtil.handler(self._onClickRecieve, self, data))
	GameUtil.addClickHandler(cell.btnGoto, GameUtil.handler(self._onClickGoto, self, data))
	goutil.setActive(cell.goProgressTxt, not data.gainPrize)
	goutil.setActive(cell.goReceive, data.gainPrize)

	cell.titleTxt.text = data.config.taskTitle
	cell.descTxt.text = data.config.taskDesc
	cell.progressTxt.text = data.value > data.config.maxProgress and data.config.maxProgress .. "/" .. data.config.maxProgress or data.value .. "/" .. data.config.maxProgress
end

function SeasonPassPortEnergyView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "cellPoint")

	MaterialMgr.resetAll(cell.item)
	self:_removeCellEff(cell.item)

	cell.goBtnRecieve = goutil.findChild(cell.go, "btnRecieve")
	cell.goBtnGoto = goutil.findChild(cell.go, "btnGoto")
	cell.btnRecieve = goutil.findChildButtonComponent(cell.go, "btnRecieve")
	cell.btnGoto = goutil.findChildButtonComponent(cell.go, "btnGoto")

	GameUtil.rmClickHandler(cell.btnRecieve)
	GameUtil.rmClickHandler(cell.btnGoto)

	cell.goReceive = goutil.findChild(cell.go, "receive")
	cell.titleTxt = goutil.findChildTextComponent(cell.go, "titleTxt")
	cell.descTxt = goutil.findChildTextComponent(cell.go, "descTxt")
	cell.goProgressTxt = goutil.findChild(cell.go, "progressTxt")
	cell.progressTxt = goutil.findChildTextComponent(cell.go, "progressTxt")

	goutil.setActive(cell.goReceive, false)

	return cell
end

function SeasonPassPortEnergyView:updateTimer()
	if self._viewData.baseCfg.textureNameB == self._viewData.baseCfg.textureNameA then
		removetimer(self.updateTimer, self)

		return
	end

	if self._bgChangeTime >= self._changeTime then
		self:_changeShowTab(self._nowSlectBgIndex == 1 and 2 or 1)
	else
		self._bgChangeTime = self._bgChangeTime + 1
	end
end

function SeasonPassPortEnergyView:_changeShowTab(index)
	self._bgChangeTime = 0
	self._nowSlectBgIndex = index

	local bgPathList = {
		self._viewData.baseCfg.textureNameA,
		self._viewData.baseCfg.textureNameB
	}
	local bgPath = bgPathList[index]

	if not self._viewData.baseCfg.showSkinIdList then
		local showSkinIdList = {}
		local skinId = checknumber(showSkinIdList[index])

		if index == 2 then
			if not string.nilorempty(bgPath) then
				self:_setViewEffect(false)
			end
		elseif not string.nilorempty(bgPath) then
			self:_setViewEffect(true)
		end

		if not string.nilorempty(bgPath) then
			local path = "ui/bigbg/season/" .. bgPath

			self:_loadBigBg(self._pet, path, false)
		else
			self:_unLoadBigBg(self._pet)
		end

		if skinId > 0 then
			if not self._viewData.baseCfg.rolePosLists then
				local rolePosLists = {}

				if not rolePosLists[index] then
					local pos = {}

					if not pos[3] then
						local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

						if not pos[4] then
							local scaleX = scale

							self:_loadRole(skinId, self._role, x, y, scale, scaleX)
						end
					end
				end
			end
		else
			self:_unLoadRole()
		end
	end
end

function SeasonPassPortEnergyView:_refreshRedDot()
	local onBtnFindRP = false
	local onBtnOneKeyRP = false
	local onBtnReceiveRP = false

	goutil.setActive(self._btnFindRP, onBtnFindRP)
	goutil.setActive(self._btnOneKeyRP, onBtnOneKeyRP)
	goutil.setActive(self._btnReceiveRP, onBtnReceiveRP)
end

function SeasonPassPortEnergyView:_setViewEffect(isShow)
	UIEffectManager.instance:stopEffect(self._viewEff)

	self._viewEff = nil

	if isShow then
		local effPath = "20221028/nizhanmiling/fx_ui_nizhanmiling.prefab"

		local function func(_, eff)
			eff:setParent(self._effect.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
			eff:setClipping(self._viewRectTr)
		end

		self._viewEff = UIEffectManager.instance:playEffect(self, effPath, self._effect, 0, 0, true, false, nil, func, nil)
	end
end

function SeasonPassPortEnergyView:_loadRole(skinId, rootParent, x, y, scale, sclaeX)
	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, rootParent, scale, nil, true, 0, 0)

	GameUtil.setLocalPos(rootParent, x, y)
	GameUtil.setLocalScale(rootParent, sclaeX, scale, scale)
end

function SeasonPassPortEnergyView:_unLoadRole()
	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function SeasonPassPortEnergyView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function SeasonPassPortEnergyView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function SeasonPassPortEnergyView:_onClickTask()
	self:_selectTabByIndex(1)
	self._tableView:MoveCellInView(0, false)
end

function SeasonPassPortEnergyView:_onClickAchievement()
	self:_selectTabByIndex(2)
	self._tableView:MoveCellInView(0, false)
end

function SeasonPassPortEnergyView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasonPassPortEnergyView:_onClickRecieve(data)
	if not data.gainPrize then
		SeasonModeWarOrderController.instance:sendRequestSeasonGetTaskPrize(data.taskId)
	end
end

function SeasonPassPortEnergyView:_onClickOneKey()
	local canOneKeyRecieve = false

	for _, v in pairs(self._viewData.dailyTaskData) do
		if not v.gainPrize and v.isFinish then
			canOneKeyRecieve = true

			break
		end
	end

	if not canOneKeyRecieve then
		for _, v in pairs(self._viewData.allTimeTaskData) do
			if not v.gainPrize and v.isFinish then
				canOneKeyRecieve = true

				break
			end
		end
	end

	if canOneKeyRecieve then
		SeasonModeWarOrderController.instance:sendRequestSeasonGetTaskPrize(-1)
	else
		FloatWordMgr.instance:show("当前无可领取奖励")
	end
end

function SeasonPassPortEnergyView:_onClickGoto(data)
	GotoMgr.gotoByString(data.config.jumpTo)

	local parentPresentor = self._viewPresentor.parentPresentor

	if parentPresentor then
		UIStateManager.instance:popByName(parentPresentor.viewName)
	else
		self:close()
	end
end

return SeasonPassPortEnergyView
