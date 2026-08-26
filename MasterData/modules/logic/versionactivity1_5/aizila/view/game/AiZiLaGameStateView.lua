-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameStateView.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateView", package.seeall)

local AiZiLaGameStateView = class("AiZiLaGameStateView", BaseView)

function AiZiLaGameStateView:onInitView()
	self._btnfullClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullClose")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._gostateItem = gohelper.findChild(self.viewGO, "#go_stateItem")
	self._goState = gohelper.findChild(self.viewGO, "#go_stateItem/#go_State")
	self._goeffdown = gohelper.findChild(self.viewGO, "#go_stateItem/#go_State/#go_effdown")
	self._goeffup = gohelper.findChild(self.viewGO, "#go_stateItem/#go_State/#go_effup")
	self._txteffDesc = gohelper.findChildText(self.viewGO, "#go_stateItem/#go_State/#txt_effDesc")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_equip")
	self._goEquip = gohelper.findChild(self.viewGO, "#scroll_equip/Viewport/Content/#go_Equip")
	self._goequipState = gohelper.findChild(self.viewGO, "#scroll_equip/Viewport/Content/#go_equipState")
	self._goEffect = gohelper.findChild(self.viewGO, "#scroll_equip/Viewport/Content/#go_Effect")
	self._gogameState = gohelper.findChild(self.viewGO, "#scroll_equip/Viewport/Content/#go_gameState")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameStateView:addEvents()
	self._btnfullClose:AddClickListener(self._btnfullCloseOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function AiZiLaGameStateView:removeEvents()
	self._btnfullClose:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AiZiLaGameStateView:_btnfullCloseOnClick()
	self:closeThis()
end

function AiZiLaGameStateView:_btnCloseOnClick()
	self:closeThis()
end

function AiZiLaGameStateView:_editableInitView()
	transformhelper.setLocalPos(self._gostateItem.transform, 0, 0, 0)
	gohelper.setActive(self._gostateItem, false)
end

function AiZiLaGameStateView:onUpdateParam()
	return
end

function AiZiLaGameStateView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.closeThis, self)
	end

	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.ExitGame, self.closeThis, self)
	self:refreshUI()
end

function AiZiLaGameStateView:onClose()
	return
end

function AiZiLaGameStateView:onDestroyView()
	return
end

function AiZiLaGameStateView:refreshUI()
	local equipStateList = self:_getEquipStateDataList()
	local gameStateList = self:_getGameStateDataList()

	gohelper.setActive(self._goEquip, equipStateList and #equipStateList > 0)
	gohelper.setActive(self._goEffect, gameStateList and #gameStateList > 0)
	gohelper.CreateObjList(self, self._onEquipStateItem, equipStateList, self._goequipState, self._gostateItem, AiZiLaGameStateItem)
	gohelper.CreateObjList(self, self._onGameStateItem, gameStateList, self._gogameState, self._gostateItem, AiZiLaGameStateItem)
end

function AiZiLaGameStateView:_getEquipStateDataList()
	local list = {}

	tabletool.addValues(list, AiZiLaModel.instance:getEquipMOList())

	return list
end

function AiZiLaGameStateView:_getGameStateDataList()
	local list = {}
	local buffList = AiZiLaGameModel.instance:getBuffIdList() or {}
	local actId = AiZiLaGameModel.instance:getActivityID()
	local tAiZiLaConfig = AiZiLaConfig.instance

	for i, buffId in ipairs(buffList) do
		local buffCfg = tAiZiLaConfig:getBuffCo(actId, buffId)

		if buffCfg then
			table.insert(list, buffCfg)
		else
			logError(string.format("[export_状态] buff配置找不到。 activityId:%s buffId:%s", actId, buffId))
		end
	end

	return list
end

function AiZiLaGameStateView:_onEquipStateItem(cell_component, data, index)
	local equipMO = data
	local equipCfg = equipMO:getConfig()

	if equipCfg then
		local tag = {
			equipCfg.name,
			equipCfg.effectDesc
		}
		local text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a5_aizila_role_state_effect_desc"), tag)

		cell_component:setStateStr(text)
	end

	cell_component:setShowUp(true)
end

function AiZiLaGameStateView:_onGameStateItem(cell_component, data, index)
	local buffCfg = data

	if buffCfg then
		cell_component:setStateStr(buffCfg.effectDesc)
		cell_component:setShowUp(buffCfg.reduction ~= 1)
	end
end

return AiZiLaGameStateView
