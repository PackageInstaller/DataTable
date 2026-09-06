-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTotemPoleOtherView.lua

module("logic.extensions.season.view.SeasonTotemPoleOtherView", package.seeall)

local SeasonTotemPoleOtherView = class("SeasonTotemPoleOtherView", ViewComponent)

SeasonTotemPoleOtherView.refreshEffect = "20211028/xunlianchang/fx_ui_xlc_shuaxin_da.prefab"

function SeasonTotemPoleOtherView:ctor()
	SeasonTotemPoleOtherView.super.ctor(self)
end

function SeasonTotemPoleOtherView:unbindEvents()
	SeasonTotemPoleOtherView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)

	for i, item in ipairs(self._raceFilterTabs) do
		GameUtil.rmClickHandler(item)
	end

	for i, item in ipairs(self._totemItems) do
		-- block empty
	end

	for i, item in ipairs(self._skillItems) do
		GameUtil.rmClickHandler(item)
	end
end

function SeasonTotemPoleOtherView:bindEvents()
	SeasonTotemPoleOtherView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)

	for i, item in ipairs(self._raceFilterTabs) do
		GameUtil.addClickHandler(item, GameUtil.handler(self._onClickTab, self, i))
	end

	for i, item in ipairs(self._totemItems) do
		-- block empty
	end

	for i, item in ipairs(self._skillItems) do
		GameUtil.addClickHandler(item, GameUtil.handler(self._onClickSkill, self, i))
	end
end

function SeasonTotemPoleOtherView:buildUI()
	SeasonTotemPoleOtherView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtPower = self:getTxt("info/power/txtPower")
	self._txtLevel = self:getTxt("info/totempole/level/txtLevel")
	self._btnTips = self:getBtn("btnTip")

	local raceFilter = self:getGo("info/raceFilter")

	self._raceFilterTabs = {}
	self._raceFilterTabsReds = {}

	for i = 1, 6 do
		local item = goutil.findChild(raceFilter, string.format("attr_%s", i))

		table.insert(self._raceFilterTabs, item)

		local red = self:getGo("info/raceFilter/attr_" .. i .. "/redpoint")

		table.insert(self._raceFilterTabsReds, red)
	end

	self._totempoleIcon = self:getGo("info/totempole/icon")

	local totempole = self:getGo("info/totempole")

	self._totemItems = {}
	self._totemItemsReds = {}

	for i = 1, 6 do
		local item = goutil.findChild(totempole, string.format("totem_%s", i))

		table.insert(self._totemItems, item)

		local redpoint = goutil.findChild(totempole, string.format("totem_%s/redpoint", i))

		table.insert(self._totemItemsReds, redpoint)
	end

	local attrDesc = self:getGo("detail/attrLook/attrDesc/ViewPort/Content")

	self._attrDescItems = {}
	self._attrDescEffectParent = {}
	self._goEffect = self:getGo("detail/attrLook/effect")

	for i = 1, 6 do
		local txtDesc = goutil.findChildTextComponent(attrDesc, string.format("attrDesc_%s/txtDesc", i))

		table.insert(self._attrDescItems, txtDesc)
		table.insert(self._attrDescEffectParent, self:getGo("detail/attrLook/attrDesc/ViewPort/Content/attrDesc_" .. i))
	end

	local skill = self:getGo("detail/skill")

	self.skillGo = skill
	self._skillItems = {}

	for i = 1, 3 do
		local skillItem = goutil.findChild(skill, string.format("skillItem_%s", i))

		table.insert(self._skillItems, skillItem)
	end

	self._goldBarCon = self:getGo("goldBarCon")
	self._emptyTotem = self:getGo("detail/empty")
	self._effectCore = self:getGo("info/totempole/effect")
end

function SeasonTotemPoleOtherView:onExit()
	SeasonTotemPoleOtherView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTotemInfoUpdated, self._onTotemInfoUpdated, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTotemPropertyEffectUpdate, self._onTotemPropertyEffectUpdate, self)
	SeasonMainCampModel.instance:setCacheTotemSelectTabId(self._selectTabId)
