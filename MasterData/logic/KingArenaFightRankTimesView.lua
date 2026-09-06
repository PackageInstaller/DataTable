-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/rank/KingArenaFightRankTimesView.lua

module("logic.extensions.kingarena.view.rank.KingArenaFightRankTimesView", package.seeall)

local KingArenaFightRankTimesView = class("KingArenaFightRankTimesView", ViewComponent)

function KingArenaFightRankTimesView:buildUI()
	KingArenaFightRankTimesView.super.buildUI(self)

	self._rankScrView = self:getGo("rankScrView")
	self._rankScrCell = self:getGo("rankScrCell")
	self._emptyGo = self:getGo("emptyGo")
	self._rankScrollerList = ScrollerList.create(self._rankScrView, self._rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._dropdown = self:getGo("dropdown")
	self._dropdownComp = DropDownAdapter.Get(self._dropdown)
end

function KingArenaFightRankTimesView:bindEvents()
	KingArenaFightRankTimesView.super.bindEvents(self)
end

function KingArenaFightRankTimesView:unbindEvents()
	KingArenaFightRankTimesView.super.unbindEvents(self)
end

function KingArenaFightRankTimesView:onEnter()
	KingArenaFightRankTimesView.super.onEnter(self)

	self._rankType = KingArenaEnum.RankType_Fight_Two
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

function KingArenaFightRankTimesView:onExit()
	KingArenaFightRankTimesView.super.onExit(self)
	self._dropdownComp:RemoveOnValueChanged()
	self._dropdownComp:ClearOptions()
	self._rankScrollerList:dispose()
end

function KingArenaFightRankTimesView:_sendGetInfoReq()
	local zoneId = self:_getCurZoneId()

	if zoneId > 0 then
		KingArenaController.instance:sendPM_KingArenaRankViewReq(self._rankType, zoneId)
	end
end

function KingArenaFightRankTimesView:_getCurZoneId()
	local value = self._dropdownComp:GetValue()

	return value + 1
end

function KingArenaFightRankTimesView:_handlePM_KingArenaRankViewRes(msg)
	if msg.type ~= self._rankType then
		return
	end

	if msg.type == self._rankType then
		local curZoneId = self:_getCurZoneId()

		if curZoneId ~= msg.zoneId then
			return
		end
	end

	self._myRank = msg.myRank
	self._rankInfoList = msg.rankInfoList

	self:_onUpdate()
end

function KingArenaFightRankTimesView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollerList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollerList:MoveCellInView(idx, isMotion)
end

function KingArenaFightRankTimesView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.opHeadInfo
	local familyName = info.familyName
	local everMaxZdl = info.everMaxZdl
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")
	local txtFamily = goutil.findChildTextComponent(mainGo, "txtFamily")
	local txtTimes = goutil.findChildTextComponent(mainGo, "txtTimes")

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
	txtTimes.text = (info:HasField("kingTimes") or nil) and info.kingTimes

	HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)
end

function KingArenaFightRankTimesView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)
end

return KingArenaFightRankTimesView
