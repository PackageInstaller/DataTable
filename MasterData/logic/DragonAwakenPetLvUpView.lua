-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenPetLvUpView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenPetLvUpView", package.seeall)

local DragonAwakenPetLvUpView = class("DragonAwakenPetLvUpView", ViewComponent)

function DragonAwakenPetLvUpView:ctor()
	DragonAwakenPetLvUpView.super.ctor(self)
end

function DragonAwakenPetLvUpView:unbindEvents()
	DragonAwakenPetLvUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btn1)
	GameUtil.rmClickHandler(self._btn2)
	GameUtil.rmClickHandler(self._btn3)
	GameUtil.rmClickHandler(self._btn4)
	GameUtil.rmClickHandler(self._btn5)
end

function DragonAwakenPetLvUpView:bindEvents()
	DragonAwakenPetLvUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btn1, self._onClickEquip, self)
	GameUtil.addClickHandler(self._btn2, self._onClickLevel, self)
	GameUtil.addClickHandler(self._btn3, self._onClickSuit, self)
	GameUtil.addClickHandler(self._btn4, self._onClickStarGod, self)
	GameUtil.addClickHandler(self._btn5, self._onClickAwake, self)
end

function DragonAwakenPetLvUpView:buildUI()
	DragonAwakenPetLvUpView.super.buildUI(self)

	self._goldBarCon = self:getGo("goldBarCon")
	self._starShow = self:getGo("cell_1/starShow")
	self._equipStarList = GameUtil.getChildren(self._starShow)
	self._btn1 = self:getGo("cell_1/btn")
	self._txtLvl2 = self:getTxt("cell_2/txtLvl")
	self._btn2 = self:getGo("cell_2/btn")
	self._txtLvl3 = self:getTxt("cell_3/txtLvl")
	self._btn3 = self:getGo("cell_3/btn")
	self._txtLvl4 = self:getTxt("cell_4/txtLvl")
	self._btn4 = self:getGo("cell_4/btn")
	self._txtLvl5 = self:getTxt("cell_5/txtLvl")
	self._btn5 = self:getGo("cell_5/btn")
	self._txt1 = self:getTxt("cell_1/btn/txt")
	self._txt2 = self:getTxt("cell_2/btn/txt")
	self._txt3 = self:getTxt("cell_3/btn/txt")
	self._txt4 = self:getTxt("cell_4/btn/txt")
	self._txt5 = self:getTxt("cell_5/btn/txt")
	self._txtCost1 = self:getTxt("cell_1/txtCost")
	self._txtCost2 = self:getTxt("cell_2/txtCost")
	self._txtCost3 = self:getTxt("cell_3/txtCost")
	self._txtCost4 = self:getTxt("cell_4/txtCost")
	self._txtCost5 = self:getTxt("cell_5/txtCost")
	self._iconCost1 = self:getGo("cell_1/txtCost/icon")
	self._iconCost2 = self:getGo("cell_2/txtCost/icon")
	self._iconCost3 = self:getGo("cell_3/txtCost/icon")
	self._iconCost4 = self:getGo("cell_4/txtCost/icon")
	self._iconCost5 = self:getGo("cell_5/txtCost/icon")
	self._txtTips1 = self:getTxt("cell_1/txtTips")
	self._txtTips3 = self:getTxt("cell_3/txtTips")
	self._txtTips4 = self:getTxt("cell_4/txtTips")
	self._txtTips5 = self:getTxt("cell_5/txtTips")
end

function DragonAwakenPetLvUpView:onExit()
	DragonAwakenPetLvUpView.super.onExit(self)
	MaterialMgr.resetAll(self._iconCost1)
	MaterialMgr.resetAll(self._iconCost2)
	MaterialMgr.resetAll(self._iconCost3)
	MaterialMgr.resetAll(self._iconCost4)
	MaterialMgr.resetAll(self._iconCost5)
end

function DragonAwakenPetLvUpView:onEnter()
	DragonAwakenPetLvUpView.super.onEnter(self)

	self._activityId = 419001

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])

	if actId > 0 then
		self._activityId = actId
	end

	self:_updateByCfg()
	self.addGEvent(self, GlobalNotify.DragonAwakenUpdateUpgradeInfo, self._updateByInfo, self)
	self:_updateByInfo()
end

