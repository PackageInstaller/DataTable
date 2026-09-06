-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/rank/KingArenaFightRankView.lua

module("logic.extensions.kingarena.view.rank.KingArenaFightRankView", package.seeall)

local KingArenaFightRankView = class("KingArenaFightRankView", ViewComponent)

function KingArenaFightRankView:buildUI()
	KingArenaFightRankView.super.buildUI(self)

	self._rankScrView = self:getGo("rankScrView")
	self._rankScrCell = self:getGo("rankScrCell")
	self._emptyGo = self:getGo("emptyGo")
	self._rankScrollerList = ScrollerList.create(self._rankScrView, self._rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._dropdown = self:getGo("dropdown")
	self._dropdownComp = DropDownAdapter.Get(self._dropdown)
end

function KingArenaFightRankView:bindEvents()
	KingArenaFightRankView.super.bindEvents(self)
end

function KingArenaFightRankView:unbindEvents()
	KingArenaFightRankView.super.unbindEvents(self)
end

function KingArenaFightRankView:onEnter()
	KingArenaFightRankView.super.onEnter(self)

	self._rankType = KingArenaEnum.RankType_Fight_One
	self._seasonId = KingArenaController.instance:getSeasonId()
	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)
	self._myRank = 0
	self._rankInfoList = {}
	self._valueZoneIds = {}

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaRankViewRes, self._handlePM_KingArenaRankViewRes, self)
	self._dropdownComp:ClearOptions()

	local zoneCfg = KingArenaConfig.instance:getZoneCfg(self._seasonId)

	if zoneCfg then
		for index, data in ipairs(zoneCfg) do
			self._valueZoneIds[data.zoneId] = index - 1

			self._dropdownComp:AddOptions(data.name)
		end

		self._dropdownComp:AddOnValueChanged(function(handler, value)
			self:_sendGetInfoReq()
		end, self)
	end

	local zoneId = self._kingArenaMo:getZoneId()
	local value = checknumber(self._valueZoneIds[zoneId])

	if self._dropdownComp:GetValue() == value then
		self:_sendGetInfoReq()
	else
		self._dropdownComp:SetValue(value)
	end

	self:_onUpdate()
end

function KingArenaFightRankView:onExit()
	KingArenaFightRankView.super.onExit(self)
	self._dropdownComp:RemoveOnValueChanged()
	self._dropdownComp:SetValue(-1)
	self._dropdownComp:ClearOptions()
	self._rankScrollerList:dispose()
end

function KingArenaFightRankView:_sendGetInfoReq()
	local zoneId = self:_getCurZoneId()

	if zoneId > 0 then
		KingArenaController.instance:sendPM_KingArenaRankViewReq(self._rankType, zoneId)
	end
end

function KingArenaFightRankView:_getCurZoneId()
	local value = self._dropdownComp:GetValue()

	return value + 1
end

function KingArenaFightRankView:_handlePM_KingArenaRankViewRes(msg)
	if msg.type ~= self._rankType then
		return
	end

	if self._rankType == self._rankType then
		local curZoneId = self:_getCurZoneId()

		if curZoneId ~= msg.zoneId then
			return
		end
	end

	self._myRank = msg.myRank
	self._rankInfoList = msg.rankInfoList

	self:_onUpdate()
end

function KingArenaFightRankView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollerList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollerList:MoveCellInView(idx, isMotion)
end

function KingArenaFightRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.opHeadInfo
	local familyName = info.familyName
	local everMaxZdl = info.everMaxZdl
	local userId = headInfo.userId
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtFamily = goutil.findChildTextComponent(mainGo, "txtFamily")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local btnDef = goutil.findChild(mainGo, "btnDef")

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if txtName then
		txtName.text = headInfo.userName
	end

	txtFamily.text = string.nilorempty(familyName) and "无" or familyName
	txtZdl.text = everMaxZdl

	HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)
	GameUtil.addClickHandler(btnDef, function()
		if checknumber(userId) ~= 0 then
			KingArenaController.instance:viewFormation(userId)
		end
	end, self)
	GameUtil.SetActive(btnDef, checknumber(userId) ~= 0)
end

function KingArenaFightRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local btnDef = goutil.findChild(mainGo, "btnDef")

	HeadItemController.instance:resetHeadCell(head)
	GameUtil.rmClickHandler(btnDef)
end

return KingArenaFightRankView
