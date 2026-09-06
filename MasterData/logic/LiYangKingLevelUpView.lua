-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingLevelUpView.lua

module("logic.extensions.liyangking.view.LiYangKingLevelUpView", package.seeall)

local LiYangKingLevelUpView = class("LiYangKingLevelUpView", ViewComponent)

function LiYangKingLevelUpView:ctor()
	LiYangKingLevelUpView.super.ctor(self)
end

function LiYangKingLevelUpView:unbindEvents()
	LiYangKingLevelUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._goldBar)
end

function LiYangKingLevelUpView:bindEvents()
	LiYangKingLevelUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._goldBar, self._onClickBtnGoldBar, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickBtnLevelUp, self)
end

function LiYangKingLevelUpView:buildUI()
	LiYangKingLevelUpView.super.buildUI(self)

	self._goldBarItem = self:getGo("goldBar/item")
	self._goldBar = self:getGo("goldBar")
	self._txtNum = self:getTxt("goldBar/txtNum")
	self._imgArrow = self:getGo("imgArrow")
	self._after = self:getGo("after")
	self._pre = self:getGo("pre")
	self._imgPreChangeComp = self:getGo("pre/imgPre"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgAfterChangeComp = self:getGo("after/imgAfter"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgPreTypeChangeComp = self:getGo("pre/imgPre/type/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgAfterTypeChangeComp = self:getGo("after/imgAfter/type/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtPre = self:getTxt("pre/txtPre")
	self._txtAfter = self:getTxt("after/txtAfter")
	self._txtCost = self:getTxt("txtCost")
	self._imgCost = self:getGo("img")
	self._max = self:getGo("max")
	self._imgMaxChangeComp = self:getGo("max/imgMax"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgMaxTypeChangeComp = self:getGo("max/imgMax/type/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtMax = self:getTxt("max/txtMax")
	self._btnClose = self:getGo("btnClose")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._txtBtnLevelUp = self:getTxt("btnLevelUp/txt")
end

function LiYangKingLevelUpView:onExit()
	LiYangKingLevelUpView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgCost)
	MaterialMgr.clearIcon(self._goldBarItem)
end

function LiYangKingLevelUpView:onEnter()
	LiYangKingLevelUpView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangUpgradeBuildingRes, self._onUpgradeBuildingRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1]) == 0 and 509001 or checknumber(params[1])
	self._buildId = checknumber(params[2])
	self._info = LiYangKingModel.instance:getInfo(self._activityId)
	self._actCfg = LiYangKingConfig.instance:getActCfg(self._activityId)
	self._buildLevelCfgs = LiYangKingConfig.instance:getBuildingLevelCfgsByBuildingId(self._activityId, self._buildId)
	self._buildingsMap = self._info.buildingsMap
	self._buildInfo = self._buildingsMap[self._buildId]
	self._buildCfg = LiYangKingConfig.instance:getBuildingCfgByBuildingId(self._activityId, self._buildId)
	self._curLevelCfg = self._buildLevelCfgs[self._buildInfo.level]

	local maxLevel = #self._buildLevelCfgs

	self._nextLevel = math.min(self._buildInfo.level + 1, maxLevel)
	self._nextLevelCfg = self._buildLevelCfgs[self._nextLevel]

	self:_onUpdateUI()
end

function LiYangKingLevelUpView:_onUpdateUI()
	local maxLevel = #self._buildLevelCfgs
	local curIsMaxLevel = maxLevel == self._buildInfo.level
	local itemId = self._actCfg.itemId
	local matName = MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, itemId)

	if curIsMaxLevel then
		self._txtMax.text = string.format("已达%d级", self._buildInfo.level, self._curLevelCfg.efficiency, matName)

		self._imgMaxChangeComp:SetState(self._buildInfo.level)
		self._imgMaxTypeChangeComp:SetState(self._buildId)
	else
		self._txtPre.text = string.format("当前%d级\n每次可获得<color=#ff5353>%d</color>%s", self._buildInfo.level, self._curLevelCfg.efficiency, matName)
		self._txtAfter.text = string.format("升级后%d级\n每次可获得<color=#ff5353>%d</color>%s", self._nextLevel, self._nextLevelCfg.efficiency, matName)

		MaterialMgr.setIcon(self._imgCost, MatType.ACTIVITY_ITEM, itemId, nil, nil)
		self._imgPreChangeComp:SetState(self._buildInfo.level)
		self._imgAfterChangeComp:SetState(self._nextLevel)
		self._imgPreTypeChangeComp:SetState(self._buildId)
		self._imgAfterTypeChangeComp:SetState(self._buildId)

		local cost = self._nextLevelCfg.cost
		local hasScoreNum = checknumber(self._info.curScore)

		GameUtil.SetGray(self._btnLevelUp, hasScoreNum < cost)
	end

	self._txtCost.text = self._nextLevelCfg.cost
	self._txtNum.text = self._info.curScore

	GameUtil.SetActive(self._pre, not curIsMaxLevel)
	GameUtil.SetActive(self._after, not curIsMaxLevel)
	GameUtil.SetActive(self._imgArrow, not curIsMaxLevel)
	GameUtil.SetActive(self._imgCost, not curIsMaxLevel)
	GameUtil.SetActive(self._txtCost.gameObject, not curIsMaxLevel)
	GameUtil.SetActive(self._max, curIsMaxLevel)
	GameUtil.SetGray(self._btnLevelUp, curIsMaxLevel)
	MaterialMgr.setIcon(self._goldBarItem, MatType.ACTIVITY_ITEM, itemId)

	self._txtBtnLevelUp.text = curIsMaxLevel and "已满级" or "升级"
end

function LiYangKingLevelUpView:_onClickBtnLevelUp()
	local cost = self._nextLevelCfg.cost
	local hasScoreNum = checknumber(self._info.curScore)
	local matName = MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, self._actCfg.itemId)
	local maxLevel = #self._buildLevelCfgs
	local curIsMaxLevel = maxLevel == self._buildInfo.level

	if curIsMaxLevel then
		FloatWordMgr.instance:show("已满级")

		return
	end

	if hasScoreNum < cost then
		FloatWordMgr.instance:show(string.format("%s不足", matName))

		return
	end

	LiYangKingController.instance:sendPM_PrinceLiyangUpgradeBuildingReq(self._activityId, self._buildId)
end

function LiYangKingLevelUpView:_onUpgradeBuildingRes()
	FloatWordMgr.instance:show("升级成功！")

	self._info = LiYangKingModel.instance:getInfo(self._activityId)
	self._actCfg = LiYangKingConfig.instance:getActCfg(self._activityId)
	self._buildLevelCfgs = LiYangKingConfig.instance:getBuildingLevelCfgsByBuildingId(self._activityId, self._buildId)
	self._buildingsMap = self._info.buildingsMap
	self._buildInfo = self._buildingsMap[self._buildId]
	self._buildCfg = LiYangKingConfig.instance:getBuildingCfgByBuildingId(self._activityId, self._buildId)
	self._curLevelCfg = self._buildLevelCfgs[self._buildInfo.level]

	local maxLevel = #self._buildLevelCfgs

	self._nextLevel = math.min(self._buildInfo.level + 1, maxLevel)
	self._nextLevelCfg = self._buildLevelCfgs[self._nextLevel]

	self:_onUpdateUI()
end

function LiYangKingLevelUpView:_onClickBtnGoldBar()
	CommonTipsMgr.instance:openMaterialTips(self._goldBar, MatType.ACTIVITY_ITEM, self._actCfg.itemId)
end

return LiYangKingLevelUpView
