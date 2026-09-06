-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/LongYanSQLevelView.lua

module("logic.extensions.godlongyan.view.LongYanSQLevelView", package.seeall)

local LongYanSQLevelView = class("LongYanSQLevelView", ViewComponent)
local PerPageCount = 5

function LongYanSQLevelView:ctor()
	LongYanSQLevelView.super.ctor(self)
end

function LongYanSQLevelView:buildUI()
	LongYanSQLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self._btnChallenge = self:getBtn("info/btnChallenge")
	self._btnBuff = self:getBtn("info/btnBuff")
	self._levelCellList = {}

	for i = 1, 5 do
		local go = self:getGo("level_" .. i)
		local cls = GameUtil.AddLuaOnce(go, LYSQLevelCell)

		table.insert(self._levelCellList, cls)
	end

	self._sliderLevel = self:getSlider("level/slider")
	self._txtLevel = self:getTxt("level/slider/FillArea/info/txtLevel")
	self._txtDown = self:getTxt("level/txtDown")
	self._txtUp = self:getTxt("level/txtUp")
	self._headIcon = self:getGo("level/slider/FillArea/info/head")
	self._txtLevelName = self:getTxt("info/txtName")
	self._txtCondition1 = self:getTxt("info/txtCondition1")
	self._txtCondition2 = self:getTxt("info/txtCondition2")
	self._conditionState1 = self:getGo("info/txtCondition1/yes")
	self._conditionState2 = self:getGo("info/txtCondition2/yes")
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
end

function LongYanSQLevelView:bindEvents()
	LongYanSQLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._dragArea:AddEndDragListener(self._onEndDrag, self)
end

function LongYanSQLevelView:unbindEvents()
	LongYanSQLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._dragArea:RemoveEndDragListener()
end

function LongYanSQLevelView:onEnter()
	LongYanSQLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanSelectLevel, self._onSelectLevel, self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanChallengeGetInfoRes, self._updateRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanUpgradeBuff, self._updateRedPoint, self)

	self._challengeId = self:getFirstParam()
	self._cfgChallenge = GodLongYanConfig.instance:getGlyData(self._challengeId)
	self._enemyFmtCfgs = GodLongYanConfig.instance:getCreepsCfgList(self._cfgChallenge.monsterPlan)
	self._totalLevelCount = #self._enemyFmtCfgs
	self._maxPage = Mathf.Ceil(self._totalLevelCount / PerPageCount)

	local curPassStage = GodLongYanModel.instance:getCurStage()

	self._curSelectLevelIndex = Mathf.Clamp(curPassStage + 1, 1, self._totalLevelCount)

	if curPassStage == self._totalLevelCount then
		local function callback()
			UIStateManager.instance:popByName(ViewName.LongYanSQLevelView)
			UIStateManager.instance:popByName(ViewName.LongYanSQMainView)
		end

		UIStateManager.instance:push(ViewName.DivineEvolveTipView, callback)
	end

	self._curPage = self:_getPageByStage(self._curSelectLevelIndex)

	self:_initBackgroundImage()
	self:_initTipAnim()
	self:_updateLevels()
	self:_initLevelSlider()
	self:_updateCurSelectLevelInfo()
	self:_updateRedPoint()

	if GodLongYanModel.instance:getIsShowLevelTip() then
		self:_playTipAnim()
	end
end

function LongYanSQLevelView:onExit()
	LongYanSQLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanSelectLevel, self._onSelectLevel, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanChallengeGetInfoRes, self._updateRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanUpgradeBuff, self._updateRedPoint, self)
	self:_clearBackgroundImage()
	self.petScrollList:dispose()
	self.rewardScrollList:dispose()
	self:_clearLevelSlider()
	self:_clearBgEffect()
end

function LongYanSQLevelView:_onClickClose()
	self:close()
end

function LongYanSQLevelView:_onClickChallenge()
	local curPassStage = GodLongYanModel.instance:getCurStage()

	if self._curSelectLevelIndex > curPassStage + 1 then
		FloatWordMgr.instance:show(string.format("请先通过第%d关", curPassStage + 1))
	elseif self._curSelectLevelIndex < curPassStage + 1 then
		FloatWordMgr.instance:show("已通关")
	else
		local customFmtMo = GodLongYanModel.instance:getCustomFmtMo()
		local cfg = self._enemyFmtCfgs[self._curSelectLevelIndex]

		customFmtMo:initParams(self._challengeId, cfg)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end
end

function LongYanSQLevelView:_onClickPrePage()
	if self._curPage <= 1 then
		self._curPage = 1

		return
	end

	self._curPage = self._curPage - 1

	self:_updateLevels()
	self:_playTipAnim()
end

function LongYanSQLevelView:_onClickNextPage()
	if self._curPage >= self._maxPage then
		self._curPage = self._maxPage

		return
	end

	self._curPage = self._curPage + 1

	self:_updateLevels()
	self:_playTipAnim()
end

function LongYanSQLevelView:_onClickBuff()
	UIStateManager.instance:push(ViewName.LongYanSQBuffView)
end

function LongYanSQLevelView:_onEndDrag(eventData)
	if eventData.position.y - eventData.pressPosition.y >= 0 then
		self:_onClickPrePage()
	else
		self:_onClickNextPage()
	end
end

function LongYanSQLevelView:_onSelectLevel(index)
	local lastIndex = self._curSelectLevelIndex

	self._curSelectLevelIndex = index

	for i, v in ipairs(self._levelCellList) do
		v:setSelectState(self._curSelectLevelIndex)
	end

	if lastIndex ~= self._curSelectLevelIndex then
		self:_updateCurSelectLevelInfo()
	end
end

