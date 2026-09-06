-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTotemActivationView.lua

module("logic.extensions.season.view.SeasonTotemActivationView", package.seeall)

local SeasonTotemActivationView = class("SeasonTotemActivationView", ViewComponent)

function SeasonTotemActivationView:ctor()
	SeasonTotemActivationView.super.ctor(self)
end

function SeasonTotemActivationView:unbindEvents()
	SeasonTotemActivationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLevelUp)
end

function SeasonTotemActivationView:bindEvents()
	SeasonTotemActivationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickActive, self)
end

function SeasonTotemActivationView:buildUI()
	SeasonTotemActivationView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._txtCost = MaterialMgr.findGraphicText(self.mainGO, "txtCost")

	local attrDesc = self:getGo("attrDesc")

	self._attrDescItems = {}

	for i = 1, 6 do
		local txtDesc = goutil.findChildTextComponent(attrDesc, string.format("attrDesc_%s/txtDesc", i))

		table.insert(self._attrDescItems, txtDesc)
	end
end

function SeasonTotemActivationView:onExit()
	SeasonTotemActivationView.super.onExit(self)
end

function SeasonTotemActivationView:onEnter()
	SeasonTotemActivationView.super.onEnter(self)

	local params = self:getOpenParam()

	self._raceType = checknumber(params[1])
	self._itemId = checknumber(params[2])
	self._userId = params[3]

	GameUtil.setUIImageSpriteIdx(self:getGo("icon"), self._itemId - 1)

	local totemInfo = SeasonMainCampModel.instance:getTotemPoleInfoByRaceType(self._userId, self._raceType)
	local itemLv = totemInfo:getSubItemLv(self._itemId)
	local entries = totemInfo:getSubEntry(self._itemId, itemLv + 1)
	local strEntries = SeasonMainCampController.instance:toAttrList(entries)

	for i, txtDesc in ipairs(self._attrDescItems) do
		if strEntries[i] then
			GameUtil.SetActive(txtDesc, true)

			txtDesc.text = strEntries[i]
		else
			GameUtil.SetActive(txtDesc, false)
		end
	end

	self._nextConfig = SeasonMainCampConfig.instance:getTotemPoleItemConfig(totemInfo.totemItemPlanId, self._itemId, itemLv + 1)

	local cost = self._nextConfig.cost

	if not string.nilorempty(cost) then
		GameUtil.SetActive(self._txtCost, true)

		self._costArray = string.split(cost, "#")

		local content = ""

		for i, cfgStr in ipairs(self._costArray) do
			local type, id, num = MaterialMgr.getMatParams(cfgStr)

			content = content .. MaterialMgr.getContentMatStr(cfgStr, 35, -10, MaterialMgr.ICON_TYPE_ICON) .. "x"
			content = not MaterialModel.instance:IsEnough(type, id, num) and content .. string.format("<color=#FF0000>%s</color> ", num) or content .. num .. " "
		end

		self._txtCost.text = langPara("消耗：%s", content)
	else
		GameUtil.SetActive(self._txtCost, false)
	end
end

function SeasonTotemActivationView:_onClickActive()
	local needCampLv = checknumber(self._nextConfig.camplv)

	if needCampLv > SeasonMainCampModel.instance:getCampLv() then
		FloatWordMgr.instance:show(lang("主营地等级不足"))

		return
	end

	if self._costArray then
		for i, cfgStr in ipairs(self._costArray) do
			local type, id, num = MaterialMgr.getMatParams(cfgStr)

			if not MaterialFacade.instance:checkMatEnough(type, id, num, nil, true) then
				return
			end
		end
	end

	SeasonModePveAgent.instance:sendPM_SMPVEUpgradeTotemPoleItemReq(self._raceType, self._itemId)
	self:close()
end

return SeasonTotemActivationView
