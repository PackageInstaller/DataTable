-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveLevelupView.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveLevelupView", package.seeall)

local NaiLongEvolveLevelupView = class("NaiLongEvolveLevelupView", ViewComponent)

function NaiLongEvolveLevelupView:ctor()
	NaiLongEvolveLevelupView.super.ctor(self)
end

function NaiLongEvolveLevelupView:unbindEvents()
	NaiLongEvolveLevelupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoldBar)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnCancel)
end

function NaiLongEvolveLevelupView:bindEvents()
	NaiLongEvolveLevelupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoldBar, self._onClickBtnGoldBar, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickBtnLevelUp, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function NaiLongEvolveLevelupView:buildUI()
	NaiLongEvolveLevelupView.super.buildUI(self)

	self._txtPosType = self:getTxt("txtPosType")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._matNumGo = self:getGo("matNum")
	self._item = self:getGo("matNum/item")
	self._txtNum = self:getTxt("matNum/txtNum")
	self._btnGoldBar = self:getGo("goldBar")
	self._itemGoldBar = self:getGo("goldBar/item")
	self._txtNumGoldBar = self:getTxt("goldBar/txtNum")
	self._btnCancel = self:getGo("btnCancel")
	self._imgSpriteChange = self:getGo("icon"):GetComponent("UIImageSpriteChange")
	self._btnClose = self:getGo("btnClose")
	self._cell = self:getGo("cell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NaiLongEvolveLevelupView:onExit()
	NaiLongEvolveLevelupView.super.onExit(self)
	MaterialMgr.clearIcon(self._item)
	MaterialMgr.clearIcon(self._itemGoldBar)
	uGuiUtil.clearImage(self._imgSpriteChange.gameObject)
end

function NaiLongEvolveLevelupView:onEnter()
	NaiLongEvolveLevelupView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MilkDragonClgPosLvlUpRes, self._onPosLvlRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._posType = checknumber(params[2])
	self._actCfg = NaiLongEvolveConfig.instance:getActData(self._activityId)
	self._stageCfgs = NaiLongEvolveConfig.instance:getStageData(self._activityId)

	local typePosCfgs = NaiLongEvolveConfig.instance:getPosData(self._activityId)

	self._typePosCfg = typePosCfgs[self._posType]
	self._info = NaiLongEvolveModel.instance:getInfo(self._activityId)
	self._posTypeNames = NaiLongEvolveConfig.instance:getPosNames(self._activityId)
	self._curActiveScore = 0
	self._curLevel = self._info.posType2LvlDic[self._posType] or 0

	self:_onSetUI()
end

function NaiLongEvolveLevelupView:_onSetUI()
	local name = self._posTypeNames[self._posType]

	if not self._info.posType2LvlDic[self._posType] then
		local matStr = self._actCfg.scoreIcon
		local arr = string.split(matStr, ":")
		local data = self:_getNextLevelData()
		local levelUpCostNum = data.lvlUpCostScore
		local isMaxLevel = self:_isMaxLevel()

		self._txtPosType.text = name .. self._info.posType2LvlDic[self._posType] .. "级"
		self._txtNum.text = levelUpCostNum
		self._txtNumGoldBar.text = self._info.curScore or 0

		MaterialMgr.clearIcon(self._item)
		MaterialMgr.setIcon(self._item, arr[1], arr[2])
		MaterialMgr.clearIcon(self._itemGoldBar)
		MaterialMgr.setIcon(self._itemGoldBar, arr[1], arr[2])
		self._scrollList:reloadData(self._typePosCfg)
		self._imgSpriteChange:SetState(self._posType - 1)
		GameUtil.SetActive(self._btnLevelUp, not isMaxLevel)
		GameUtil.SetActive(self._btnCancel, isMaxLevel)
		GameUtil.SetActive(self._matNumGo, not isMaxLevel)
	end
end

function NaiLongEvolveLevelupView:_update()
	self._info = NaiLongEvolveModel.instance:getInfo(self._activityId)
	self._curLevel = self._info.posType2LvlDic[self._posType] or 0

	self:_onSetUI()
end

function NaiLongEvolveLevelupView:_updateCell(view, cell, data)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local colorChangeComp = goutil.findChild(cell, "txtDesc"):GetComponent(typeof(UITextColorChange))
	local imgLockGo = goutil.findChild(cell, "imgLock")
	local hasEvolve = self._curLevel >= data.posLvl

	txtDesc.text = data.desc
	txtLv.text = "Lv." .. data.posLvl

	colorChangeComp:SetState(hasEvolve and 0 or 1)
	GameUtil.SetActive(imgLockGo, not hasEvolve)
end

function NaiLongEvolveLevelupView:_clearCell(cell)
	return
end

function NaiLongEvolveLevelupView:_isMaxLevel()
	local lastPosLvl = NaiLongEvolveConfig.instance:getPosLastLvl(self._activityId, self._posType)

	return lastPosLvl <= self._curLevel
end

function NaiLongEvolveLevelupView:_onClickBtnLevelUp()
	local isMaxLevel = self:_isMaxLevel()

	if isMaxLevel then
		FloatWordMgr.instance:show("已达最大等级，请升级其他部位")

		return
	end

	local matHasNum = self._info.curScore
	local data = self:_getNextLevelData()
	local levelUpCostNum = data.lvlUpCostScore

	if levelUpCostNum <= matHasNum then
		NaiLongEvolveController.instance:sendPM_MilkDragonClgPosLvlUpReq(self._activityId, self._posType)
	else
		FloatWordMgr.instance:show("技能点不足")
	end
end

function NaiLongEvolveLevelupView:_getNextLevelData()
	for idx, data in ipairs(self._typePosCfg) do
		if self._curLevel + 1 == data.posLvl then
			return data
		end
	end

	return self._typePosCfg and self._typePosCfg[#self._typePosCfg]
end

function NaiLongEvolveLevelupView:_onPosLvlRes()
	FloatWordMgr.instance:show("成功升级")
	self:_update()
end

function NaiLongEvolveLevelupView:_onClickBtnGoldBar()
	local scoreIcon = self._actCfg.scoreIcon
	local arr = string.split(scoreIcon, ":")

	CommonTipsMgr.instance:openMaterialTips(self._btnGoldBar, checknumber(arr[1]), checknumber(arr[2]), checknumber(self._info.curScore))
end

function NaiLongEvolveLevelupView:_onClickBtnCancel()
	FloatWordMgr.instance:show("已达最大等级，请升级其他部位")
end

return NaiLongEvolveLevelupView
