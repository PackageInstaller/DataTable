-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/view/FamilyTechUpgradeView.lua

module("logic.extensions.familytech.view.FamilyTechUpgradeView", package.seeall)

local FamilyTechUpgradeView = class("FamilyTechUpgradeView", ViewComponent)

function FamilyTechUpgradeView:unbindEvents()
	FamilyTechUpgradeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
end

function FamilyTechUpgradeView:bindEvents()
	FamilyTechUpgradeView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
end

function FamilyTechUpgradeView:onExit()
	FamilyTechUpgradeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyTechUpgradeSuccess, self._onTechUpgrade, self)
	GlobalDispatcher:removeListener(GlobalNotify.SweepUpdate, self._onSweepUpdate, self)
end

function FamilyTechUpgradeView:buildUI()
	FamilyTechUpgradeView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	local info = self:getGo("info")

	self._txtName = goutil.findChildTextComponent(info, "txtName")
	self._txtLevel = goutil.findChildTextComponent(info, "txtLevel")
	self._txtDesc = goutil.findChildTextComponent(info, "txtDesc")
	self._now = goutil.findChild(info, "layout/now")
	self._after = goutil.findChild(info, "layout/after")
	self._txtNowDesc = goutil.findChildTextComponent(self._now, "txtDesc")
	self._txtAfterDesc = goutil.findChildTextComponent(self._after, "txtDesc")

	local levelup = self:getGo("levelup")

	self._txtCurLv = goutil.findChildTextComponent(levelup, "lv/txt_lv")
	self._coins = goutil.findChild(levelup, "items")
	self._itemGrid = goutil.findChild(levelup, "ItemGird")
	self._btnUpgrade = self:getBtn("levelup/btnUpgrade")
	self._btnSweep = self:getBtn("levelup/btnSweep")
	self._stateMax = self:getGo("stateMax")
	self._levelup = levelup
end

function FamilyTechUpgradeView:onEnter()
	FamilyTechUpgradeView.super.onEnter(self)

	self._techId = checknumber(self:getFirstParam())

	self:_updateUI()
	GlobalDispatcher:addListener(GlobalNotify.FamilyTechUpgradeSuccess, self._onTechUpgrade, self)
	GlobalDispatcher:addListener(GlobalNotify.SweepUpdate, self._onSweepUpdate, self)
end

function FamilyTechUpgradeView:_onSweepUpdate()
	self:_updateUI()
end

function FamilyTechUpgradeView:_onTechUpgrade()
	self:_updateUI()
	FloatWordMgr.instance:show("升级成功")
end

function FamilyTechUpgradeView:_updateUI()
	local cfg = FamilyTechConfig.instance:getFamilyTechCfg(self._techId)
	local curLv = FamilyTechModel.instance:getTechLevel(self._techId)
	local curLvCfg = FamilyTechConfig.instance:getFamilyTechLvCfg(self._techId, curLv)
	local nextLvCfg = FamilyTechConfig.instance:getFamilyTechLvCfg(self._techId, curLv + 1)

	self._txtName.text = cfg.name
	self._txtDesc.text = cfg.desc
	self._txtLevel.text = string.format("<color=#20B376FF>%s</color>级", curLv)
	self._txtNowDesc.text = curLvCfg.desc

	local isMax = nextLvCfg == nil

	self._stateMax:SetActive(isMax)
	self._levelup:SetActive(not isMax)
	self._after:SetActive(not isMax)

	if not isMax then
		self._txtAfterDesc.text = nextLvCfg.desc
		self._familyLevelLimit = nextLvCfg.familyLevelLimit

		local upgradeCost = string.split(curLvCfg.upgradeCost, "#")
		local coinCost = upgradeCost[#upgradeCost]

		table.remove(upgradeCost, #upgradeCost)

		self._isEnough = true
		self._curMatarialCost = ""

		self._btnSweep.gameObject:SetActive(true)
		GameUtil.updateCellsWithCreate(self._itemGrid, upgradeCost, self._updateItem, self)

		if self._isEnough then
			self._btnSweep.gameObject:SetActive(false)
		end

		GameUtil.updateCellsWithCreate(self._coins, {
			coinCost
		}, self._updateCoin, self)
	end
end

function FamilyTechUpgradeView:_updateItem(go, cfgStr)
	local matType, matId, matNum = unpack(string.splitToNumber(cfgStr, ":"))
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local itemPoint = goutil.findChild(go, "itemPoint")
	local imgAdd = goutil.findChild(go, "img_add")
	local proxy = MaterialMgr.setCellByCfg(string.format("%s:%s:0", matType, matId), itemPoint)
	local curNum = MaterialFacade.instance:getMatNumber(matType, matId)
	local isEnough = matNum <= curNum
	local color = isEnough and "0068B7FF" or "ff0000"

	txtNum.text = string.format("<color=#%s>%s</color>/%s", color, curNum, matNum)

	if proxy then
		proxy:setAutoTips(false)
		proxy.binder:setCallBack(function()
			MaterialMgr.openGetSource(matType, matId)
		end)
	end

	self._isEnough = self._isEnough and isEnough

	goutil.setActive(imgAdd, not isEnough)

	self._curMatarialCost = string.nilorempty(self._curMatarialCost) and cfgStr or self._curMatarialCost .. "#" .. cfgStr

	if not PlotCopyModel.instance:isOneWaySweepExistAtLeast(matType, matId) then
		self._btnSweep.gameObject:SetActive(false)
	end
end

function FamilyTechUpgradeView:_updateCoin(go, cfgStr)
	local txtNum = goutil.findChildTextComponent(go, "num")
	local icon = goutil.findChild(go, "icon")
	local matType, matId, matNum = unpack(string.splitToNumber(cfgStr, ":"))

	MaterialMgr.setIcon(icon, matType, matId)

	txtNum.text = matNum

	local isEnough = MaterialModel.instance:IsEnough(matType, matId, matNum)

	self._isEnough = self._isEnough and isEnough

	if not isEnough then
		txtNum.text = string.format("<color=#eb4642>%s</color>", txtNum.text)
	end
end

function FamilyTechUpgradeView:_onClickUpgrade()
	local familyLv = FamilyController.instance:getFamilyLv()

	if familyLv < self._familyLevelLimit then
		FloatWordMgr.instance:show(lang("family_tech_family_lv_limited"))
	elseif not self._isEnough then
		FloatWordMgr.instance:show("升级道具不足")
	else
		FamilyTechController.instance:reqUpgradeTech(self._techId)
	end
end

function FamilyTechUpgradeView:_onClickSweep()
	if not string.nilorempty(self._curMatarialCost) then
		MopupModel.instance:clickOneKeySweep(self._curMatarialCost)
	end
end

return FamilyTechUpgradeView
