-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadpetlvlupView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadpetlvlupView", package.seeall)

local ChuangjingroadpetlvlupView = class("ChuangjingroadpetlvlupView", ViewComponent)

function ChuangjingroadpetlvlupView:ctor()
	ChuangjingroadpetlvlupView.super.ctor(self)
end

function ChuangjingroadpetlvlupView:unbindEvents()
	ChuangjingroadpetlvlupView.super.unbindEvents(self)
end

function ChuangjingroadpetlvlupView:bindEvents()
	ChuangjingroadpetlvlupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btn1, self._onClickEquip, self)
	GameUtil.addClickHandler(self._btn2, self._onClickLevel, self)
	GameUtil.addClickHandler(self._btn3, self._onClickSuit, self)
	GameUtil.addClickHandler(self._btn4, self._onClickStarGod, self)
	GameUtil.addClickHandler(self._btn5, self._onClickAwake, self)
end

function ChuangjingroadpetlvlupView:buildUI()
	ChuangjingroadpetlvlupView.super.buildUI(self)

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
end

function ChuangjingroadpetlvlupView:onExit()
	ChuangjingroadpetlvlupView.super.onExit(self)
end

function ChuangjingroadpetlvlupView:onEnter()
	ChuangjingroadpetlvlupView.super.onEnter(self)

	self._activityId = 396001

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])

	if actId > 0 then
		self._activityId = actId
	end

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetPetInfo(self._activityId)
	self:_onRefershUI()

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId)

	if cfg and not string.nilorempty(cfg.lvlupCost) then
		local list = string.split(cfg.lvlupCost, "#")
		local objList = {}

		for i, v in ipairs(list) do
			local tem = {
				showAdd = true,
				id = v
			}

			table.insert(objList, tem)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	end
end

function ChuangjingroadpetlvlupView:_onRefershUI()
	local info = ChuangJingRoadModel.instance:getPetInfo(self._activityId) or {}

	self._unlockCreepIds = info.unlockCreepIds or {}
	self._level = checknumber(info.level)
	self._awakenLv = checknumber(info.awakenLv)
	self._equipmentLv = checknumber(info.equipmentLv)
	self._starGodPlusLv = checknumber(info.starGodPlusLv)
	self._holyStripeLv = checknumber(info.holyStripeLv)

	for i, v in ipairs(self._equipStarList) do
		GameUtil.SetGray(v, true)

		if i <= self._equipmentLv then
			GameUtil.SetGray(v, false)
		end
	end

	local lvlCfg = ChuangJingRoadConfig.instance:getLevelCostById(self._activityId, self._level) or {}

	self._txtLvl2.text = langPara("Lv.%s", checknumber(lvlCfg.lv))
	self._txtLvl3.text = langPara("Lv.%s", self._holyStripeLv)

	local starGodCfg = ChuangJingRoadConfig.instance:getStarGodCostById(self._activityId, self._starGodPlusLv) or {}

	self._txtLvl4.text = langPara("Lv.%s", checknumber(starGodCfg.starGodLv))
	self._txtLvl5.text = GameUtil.toRomanNumber(self._awakenLv)

	local cfg = ChuangJingRoadConfig.instance:getEquipCostById(self._activityId, self._equipmentLv + 1)

	GameUtil.SetGray(self._btn1, cfg == nil)

	self._txt1.text = cfg == nil and "已满级" or "升级"

	local lvlCfg = ChuangJingRoadConfig.instance:getLevelCostById(self._activityId, self._level + 1)

	GameUtil.SetGray(self._btn2, lvlCfg == nil)

	self._txt2.text = lvlCfg == nil and "已满级" or "升级"

	local suitCfg = ChuangJingRoadConfig.instance:getHolyStripeCostById(self._activityId, self._holyStripeLv + 1)

	GameUtil.SetGray(self._btn3, suitCfg == nil)

	self._txt3.text = suitCfg == nil and "已满级" or "升级"

	local starGodCfg = ChuangJingRoadConfig.instance:getStarGodCostById(self._activityId, self._starGodPlusLv + 1)

	GameUtil.SetGray(self._btn4, starGodCfg == nil)

	self._txt4.text = starGodCfg == nil and "已满级" or "升级"

	local awakenCfg = ChuangJingRoadConfig.instance:getAwakenCostById(self._activityId, self._awakenLv + 1)

	GameUtil.SetGray(self._btn5, awakenCfg == nil)

	self._txt5.text = awakenCfg == nil and "已满级" or "升级"
