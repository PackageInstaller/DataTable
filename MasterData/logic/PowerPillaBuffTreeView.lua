-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaBuffTreeView.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaBuffTreeView", package.seeall)

local PowerPillaBuffTreeView = class("PowerPillaBuffTreeView", ViewComponent)

function PowerPillaBuffTreeView:buildUI()
	PowerPillaBuffTreeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "btnTip")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._descCol = {}

	local mainGo = goutil.findChild(self.mainGO, "descCol")

	self._descCol._mainGo = mainGo
	self._descCol._buff = {}
	self._descCol._buff._mainGo = goutil.findChild(mainGo, "buff")
	self._descCol._buff._icon = goutil.findChild(mainGo, "buff/icon")
	self._descCol._buff._txtTitle = goutil.findChildTextComponent(mainGo, "buff/txtTitle/txt")
	self._descCol._content = {}
	self._descCol._content._mainGo = goutil.findChild(mainGo, "content")
	self._descCol._content._txtCurDesc = goutil.findChildTextComponent(mainGo, "content/txtCurDesc")
	self._descCol._content._txtNextDesc = goutil.findChildTextComponent(mainGo, "content/txtNextDesc")
	self._descCol._content._txtCurGold = goutil.findChildTextComponent(mainGo, "content/txtCurGold")
	self._descCol._content._txtCostGold = goutil.findChildTextComponent(mainGo, "content/txtCostGold")
	self._descCol._content._btnUp = goutil.findChild(mainGo, "content/btnUp")
	self._buffContent = goutil.findChild(self.mainGO, "buffCol/buffView/Viewport/Content")
	self._customInputOfDescCol = UICustomInput.Get(self._descCol._mainGo)
end

function PowerPillaBuffTreeView:bindEvents()
	PowerPillaBuffTreeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._descCol._content._btnUp, self._onClickBtnUp, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	self._customInputOfDescCol:AddListener(self._onCustomInputCallbackOfDescCol, self)
end

function PowerPillaBuffTreeView:unbindEvents()
	PowerPillaBuffTreeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._descCol._content._btnUp)
	GameUtil.rmClickHandler(self._btnReset)
	self._customInputOfDescCol:RemoveListener()
end

function PowerPillaBuffTreeView:onEnter()
	PowerPillaBuffTreeView.super.onEnter(self)

	self._activityId = PowerPillaModel.instance:getActivityId()
	self._curBuffOnlyId = 0

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.MPPGetBuffInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPUpgradeBuffRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPUpgradeBuffResetRes, self._handleBuffResetRes, self)
	MaintainPowerPillaAgent.instance:sendPM_MPPGetBuffInfoReq(self._activityId)
end

function PowerPillaBuffTreeView:onExit()
	PowerPillaBuffTreeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetBuffInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPUpgradeBuffRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPUpgradeBuffResetRes, self._handleBuffResetRes, self)
	self:_onClearBuffCol()
	self:_onClearDescCol()
	self:_clearBgEffect()
end

function PowerPillaBuffTreeView:_handleBuffResetRes()
	FloatWordMgr.instance:show("重置成功")
	MaintainPowerPillaAgent.instance:sendPM_MPPGetBuffInfoReq(self._activityId)
end

function PowerPillaBuffTreeView:_onSetUI()
	self:_loadBgEffect()
end

function PowerPillaBuffTreeView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PowerPillaBuffTreeView:_onUpdateData()
	return
end

function PowerPillaBuffTreeView:_onUpdateUI()
	self:_onUpdateBuffColUI()
	self:_onUpdateDescColUI()
end

function PowerPillaBuffTreeView:_loadBgEffect()
	self:_clearBgEffect()

	local path = "20230602/fuyaota/fx_ui_fuyaota_fw02"

	if not string.nilorempty(path) then
		path = path .. ".prefab"
		self._bgEffect = UIEffectManager.instance:playEffect(self, path, self.mainGO.transform, 0, 0, true, false)

		self._bgEffect:setParent(self.mainGO.transform)
		self._bgEffect:setScale(1)
		self._bgEffect:setLocalPos(0, 0, 0)
	end
end

function PowerPillaBuffTreeView:_clearBgEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

