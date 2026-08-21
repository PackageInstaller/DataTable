-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleMainViewFacade.lua

module("logic.extensions.battle.facade.BattleMainViewFacade", package.seeall)

local BattleMainViewFacade = class("BattleMainViewFacade", BaseFacade)
local kLocalSettingKey = "BattleMainViewFacade"
local kComapreViewKey = "CompareView"
local kHeroViewKey = "HeroView"
local kMainVisibleKey = "mainView"

function BattleMainViewFacade:ctor()
	self._isRegistered = false
	self._mainView = false
	self._compareView = false
	self._unitInfoView = false
	self._skillView = false
	self._leftTopView = false
	self._rightTopView = false
	self._rightDownView = false
	self._additionalTerrainInfoView = false
	self._uiElementView = false
	self._roleView = false
end

function BattleMainViewFacade:registerView(view)
	local views = view._viewPresentor._views

	self._isRegistered = true
	self._mainView = views[1]
	self._compareView = views[2]
	self._unitInfoView = views[3]
	self._skillView = views[4]
	self._leftTopView = views[5]
	self._centerTopView = views[6]
	self._leftDownView = views[7]
	self._rightTopView = views[8]
	self._rightDownView = views[9]
	self._additionalTerrainInfoView = views[10]
	self._uiElementView = views[11]
	self._proxyView = views[12]
	self._roleView = views[14]
	self._activeUnitInfoView = false

	self._compareView:setVisible(false)
	self._unitInfoView:setVisible(false)
	self._skillView:setVisible(false)
	self._leftTopView:setVisible(false)
	self._centerTopView:setVisible(false)
	self._leftDownView:setVisible(false)
	self._rightTopView:setVisible(false)
	self._rightDownView:setVisible(false)
	self._additionalTerrainInfoView:setVisible(false)
	self._proxyView:setVisible(false)
	self:setForNormal()
	self:setForAiMode(BattleMgr.instance:getModel():getAiMode())
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Undo, false, kLocalSettingKey)
end

function BattleMainViewFacade:unregisterView()
	self._isRegistered = false
	self._mainView = false
	self._compareView = false
	self._unitInfoView = false
	self._skillView = false
	self._leftTopView = false
	self._centerTopView = false
	self._leftDownView = false
	self._rightTopView = false
	self._rightDownView = false
	self._additionalTerrainInfoView = false
	self._uiElementView = false
	self._proxyView = false
	self._roleView = false
	self._activeUnitInfoView = false
end

function BattleMainViewFacade:setUIElementVisible(elementEnum, visible, key)
	if self._isRegistered then
		self._uiElementView:setElementVisible(elementEnum, visible, key)
	else
		BattleViewStateModel.instance:setUIElementVisible(elementEnum, visible, key)
	end
end

function BattleMainViewFacade:switchOperateUnit(unit, isOperatable, handler)
	if not self:_checkView() then
		return false
	end

	local model = BattleMgr.instance:getModel()

	if model:getPhase() == BattleEnum.Phase.READY then
		BattleCampAdjustmentViewFacade.instance:setOperatorUnit(unit)
	else
		self._unitInfoView:setVisible(true)
		self._unitInfoView:clearOperateUnit()
		self._unitInfoView:setOperateUnit(unit)
		self._leftDownView:setVisible(false, kHeroViewKey)

		self._activeUnitInfoView = self._unitInfoView

		if isOperatable then
			self._skillView:setVisible(true)
			self._skillView:setOperateUnit(unit, handler)
		else
			self._skillView:setVisible(false)
		end

		self._rightDownView:setVisible(false)
		self._centerTopView:setVisible(true)
		self._leftTopView:setVisible(true)
		self._rightTopView:setVisible(true)
	end
end

function BattleMainViewFacade:clearOperateUnit()
	if not self:_checkView() then
		return false
	end

	self._leftDownView:setVisible(true, kHeroViewKey)
	self._unitInfoView:clearOperateUnit()
	self._unitInfoView:setVisible(false)
	self._skillView:clearOperateUnit()
	self._skillView:setVisible(false)
	self:hideCompareView()

	self._activeUnitInfoView = false

	local isProxyMode = BattleMgr.instance:getModel():isProxyMode()

	self._leftTopView:setVisible(not isProxyMode or false)
	self._rightDownView:setVisible(false)
	self._centerTopView:setVisible(true)
	self._rightTopView:setVisible(true)
end

function BattleMainViewFacade:isRegistered()
	return self._isRegistered
end

function BattleMainViewFacade:setVisible(visible)
	if not self:_checkView() then
		return false
	end

	self._mainView:doFadeAnim(not visible)
end

function BattleMainViewFacade:isVisible()
	return BattleViewStateModel.instance:isUIElementVisible(BattleUIElement.Main)
end

function BattleMainViewFacade:setSelectTarget(targetUnionIndex)
	if not self:_checkView() then
		return false
	end

	self._skillView:setSelectTarget(targetUnionIndex)
end

function BattleMainViewFacade:showCompareView(forecastResult)
	if not self:_checkView() then
		return false
	end

	if self._activeUnitInfoView then
		self._unitInfoView:setVisible(false, "battlecompare", true)
	end

	self._leftDownView:setVisible(false, kComapreViewKey)
	self._compareView:showCompareView(forecastResult)
