-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityReportDetailView.lua

module("logic.extensions.guardcity.view.GuardCityReportDetailView", package.seeall)

local GuardCityReportDetailView = class("GuardCityReportDetailView", ViewComponent)

function GuardCityReportDetailView:ctor()
	GuardCityReportDetailView.super.ctor(self)
end

function GuardCityReportDetailView:buildUI()
	GuardCityReportDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._petCon = self:getGo("petCol/petCon")
	self._uIChangePetStage = goutil.findChildComponent(self.mainGO, "petCol/stage", "UIImageSpriteChange")
	self._imgNumberTxtPetPower = goutil.findChildComponent(self.mainGO, "petCol/power/imgRecZdl", "UIImgNumeralText")
	self._txtPetName = self:getTxt("petCol/name/txtName")
	self._txtLevel = self:getTxt("petCol/level/txtLevel")
	self._emptyGo = self:getGo("noData")
	self._tabelView = self:getGo("listCol/listview")
	self._tableCell = self:getGo("listCol/listItem")
	self._btnSure = self:getBtn("btnSure")
end

function GuardCityReportDetailView:bindEvents()
	GuardCityReportDetailView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function GuardCityReportDetailView:unbindEvents()
	GuardCityReportDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function GuardCityReportDetailView:onEnter()
	GuardCityReportDetailView.super.onEnter(self)

	self._tabScroll = ScrollerList.create(self._tabelView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local params = self:getOpenParam()

	self._activityId = params[1]

	local data = params[2]

	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)

	self:_refreshPetInfo(data.creepsMasterId)
	self._tabScroll:reloadData(data.reportPlayerInfos)
end

function GuardCityReportDetailView:onExit()
	GuardCityReportDetailView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)
	end
end

function GuardCityReportDetailView:_refreshPetInfo(creepsMasterId)
	local cfg = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, creepsMasterId)
	local creepsCfg = GuardCityConfig.instance:getCreepsCfg(creepsMasterId)
	local res = {}

	for i, v in ipairs(creepsCfg) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(v.extproperties) or {}

		res = AttrMo.addSameAttrs(attrs, res)
	end

	self._bossMaxHp = checknumber(res[FightingPowerFormula.instance:getAttrTypeByName("生命")])

	self._uIChangePetStage:SetState(1)
	self._imgNumberTxtPetPower:SetNum(checknumber(cfg.recommendZdl))

	self._txtLevel.text = langPara("%d", checknumber(cfg.star))
	self._txtPetName.text = cfg.name

	local path = GameUrl.getLihuiSpineUIUrl(cfg.resName)

	self._roleObj = RoleObjectPool.instance:addSpineToParent(self._roleObj, path, self._petCon, 0.1)
end

function GuardCityReportDetailView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "rank/txtRank")
	local imgChangeRank = goutil.findChildComponent(go, "rank", "UIImageSpriteChange")
	local imgHeadIcon = goutil.findChild(go, "headGo")
	local sliderDamage = Framework.SliderAdapter.GetFrom(go, "barSli")
	local imgChangeStage = goutil.findChildComponent(go, "stage", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtPower = goutil.findChildTextComponent(go, "txtPower")

	txtRank.text = data.rank

	GameUtil.SetActive(imgChangeRank, data.rank <= 3 and data.rank > 0)
	GameUtil.SetActive(txtRank, true)

	if data.rank <= 3 and data.rank > 0 then
		imgChangeRank:SetState(data.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
	else
		GameUtil.SetActive(imgChangeRank, false)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgHeadIcon)
			end
		end)
	end

	if data.damage < self._bossMaxHp then
		sliderDamage:SetValue(data.damage / self._bossMaxHp)
	else
		sliderDamage:SetValue(1)
	end

	GameUtil.SetActive(imgChangeStage, false)

	if data.headInfo.userId == data.mvpPlayerId then
		GameUtil.SetActive(imgChangeStage, true)
		imgChangeStage:SetState(0)
	elseif data.headInfo.userId == RoleModel.instance:getUserId() then
		GameUtil.SetActive(imgChangeStage, true)
		imgChangeStage:SetState(1)
	end

	txtName.text = data.headInfo.userName
	txtPower.text = data.damage
end

function GuardCityReportDetailView:_clearCell(cell)
	local go = cell.gameObject
	local imgHeadIcon = goutil.findChild(go, "headGo")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)
end

function GuardCityReportDetailView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return GuardCityReportDetailView
