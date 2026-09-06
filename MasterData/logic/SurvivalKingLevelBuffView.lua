-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingLevelBuffView.lua

module("logic.extensions.survivalking.view.SurvivalKingLevelBuffView", package.seeall)

local SurvivalKingLevelBuffView = class("SurvivalKingLevelBuffView", ViewComponent)

function SurvivalKingLevelBuffView:ctor()
	SurvivalKingLevelBuffView.super.ctor(self)
end

function SurvivalKingLevelBuffView:unbindEvents()
	SurvivalKingLevelBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUpgrade)
	GameUtil.rmClickHandler(self._btnAdd)
end

function SurvivalKingLevelBuffView:bindEvents()
	SurvivalKingLevelBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnUpgrade, self._onClickUpgrade, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
end

function SurvivalKingLevelBuffView:buildUI()
	SurvivalKingLevelBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnUpgrade = self:getGo("btnUpgrade")
	self._txtUpgrade = self:getTxt("btnUpgrade/txt")
	self._txtCost = self:getTxt("btnUpgrade/goCost/txtCost")
	self._goUpgradeRedPoint = self:getGo("btnUpgrade/redPoint")
	self._goUpgradeCost = self:getGo("btnUpgrade/goCost")
	self._goUpgradeIcon = self:getGo("btnUpgrade/goCost/icon")
	self._goUpgradeCostIcon = self:getGo("imgCurrentBalance/icon")
	self._goImgCurrentBalance = self:getGo("imgCurrentBalance")
	self._btnAdd = self:getGo("imgCurrentBalance/btnAdd")
	self._txtCurrentLevel = self:getTxt("imgCurrentLevel/txtCurrentLevel")
	self._txtCurrentBalance = self:getTxt("imgCurrentBalance/txtCurrentLevel")

	local goTab = self:getGo("tableView")
	local goCell = self:getGo("tableView/cell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SurvivalKingLevelBuffView:onExit()
	SurvivalKingLevelBuffView.super.onExit(self)
	self._tableView:dispose()
	MaterialMgr.clearIcon(self._goUpgradeIcon)
	MaterialMgr.clearIcon(self._goUpgradeCostIcon)
end

function SurvivalKingLevelBuffView:onEnter()
	SurvivalKingLevelBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingUpdatePresetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGetBaseInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._updateUIByInfo, self)

	self._activityId = 529002
	self._curRound = 1

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
		self._curRound = checknumber(params[2]) or 1
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SurvivalKingController.instance:sendGetPresetInfo(self._activityId)
	SurvivalKingController.instance:getBaseInfo(self._activityId)
end

function SurvivalKingLevelBuffView:_updateUIByCfg()
	self._levelBuffIds = {}

	local levelBuffCfgMap = SurvivalKingConfig.instance:getAllLevelBuffCfgs(self._activityId) or {}

	for buffId, levelCfgs in pairs(levelBuffCfgMap) do
		if levelCfgs and next(levelCfgs) then
			table.insert(self._levelBuffIds, buffId)
		end
	end

	table.sort(self._levelBuffIds, function(a, b)
		return a < b
	end)
end

function SurvivalKingLevelBuffView:_updateUIByInfo()
	self._curLevel = SurvivalKingModel.instance:getLevelBuffLevel(self._activityId)
	self._curBuffId = SurvivalKingModel.instance:getLevelBuffId(self._activityId, self._curRound) or 0

	self:_refreshLevelInfo()
	self:_refreshCostInfo()
	self._tableView:reloadData(self._levelBuffIds)
end

function SurvivalKingLevelBuffView:_refreshLevelInfo()
	self._txtCurrentLevel.text = langPara("当前增益等级： <color=#00e5a3>LV%s</color>", self._curLevel)
end

