-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/view/DivineasheslessdragonlevelView.lua

module("logic.extensions.divineasheslessdragon.view.DivineasheslessdragonlevelView", package.seeall)

local DivineasheslessdragonlevelView = class("DivineasheslessdragonlevelView", ViewComponent)
local PerPageCount = 5

function DivineasheslessdragonlevelView:ctor()
	DivineasheslessdragonlevelView.super.ctor(self)
end

function DivineasheslessdragonlevelView:buildUI()
	DivineasheslessdragonlevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self._btnChallenge = self:getBtn("info/btnChallenge")
	self._levelCellList = {}

	for i = 1, 5 do
		local go = self:getGo("level_" .. i)
		local cls = GameUtil.AddLuaOnce(go, SYWJLLevelCell)

		table.insert(self._levelCellList, cls)
	end

	self._sliderLevel = self:getSlider("level/slider")
	self._txtLevel = self:getTxt("level/slider/FillArea/info/txtLevel")
	self._txtDown = self:getTxt("level/txtDown")
	self._txtUp = self:getTxt("level/txtUp")
	self._headIcon = self:getGo("level/slider/FillArea/info/head")
	self._txtLevelName = self:getTxt("info/txtName")
	self._txtCondition1 = self:getTxt("info/txtCondition1")
	self._conditionState1 = self:getGo("info/txtCondition1/yes")
	self.petTableview = self:getGo("info/petview")
	self.petCell = self:getGo("info/petcell")
	self.petScrollList = ScrollerList.create(self.petTableview, self.petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self.rewardTableview = self:getGo("info/rewardview")
	self.rewardCell = self:getGo("info/rewardcell")
	self.rewardScrollList = ScrollerList.create(self.rewardTableview, self.rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._animator = self:getGo("tip"):GetComponent(ComponentType.Animator)
	self._txtTipName = self:getTxt("tip/txt2")
	self._dragArea = Framework.UIDragTrigger.Get(self:getGo("dragArea"))
	self._redPoint = self:getGo("info/btnBuff/redPoint")
	self._txtBattleRule = self:getTxt("info/txtBattleRule")
	self._title3Go = self:getGo("info/title_3")
end

function DivineasheslessdragonlevelView:bindEvents()
	DivineasheslessdragonlevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._dragArea:AddEndDragListener(self._onEndDrag, self)
end

function DivineasheslessdragonlevelView:unbindEvents()
	DivineasheslessdragonlevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._dragArea:RemoveEndDragListener()
end

function DivineasheslessdragonlevelView:onEnter()
	DivineasheslessdragonlevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineAsheslessDragonSelectLevel, self._onSelectLevel, self)

	self._activityId = DivineasheslessdragonModel.instance:getActivityId()
	self._stageCfgs = DivineasheslessdragonConfig.instance:getStageCfgs(self._activityId)
	self._totalLevelCount = #self._stageCfgs
	self._maxPage = Mathf.Ceil(self._totalLevelCount / PerPageCount)

	local curPassStage = DivineasheslessdragonModel.instance:getPassedStageId(self._activityId)

	self._curSelectLevelIndex = Mathf.Clamp(curPassStage + 1, 1, self._totalLevelCount)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()

	self._curPage = self:_getPageByStage(self._curSelectLevelIndex)

	self:_initBackgroundImage()
	self:_initTipAnim()
	self:_updateLevels()
	self:_initLevelSlider()
	self:_updateCurSelectLevelInfo()
	self:_updateRedPoint()
end

function DivineasheslessdragonlevelView:onExit()
	DivineasheslessdragonlevelView.super.onExit(self)
	self:_clearBackgroundImage()
	self.petScrollList:dispose()
	self.rewardScrollList:dispose()
	self:_clearLevelSlider()
	self:_clearBgEffect()
end

function DivineasheslessdragonlevelView:_initAoqiGodUI()
	GameUtil.SetActive(self._title3Go, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self.rewardTableview, not self._isAoqiGodProcessType)
end

function DivineasheslessdragonlevelView:_onClickClose()
	self:close()
end

function DivineasheslessdragonlevelView:_onClickChallenge()
	local curPassStage = DivineasheslessdragonModel.instance:getPassedStageId(self._activityId)

	if self._curSelectLevelIndex > curPassStage + 1 then
		FloatWordMgr.instance:show(string.format("请先通过第%d关", curPassStage + 1))
	elseif self._curSelectLevelIndex < curPassStage + 1 then
		FloatWordMgr.instance:show("已通关")
	else
		local customFmtMo = DivineasheslessdragonModel.instance:getCustomFmtMo()
		local cfg = self._stageCfgs[self._curSelectLevelIndex]

		customFmtMo:initParams(self._activityId, cfg)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end
end

function DivineasheslessdragonlevelView:_onClickPrePage()
	if self._curPage <= 1 then
		self._curPage = 1

		return
	end

	self._curPage = self._curPage - 1

	self:_updateLevels()
	self:_playTipAnim()
end

function DivineasheslessdragonlevelView:_onClickNextPage()
	if self._curPage >= self._maxPage then
		self._curPage = self._maxPage

		return
	end

	self._curPage = self._curPage + 1

	self:_updateLevels()
	self:_playTipAnim()
end

function DivineasheslessdragonlevelView:_onEndDrag(eventData)
	if eventData.position.y - eventData.pressPosition.y >= 0 then
		self:_onClickPrePage()
	else
		self:_onClickNextPage()
	end
end

function DivineasheslessdragonlevelView:_onSelectLevel(index)
	local lastIndex = self._curSelectLevelIndex

	self._curSelectLevelIndex = index

	for i, v in ipairs(self._levelCellList) do
		v:setSelectState(self._curSelectLevelIndex)
	end

	if lastIndex ~= self._curSelectLevelIndex then
		self:_updateCurSelectLevelInfo()
	end
end

function DivineasheslessdragonlevelView:_getStartAndEndIndex(page)
	return (page - 1) * PerPageCount + 1, page * PerPageCount
end

function DivineasheslessdragonlevelView:_getPageByStage(stage)
	return Mathf.Floor((stage - 1) / PerPageCount) + 1
end

function DivineasheslessdragonlevelView:_updateLevels()
	self:_setBackgroundImage(self._curPage)
	self:_updateLevelSlider()
	self:_loadBgEffect(self._curPage)

	local startIndex, endIndex = self:_getStartAndEndIndex(self._curPage)
	local curIndex = startIndex

	for i, v in ipairs(self._levelCellList) do
		local param = {}

		param.index = curIndex
		param.isSelect = curIndex == self._curSelectLevelIndex
		param.activityId = self._activityId
		curIndex = curIndex + 1

		v:init(param)
	end
end

function DivineasheslessdragonlevelView:_initLevelSlider()
	self._txtDown.text = "1关"
	self._txtUp.text = self._totalLevelCount .. "关"

	MaterialMgr.setIcon(self._headIcon, MatType.Pet, 12021)
end

function DivineasheslessdragonlevelView:_clearLevelSlider()
	MaterialMgr.clearIcon(self._headIcon)
end

function DivineasheslessdragonlevelView:_updateLevelSlider()
	local curPassStage = DivineasheslessdragonModel.instance:getPassedStageId(self._activityId)
	local curLevel = curPassStage + 1
	local num = curLevel <= self._totalLevelCount and curLevel or self._totalLevelCount

	self._sliderLevel:SetValue((num - 1) / (self._totalLevelCount - 1))

	self._txtLevel.text = string.format("当前第%d关", math.min(curLevel, self._totalLevelCount))
end

function DivineasheslessdragonlevelView:_initBackgroundImage()
	return
end

function DivineasheslessdragonlevelView:_setBackgroundImage(curPage)
	return
end

function DivineasheslessdragonlevelView:_clearBackgroundImage()
	uGuiUtil.clearImage(self._bg)
end

function DivineasheslessdragonlevelView:_updateCurSelectLevelInfo()
	local cfg = self._stageCfgs[self._curSelectLevelIndex]

	if not cfg then
		return
	end

	self._txtLevelName.text = string.format("第%d关", self._curSelectLevelIndex)

	local isPass = DivineasheslessdragonController.instance:isCurStagePass(self._activityId, self._curSelectLevelIndex)

	self:_updateLevelCondtions(cfg, isPass)
	self:_updateEnemyHeadIcons(cfg)
	self:_updateRewardIcons(cfg)
	self:_updateBattleRule(cfg)
end

function DivineasheslessdragonlevelView:_updateLevelCondtions(cfg, isPass)
	goutil.setActive(self._conditionState1, isPass)

	self._txtCondition1.text = cfg.winRule
end

function DivineasheslessdragonlevelView:_updateEnemyHeadIcons(cfg)
	local cfgList = DivineasheslessdragonConfig.instance:getCreepsCfgs(cfg.creepsMasterId)

	self.petScrollList:reloadData(cfgList)
end

function DivineasheslessdragonlevelView:_updateRewardIcons(cfg)
	local list = MaterialMgr.changeItemStrArr(cfg.prize)

	self.rewardScrollList:reloadData(list)
end

function DivineasheslessdragonlevelView:_updatePetCell(view, cell, data, tag)
	MaterialMgr.setCell(MatType.Pet, data.raceId, cell.gameObject)
end

function DivineasheslessdragonlevelView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivineasheslessdragonlevelView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DivineasheslessdragonlevelView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivineasheslessdragonlevelView:_initTipAnim()
	return
end

function DivineasheslessdragonlevelView:_playTipAnim()
	local startIndex, endIndex = self:_getStartAndEndIndex(self._curPage)
	local cfg = self._stageCfgs[startIndex]

	self._txtTipName.text = cfg.name
end

function DivineasheslessdragonlevelView:_updateRedPoint()
	return
end

function DivineasheslessdragonlevelView:_getEffPath(page)
	if page == 1 then
		return DivineasheslessdragonlevelViewPresentor.Effect1
	elseif page == 2 then
		return DivineasheslessdragonlevelViewPresentor.Effect2
	else
		return DivineasheslessdragonlevelViewPresentor.Effect3
	end
end

function DivineasheslessdragonlevelView:_loadBgEffect(page)
	self:_clearBgEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, self:_getEffPath(page), self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._pageUIEffect = uiEffect
end

function DivineasheslessdragonlevelView:_clearBgEffect()
	if self._pageUIEffect then
		UIEffectManager.instance:stopEffect(self._pageUIEffect)

		self._pageUIEffect = nil
	end
end

function DivineasheslessdragonlevelView:_updateBattleRule(cfg)
	self._txtBattleRule.text = cfg.battleRule
end

return DivineasheslessdragonlevelView
