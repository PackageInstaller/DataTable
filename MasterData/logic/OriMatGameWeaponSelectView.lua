-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponSelectView.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponSelectView", package.seeall)

local OriMatGameWeaponSelectView = class("OriMatGameWeaponSelectView", ViewComponent)

function OriMatGameWeaponSelectView:buildUI()
	OriMatGameWeaponSelectView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._btnOneKey = self:getGo("btnOneKey")
	self._btnSpecial = self:getGo("btnSpecial")
	self._txtTips = self:getTxt("tips/txt")

	local itemScrCell = self:getGo("itemCol/scrCell")
	local itemScrView = self:getGo("itemCol/scrView")

	self._itemScrollerList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function OriMatGameWeaponSelectView:bindEvents()
	OriMatGameWeaponSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickBtnOneKey, self)
	GameUtil.addClickHandler(self._btnSpecial, self._onClickBtnSpecial, self)
end

function OriMatGameWeaponSelectView:unbindEvents()
	OriMatGameWeaponSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnSpecial)
end

function OriMatGameWeaponSelectView:onEnter()
	OriMatGameWeaponSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._subMo = OriMatGameController.instance:getSubMo(self._seasonId)

	local seasonData = OriMatGameConfig.instance:getSeasonData(self._seasonId)

	self._stagePlanId = seasonData.stagePlanId
	self._weaponPlanId = seasonData.weaponPlanId

	local stageCfg = OriMatGameConfig.instance:getStageCfgByStageId(self._stagePlanId, self._stageId)
	local gamePlanCfg = OriMatGameConfig.instance:getGamePlanCfg(stageCfg.gamePlanId)

	self._maxWeaponNum = checknumber(gamePlanCfg.maxWeaponNum)
	self._selectedWeaponIds = {}
	self._mapBuffIdList = OriMatGameConfig.instance:getMapBuffIdListInMapData(gamePlanCfg.gamePlanId)

	GameUtil.SetActive(self._btnSpecial, #self._mapBuffIdList > 0)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameStartRes, self._handlePM_OriginMaterialGameStartRes, self)
	self:_onUpdate()
end

function OriMatGameWeaponSelectView:onExit()
	OriMatGameWeaponSelectView.super.onExit(self)
	self._itemScrollerList:dispose()
end

function OriMatGameWeaponSelectView:_handlePM_OriginMaterialGameStartRes(status, msg)
	if status ~= 0 then
		self:close()

		return
	end

	local talents = self._subMo:getUnlockTalentIds()

	OriMatGameController.instance:startGameDirectly(self._seasonId, self._stageId, self._selectedWeaponIds, talents)
	self:close()
end

function OriMatGameWeaponSelectView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function OriMatGameWeaponSelectView:_onUpdateData()
	self._weaponDataList = {}

	local cfg = OriMatGameConfig.instance:getWeaponPlanCfg(self._weaponPlanId)
	local weaponIdList = cfg.weaponIdList

	for _, weaponId in ipairs(weaponIdList) do
		local data = OriMatGameConfig.instance:getWeaponCfg(weaponId)

		if data then
			table.insert(self._weaponDataList, data)
		else
			printError(string.format("武器配置不存在：%s", weaponId))
		end
	end
end

function OriMatGameWeaponSelectView:_onUpdateUI()
	self:_onUpdatePlane()
	self._itemScrollerList:reloadData(self._weaponDataList)
end

function OriMatGameWeaponSelectView:_onUpdatePlane()
	local selectedNum = #self._selectedWeaponIds
	local isFull = selectedNum >= self._maxWeaponNum or self._maxWeaponNum <= 0

	self._txtTips.text = isFull and string.format("请先选择%s个武器进入战斗（<color=#60ee85>%s</color>/%s）", self._maxWeaponNum, selectedNum, self._maxWeaponNum) or string.format("请先选择%s个武器进入战斗（<color=#eb4624>%s</color>/%s）", self._maxWeaponNum, selectedNum, self._maxWeaponNum)

	GameUtil.SetActive(self._btnSure, isFull)
	GameUtil.SetActive(self._btnOneKey, not isFull)
end

function OriMatGameWeaponSelectView:_updateItemCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local weaponId = data.weaponId
	local icon = goutil.findChild(mainGo, "icon")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local tagNew = goutil.findChild(mainGo, "tagNew")
	local spriteChange = GameUtil.getUIImageSpriteChange(icon)

	spriteChange:ChangeSprite(data.weaponPic)
	icon:GetComponent(goutil.Type_UIImage):SetNativeSize()

	txtName.text = data.weaponName

	local isSelected = self:_isWeaponSelected(weaponId)

	GameUtil.SetActive(tagSelect, isSelected)

	local isNew = self._subMo:isNewWeapon(weaponId)

	GameUtil.SetActive(tagNew, isNew)
	GameUtil.addClickHandler(mainGo, function()
		local isSelected = self:_isWeaponSelected(weaponId)
		local result = false

		if isSelected then
			table.removebyvalue(self._selectedWeaponIds, weaponId)

			result = true
		elseif #self._selectedWeaponIds >= self._maxWeaponNum then
			FloatWordMgr.instance:show(string.format("最多只能选择%s个武器", self._maxWeaponNum))
		else
			result = true

			table.insert(self._selectedWeaponIds, weaponId)
		end

		if result then
			self:_onUpdatePlane()
			GameUtil.SetActive(tagSelect, not isSelected)
		end
	end)
	GameUtil.addClickHandler(icon, function()
		UIStateManager.instance:push(ViewName.OriMatGameWeaponTipsWinView, weaponId)
	end)
end

function OriMatGameWeaponSelectView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.rmClickHandler(mainGo)
	GameUtil.rmClickHandler(icon)
end

function OriMatGameWeaponSelectView:_onClickBtnSure()
	if self._maxWeaponNum <= 0 then
		FloatWordMgr.instance:show("请选择武器")

		return
	end

	if #self._selectedWeaponIds < self._maxWeaponNum then
		FloatWordMgr.instance:show(string.format("请选择%s个武器", self._maxWeaponNum))

		return
	end

	if not self._subMo:isInTimeOfStage(self._stageId) then
		FloatWordMgr.instance:show("未开放")

		return
	end

	OriMatGameController.instance:sendPM_OriginMaterialGameStartReq(self._seasonId, self._stageId)
end

function OriMatGameWeaponSelectView:_onClickBtnCancel()
	self:close()
end

function OriMatGameWeaponSelectView:_onClickBtnOneKey()
	if #self._selectedWeaponIds >= self._maxWeaponNum then
		return
	end

	for _, data in ipairs(self._weaponDataList) do
		local weaponId = data.weaponId

		if not self:_isWeaponSelected(weaponId) then
			table.insert(self._selectedWeaponIds, weaponId)

			if #self._selectedWeaponIds >= self._maxWeaponNum then
				break
			end
		end
	end

	self:_onUpdateUI()
end

function OriMatGameWeaponSelectView:_isWeaponSelected(weaponId)
	return table.indexof(self._selectedWeaponIds, weaponId) ~= false
end

function OriMatGameWeaponSelectView:_onClickBtnSpecial()
	UIStateManager.instance:push(ViewName.OriMatGameSpecialGridView, self._mapBuffIdList)
end

return OriMatGameWeaponSelectView