function SurvivalKingLevelBuffView:_refreshCostInfo()
	local upgradeInfo = SurvivalKingController.instance:getLevelBuffUpgradeInfo(self._activityId)

	if upgradeInfo.isMaxLevel then
		self._txtUpgrade.text = lang("已满级")

		GameUtil.SetActive(self._goUpgradeRedPoint, false)
		GameUtil.SetActive(self._goImgCurrentBalance, false)
		GameUtil.SetActive(self._goUpgradeCost, false)

		return
	end

	self._txtUpgrade.text = lang("升级")

	GameUtil.SetActive(self._goImgCurrentBalance, true)
	GameUtil.SetActive(self._goUpgradeCost, true)

	if not upgradeInfo.costMatType or not upgradeInfo.costMatId or upgradeInfo.costMatNum <= 0 then
		return
	end

	self._costMatType = upgradeInfo.costMatType
	self._costMatId = upgradeInfo.costMatId
	self._costMatNum = upgradeInfo.costMatNum
	self._costHasNum = upgradeInfo.costHasNum

	local color = self._costHasNum >= self._costMatNum and "20DBA1" or "FF5F5F"

	self._txtCost.text = langPara("<color=#%s>%s</color>/%s", color, self._costHasNum, self._costMatNum)
	self._txtCurrentBalance.text = tostring(self._costHasNum)

	MaterialMgr.setIcon(self._goUpgradeIcon, self._costMatType, self._costMatId)
	MaterialMgr.setIcon(self._goUpgradeCostIcon, self._costMatType, self._costMatId)
	GameUtil.SetActive(self._goUpgradeRedPoint, upgradeInfo.canUpgrade)
end

function SurvivalKingLevelBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "imgName/txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtHaveCount = goutil.findChildTextComponent(go, "imgHaveCount/txtHaveCount")
	local mark = goutil.findChild(go, "mark")
	local item = goutil.findChild(go, "item")
	local buffId = checknumber(data)
	local levelCfg = SurvivalKingConfig.instance:getLevelBuffCfg(self._activityId, buffId, self._curLevel)

	if levelCfg then
		txtName.text = levelCfg.name or ""
	end

	if levelCfg then
		txtDesc.text = levelCfg.desc or ""
	end

	txtHaveCount.text = langPara("等级：Lv%s", self._curLevel)

	GameUtil.SetActive(mark, self._curBuffId == buffId)

	local iconUrl = levelCfg and levelCfg.iconUrl

	if not string.nilorempty(iconUrl) then
		local iconPath = string.format("%s.png", iconUrl)

		uGuiUtil.setSpriteToImage(item, uGuiUtil.SpriteType.BigBg, iconPath)
	end

	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickSelect, self, buffId))
end

function SurvivalKingLevelBuffView:_clearCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	GameUtil.rmClickHandler(go)
	uGuiUtil.clearImage(item)
end

function SurvivalKingLevelBuffView:_onClickSelect(buffId)
	local newBuffId = self._curBuffId == buffId and 0 or buffId

	SurvivalKingController.instance:saveLevelBuffId(self._activityId, newBuffId, self._curRound)
end

function SurvivalKingLevelBuffView:_onClickUpgrade()
	local upgradeInfo = SurvivalKingController.instance:getLevelBuffUpgradeInfo(self._activityId)

	if upgradeInfo.isMaxLevel then
		TipsFacade.instance:openCommonTips(lang("已达最高等级"))

		return
	end

	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips(lang("仅可在报名时间且无进行中场次时升级！"))

		return
	end

	if self._costHasNum < self._costMatNum then
		TipsFacade.instance:openCommonTips(lang("数量不足，无法升级"))

		return
	end

	local matName = MaterialMgr.getMaterialsName(self._costMatType, self._costMatId) or ""
	local nextLevel = self._curLevel + 1
	local content = langPara("确定消耗%s×%s升级所有祝福等级吗？\n当前等级：<color=#ff3b30>LV%s</color>\n升级后：<color=#ff3b30>LV%s</color>", matName, self._costMatNum, self._curLevel, nextLevel)

	TipsFacade.instance:openPopupCostMatViewNew(self._costMatType, self._costMatId, self._costMatNum, content, function()
		SurvivalKingController.instance:upgradeLevelBuff(self._activityId)
	end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function SurvivalKingLevelBuffView:_onClickAdd()
	if self._costMatType and self._costMatId then
		MaterialMgr.openGetSource(self._costMatType, self._costMatId)
	end
end

return SurvivalKingLevelBuffView