end

function ChuangjingroadpetlvlupView:_onClickEquip()
	if #self._unlockCreepIds == 0 then
		TipsFacade.instance:openCommonTips("请先招募精灵")

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId) or {}

	if self._level < checknumber(cfg.equipmentOpen) then
		local lvlCfg = ChuangJingRoadConfig.instance:getLevelCostById(self._activityId, checknumber(cfg.equipmentOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getEquipCostById(self._activityId, self._equipmentLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将装备升级到Lv.%s吗？", iconStr, num, cfg.level)

		self:_checkAndCall(type, id, num, content, function()
			ChuangJingRoadController.instance:sendEquipLvlUp(self._activityId)
		end, 1)
	end
end

function ChuangjingroadpetlvlupView:_onClickLevel()
	if #self._unlockCreepIds == 0 then
		TipsFacade.instance:openCommonTips("请先招募精灵")

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getLevelCostById(self._activityId, self._level + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将公共等级升级到Lv.%s吗？", iconStr, num, cfg.lv)

		self:_checkAndCall(type, id, num, content, function()
			ChuangJingRoadController.instance:sendPetLvlUp(self._activityId)
		end, 2)
	end
end

function ChuangjingroadpetlvlupView:_onClickSuit()
	if #self._unlockCreepIds == 0 then
		TipsFacade.instance:openCommonTips("请先招募精灵")

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId) or {}

	if self._level < checknumber(cfg.holyStripeOpen) then
		local lvlCfg = ChuangJingRoadConfig.instance:getLevelCostById(self._activityId, checknumber(cfg.holyStripeOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getHolyStripeCostById(self._activityId, self._holyStripeLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将灵纹升级到Lv.%s吗？", iconStr, num, cfg.level)

		self:_checkAndCall(type, id, num, content, function()
			ChuangJingRoadController.instance:sendHolyStripeLvlUp(self._activityId)
		end, 3)
	end
end

function ChuangjingroadpetlvlupView:_onClickStarGod()
	if #self._unlockCreepIds == 0 then
		TipsFacade.instance:openCommonTips("请先招募精灵")

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId) or {}

	if self._level < checknumber(cfg.starGodPlusOpen) then
		local lvlCfg = ChuangJingRoadConfig.instance:getLevelCostById(self._activityId, checknumber(cfg.starGodPlusOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getStarGodCostById(self._activityId, self._starGodPlusLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将星神升级到Lv.%s吗？", iconStr, num, cfg.starGodLv)

		self:_checkAndCall(type, id, num, content, function()
			ChuangJingRoadController.instance:sendStarGodLvlUp(self._activityId)
		end, 4)
	end
end

function ChuangjingroadpetlvlupView:_onClickAwake()
	if #self._unlockCreepIds == 0 then
		TipsFacade.instance:openCommonTips("请先招募精灵")

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId) or {}

	if self._level < checknumber(cfg.awakenOpen) then
		local lvlCfg = ChuangJingRoadConfig.instance:getLevelCostById(self._activityId, checknumber(cfg.awakenOpen)) or {}

		TipsFacade.instance:openCommonTips(langPara("精灵公共等级达到Lv.%s后开启，先去升级等级吧~", lvlCfg.lv))

		return
	end

	local cfg = ChuangJingRoadConfig.instance:getAwakenCostById(self._activityId, self._awakenLv + 1)

	if cfg then
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local iconStr = MaterialMgr.getContentMatStr(cfg.cost, 26, -5, true)
		local content = langPara("确定消耗%s%s将觉醒等级升级到觉醒%s吗？", iconStr, num, GameUtil.toRomanNumber(cfg.level))

		self:_checkAndCall(type, id, num, content, function()
			ChuangJingRoadController.instance:sendAwakenLvlUp(self._activityId)
		end, 5)
	end
end

function ChuangjingroadpetlvlupView:_checkAndCall(type, id, num, content, callBack, myKey)
	local key = "ChuangjingroadpetlvlupView_" .. myKey

	TipsFacade.instance:openPopupCostMatViewWithToggleKey(type, id, num, content, callBack, key)
end

return ChuangjingroadpetlvlupView