function LongYanSQLevelView:_getStartAndEndIndex(page)
	return (page - 1) * PerPageCount + 1, page * PerPageCount
end

function LongYanSQLevelView:_getPageByStage(stage)
	return Mathf.Floor((stage - 1) / PerPageCount) + 1
end

function LongYanSQLevelView:_updateLevels()
	self:_setBackgroundImage(self._curPage)
	self:_updateLevelSlider()
	self:_loadBgEffect(self._curPage)

	local startIndex, endIndex = self:_getStartAndEndIndex(self._curPage)
	local curIndex = startIndex

	for i, v in ipairs(self._levelCellList) do
		local param = {}

		param.index = curIndex
		param.levelCfg = self._enemyFmtCfgs[curIndex]
		param.isSelect = curIndex == self._curSelectLevelIndex
		curIndex = curIndex + 1

		v:init(param)
	end
end

function LongYanSQLevelView:_initLevelSlider()
	self._txtDown.text = "1关"
	self._txtUp.text = self._totalLevelCount .. "关"

	MaterialMgr.setIcon(self._headIcon, MatType.Pet, 12002)
end

function LongYanSQLevelView:_clearLevelSlider()
	MaterialMgr.clearIcon(self._headIcon)
end

function LongYanSQLevelView:_updateLevelSlider()
	local curPassStage = GodLongYanModel.instance:getCurStage()
	local curLevel = curPassStage + 1
	local num = curLevel <= self._totalLevelCount and curLevel or self._totalLevelCount

	self._sliderLevel:SetValue((num - 1) / (self._totalLevelCount - 1))

	self._txtLevel.text = string.format("当前第%d关", curLevel)
end

function LongYanSQLevelView:_initBackgroundImage()
	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, LongYanSQLevelViewPresentor.DefaultBgPath)
end

function LongYanSQLevelView:_setBackgroundImage(curPage)
	local index = (curPage - 1) * PerPageCount + 1
	local imgName = self._enemyFmtCfgs[index].background

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("godlongyan", imgName))
end

function LongYanSQLevelView:_clearBackgroundImage()
	uGuiUtil.clearImage(self._bg)
end

function LongYanSQLevelView:_updateCurSelectLevelInfo()
	local cfg = self._enemyFmtCfgs[self._curSelectLevelIndex]

	if not cfg then
		return
	end

	self._txtLevelName.text = string.format("第%d关", self._curSelectLevelIndex)

	local isPass = GodLongYanModel.instance:isCurStagePass(self._curSelectLevelIndex)

	self:_updateLevelCondtions(cfg, isPass)
	self:_updateEnemyHeadIcons(cfg)
	self:_updateRewardIcons(cfg)
end

function LongYanSQLevelView:_updateLevelCondtions(cfg, isPass)
	goutil.setActive(self._txtCondition1.gameObject, true)
	goutil.setActive(self._txtCondition2.gameObject, true)
	goutil.setActive(self._conditionState1, isPass)
	goutil.setActive(self._conditionState2, isPass)

	if not string.nilorempty(cfg.winRule1) then
		self._txtCondition1.text = cfg.winRule1

		if not string.nilorempty(cfg.winRule2) then
			self._txtCondition2.text = cfg.winRule2
		else
			goutil.setActive(self._txtCondition2.gameObject, false)
		end
	elseif not string.nilorempty(cfg.winRule2) then
		self._txtCondition1.text = cfg.winRule2

		goutil.setActive(self._txtCondition2.gameObject, false)
	else
		goutil.setActive(self._txtCondition1.gameObject, false)
	end
end

function LongYanSQLevelView:_updateEnemyHeadIcons(cfg)
	local cfgList = GodLongYanConfig.instance:getCreepsMasterList(cfg.creepsMasterId)

	self.petScrollList:reloadData(cfgList)
end

function LongYanSQLevelView:_updateRewardIcons(cfg)
	local list = MaterialMgr.changeItemStrArr(cfg.passPrize)

	self.rewardScrollList:reloadData(list)
end

function LongYanSQLevelView:_updatePetCell(view, cell, data, tag)
	MaterialMgr.setCell(MatType.Pet, data.raceId, cell.gameObject)
end

function LongYanSQLevelView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function LongYanSQLevelView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function LongYanSQLevelView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function LongYanSQLevelView:_initTipAnim()
	self._animator:Play("longyansqlevelview")
end

function LongYanSQLevelView:_playTipAnim()
	local startIndex, endIndex = self:_getStartAndEndIndex(self._curPage)
	local cfg = self._enemyFmtCfgs[startIndex]
	local strList = string.split(cfg.name, "-")

	if strList[1] then
		self._txtTipName.text = strList[1]
	end

	self._animator:Play("longyansqlevelview_2", 0, 0)
end

function LongYanSQLevelView:_updateRedPoint()
	goutil.setActive(self._redPoint, GodLongYanModel.instance:isAnyBuffCanUpgrade())
end

function LongYanSQLevelView:_getEffPath(page)
	if page == 1 then
		return LongYanSQLevelViewPresentor.Effect1
	elseif page == 2 then
		return LongYanSQLevelViewPresentor.Effect2
	else
		return LongYanSQLevelViewPresentor.Effect3
	end
end

function LongYanSQLevelView:_loadBgEffect(page)
	self:_clearBgEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, self:_getEffPath(page), self._bg.transform, 0, 0, true, false)

	uiEffect:setParent(self._bg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._pageUIEffect = uiEffect
end

function LongYanSQLevelView:_clearBgEffect()
	if self._pageUIEffect then
		UIEffectManager.instance:stopEffect(self._pageUIEffect)

		self._pageUIEffect = nil
	end
end

return LongYanSQLevelView
