-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightMasterPrizeView.lua

module("logic.extensions.holylight.view.HolyLightMasterPrizeView", package.seeall)

local HolyLightMasterPrizeView = class("HolyLightMasterPrizeView", ViewComponent)

function HolyLightMasterPrizeView:buildUI()
	HolyLightMasterPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	local prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "prizeCol/itemScrollercell")
	self._prizeScrollList = ScrollerList.create(prizeScrollerview, prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function HolyLightMasterPrizeView:bindEvents()
	HolyLightMasterPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function HolyLightMasterPrizeView:unbindEvents()
	HolyLightMasterPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function HolyLightMasterPrizeView:onEnter()
	HolyLightMasterPrizeView.super.onEnter(self)

	self._activityId = HolyLightController.instance:getActivityId()
	self._activityType = HolyLightController.instance:getActivityType()

	if self._activityId <= 0 then
		TipsFacade.instance:openTipWindowNoX("提示", "不在活动范围内", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._holyLightMgr = HolyLightController.instance:getHolyLightMgr(self._activityId)

	self:_onUpdatePrizeScrollerList()
end

function HolyLightMasterPrizeView:onExit()
	HolyLightMasterPrizeView.super.onExit(self)
	self._prizeScrollList:dispose()
end

function HolyLightMasterPrizeView:_onUpdatePrizeScrollerList()
	local dataList = {}
	local cfg = HolyLightConfig.instance:getHlMasterCfg(self._activityId)

	for _, data in ipairs(cfg) do
		table.insert(dataList, data)
	end

	table.sort(dataList, function(a, b)
		local isPassA = self._holyLightMgr:isPassToFightMaster(a.masterId) and 1 or 0
		local isPassB = self._holyLightMgr:isPassToFightMaster(b.masterId) and 1 or 0

		if isPassA == isPassB then
			if a.masterId < b.masterId then
				return true
			end

			return false
		end

		return isPassA < isPassB
	end)
	self._prizeScrollList:reloadData(dataList)
end

function HolyLightMasterPrizeView:_updatePrizeCell(view, cell, data, tag)
	local index = cell.index
	local mainGo = cell.gameObject
	local imgMaster = goutil.findChild(mainGo, "imgMaster")
	local txtMaster = goutil.findChildTextComponent(mainGo, "master/txtMaster")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local masterId = data.masterId

	GameUtil.setUIImageSpriteIdx(imgMaster, index % 3)

	txtMaster.text = string.format("击败次数：%s", data.times + 1)

	GameUtil.SetActive(imgPass, self._holyLightMgr:isPassToFightMaster(masterId))

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			local infoList = {}

			for _, prizeStr in ipairs(prizeStrArr) do
				local info = {}

				info.prizeStr = prizeStr
				info.data = data

				table.insert(infoList, info)
			end

			self._itemScrollListDic[mainGo]:reloadData(infoList)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function HolyLightMasterPrizeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local imgMaster = goutil.findChild(mainGo, "imgMaster")
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function HolyLightMasterPrizeView:_updateItemCell(view, cell, info, tag)
	local data = info.data
	local prizeStr = info.prizeStr
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")
	local receive = goutil.findChild(mainGo, "receive")

	GameUtil.SetActive(receive, self._holyLightMgr:isPassToFightMaster(data.masterId))
	MaterialMgr.setCellByCfg(prizeStr, con)
end

function HolyLightMasterPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")

	MaterialMgr.resetAll(con)
end

return HolyLightMasterPrizeView