function PowerPillaBuffTreeView:_onUpdateBuffColUI()
	local btCfgs = PowerPillaConfig.instance:getBuffTreeCfgs(self._activityId)
	local parentTran = self._buffContent.transform
	local childGo = parentTran:GetChild(0).gameObject
	local childrens = GameUtil.getChildren(parentTran)

	for idx, mainGo in ipairs(childrens) do
		GameUtil.SetActive(mainGo, idx > 1 and idx <= #btCfgs + 1)
	end

	for listId, btCfg in ipairs(btCfgs) do
		if not childrens[listId + 1] then
			local mainGo = goutil.cloneAndSetParent(childGo, parentTran)

			GameUtil.SetActive(childrens[listId + 1], true)
			self:_updateListCellOfBuff(childrens[listId + 1], listId)
		end
	end
end

function PowerPillaBuffTreeView:_onClearBuffCol()
	local parentTran = self._buffContent.transform
	local childrens = GameUtil.getChildren(parentTran)

	for _, mainGo in ipairs(childrens) do
		self:_clearListCellOfBuff(mainGo)
	end
end

function PowerPillaBuffTreeView:_updateListCellOfBuff(mainGo, listId)
	local buffView = goutil.findChild(mainGo, "buffView")
	local cfg = PowerPillaConfig.instance:getBuffTreeDataList(self._activityId, listId)
	local parentTran = buffView.transform
	local childrens = GameUtil.getChildren(parentTran)

	for index, childGo in ipairs(childrens) do
		local data = PowerPillaConfig.instance:getBuffTreeData(self._activityId, listId, index)

		GameUtil.SetActive(childGo, data)

		if data then
			self:_updateBuffCellOfBuff(childGo, listId, index)
		end
	end
end

function PowerPillaBuffTreeView:_clearListCellOfBuff(mainGo)
	local buffView = goutil.findChild(mainGo, "buffView")
	local parentTran = buffView.transform
	local childrens = GameUtil.getChildren(parentTran)

	for _, childGo in ipairs(childrens) do
		self:_clearBuffCellOfBuff(childGo)
	end
end

function PowerPillaBuffTreeView:_updateBuffCellOfBuff(mainGo, listId, index)
	local icon = goutil.findChild(mainGo, "icon")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle/txt")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc/txt")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local mask = goutil.findChild(mainGo, "mask")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local leftLine = goutil.findChild(mainGo, "leftLine")
	local rightLine = goutil.findChild(mainGo, "rightLine")
	local btData = PowerPillaConfig.instance:getBuffTreeData(self._activityId, listId, index)

	if btData then
		if not btData.type then
			local type = 0
			local level = PowerPillaModel.instance:getBuffLevel(type)
			local buffData = PowerPillaConfig.instance:getBuffData(self._activityId, type, level)
			local isHasLeft = checkbool(PowerPillaConfig.instance:getBuffTreeDataList(self._activityId, listId - 1))
			local isHasRight = checkbool(PowerPillaConfig.instance:getBuffTreeDataList(self._activityId, listId + 1))

			GameUtil.SetActive(leftLine, isHasLeft)
			GameUtil.SetActive(rightLine, isHasRight)

			if buffData then
				txtTitle.text = buffData.buffName or ""
			end

			if buffData then
				txtDesc.text = buffData.buffDesc or ""
			end

			local bgGo = icon
			local path = buffData and buffData.iconPath

			if not string.nilorempty(path) and bgGo then
				local spriteType = uGuiUtil.SpriteType.BigBg
				local spriteName = GameUrl.getExpEventUrl(path)

				local function func()
					return
				end

				uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
			else
				uGuiUtil.clearImage(bgGo)
			end

			local result, tips = PowerPillaController.instance:getTryUpdateBuffResultAndTips(self._activityId, type, level)

			GameUtil.SetActive(redPoint, result == 0)
			GameUtil.SetActive(mask, level <= 0)

			local function clickFunc()
				self:_setDescColVisual(true)

				self._curBuffOnlyId = btData.onlyId

				self:_onUpdateDescColUI()
			end

			GameUtil.addClickHandler(btnSelect, clickFunc)
		end
	end