function DragonAwakenPetLvUpView:_updateByCfg()
	self._actCfg = DragonAwakenConfig.instance:getActivityCfg(self._activityId)

	if self._actCfg then
		local lvUpCost = self._actCfg.lvUpCost

		if not string.nilorempty(lvUpCost) then
			local list = string.split(lvUpCost, "#")
			local objList = {}

			for i, v in ipairs(list) do
				local tem = {
					showAdd = false,
					id = v
				}

				table.insert(objList, tem)
			end

			MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
		end

		local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.equipmentOpen))

		self._txtTips1.text = string.format("等级%s级解锁", lvlCfg.lv)
		lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.holyStripeOpen))
		self._txtTips3.text = string.format("等级%s级解锁", lvlCfg.lv)
		lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.starGodPlusOpen))
		self._txtTips4.text = string.format("等级%s级解锁", lvlCfg.lv)
		lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.awakenOpen))
		self._txtTips5.text = string.format("等级%s级解锁", lvlCfg.lv)
	end
end

function DragonAwakenPetLvUpView:_updateByInfo()
	self._level = DragonAwakenModel.instance:getCurUpgradeLevelByType(self._activityId, DragonAwakenController.UpgradeType.Pet)
	self._awakenLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self._activityId, DragonAwakenController.UpgradeType.Awaken)
	self._equipmentLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self._activityId, DragonAwakenController.UpgradeType.Equip)
	self._starGodPlusLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self._activityId, DragonAwakenController.UpgradeType.StarGod)
	self._holyStripeLv = DragonAwakenModel.instance:getCurUpgradeLevelByType(self._activityId, DragonAwakenController.UpgradeType.HolyStripe)

	for i, v in ipairs(self._equipStarList) do
		GameUtil.SetGray(v, true)

		if i <= self._equipmentLv then
			GameUtil.SetGray(v, false)
		end
	end

	local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, self._level) or {}

	self._txtLvl2.text = langPara("Lv.%s", checknumber(lvlCfg.lv))
	self._txtLvl3.text = langPara("Lv.%s", self._holyStripeLv)

	local starGodCfg = DragonAwakenConfig.instance:getStarGodCfgByLv(self._activityId, self._starGodPlusLv) or {}

	self._txtLvl4.text = langPara("Lv.%s", checknumber(starGodCfg.starGodLv))
	self._txtLvl5.text = GameUtil.toRomanNumber(self._awakenLv)

	local cfg = DragonAwakenConfig.instance:getEquipCostById(self._activityId, self._equipmentLv + 1)

	GameUtil.SetGray(self._btn1, cfg == nil)

	self._txt1.text = cfg == nil and "已满级" or "升级"

	goutil.setActive(self._txtCost1.gameObject, false)
	goutil.setActive(self._txtTips1.gameObject, false)

	if cfg == nil then
		-- block empty
	elseif self._actCfg.equipmentOpen <= self._level then
		goutil.setActive(self._txtCost1.gameObject, true)
		self:_setCostData(cfg.cost, self._iconCost1, self._txtCost1)
	else
		goutil.setActive(self._txtTips1.gameObject, true)
	end

	local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, self._level + 1)

	GameUtil.SetGray(self._btn2, lvlCfg == nil)

	self._txt2.text = lvlCfg == nil and "已满级" or "升级"

	goutil.setActive(self._txtCost2.gameObject, false)

	if lvlCfg == nil then
		-- block empty
	else
		goutil.setActive(self._txtCost2.gameObject, true)
		self:_setCostData(lvlCfg.cost, self._iconCost2, self._txtCost2)
	end

	local suitCfg = DragonAwakenConfig.instance:getHolyStripeCostByLv(self._activityId, self._holyStripeLv + 1)

	GameUtil.SetGray(self._btn3, suitCfg == nil)

	self._txt3.text = suitCfg == nil and "已满级" or "升级"

	goutil.setActive(self._txtCost3.gameObject, false)
	goutil.setActive(self._txtTips3.gameObject, false)

	if suitCfg == nil then
		-- block empty
	elseif self._actCfg.holyStripeOpen <= self._level then
		goutil.setActive(self._txtCost3.gameObject, true)
		self:_setCostData(suitCfg.cost, self._iconCost3, self._txtCost3)
	else
		goutil.setActive(self._txtTips3.gameObject, true)
	end

	local starGodCfg = DragonAwakenConfig.instance:getStarGodCfgByLv(self._activityId, self._starGodPlusLv + 1)

	GameUtil.SetGray(self._btn4, starGodCfg == nil)

	self._txt4.text = starGodCfg == nil and "已满级" or "升级"

	goutil.setActive(self._txtCost4.gameObject, false)
	goutil.setActive(self._txtTips4.gameObject, false)

	if starGodCfg == nil then
		-- block empty
	elseif self._actCfg.starGodPlusOpen <= self._level then
		goutil.setActive(self._txtCost4.gameObject, true)
		self:_setCostData(starGodCfg.cost, self._iconCost4, self._txtCost4)
	else
		goutil.setActive(self._txtTips4.gameObject, true)
	end

	local awakenCfg = DragonAwakenConfig.instance:getAwakenCostCfgByLv(self._activityId, self._awakenLv + 1)

	GameUtil.SetGray(self._btn5, awakenCfg == nil)

	self._txt5.text = awakenCfg == nil and "已满级" or "升级"

	if awakenCfg == nil then
		goutil.setActive(self._txtCost5.gameObject, false)
	else
		goutil.setActive(self._txtCost5.gameObject, true)
		self:_setCostData(awakenCfg.cost, self._iconCost5, self._txtCost5)
	end

	goutil.setActive(self._txtCost5.gameObject, false)
	goutil.setActive(self._txtTips5.gameObject, false)

	if awakenCfg == nil then
		-- block empty
	elseif self._actCfg.awakenOpen <= self._level then
		goutil.setActive(self._txtCost5.gameObject, true)
		self:_setCostData(awakenCfg.cost, self._iconCost5, self._txtCost5)
	else
		goutil.setActive(self._txtTips5.gameObject, true)
	end
