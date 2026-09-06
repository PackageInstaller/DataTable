-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeUpgradeView.lua

module("logic.extensions.luyngarde.view.LuyngardeUpgradeView", package.seeall)

local LuyngardeUpgradeView = class("LuyngardeUpgradeView", ViewComponent)

function LuyngardeUpgradeView:ctor()
	LuyngardeUpgradeView.super.ctor(self)
end

function LuyngardeUpgradeView:unbindEvents()
	LuyngardeUpgradeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHide)

	for i, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell.btn)
		GameUtil.rmClickHandler(cell.btnShow)
	end
end

function LuyngardeUpgradeView:bindEvents()
	LuyngardeUpgradeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHideInfo, self)

	for i, cell in ipairs(self._cellList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickUpgrade, self, i))
		GameUtil.addClickHandler(cell.btnShow, GameUtil.handler(self._onClickShowInfo, self, i))
	end
end

function LuyngardeUpgradeView:buildUI()
	LuyngardeUpgradeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._cellList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("com/cell" .. i)
		cell.cost = goutil.findChild(cell.go, "cost")
		cell.txtNum = goutil.findChildTextComponent(cell.go, "cost/txtNum")
		cell.icon = goutil.findChild(cell.go, "cost/icon")
		cell.btn = goutil.findChild(cell.go, "cost/btn")
		cell.btnShow = goutil.findChild(cell.go, "btnShow")
		cell.showInfo = goutil.findChild(cell.go, "showInfo")

		GameUtil.SetActive(cell.showInfo, false)

		self._cellList[i] = cell
	end

	self._btnHide = self:getGo("btnHide")

	GameUtil.SetActive(self._btnHide, false)

	self._slider = self:getSlider("slider")
	self._goldBarCon = self:getGo("goldBarCon")
end

function LuyngardeUpgradeView:onExit()
	LuyngardeUpgradeView.super.onExit(self)

	for i, cell in ipairs(self._cellList) do
		MaterialMgr.resetAll(cell.icon)
	end
end

function LuyngardeUpgradeView:onEnter()
	LuyngardeUpgradeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.LuyngardeUpgradePet, self._updateList, self)

	self._activityId = checknumber(self:getFirstParam())
	self._actCfg = LuyngardeConfig.instance:getActCfg(self._activityId)
	self._upgradeCfgs = LuyngardeConfig.instance:getPetUpgradeCfgs(self._activityId)

	local showItemStr = ""

	for i, cell in ipairs(self._cellList) do
		local cfg = self._upgradeCfgs[i]
		local matType, cfgId, matNum = MaterialMgr.getMatParams(cfg.cost)

		MaterialMgr.setIcon(cell.icon, matType, cfgId)

		cell.txtNum.text = matNum

		if i == 2 and GameUtil.isEmptyString(showItemStr) then
			showItemStr = matType .. ":" .. cfgId
		end
	end

	self:_updateList()

	if not GameUtil.isEmptyString(showItemStr) then
		local objList = {
			{
				showAdd = false,
				id = showItemStr
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	end
end

function LuyngardeUpgradeView:_updateList()
	local baseInfo = LuyngardeModel.instance:getBaseInfoByActId(self._activityId)

	self._curLevel = baseInfo.level

	for i, cell in ipairs(self._cellList) do
		GameUtil.SetActive(cell.cost, i > self._curLevel)
	end

	self._slider:SetValue((self._curLevel - 1) / (#self._cellList - 1))
end

function LuyngardeUpgradeView:_onClickUpgrade(id)
	local cfg = self._upgradeCfgs[id]
	local costStr = cfg.cost

	if MaterialMgr.getMatEnough(costStr) then
		LuyngardeController.instance:upgradePet(self._activityId)
	else
		local matName = MaterialMgr.getMaterialsNameByCfg(costStr)

		FloatWordMgr.instance:show(string.format("%s不足，去章节-魔龙之心/终湮神临获得更多吧!", matName))
	end
end

function LuyngardeUpgradeView:_onClickShowInfo(id)
	GameUtil.SetActive(self._btnHide, true)
	GameUtil.SetActive(self._cellList[id].showInfo, true)
end

function LuyngardeUpgradeView:_onClickHideInfo()
	GameUtil.SetActive(self._btnHide, false)

	for i, cell in ipairs(self._cellList) do
		GameUtil.SetActive(cell.showInfo, false)
	end
end

return LuyngardeUpgradeView
