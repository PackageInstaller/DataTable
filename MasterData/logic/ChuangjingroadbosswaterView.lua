-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadbosswaterView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadbosswaterView", package.seeall)

local ChuangjingroadbosswaterView = class("ChuangjingroadbosswaterView", ViewComponent)

function ChuangjingroadbosswaterView:ctor()
	ChuangjingroadbosswaterView.super.ctor(self)
end

function ChuangjingroadbosswaterView:unbindEvents()
	ChuangjingroadbosswaterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ChuangjingroadbosswaterView:bindEvents()
	ChuangjingroadbosswaterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ChuangjingroadbosswaterView:buildUI()
	ChuangjingroadbosswaterView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtDiff = self:getTxt("txtDiff")
	self._txtDesc = self:getTxt("txtDesc")
	self._fmt_2 = self:getGo("fmt_2")
	self._fmt_1 = self:getGo("fmt_1")
	self._changeBg = self:getGo("changeBg")
end

function ChuangjingroadbosswaterView:onExit()
	ChuangjingroadbosswaterView.super.onExit(self)
	uGuiUtil.clearImage(self._changeBg)
end

function ChuangjingroadbosswaterView:onEnter()
	ChuangjingroadbosswaterView.super.onEnter(self)

	self._activityId = 396001
	self._zoneId = 2

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])
	local zoneId = checknumber(params[2])

	if actId > 0 then
		self._activityId = actId
	end

	if zoneId > 0 then
		self._zoneId = zoneId
	end

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetInfo(self._activityId)
	self:_onRefershUI()
end

function ChuangjingroadbosswaterView:_onRefershUI()
	local info = ChuangJingRoadModel.instance:getInfo(self._activityId) or {}

	if not info.zones then
		local zones = {}

		self._zoneInfo = nil

		for i, v in ipairs(zones) do
			if v.zoneId == self._zoneId then
				self._zoneInfo = v

				break
			end
		end

		self._zoneInfo = self._zoneInfo or {}
		self._waterBoss = self._zoneInfo.waterBoss or {}
		self._isFinishBoss = checkbool(self._zoneInfo.isFinishBoss)

		local dam1 = checknumber(self._waterBoss.teamADamage)
		local dam2 = checknumber(self._waterBoss.teamBDamage)
		local damageList = {}

		table.insert(damageList, dam1)
		table.insert(damageList, dam2)

		self._damageList = damageList

		local cfg = ChuangJingRoadConfig.instance:getWaterBossCfgById(self._activityId, self._zoneId) or {}
		local damageGap = checknumber(cfg.damageGap)

		self._txtDesc.text = cfg.desc

		local diff = math.abs(dam1 - dam2)

		self._txtDiff.text = langPara("差值\n%s\n<color=#ffffff><size=26>%s</size></color>", diff, (dam1 > 0 and dam2 > 0 and diff <= damageGap or nil) and "已通关")

		local arr = {}

		table.insert(arr, cfg.teamA)
		table.insert(arr, cfg.teamB)

		for i, creepsMasterId in ipairs(arr) do
			local creeps = ChuangJingRoadConfig.instance:getCreepsCfgById(creepsMasterId) or {}
			local map = {}

			for k, pet in pairs(creeps) do
				map[pet.posId] = pet
			end

			local fmt = self:getGo("fmt_" .. i)

			for j = 1, 9 do
				local cell = goutil.findChild(fmt, "cell_" .. j)
				local cc = map[j]

				GameUtil.SetActive(cell, false)

				if cc then
					GameUtil.SetActive(cell, true)

					local icon = goutil.findChild(fmt, "cell_" .. j .. "/icon")

					MaterialMgr.setIcon(icon, MatType.Pet, cc.raceId)
				end
			end

			local txtHurt = goutil.findChildTextComponent(fmt, "txtHurt")

			txtHurt.text = langPara("造成伤害：%s", checknumber(damageList[i]))

			local pass = goutil.findChild(fmt, "pass")
			local btnReset = goutil.findChild(fmt, "btnReset")
			local btnStart = goutil.findChild(fmt, "btnStart")

			GameUtil.SetActive(pass, checknumber(damageList[i]) > 0)
			GameUtil.SetActive(btnReset, checknumber(damageList[i]) > 0)
			GameUtil.SetActive(btnStart, checknumber(damageList[i]) == 0)
			GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickReset, self, i))
			GameUtil.addClickHandler(btnStart, GameUtil.handler(self._onClickStart, self, i, creepsMasterId))
		end

		local extCfg = ChuangJingRoadConfig.instance:getExtStageById(self._activityId, self._zoneId)

		self._txtDesc.text = extCfg.desc

		local zoneCfg = ChuangJingRoadConfig.instance:getZoneCfgById(self._activityId, self._zoneId) or {}

		uGuiUtil.setSpriteToImage(self._changeBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(zoneCfg.imageUrl), function()
			self._changeBg.gameObject:GetComponent("Image"):SetNativeSize()
		end)
	end
end

function ChuangjingroadbosswaterView:_onClickStart(idx, creepsMasterId)
	if self._isFinishBoss then
		TipsFacade.instance:openCommonTips("本挑战已完全通关")
	else
		ChuangJingRoadController.instance:openWaterBossMissionView(self._activityId, self._zoneId, idx, creepsMasterId)
	end
end

function ChuangjingroadbosswaterView:_onClickReset(idx)
	if self._isFinishBoss then
		TipsFacade.instance:openCommonTips("本挑战已完全通关")
	else
		local content = langPara("当前造成伤害：%s，是否确认重置？", checknumber(self._damageList[idx]))

		TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
			ChuangJingRoadController.instance:sendResetBossFight(self._activityId, self._zoneId, idx - 1)
		end)
	end
end

function ChuangjingroadbosswaterView:_onClickTip()
	return
end

return ChuangjingroadbosswaterView
