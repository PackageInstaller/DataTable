-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadbossfireView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadbossfireView", package.seeall)

local ChuangjingroadbossfireView = class("ChuangjingroadbossfireView", ViewComponent)

function ChuangjingroadbossfireView:ctor()
	ChuangjingroadbossfireView.super.ctor(self)
end

function ChuangjingroadbossfireView:unbindEvents()
	ChuangjingroadbossfireView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ChuangjingroadbossfireView:bindEvents()
	ChuangjingroadbossfireView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ChuangjingroadbossfireView:buildUI()
	ChuangjingroadbossfireView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtDiff = self:getTxt("txtDiff")
	self._txtDesc = self:getTxt("txtDesc")
	self._imgDiff = self:getGo("imgDiff")
	self._changeBg = self:getGo("changeBg")
end

function ChuangjingroadbossfireView:onExit()
	ChuangjingroadbossfireView.super.onExit(self)
	uGuiUtil.clearImage(self._changeBg)
end

function ChuangjingroadbossfireView:onEnter()
	ChuangjingroadbossfireView.super.onEnter(self)

	self._activityId = 396001
	self._zoneId = 3

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

function ChuangjingroadbossfireView:_onRefershUI()
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
		self._fireBoss = self._zoneInfo.fireBoss or {}
		self._isFinishBoss = checkbool(self._zoneInfo.isFinishBoss)

		local num1 = checknumber(self._fireBoss.teamALeftPetNum)
		local num2 = checknumber(self._fireBoss.teamBLeftPetNum)
		local leftPetList = {}

		table.insert(leftPetList, num1)
		table.insert(leftPetList, num2)

		self._leftPetList = leftPetList

		local cfg = ChuangJingRoadConfig.instance:getFireBossCfgById(self._activityId, self._zoneId) or {}
		local compareTo = cfg.compareTo
		local extCfg = ChuangJingRoadConfig.instance:getExtStageById(self._activityId, self._zoneId)

		self._txtDesc.text = extCfg.desc

		local tips = "未达成"

		if num1 > 0 and num2 > 0 then
			if compareTo == GameEnum.GREATER_THAN and num2 < num1 then
				tips = "已通关"
			elseif compareTo == GameEnum.GREATER_THAN_OR_EQUAL_TO and num2 <= num1 then
				tips = "已通关"
			elseif compareTo == GameEnum.LESS_THAN and num1 < num2 then
				tips = "已通关"
			elseif compareTo == GameEnum.LESS_THAN_OR_EQUAL_TO and num1 <= num2 then
				tips = "已通关"
			elseif compareTo == GameEnum.EQUAL_TO and num1 == num2 then
				tips = "已通关"
			end
		end

		self._txtDiff.text = tips

		local spIdx = 0

		if num1 == num2 then
			spIdx = 0
		elseif num2 < num1 then
			spIdx = 1
		elseif num1 < num2 then
			spIdx = 2
		end

		GameUtil.setUIImageSpriteIdx(self._imgDiff, spIdx)

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

			txtHurt.text = langPara("存活精灵数量：%s", checknumber(leftPetList[i]))

			local pass = goutil.findChild(fmt, "pass")
			local btnReset = goutil.findChild(fmt, "btnReset")
			local btnStart = goutil.findChild(fmt, "btnStart")

			GameUtil.SetActive(pass, checknumber(leftPetList[i]) > 0)
			GameUtil.SetActive(btnReset, checknumber(leftPetList[i]) > 0)
			GameUtil.SetActive(btnStart, checknumber(leftPetList[i]) == 0)
			GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickReset, self, i))
			GameUtil.addClickHandler(btnStart, GameUtil.handler(self._onClickStart, self, i, creepsMasterId))
		end

		local zoneCfg = ChuangJingRoadConfig.instance:getZoneCfgById(self._activityId, self._zoneId) or {}

		uGuiUtil.setSpriteToImage(self._changeBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(zoneCfg.imageUrl), function()
			self._changeBg.gameObject:GetComponent("Image"):SetNativeSize()
		end)
	end
end

function ChuangjingroadbossfireView:_onClickStart(idx, creepsMasterId)
	if self._isFinishBoss then
		TipsFacade.instance:openCommonTips("本挑战已完全通关")
	else
		ChuangJingRoadController.instance:openFireBossMissionView(self._activityId, self._zoneId, idx, creepsMasterId)
	end
end

function ChuangjingroadbossfireView:_onClickReset(idx)
	if self._isFinishBoss then
		TipsFacade.instance:openCommonTips("本挑战已完全通关")
	else
		local content = langPara("当前存活精灵数量：%s，是否确认重置？", checknumber(self._leftPetList[idx]))

		TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
			ChuangJingRoadController.instance:sendResetBossFight(self._activityId, self._zoneId, idx - 1)
		end)
	end
end

function ChuangjingroadbossfireView:_onClickTip()
	return
end

return ChuangjingroadbossfireView
