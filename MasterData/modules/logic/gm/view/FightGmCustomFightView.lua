-- chunkname: @modules/logic/gm/view/FightGmCustomFightView.lua

module("modules.logic.gm.view.FightGmCustomFightView", package.seeall)

local FightGmCustomFightView = class("FightGmCustomFightView", FightBaseView)

FightGmCustomFightView.SelectItemType = {
	Team = 1,
	Equip = 3,
	Character = 2
}

function FightGmCustomFightView:onInitView()
	self.teamNameText = gohelper.findChildText(self.viewGO, "topLeft/teamName")
	self.selectBtnBg = gohelper.findChildClickWithDefaultAudio(self.viewGO, "selectPart")
	self._btnClose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn_close")
	self.btn_teammodel = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topLeft/btn_teammodel")
	self.selectPart = gohelper.findChild(self.viewGO, "selectPart")
	self.searchInput = gohelper.findChildInputField(self.viewGO, "selectPart/searchInput")
	self.selectItemContent = gohelper.findChild(self.viewGO, "selectPart/Scroll View/Viewport/Content")
	self.selectItem = gohelper.findChild(self.viewGO, "selectPart/Scroll View/Viewport/Content/item")
	self.selectScrollView = self:com_registViewItemList(self.selectItem, FightGmCustomFightSelectItem, self.selectItemContent)
	self.characterItemRoot = gohelper.findChild(self.viewGO, "centre/grid")
	self.characterItem = gohelper.findChild(self.viewGO, "centre/grid/1")
	self.characterScrollView = self:com_registViewItemList(self.characterItem, FightGmCustomFightCharacterItem, self.characterItemRoot)
	self.battleIdInput = gohelper.findChildInputField(self.viewGO, "centre/battleIdPart/battleInput")
	self.exRuleInput = gohelper.findChildInputField(self.viewGO, "centre/rulePart/ruleInput")
	self.winRoundInput = gohelper.findChildInputField(self.viewGO, "centre/rulePart/winRoundLabel")
	self.loopCountInput = gohelper.findChildInputField(self.viewGO, "centre/rulePart/loopCount")
	self.btnRun = gohelper.findChildClickWithDefaultAudio(self.viewGO, "bottom/btn_run")
	self.toggle = gohelper.findChildToggle(self.viewGO, "bottom/Toggle")
end

function FightGmCustomFightView:addEvents()
	self:com_registClick(self._btnClose, self.closeThis)
	self:com_registClick(self.btn_teammodel, self._onTeamModelClick)
	self:com_registClick(self.selectBtnBg, self._onSelectBtnClick)
	self.searchInput:AddOnValueChanged(self.onSearchInputValueChanged, self)
	self.battleIdInput:AddOnValueChanged(self.onBattleIdInputValueChanged, self)
	self.exRuleInput:AddOnValueChanged(self.onExRuleInputValueChanged, self)
	self.winRoundInput:AddOnValueChanged(self.onWinRoundInputValueChanged, self)
	self.loopCountInput:AddOnValueChanged(self.onLoopCountInputValueChanged, self)
	self:com_registClick(self.btnRun, self.onBtnRunClick)
end

function FightGmCustomFightView:onSearchInputValueChanged()
	local searchText = self.searchInput:GetText()

	if searchText == "" then
		for i, v in ipairs(self.selectScrollView) do
			gohelper.setActive(v.GAMEOBJECT, true)
		end
	else
		for i, v in ipairs(self.selectScrollView) do
			local tarStr = v.text.text

			if string.find(tarStr, searchText) or string.find(tostring(v.itemData.id), searchText) then
				gohelper.setActive(v.GAMEOBJECT, true)
			else
				gohelper.setActive(v.GAMEOBJECT, false)
			end
		end
	end
end

function FightGmCustomFightView:_onSelectBtnClick()
	self.selectPart:SetActive(false)
end

function FightGmCustomFightView:onBtnRunClick()
	local battleId = self.battleIdInput:GetText()
	local exRule = self.exRuleInput:GetText()
	local winRound = self.winRoundInput:GetText()
	local loopCount = self.loopCountInput:GetText()
	local req = FightToolModule_pb.EnterCustomFightRequest()

	req.battleId = tonumber(battleId) or 0
	req.extraRule = exRule
	req.round = tonumber(winRound) or 0
	req.fightNum = tonumber(loopCount) or 0
	req.fightType = self.toggle.isOn and 1 or 2

	for i = 1, #self.characterScrollView do
		local data = self.characterScrollView[i].data

		if data.heroId ~= 0 then
			local proto = FightToolModule_pb.CustomFightEntityInfo()

			proto.pos = data.pos
			proto.heroId = data.heroId
			proto.level = data.level
			proto.exLevel = data.exLevel
			proto.equipId = data.equipId
			proto.equipLevel = data.equipLevel
			proto.equipExLevel = data.equipExLevel
			proto.talentLevel = data.talentLevel
			proto.talentStyle = data.talentStyle
			proto.factsId = data.factsId
			proto.extraPassiveSkill = data.extraPassiveSkill
			proto.extraAttr = data.extraAttr
			proto.param = data.param

			table.insert(req.entityInfos, proto)
		end
	end

	FightToolRpc.instance:sendMsg(req)
end

function FightGmCustomFightView:onBattleIdInputValueChanged()
	return
end

function FightGmCustomFightView:onExRuleInputValueChanged()
	return
end

