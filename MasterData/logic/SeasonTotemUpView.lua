-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTotemUpView.lua

module("logic.extensions.season.view.SeasonTotemUpView", package.seeall)

local SeasonTotemUpView = class("SeasonTotemUpView", ViewComponent)

function SeasonTotemUpView:ctor()
	SeasonTotemUpView.super.ctor(self)
end

function SeasonTotemUpView:unbindEvents()
	SeasonTotemUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLevelUp)
end

function SeasonTotemUpView:bindEvents()
	SeasonTotemUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
end

function SeasonTotemUpView:buildUI()
	SeasonTotemUpView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._txtCost = self:getTxt("txtCost")

	local attrDesc = self:getGo("attrDesc")

	self._attrDescItems = {}

	for i = 1, 6 do
		local txtDesc = goutil.findChildTextComponent(attrDesc, string.format("attrDesc_%s/txtDesc", i))

		table.insert(self._attrDescItems, txtDesc)
	end

	self._skillInfoGo = self:getGo("skillInfo")
	self._txtSkillDesc = self:getTxt("skillInfo/txtDesc")
	self._txtLevel = self:getTxt("icon/level/txtLevel")
	self._icon = self:getGo("icon")
	self._skillIcon = self:getGo("skillInfo/icon/attr"):GetComponent("UIImageSpriteChange")
	self._skillBorder = self:getGo("skillInfo/icon"):GetComponent("UIImageSpriteChange")
	self._txtEmpty = self:getTxt("txtEmpty")
end

function SeasonTotemUpView:onExit()
	SeasonTotemUpView.super.onExit(self)
	uGuiUtil.clearImage(self._skillIcon)
end

function SeasonTotemUpView:onEnter()
	SeasonTotemUpView.super.onEnter(self)

	local params = self:getOpenParam()

	self._raceType = checknumber(params[1])
	self._userId = params[2]

	GameUtil.setUIImageSpriteIdx(self._icon, self._raceType - 1)

	local totemInfo = SeasonMainCampModel.instance:getTotemPoleInfoByRaceType(self._userId, self._raceType)
	local level = totemInfo.mainTotemPoleLv
	local entries = totemInfo:getMainEntry(level + 1)
	local strEntries = SeasonMainCampController.instance:toAttrList(entries)

	for i, txtDesc in ipairs(self._attrDescItems) do
		if strEntries[i] then
			GameUtil.SetActive(txtDesc, true)

			txtDesc.text = strEntries[i]
		else
			GameUtil.SetActive(txtDesc, false)
		end
	end

	self._nextConfig = SeasonMainCampConfig.instance:getMainTotemConfig(totemInfo.mainTotemPlanId, level + 1)

	local cost = self._nextConfig.cost

	if not string.nilorempty(cost) then
		GameUtil.SetActive(self._txtCost, true)

		self._costArray = string.split(cost, "#")

		local costStrArray = {}

		for i, cfgStr in ipairs(self._costArray) do
			local type, id, num = MaterialMgr.getMatParams(cfgStr)
			local name = MaterialMgr.getMaterialsName(type, id)

			table.insert(costStrArray, string.format("%sx%s", name, num))
		end

		self._txtCost.text = langPara("消耗：%s", table.concat(costStrArray, " "))
	else
		GameUtil.SetActive(self._txtCost, false)
	end

	self._txtLevel.text = langPara("Lv.%s", level + 1)

	if string.nilorempty(self._nextConfig.isNextUpgrade) or self._nextConfig.isNextUpgrade == "0" then
		GameUtil.SetActive(self._skillInfoGo, true)
		GameUtil.SetActive(self._txtEmpty, false)

		self._txtSkillDesc.text = langPara("%s(Lv.%s激活)", self._nextConfig.buffName, level + 1)

		self._skillIcon:ChangeSprite(self._nextConfig.buffIcon)

		local _, map = SeasonMainCampConfig.instance:getTotemSkillCfgsById(self._raceType)

		if map[self._nextConfig] then
			self._skillBorder:SetState(map[self._nextConfig] - 1)
		end
	else
		GameUtil.SetActive(self._skillInfoGo, false)
		GameUtil.SetActive(self._txtEmpty, true)
	end
end

function SeasonTotemUpView:_onClickLevelUp()
	local needCampLv = checknumber(self._nextConfig.campLv)

	if needCampLv > SeasonMainCampModel.instance:getCampLv() then
		FloatWordMgr.instance:show(lang(string.format("主营地%s级解锁", needCampLv)))

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

	SeasonModePveAgent.instance:sendPM_SMPVEUpgradeMainTotemPoleReq(self._raceType)
	self:close()
end

return SeasonTotemUpView