end

function PowerPillaBuffTreeView:_clearBuffCellOfBuff(mainGo)
	local icon = goutil.findChild(mainGo, "icon")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(btnSelect)
end

function PowerPillaBuffTreeView:_onUpdateDescColUI()
	self:_setDescColVisual(self:_getDescColVisual() and self._curBuffOnlyId > 0)

	if not self:_getDescColVisual() then
		return
	end

	local btData = PowerPillaConfig.instance:getBuffTreeDataById(self._activityId, self._curBuffOnlyId)
	local curBuffData

	if btData then
		local level = PowerPillaModel.instance:getBuffLevel(btData.type)

		curBuffData = PowerPillaConfig.instance:getBuffData(self._activityId, btData.type, level)
	end

	local nextBuffData

	if curBuffData then
		nextBuffData = PowerPillaConfig.instance:getBuffData(self._activityId, curBuffData.type, curBuffData.level + 1)
	end

	local bgGo = self._descCol._buff._icon
	local path = curBuffData and curBuffData.iconPath

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = GameUrl.getExpEventUrl(path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	if curBuffData then
		self._descCol._buff._txtTitle.text = curBuffData.buffName or ""
	end

	if curBuffData then
		self._descCol._content._txtCurDesc.text = curBuffData.buffDesc or ""
	end

	if nextBuffData then
		self._descCol._content._txtNextDesc.text = nextBuffData.buffDesc or ""
	end

	local curGold = 0
	local costGold = 0
	local matName = "代币"

	if curBuffData and not string.nilorempty(curBuffData.cost) then
		local matType, matId, matNum = MaterialMgr.getMatParams(curBuffData.cost)

		curGold = MaterialModel.instance:getMaterialsNumber(matType, matId)
		costGold = matNum
		matName = MaterialMgr.getMaterialsName(matType, matId)
	end

	self._descCol._content._txtCurGold.text = string.format("拥有：<color=#894929>%s</color>%s", curGold, matName)
	self._descCol._content._txtCostGold.text = string.format("消耗：<color=#894929>%s</color>%s", costGold, matName)

	local isNeedMask = false

	if curBuffData then
		local result, tips = PowerPillaController.instance:getTryUpdateBuffResultAndTips(self._activityId, curBuffData.type, curBuffData.level)

		isNeedMask = result ~= GameEnum.ResultCode.Success
	end

	GameUtil.SetGray(self._descCol._content._btnUp, isNeedMask)
end

function PowerPillaBuffTreeView:_onClearDescCol()
	return
end

function PowerPillaBuffTreeView:_onClickBtnUp()
	local btData = PowerPillaConfig.instance:getBuffTreeDataById(self._activityId, self._curBuffOnlyId)

	if btData then
		if not btData.type then
			local type = 0

			if type > 0 then
				local curLevel = PowerPillaModel.instance:getBuffLevel(type)
				local result, tips = PowerPillaController.instance:getTryUpdateBuffResultAndTips(self._activityId, type, curLevel)

				FloatWordMgr.instance:show(tips)

				if result ~= GameEnum.ResultCode.Success then
					return
				end

				MaintainPowerPillaAgent.instance:sendPM_MPPUpgradeBuffReq(self._activityId, type)
			end
		end
	end
end

function PowerPillaBuffTreeView:_setDescColVisual(isToShow)
	self._isDescColInShow = isToShow

	GameUtil.SetActive(self._descCol._mainGo, isToShow)
end

function PowerPillaBuffTreeView:_getDescColVisual()
	return checkbool(self._isDescColInShow)
end

function PowerPillaBuffTreeView:_onCustomInputCallbackOfDescCol(hover)
	if not hover then
		self:_setDescColVisual(false)
	end
end

function PowerPillaBuffTreeView:_onClickBtnReset()
	local result, tips = PowerPillaController.instance:getTryResetBuffResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "确定重置后，将返还所有BUFF代币，并且所有BUFF效果回到初始状态"

	local function okFunc()
		MaintainPowerPillaAgent.instance:sendPM_ResetBuffReq(self._activityId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

return PowerPillaBuffTreeView