end

function SeasonTotemPoleOtherView:onEnter()
	SeasonTotemPoleOtherView.super.onEnter(self)

	self._userId = SeasonModel.instance:getTeammateId()

	GlobalDispatcher:addListener(GlobalNotify.SeasonTotemInfoUpdated, self._onTotemInfoUpdated, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonTotemPropertyEffectUpdate, self._onTotemPropertyEffectUpdate, self)

	local tabId = SeasonMainCampModel.instance:getCacheTotemSelectTabId()

	self:_onClickTab(tabId)

	local seasonId = SeasonModel.instance:getSeasonId()
	local totemPolConfig = SeasonMainCampConfig.instance:getTotemPoleConfig(seasonId)

	SeasonMainCampController.instance:sendGetTotemInfo(self._userId)
	GameUtil.SetActive(self._btnTips, false)
end

function SeasonTotemPoleOtherView:_onTotemInfoUpdated()
	self:_updateTabSelectStates()
	self:_updateCurTabDetail()
	self:_updateSummary()
end

function SeasonTotemPoleOtherView:_updateTabSelectStates()
	for i, item in ipairs(self._raceFilterTabs) do
		GameUtil.SetActive(goutil.findChild(item, "select"), i == self._selectTabId)
		GameUtil.SetActive(self._raceFilterTabsReds[i], false)
	end

	GameUtil.setUIImageSpriteIdx(self._totempoleIcon, self._selectTabId - 1)
end

function SeasonTotemPoleOtherView:_updateCurTabDetail()
	local model = SeasonMainCampModel.instance
	local totemInfo = model:getTotemPoleInfoByRaceType(self._userId, self._selectTabId)

	if totemInfo then
		for i, item in ipairs(self._totemItems) do
			local lockGo = goutil.findChild(item, "lock")
			local icon = goutil.findChild(item, "icon")
			local redpoint = goutil.findChild(item, "redpoint")
			local level = totemInfo:getSubItemLv(i)
			local nextConfig = SeasonMainCampConfig.instance:getTotemPoleItemConfig(totemInfo.totemItemPlanId, i, level + 1)

			GameUtil.SetActive(lockGo, level <= totemInfo.mainTotemPoleLv and nextConfig ~= nil)
			GameUtil.SetActive(redpoint, false)

			local isGray = totemInfo:isSmallTotemCanUpgrade(i)

			GameUtil.SetGray(icon, isGray)
		end

		local isAct = totemInfo:isMainTotemCanUpgrade()

		if isAct then
			local level = totemInfo.mainTotemPoleLv
			local nextConfig = SeasonMainCampConfig.instance:getMainTotemConfig(totemInfo.mainTotemPlanId, level + 1)
			local isAllEnough = MaterialFacade.instance:isMatsEnough(nextConfig.cost)
			local needCampLv = checknumber(nextConfig.campLv)

			if needCampLv <= SeasonMainCampModel.instance:getCampLv() then
				-- block empty
			end
		end

		local mainTotemPoleLv = checknumber(totemInfo.mainTotemPoleLv)

		self._txtLevel.text = string.format("Lv.%s", mainTotemPoleLv)

		local totalAttrEntry = SeasonMainCampModel.instance:getTotemAttrEntryByTabId(self._userId, self._selectTabId)
		local zdl = AttrMo.calcFightPowerByAttrs(totalAttrEntry)

		self._txtPower.text = langPara("当前战力：%s", zdl or 0)
	end
end

function SeasonTotemPoleOtherView:_playCellEff(go, path, loop)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = path

	local function finishHandler()
		if not loop then
			self:_removeCellEff(go)
		end
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, loop, nil, finishHandler, nil, nil)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScaleXYZ(1, 0.6, 1)
	self._effs[go]:setLocalPos(0, 0, 0)
end

function SeasonTotemPoleOtherView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasonTotemPoleOtherView:_onTotemPropertyEffectUpdate()
	self:_playCellEff(self._goEffect, SeasonTotemPoleOtherView.refreshEffect, false)
end

