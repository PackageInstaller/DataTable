-- chunkname: @modules/logic/gm/view/FightGMDouQuQuTest.lua

module("modules.logic.gm.view.FightGMDouQuQuTest", package.seeall)

local FightGMDouQuQuTest = class("FightGMDouQuQuTest", FightBaseView)

function FightGMDouQuQuTest:onInitView()
	self._btnClose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn_close")
	self._btnEnemyAddSelect = gohelper.findChildClickWithDefaultAudio(self.viewGO, "centre/enemy/btn_add")
	self._btnPlayerAddSelect = gohelper.findChildClickWithDefaultAudio(self.viewGO, "centre/player/btn_add")
	self._btnEnterFight = gohelper.findChildClickWithDefaultAudio(self.viewGO, "centre/btn_enter_fight")
	self._btnMultiSimulate = gohelper.findChildClickWithDefaultAudio(self.viewGO, "centre/btn_multi_simulate")
	self._enemySelectItemContent = gohelper.findChild(self.viewGO, "centre/enemy/Scroll View/Viewport/Content")
	self._playerSelectItemContent = gohelper.findChild(self.viewGO, "centre/player/Scroll View/Viewport/Content")
	self._enemySelectedItemContent = gohelper.findChild(self.viewGO, "centre/selected/enemy_selected/Viewport/Content")
	self._playerSelectedItemContent = gohelper.findChild(self.viewGO, "centre/selected/player_selected/Viewport/Content")
	self._selectItem = gohelper.findChild(self.viewGO, "centre/enemy/Scroll View/Viewport/Content/item")
	self._pathInput = gohelper.findChildInputField(self.viewGO, "topLeft/InputField")
	self._battleIdInput = gohelper.findChildInputField(self.viewGO, "centre/battleIdInput/InputField")
	self._battleCountInput = gohelper.findChildInputField(self.viewGO, "centre/battleCountInput/InputField")
	self._logText = gohelper.findChildText(self.viewGO, "bottom/Scroll View/Viewport/Content/Text")
end

function FightGMDouQuQuTest:addEvents()
	self:com_registClick(self._btnClose, self.closeThis)
	self:com_registClick(self._btnEnemyAddSelect, self._onBtnEnemyAddSelect)
	self:com_registClick(self._btnPlayerAddSelect, self._onBtnPlayerAddSelect)
	self:com_registClick(self._btnEnterFight, self._onBtnEnterFight)
	self:com_registClick(self._btnMultiSimulate, self._onBtnMultiSimulate)
	self._pathInput:AddOnValueChanged(self._onPathInputChange, self)
	self._battleIdInput:AddOnValueChanged(self._onBattleIdInputChange, self)
	self._battleCountInput:AddOnValueChanged(self._onBattleCountInputChange, self)
end

function FightGMDouQuQuTest:onOpen()
	self._pathInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestLogPath))
	self._battleIdInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestBattleId))
	self._battleCountInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestBattleCount))

	self._enemySelectList = self:com_registViewItemList(self._selectItem, FightGMDouQuQuTestSelectItem, self._enemySelectItemContent)
	self._playerSelectList = self:com_registViewItemList(self._selectItem, FightGMDouQuQuTestSelectItem, self._playerSelectItemContent)
	self._enemySelectedList = self:com_registViewItemList(self._selectItem, FightGMDouQuQuTestSelectItem, self._enemySelectedItemContent)
	self._playerSelectedList = self:com_registViewItemList(self._selectItem, FightGMDouQuQuTestSelectItem, self._playerSelectedItemContent)
	self._enemySelectList.listType = "_enemySelectList"
	self._playerSelectList.listType = "_playerSelectList"
	self._enemySelectedList.listType = "_enemySelectedList"
	self._playerSelectedList.listType = "_playerSelectedList"
	self._configList = {}

	for i, v in ipairs(lua_activity174_test_bot.configList) do
		table.insert(self._configList, v)
	end

	self._enemySelectList:setDataList(self._configList)
	self._playerSelectList:setDataList(self._configList)
end

function FightGMDouQuQuTest:_onPathInputChange()
	local text = self._pathInput:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestLogPath, text)
end

function FightGMDouQuQuTest:_onBattleIdInputChange()
	local text = self._battleIdInput:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestBattleId, text)
end

function FightGMDouQuQuTest:_onBattleCountInputChange()
	local text = self._battleCountInput:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestBattleCount, text)
end

function FightGMDouQuQuTest:_onBtnEnemyAddSelect()
	local enemySelectedList = {}

	for i, v in ipairs(self._enemySelectedList) do
		table.insert(enemySelectedList, v.config)
	end

	for i = #self._enemySelectList, 1, -1 do
		if self._enemySelectList[i].selecting then
			local item = self._enemySelectList:removeIndex(i)

			table.insert(enemySelectedList, item.config)
		end
	end

	table.sort(enemySelectedList, function(item1, item2)
		return item1.robotId < item2.robotId
	end)
	self._enemySelectedList:setDataList(enemySelectedList)

	self._enemySelectList.lastSelectIndex = nil
end

function FightGMDouQuQuTest:_onBtnPlayerAddSelect()
	local playerSelectedList = {}

	for i, v in ipairs(self._playerSelectedList) do
		table.insert(playerSelectedList, v.config)
	end

	for i = #self._playerSelectList, 1, -1 do
		if self._playerSelectList[i].selecting then
			local item = self._playerSelectList:removeIndex(i)

			table.insert(playerSelectedList, item.config)
		end
	end

	table.sort(playerSelectedList, function(item1, item2)
		return item1.robotId < item2.robotId
	end)
	self._playerSelectedList:setDataList(playerSelectedList)

	self._playerSelectList.lastSelectIndex = nil
end

function FightGMDouQuQuTest:_getGMStr(fightType)
	local path = self._pathInput:GetText()

	if fightType == 2 and string.nilorempty(path) then
		self._logText.text = "未配置导出路径"

		return
	end

	local player = ""

	if #self._playerSelectedList < 1 or #self._enemySelectedList < 1 then
		self._logText.text = "未选择对战机器人"

		return
	end

	if fightType == 1 and (#self._playerSelectedList > 1 or #self._enemySelectedList > 1) then
		self._logText.text = "多个机器人无法进入战斗"

		return
	end

	for i, v in ipairs(self._playerSelectedList) do
		if i > 1 then
			player = player .. "#"
		end

		player = player .. v.config.robotId
	end

	local enemy = ""

	for i, v in ipairs(self._enemySelectedList) do
		if i > 1 then
			enemy = enemy .. "#"
		end

		enemy = enemy .. v.config.robotId
	end

	local battleId = tonumber(self._battleIdInput:GetText())

	if not lua_battle.configDict[battleId] then
		self._logText.text = "战斗id不存在"

		return
	end

	local count = tonumber(self._battleCountInput:GetText())

	if not count then
		self._logText.text = "对战次数未配置"

		return
	end

	return (string.format("act174Test %s %s %s %s %s %s", path, player, enemy, battleId, count, fightType))
end

function FightGMDouQuQuTest:_onBtnEnterFight()
	local str = self:_getGMStr(1)

	if str then
		GMRpc.instance:sendGMRequest(str)
	end
end

function FightGMDouQuQuTest:_onBtnMultiSimulate()
	local str = self:_getGMStr(2)

	if str then
		GMRpc.instance:sendGMRequest(str)
	end
end

function FightGMDouQuQuTest:onDestructor()
	self._pathInput:RemoveOnValueChanged()
	self._battleIdInput:RemoveOnValueChanged()
	self._battleCountInput:RemoveOnValueChanged()
end

return FightGMDouQuQuTest