end

function BattleMainViewFacade:hideCompareView()
	if not self:_checkView() then
		return false
	end

	if self._activeUnitInfoView and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightUnitInfoPanel, false) then
		self._unitInfoView:setVisible(true, "battlecompare")
	end

	local setAtOnce = self._unitInfoView:getVisible()

	self._leftDownView:setVisible(true, kComapreViewKey)
	self._compareView:hideCompareView(setAtOnce)
end

function BattleMainViewFacade:hideRightTopView()
	if not self:_checkView() then
		return false
	end

	self._rightTopView:setVisible(false)
end

function BattleMainViewFacade:showRightTopView()
	if not self:_checkView() then
		return false
	end

	self._rightTopView:setVisible(true)
end

function BattleMainViewFacade:showTransportView()
	if not self:_checkView() then
		return
	end

	self._skillView:setVisible(false)
	self._rightDownView:setVisible(true)
end

function BattleMainViewFacade:hideTransportView()
	if not self:_checkView() then
		return
	end

	self._skillView:setVisible(true)
	self._rightDownView:setVisible(false)
end

function BattleMainViewFacade:getSelectedSkillId()
	if not self:_checkView() then
		return false
	end

	return self._skillView:getSelectedSkillId()
end

function BattleMainViewFacade:selectSkill(skillId, isStrenthening)
	if not self:_checkView() then
		return
	end

	self._skillView:selectSkill(skillId, isStrenthening)
end

function BattleMainViewFacade:setForCampAdjustment()
	if not self:_checkView() then
		return false
	end

	self._leftTopView:setVisible(false)
	self._leftDownView:setVisible(false, false, true)
	self._centerTopView:setVisible(false)
	self._rightDownView:setVisible(false)
	self._rightTopView:setVisible(true)
end

function BattleMainViewFacade:setForNormal()
	if not self:_checkView() then
		return false
	end

	self._leftTopView:setVisible(true)
	self._leftDownView:setVisible(true)
	self._centerTopView:setVisible(true)
	self._rightDownView:setVisible(false)
	self._rightTopView:setVisible(true)
	self._roleView:updateRtForNormal()
end

function BattleMainViewFacade:setForMainVisible(status)
	if not self:_checkView() then
		return false
	end

	self._leftDownView:setVisible(status, kMainVisibleKey)
end

function BattleMainViewFacade:setExplainPanelStatus(visible, key)
	self._centerTopView:setExplainVisible(visible, key)
end

function BattleMainViewFacade:setLeftTopViewVisible(visible, key)
	if not self:_checkView() then
		return false
	end

	self._leftTopView:setVisible(visible, key)
end

function BattleMainViewFacade:setCenterTopViewVisible(visible, key)
	if not self:_checkView() then
		return false
	end

	self._centerTopView:setVisible(visible, key)
end

function BattleMainViewFacade:setUnitInfoVisible(visible)
	if not self:_checkView() then
		return false
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightUnitInfoPanel, false) then
		return
	end

	self._unitInfoView:setVisible(visible)
end

function BattleMainViewFacade:setForMoving(localSettingKey)
	if not self:_checkView() then
		return false
	end

	self._leftDownView:setVisible(false, localSettingKey or kLocalSettingKey)
	self._skillView:setVisible(false, localSettingKey or kLocalSettingKey)
end

function BattleMainViewFacade:resetFromMoving(localSettingKey)
	if not self:_checkView() then
		return false
	end

	self._leftDownView:setVisible(true, localSettingKey or kLocalSettingKey)
	self._skillView:setVisible(true, localSettingKey or kLocalSettingKey)
end

function BattleMainViewFacade:cancelSelectedHero()
	if not self:_checkView() then
		return false
	end

	self._unitInfoView:setVisible(false)
end

function BattleMainViewFacade:updateViewInfoOnStrengthenChange()
	if not self:_checkView() then
		return false
	end

	self._activeUnitInfoView:updateViewInfoOnStrengthenChange()
end

function BattleMainViewFacade:lockOperation(operationOnly)
	BattleScenePickerViewFacade.instance:setEnable(false)
	BattleMainViewFacade.instance:setVisible(false)

	if not operationOnly then
		local boardMgr = BattleMgr.instance:getBoardMgr()
		local dangerArea = BattleMgr.instance:getDangerArea()

		boardMgr:setVisibleByKey(false, kLocalSettingKey)
		dangerArea:setVisibleByKey(false, kLocalSettingKey)
	end
end

function BattleMainViewFacade:unlockOperation()
	BattleScenePickerViewFacade.instance:setEnable(true)
	BattleMainViewFacade.instance:setVisible(true)

	local boardMgr = BattleMgr.instance:getBoardMgr()
	local dangerArea = BattleMgr.instance:getDangerArea()

	boardMgr:setVisibleByKey(true, kLocalSettingKey)
	dangerArea:setVisibleByKey(true, kLocalSettingKey)
end

