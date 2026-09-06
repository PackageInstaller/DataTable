-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityScoreDetailView.lua

module("logic.extensions.guardcity.view.GuardCityScoreDetailView", package.seeall)

local GuardCityScoreDetailView = class("GuardCityScoreDetailView", ViewComponent)

function GuardCityScoreDetailView:ctor()
	GuardCityScoreDetailView.super.ctor(self)
end

function GuardCityScoreDetailView:buildUI()
	GuardCityScoreDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtResult = self:getTxt("main/txtResult")
	self._txtTime = self:getTxt("main/txtTime")
	self._bloodView = self:getGo("main/blood")
	self._bloodCell = self:getGo("main/bloodDot_1")
	self._bloodItemGourp = ItemGroup.New(self._bloodView, self._bloodCell)
	self._petView = self:getGo("tableview")
	self._petCell = self:getGo("petCell")
	self._emptyGo = self:getGo("empty")
	self._imgChangeCity = goutil.findChildComponent(self.mainGO, "main/city", "UIImageSpriteChange")
end

function GuardCityScoreDetailView:bindEvents()
	GuardCityScoreDetailView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GuardCityScoreDetailView:unbindEvents()
	GuardCityScoreDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuardCityScoreDetailView:onEnter()
	GuardCityScoreDetailView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._petScrollerList = ScrollerList.create(self._petView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._reportData = params[2]
	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)

	if self._reportData.prizeType ~= 1 then
		self:close()

		return
	end

	local time = GameUtil.time2date(checknumber(self._reportData.time) / 1000)

	self._txtTime.text = langPara("%02d.%02d %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
	self._resultJson = GameUtil.jsonToTable(self._reportData.jsonParams)

	if self._resultJson.ch == 1 then
		self._imgChangeCity:SetState(1)
	elseif self._resultJson.ch == 0 then
		self._imgChangeCity:SetState(2)
	else
		self._imgChangeCity:SetState(0)
	end

	self._bloodItemGourp:updateWithLen(GuardCityConfig.instance:getCommonValue("CITY_HP_LIMIT", true) + 1, self._updateBloodCell, self)
	self._petScrollerList:reloadData(self._resultJson.hpmi or {})
	GameUtil.SetActive(self._emptyGo, #(self._resultJson.hpmi or {}) <= 0)
end

function GuardCityScoreDetailView:onExit()
	GuardCityScoreDetailView.super.onExit(self)
	self._petScrollerList:dispose()
	self._bloodItemGourp:dispose(self._clearBloodCell, self)
end

function GuardCityScoreDetailView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "pet")
	local txtLevel = goutil.findChildTextComponent(go, "level/txtLevel")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtState = goutil.findChildTextComponent(go, "txtStage")
	local txtStateChange = goutil.findChildComponent(go, "txtStage", "UITextColorChange")
	local txtBlood = goutil.findChildTextComponent(go, "txtBlood")
	local teamCfg = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, checknumber(data.cmi))

	uGuiUtil.setSpriteToImage(petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(teamCfg.headIcon))

	txtName.text = teamCfg.name
	txtLevel.text = teamCfg.star

	if checknumber(data.hr) > 0 then
		txtState.text = lang("<color=#132F50FF>状态：</color>未击败")

		txtStateChange:SetState(0)
	else
		txtState.text = lang("<color=#132F50FF>状态：</color>击败")

		txtStateChange:SetState(1)
	end

	txtBlood.text = langPara("剩余血量：%d%%", checknumber(data.hr) / 100)
end

function GuardCityScoreDetailView:_clearPetCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "pet")

	uGuiUtil.clearImage(petCon)
end

function GuardCityScoreDetailView:_updateBloodCell(cell, index)
	local go = cell.mainGO
	local imgChange = go:GetComponentInChildren(ComponentType.UIImageColorChange)

	if not imgChange then
		return
	end

	if index - 1 > self._resultJson.ch then
		imgChange:SetState(1)
	else
		imgChange:SetState(0)
	end
end

function GuardCityScoreDetailView:_clearBloodCell(cell)
	return
end

return GuardCityScoreDetailView