function FightGmCustomFightView:onWinRoundInputValueChanged()
	return
end

function FightGmCustomFightView:onLoopCountInputValueChanged()
	return
end

function FightGmCustomFightView:getConfigList(configList)
	local list = {}

	for i, v in ipairs(configList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.id > b.id
	end)

	return list
end

function FightGmCustomFightView:onClickSelectCharacter(characterView)
	self.selectPart:SetActive(true)

	local list = self:getConfigList(lua_character.configList)

	self.selectItemType = FightGmCustomFightView.SelectItemType.Character
	self.curSelectCharacterView = characterView

	self.selectScrollView:setDataList(list)
end

function FightGmCustomFightView:onClickEquipCharacter(characterView)
	self.selectPart:SetActive(true)

	local list = self:getConfigList(lua_equip.configList)

	self.selectItemType = FightGmCustomFightView.SelectItemType.Equip
	self.curSelectCharacterView = characterView

	self.selectScrollView:setDataList(list)
end

function FightGmCustomFightView:setCharacterData(characterConfig)
	local proto = FightToolModule_pb.CustomFightEntityInfo()

	proto.pos = self.curSelectCharacterView:getSelfIndex()
	proto.heroId = characterConfig.id
	proto.level = tonumber(lua_auto_fight_tool_const.configDict[1001].value)
	proto.exLevel = tonumber(lua_auto_fight_tool_const.configDict[1002].value)
	proto.equipId = tonumber(lua_auto_fight_tool_const.configDict[1003].value)
	proto.equipLevel = tonumber(lua_auto_fight_tool_const.configDict[1004].value)
	proto.equipExLevel = tonumber(lua_auto_fight_tool_const.configDict[1005].value)
	proto.talentLevel = tonumber(lua_auto_fight_tool_const.configDict[1006].value)

	local characterData = CustomFightEntityInfoData.New(proto)

	FightDataUtil.coverData(characterData, self.curSelectCharacterView.data)
	self.curSelectCharacterView:onRefreshItemData(self.curSelectCharacterView.data)
end

function FightGmCustomFightView:setEquipData(equipConfig)
	self.curSelectCharacterView.data.equipId = equipConfig.id

	self.curSelectCharacterView:onRefreshItemData(self.curSelectCharacterView.data)
end

function FightGmCustomFightView:_onTeamModelClick()
	self.selectPart:SetActive(true)

	local list = self:getConfigList(lua_auto_fight_team_tool.configList)

	self.selectItemType = FightGmCustomFightView.SelectItemType.Team

	self.selectScrollView:setDataList(list)
end

function FightGmCustomFightView:setTeamData(teamData)
	self.teamData = teamData
	self.teamNameText.text = teamData.name

	local listData = {}

	for i = 1, 4 do
		local configId = teamData["position" .. i]
		local config = lua_auto_fight_role_tool.configDict[configId]

		if config then
			local proto = FightToolModule_pb.CustomFightEntityInfo()

			proto.pos = i
			proto.heroId = config.roleId
			proto.level = config.lv
			proto.exLevel = config.exLv
			proto.equipId = config.equip
			proto.equipLevel = config.equipLv
			proto.equipExLevel = config.equipExLv
			proto.talentLevel = config.talentLv
			proto.talentStyle = config.talentStyle
			proto.factsId = config.destiny

			local characterData = CustomFightEntityInfoData.New(proto)

			table.insert(listData, characterData)
		end
	end

	self.characterScrollView:setDataList(listData)
end

function FightGmCustomFightView:onOpen()
	local localTeamData = PlayerPrefsHelper.getString(PlayerPrefsKey.GMFightCustomFightTeamList)

	if not string.nilorempty(localTeamData) then
		self.characterScrollView:setDataList(cjson.decode(localTeamData))
	else
		local listData = {}

		for i = 1, 4 do
			local proto = FightToolModule_pb.CustomFightEntityInfo()

			proto.pos = i

			local characterData = CustomFightEntityInfoData.New(proto)

			table.insert(listData, characterData)
		end

		self.characterScrollView:setDataList(listData)
	end

	self.battleIdInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMFightCustomFightBattleId))

	self.teamNameText.text = PlayerPrefsHelper.getString(PlayerPrefsKey.GMFightCustomFightTeamName)

	self.exRuleInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMFightCustomFightExRule))
	self.winRoundInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMFightCustomFightWinRound))
	self.loopCountInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMFightCustomFightLoopCount))

	self.toggle.isOn = PlayerPrefsHelper.getString(PlayerPrefsKey.GMFightCustomFightClientEnterFight) == "true"
end

function FightGmCustomFightView:onDestructor()
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMFightCustomFightTeamList, cjson.encode(self.characterScrollView.dataList))
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMFightCustomFightTeamName, self.teamNameText.text)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMFightCustomFightBattleId, self.battleIdInput:GetText())
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMFightCustomFightExRule, self.exRuleInput:GetText())
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMFightCustomFightWinRound, self.winRoundInput:GetText())
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMFightCustomFightLoopCount, self.loopCountInput:GetText())
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMFightCustomFightClientEnterFight, tostring(self.toggle.isOn))
	self.searchInput:RemoveOnValueChanged()
	self.battleIdInput:RemoveOnValueChanged()
	self.exRuleInput:RemoveOnValueChanged()
	self.winRoundInput:RemoveOnValueChanged()
	self.loopCountInput:RemoveOnValueChanged()
end

return FightGmCustomFightView