function BattleMainViewFacade:setupOperatableFunction(isEnable, key)
	if not self:_checkView() then
		return
	end

	self._leftDownView:setVisible(isEnable, key)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Undo, isEnable, key)
end

function BattleMainViewFacade:setForOperatable()
	if not self:_checkView() then
		return
	end

	BattleScenePickerViewFacade.instance:setEnable(true, BattleConst.DefaultStateKey)
	self:setUIElementVisible(BattleUIElement.Auto, true, kLocalSettingKey)
	self:setUIElementVisible(BattleUIElement.DangerZone, true, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Undo, true, kLocalSettingKey)
	self._leftDownView:setVisible(true)
end

function BattleMainViewFacade:setForNotOperatable()
	if not self:_checkView() then
		return
	end

	BattleScenePickerViewFacade.instance:setEnable(false, BattleConst.DefaultStateKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Undo, false, kLocalSettingKey)
	self._leftDownView:setVisible(false)
end

function BattleMainViewFacade:showAdditionalTerrainTips(unionIndex)
	if self._isRegistered then
		self._additionalTerrainInfoView:setUnionIndex(unionIndex)
	end
end

function BattleMainViewFacade:hideAdditionalTerrainTips()
	if self._isRegistered then
		self._additionalTerrainInfoView:setVisible(false)
		self._additionalTerrainInfoView:setUnionIndex(false)
	end
end

function BattleMainViewFacade:setForUnitInfoOpen(isOpen, key)
	if not self:_checkView() then
		return
	end

	self._leftDownView:setVisible(not isOpen, key)
end

function BattleMainViewFacade:setForCompareOpen(isOpen, key)
	if not self:_checkView() then
		return
	end

	self._centerTopView:setVisible(not isOpen, key)
	self._leftTopView:setVisible(not isOpen, key)
end

function BattleMainViewFacade:closeUnitInfoExpandPanel()
	self._activeUnitInfoView:closeExpandPanel()
end

function BattleMainViewFacade:showSkillTipsOfOperateUnit(skillInfo)
	if not skillInfo or not skillInfo.heroId or not skillInfo.skillId then
		return
	end

	if skillInfo.enhanceCodes then
		BattleExternalDataModel.instance:setPreShowSkillTips(true)
		ToolTipsMgr.showBattleSkillTips(skillInfo)

		return
	end

	local unit = self._activeUnitInfoView and self._activeUnitInfoView:getOperateUnit()

	if not unit then
		skillInfo.enhanceCodes = nil
		skillInfo.skillStatus = nil

		local skillEnhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(skillInfo.heroId, skillInfo.skillId)

		if skillEnhanceMO then
			skillInfo.enhanceCodes = skillEnhanceMO:getAllSkillEnhanceCode()
		end

		BattleExternalDataModel.instance:setPreShowSkillTips(true)
		ToolTipsMgr.showBattleSkillTips(skillInfo)

		return
	end

	local skillMO = unit.skill:getActiveSkillById(skillInfo.skillId)

	skillInfo.enhanceCodes = skillMO:getEnhanceCodes()
	skillInfo.skillStatus = unit.skill:getSkillStatus()

	BattleExternalDataModel.instance:setPreShowSkillTips(true)
	ToolTipsMgr.showBattleSkillTips(skillInfo)
end

function BattleMainViewFacade:_checkView()
	if not self._isRegistered then
		if enableWarnLog then
			printWarn("Need to register view first!")
		end

		return false
	end

	return true
end

function BattleMainViewFacade:setForAiMode(aiMode)
	if not self:_checkView() then
		return
	end

	local isProxy = aiMode == BattleExtension_pb.AiMode.USER_RECORD

	self._proxyView:setVisible(isProxy)
	self:setUIElementVisible(BattleUIElement.Undo, not isProxy, kLocalSettingKey)
	self:setUIElementVisible(BattleUIElement.Auto, not isProxy, kLocalSettingKey)
	self:setUIElementVisible(BattleUIElement.DangerZone, not isProxy, kLocalSettingKey)

	if isProxy then
		self._unitInfoView:setVisible(false)
		self:setLeftTopViewVisible(false)
		self:setForNotOperatable()
	else
		self:setForOperatable()
	end
end

function BattleMainViewFacade:setRoleVisible(status, key)
	if not self:_checkView() then
		return
	end

	self._roleView:setVisible(status, key)
end

function BattleMainViewFacade:addRolePhotoToParent(parentGo)
	if not self:_checkView() then
		return
	end

	self._roleView:addRolePhotoToParent(parentGo)
end

function BattleMainViewFacade:showRole(modelCode, unit, key, isCompare)
	if not self:_checkView() then
		return
	end

	self._roleView:showUnit(modelCode, unit, key, isCompare)
end

function BattleMainViewFacade:getRoleView()
	if not self:_checkView() then
		return
	end

	return self._roleView
end

function BattleMainViewFacade:cacheInfoExpand(status)
	self._isExpanded = status

	self._leftDownView:updatePassHintByInfo()
end

function BattleMainViewFacade:getInfoExpand()
	return self._isExpanded
end

BattleMainViewFacade.instance = BattleMainViewFacade.New()

return BattleMainViewFacade