function SeasonTotemPoleOtherView:_updateSummary()
	local totemInfo = SeasonMainCampModel.instance:getTotemPoleInfoByRaceType(self._userId, self._selectTabId)

	if totemInfo then
		local entries = totemInfo:getTotalEntry()
		local strEntries = SeasonMainCampController.instance:toAttrList(entries)
		local isEmpty = true

		for i, txtDesc in ipairs(self._attrDescItems) do
			if strEntries[i] then
				GameUtil.SetActive(txtDesc, true)

				txtDesc.text = strEntries[i]
				isEmpty = false
			else
				GameUtil.SetActive(txtDesc, false)
			end
		end

		goutil.setActive(self._emptyTotem, isEmpty)

		local seasonId = SeasonModel.instance:getSeasonId()
		local totemPolConfig = SeasonMainCampConfig.instance:getTotemPoleConfig(seasonId)
		local totemPoleRaceTypePlanId = totemPolConfig.totemPoleRaceTypePlanId
		local raceTypeConfig = SeasonMainCampConfig.instance:getTotemPoleRaceTypeConfig(totemPoleRaceTypePlanId, self._selectTabId)
		local configs = SeasonMainCampConfig.instance:getMainTotemConfigs(raceTypeConfig.mainTotemPlanId)
		local skillGroups = {}

		for i, v in ipairs(configs) do
			if v.isNextUpgrade == "0" then
				table.insert(skillGroups, v)
			end
		end

		local mainTotemPoleLv = checknumber((totemInfo or {}).mainTotemPoleLv)

		for i, skillItem in ipairs(self._skillItems) do
			local skillConfig = skillGroups[i]

			if skillConfig then
				GameUtil.SetActive(skillItem, true)

				local lockGo = goutil.findChild(skillItem, "lock")
				local txtLock = goutil.findChildTextComponent(skillItem, "lock/txtLock")
				local icon = goutil.findChildComponent(skillItem, "icon", "UIImageSpriteChange")

				if mainTotemPoleLv >= skillConfig.level then
					GameUtil.SetActive(lockGo, false)
					GameUtil.SetGray(skillItem, false)
				else
					GameUtil.SetActive(lockGo, true)

					txtLock.text = langPara("%s级激活", skillConfig.level)

					GameUtil.SetGray(skillItem, true)
				end

				icon:ChangeSprite(skillConfig.buffIcon)
			else
				GameUtil.SetActive(skillItem, false)
			end
		end
	end
end

function SeasonTotemPoleOtherView:_onClickTab(index)
	if index ~= self._selectTabId then
		self._selectTabId = index

		self:_updateTabSelectStates()
		self:_updateCurTabDetail()
		self:_updateSummary()

		local effetPath = string.format("20221028/saijiwanfa/fx_ui_sjwf_core_%s.prefab", index)

		self:_playCellEff(self._effectCore, effetPath, true)
	end
end

function SeasonTotemPoleOtherView:_onClickTotem(index)
	local totemInfo = SeasonMainCampModel.instance:getTotemPoleInfoByRaceType(self._userId, self._selectTabId)

	if totemInfo then
		UIStateManager.instance:push(ViewName.SeasonTotemActivationView, self._selectTabId, index, self._userId)
	end
end

function SeasonTotemPoleOtherView:_onClickLevelUp()
	local totemInfo = SeasonMainCampModel.instance:getTotemPoleInfoByRaceType(self._userId, self._selectTabId)

	if totemInfo then
		UIStateManager.instance:push(ViewName.SeasonTotemUpView, self._selectTabId, self._userId)
	end
end

function SeasonTotemPoleOtherView:_onClickTips()
	ViewMgr.instance:open(ViewName.RulesView, "seasonTotem_rule")
end

function SeasonTotemPoleOtherView:_onClickSkill(id)
	local id2Skillmap = SeasonMainCampConfig.instance:getTotemSkillCfgsById(self._selectTabId)
	local buffDesc = id2Skillmap[id].buffDesc

	CommonTipsMgr.instance:showTips(lang(buffDesc), self._skillItems[id])
end

return SeasonTotemPoleOtherView