end

function DragonAwakenPetLvUpView:_setCostData(costStr, iconGo, text)
	local type, id, num = MaterialMgr.getMatParams(costStr)

	MaterialMgr.setIcon(iconGo, type, id)

	text.text = num
end

function DragonAwakenPetLvUpView:_onClickEquip()
	if self._level < checknumber(self._actCfg.equipmentOpen) then
		local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.equipmentOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = DragonAwakenConfig.instance:getEquipCostById(self._activityId, self._equipmentLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将装备升级到Lv.%s吗？", iconStr, num, cfg.level)

		self:_checkAndCall(type, id, num, content, function()
			DragonAwakenController.instance:upgradeReq(self._activityId, DragonAwakenController.UpgradeType.Equip)
		end, DragonAwakenController.UpgradeType.Equip)
	end
end

function DragonAwakenPetLvUpView:_onClickLevel()
	local cfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, self._level + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将公共等级升级到Lv.%s吗？", iconStr, num, cfg.lv)

		self:_checkAndCall(type, id, num, content, function()
			DragonAwakenController.instance:upgradeReq(self._activityId, DragonAwakenController.UpgradeType.Pet)
		end, DragonAwakenController.UpgradeType.Pet)
	end
end

function DragonAwakenPetLvUpView:_onClickSuit()
	if self._level < checknumber(self._actCfg.holyStripeOpen) then
		local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.holyStripeOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = DragonAwakenConfig.instance:getHolyStripeCostByLv(self._activityId, self._holyStripeLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将灵纹升级到Lv.%s吗？", iconStr, num, cfg.level)

		self:_checkAndCall(type, id, num, content, function()
			DragonAwakenController.instance:upgradeReq(self._activityId, DragonAwakenController.UpgradeType.HolyStripe)
		end, DragonAwakenController.UpgradeType.HolyStripe)
	end
end

function DragonAwakenPetLvUpView:_onClickStarGod()
	if self._level < checknumber(self._actCfg.starGodPlusOpen) then
		local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.starGodPlusOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = DragonAwakenConfig.instance:getStarGodCfgByLv(self._activityId, self._starGodPlusLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将星神升级到Lv.%s吗？", iconStr, num, cfg.starGodLv)

		self:_checkAndCall(type, id, num, content, function()
			DragonAwakenController.instance:upgradeReq(self._activityId, DragonAwakenController.UpgradeType.StarGod)
		end, DragonAwakenController.UpgradeType.StarGod)
	end
end

function DragonAwakenPetLvUpView:_onClickAwake()
	if self._level < checknumber(self._actCfg.awakenOpen) then
		local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(self._activityId, checknumber(self._actCfg.awakenOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = DragonAwakenConfig.instance:getAwakenCostCfgByLv(self._activityId, self._awakenLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将觉醒等级升级到觉醒%s吗？", iconStr, num, GameUtil.toRomanNumber(cfg.level))

		self:_checkAndCall(type, id, num, content, function()
			DragonAwakenController.instance:upgradeReq(self._activityId, DragonAwakenController.UpgradeType.Awaken)
		end, DragonAwakenController.UpgradeType.Awaken)
	end
end

function DragonAwakenPetLvUpView:_checkAndCall(type, id, num, content, callBack, myKey)
	local key = "DragonAwakenPetLvUpView_" .. myKey

	TipsFacade.instance:openPopupCostMatViewWithToggleKey(type, id, num, content, callBack, key)
end

return DragonAwakenPetLvUpView
