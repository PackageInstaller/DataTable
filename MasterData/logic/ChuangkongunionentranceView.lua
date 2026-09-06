-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionentranceView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionentranceView", package.seeall)

local ChuangkongunionentranceView = class("ChuangkongunionentranceView", ViewComponent)

function ChuangkongunionentranceView:ctor()
	ChuangkongunionentranceView.super.ctor(self)

	self.petRaceIds = string.splitToNumber(ChuangkongunionConfig.instance:getCommonValue("ENTRANCE_PET_IDS"), "#")
end

function ChuangkongunionentranceView:unbindEvents()
	GameUtil.rmClickHandler(self._btnKeZhi)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnShop2)

	for i = 1, #self.petRaceIds do
		GameUtil.rmClickHandler(self._btnInfos[i])
	end

	GameUtil.rmClickHandler(self._btnClose)
	ChuangkongunionentranceView.super.unbindEvents(self)
end

function ChuangkongunionentranceView:bindEvents()
	ChuangkongunionentranceView.super.bindEvents(self)

	for i = 1, #self.petRaceIds do
		GameUtil.addClickHandler(self._btnInfos[i], GameUtil.handler(self._onClickInfo, self, i))
	end

	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShop, GameUtil.handler(self._onClickShop, self))
	GameUtil.addClickHandler(self._btnShop2, GameUtil.handler(self._onClickShop2, self))
	GameUtil.addClickHandler(self._btnJump, GameUtil.handler(self._onClickJump, self))
	GameUtil.addClickHandler(self._btnTip, GameUtil.handler(self._onTip, self))
	GameUtil.addClickHandler(self._btnKeZhi, GameUtil.handler(self.onClickKezhi, self))
end

function ChuangkongunionentranceView:buildUI()
	ChuangkongunionentranceView.super.buildUI(self)

	self._btnInfos = {}
	self._rare = {}
	self._txtName = {}

	for i = 1, #self.petRaceIds do
		self._btnInfos[i] = self:getGo("petInfo" .. i .. "/btnInfo")
		self._rare[i] = self:getGo("petInfo" .. i .. "/rare")
		self._txtName[i] = self:getTxt("petInfo" .. i .. "/txtName")
	end

	self._btnJump = self:getGo("btnJump")
	self._btnShop = self:getGo("btnShop")
	self._btnShop2 = self:getGo("btnStargod")
	self._txtBtnShop2 = self:getTxt("btnStargod/txt")
	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._txtTime = self:getTxt("time/txt")
	self._redPoint = self:getGo("btnJump/red")
	self._btnKeZhi = self:getGo("btnKezhi")
end

function ChuangkongunionentranceView:onExit()
	ChuangkongunionentranceView.super.onExit(self)

	for i = 1, #self.petRaceIds do
		MaterialMgr.resetAll(self._rare)
	end

	RedPointController.instance:unregRedPoint(self._redPoint)
end

function ChuangkongunionentranceView:onEnter()
	ChuangkongunionentranceView.super.onEnter(self)

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CHUANG_KONG_UNION)

	if cfg == nil then
		FloatWordMgr.instance:show("不在活动时间内")
		self:close()

		return
	end

	ChuangkongunionModel.instance:setActId(cfg.activityId)

	local timeStart = GameUtil.string2date(cfg.startTime, true)
	local timeEnd = GameUtil.string2date(cfg.endTime, true)

	self._txtTime.text = string.format("活动时间：%d.%d %d:%02d-%d.%d %d:%02d", timeStart.month, timeStart.day, timeStart.hour, timeStart.min, timeEnd.month, timeEnd.day, timeEnd.hour, timeEnd.min)

	for i = 1, #self.petRaceIds do
		MaterialMgr.setCell(MatType.Rare, self.petRaceIds[i], self._rare[i])

		self._txtName[i].text = MaterialMgr.getMaterialsName(MatType.Pet, self.petRaceIds[i])
	end

	self._txtBtnShop2.text = ChuangkongunionConfig.instance:getCommonValue("GOODS_NAME")

	local redpointIds = ChuangkongunionConfig.instance:getCommonValue("ENTRANCE_RED_POINT_IDS")

	RedPointController.instance:regRedPoint(self._redPoint, unpack(string.splitToNumber(redpointIds or "", "#")))
end

function ChuangkongunionentranceView:_onClickInfo(i)
	PetbookController.instance:openPetinfoView(self.petRaceIds[i])
end

function ChuangkongunionentranceView:_onClickJump()
	UIStateManager.instance:push(ViewName.ChuangkongunionView)
	SurveyController.instance:reportBehavior(200663)
end

function ChuangkongunionentranceView:_onTip()
	UIStateManager.instance:push(ViewName.RulesView, "chuangkongunion_rule")
end

function ChuangkongunionentranceView:_onClickShop()
	ChuangkongunionController.instance:openShop()
end

function ChuangkongunionentranceView:_onClickShop2()
	local goodsId = checknumber(ChuangkongunionConfig.instance:getCommonValue("GOODS_ID"))

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function ChuangkongunionentranceView:onClickKezhi()
	CommonTipsMgr.instance:openMaterialTips(self._btnKeZhi, MatType.Race, self.petRaceIds[1])
end

return ChuangkongunionentranceView
