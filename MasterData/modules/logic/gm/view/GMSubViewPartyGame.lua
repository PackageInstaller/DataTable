-- chunkname: @modules/logic/gm/view/GMSubViewPartyGame.lua

module("modules.logic.gm.view.GMSubViewPartyGame", package.seeall)

local GMSubViewPartyGame = class("GMSubViewPartyGame", GMSubViewBase)
local allGameNames = {
	"1.抢钱",
	"2.找路",
	"3.躲避冲撞",
	"4.木头人",
	"5.安检",
	"6.抢格子",
	"7.博弈决策",
	"8.抢地盘",
	"9.踩格子",
	"10.吃豆人",
	"11.叠叠乐",
	"12.整理分类",
	"13.找门",
	"14.找爱心",
	"15.哪个多",
	"16.抢区域",
	"17.找人",
	"18.拼图",
	"19.拼道路",
	"100.对决"
}
local gameIds = {}

for k, v in pairs(allGameNames) do
	local id = string.match(v, "^([0-9]+)%.")

	id = tonumber(id) or 1
	gameIds[k] = id
end

function GMSubViewPartyGame:ctor()
	self.tabName = "PartyGame"
end

function GMSubViewPartyGame:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewPartyGame:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewPartyGame:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("PartyGame游戏【单人测试版单机版】")
	self:addLineIndex()

	self._gameDrop1 = self:addDropDown(self:getLineGroup(), "游戏选择", allGameNames, nil, nil, {
		total_w = 600,
		fsize = 25,
		drop_w = 500,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})

	local selectVal1 = PlayerPrefsHelper.getNumber("GM_" .. self.__cname .. "_localGameId", 0)

	self._gameDrop1:SetValue(selectVal1)
	self.addButton(self, self:getLineGroup(), "进入玩法", self.enterLocalGame, self)
	self:addLineIndex()

	self.debugToggle3 = self.addToggle(self, self:getLineGroup(), "游戏不结束", self.onDebugStateChange3, self)
	self.debugToggle3.isOn = PartyGameEnum.PartyGameConfigData.DebugGameNoOver
	self.debugToggle4 = self.addToggle(self, self:getLineGroup(), "关闭单机随机种子", self.onDebugStateChange4, self)
	self.debugToggle4.isOn = PartyGameEnum.PartyGameConfigData.CloseClientRandom
	self.debugToggleAI = self.addToggle(self, self:getLineGroup(), "是否托管", self.onDebugStateChangeAI, self)
	self.debugToggleAI.isOn = PartyGame_GM.GetIsUseAI()
	self.debugToggleLm = self.addToggle(self, self:getLineGroup(), "使用Lightmap", self.onDebugStateChangeLm, self)
	self.debugToggleLm.isOn = PartyGameModel.instance:isUseLmScene()

	self:addTitleSplitLine("PartyGame游戏【联机版】")
	self:addLineIndex()

	self.debugToggle2 = self.addToggle(self, self:getLineGroup(), "是否开启调试", self.onDebugStateChange2, self)
	self.debugToggle2.isOn = PartyGameController.instance:getIsDebug()
	self._gameDrop2 = self.addDropDown(self, self:getLineGroup(), "游戏选择", allGameNames, self._onDropValueChange2, self, {
		total_w = 600,
		fsize = 25,
		drop_w = 500,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})

	local selectVal2 = PlayerPrefsHelper.getNumber("GM_" .. self.__cname .. "_matchGameId", 0)

	self._gameDrop2:SetValue(selectVal2)
	self.addButton(self, self:getLineGroup(), "匹配进入游戏【等待15s】", self.matchPartyGame2, self)
	self:addLineIndex()

	self.debugToggle = self.addToggle(self, self:getLineGroup(), "日志调试", self.onDebugStateChange, self)
	self.debugToggle.isOn = PartyGameEnum.PartyGameConfigData.DebugLockStep
	self.debugToggle5 = self.addToggle(self, self:getLineGroup(), "游戏快照", self.onDebugStateChange5, self)
	self.debugToggle5.isOn = PartyGameEnum.PartyGameConfigData.DebugLockStepWorldRecord
	self.debugToggle6 = self.addToggle(self, self:getLineGroup(), "机器人调试", self.onDebugStateChange6, self)
	self.debugToggle6.isOn = PartyGameEnum.PartyGameConfigData.MainPlayerIsRobot
	self.debugToggle7 = self.addToggle(self, self:getLineGroup(), "所有调试", self.onDebugStateChange7, self)
	self.debugToggle7.isOn = PartyGameEnum.PartyGameConfigData.DebugLockStep and PartyGameEnum.PartyGameConfigData.DebugLockStepWorldRecord and PartyGameEnum.PartyGameConfigData.MainPlayerIsRobot
	self.debugTogglestall = self.addToggle(self, self:getLineGroup(), "卡顿调试", self.onDebugStateChangeStall, self)

	self:addLineIndex()

	self.debugToggle8 = self:addToggle(self:getLineGroup(), "人数")
	self.debugInput = self:addInputText(self:getLineGroup(), "8")
	self.debugToggle9 = self:addToggle(self:getLineGroup(), "单人快速匹配")

	self:_onDropValueChange2()
	self.addButton(self, self:getLineGroup(), "对决我方必赢", self.cardDropWin, self)
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "直接结算", self.debuggameover, self)

	self._txtGMInput = self:addInputText(self:getLineGroup(), "", "GM ...", nil, nil, {
		w = 800
	})

	self.addButton(self, self:getLineGroup(), "执行GM", self.dokcpgm, self)
	self:addTitleSplitLine("PartyGame 编辑器")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "16.抢区域区域编辑", self.onClickEditGame16, self)
	self.addButton(self, self:getLineGroup(), "100.对决小游戏timeline编辑", self.onClickEditCardDropGame, self)
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "对决小游戏卡牌伤害单元测试")

	self.cardDropInputMyCardId = self:addInputText(self:getLineGroup(), "", "我方卡牌id")
	self.cardDropInputEnemyCardId = self:addInputText(self:getLineGroup(), "", "敌方卡牌id")

	self:addLineIndex()

	self.cardDropInputMyDamage = self:addInputText(self:getLineGroup(), "0", "我方伤害")
	self.cardDropInputEnemyDamage = self:addInputText(self:getLineGroup(), "0", "敌方伤害")

	self:addLineIndex()

	local damageTypeNameList = {
		"普通伤害",
		"暴击伤害",
		"回血",
		"克制伤害"
	}

	self.damage1Drop = self:addDropDown(self:getLineGroup(), "我方伤害类型", damageTypeNameList, nil, nil, {
		label_w = 600,
		total_w = 600
	})
	self.damage2Drop = self:addDropDown(self:getLineGroup(), "敌方伤害类型", damageTypeNameList, nil, nil, {
		label_w = 600,
		total_w = 600
	})

	self:addLineIndex()

	self.cardDropMyToggle = self:addToggle(self:getLineGroup(), "我方卡牌是否生效")
	self.cardDropEnemyToggle = self:addToggle(self:getLineGroup(), "敌方卡牌是否生效")

	self.addButton(self, self:getLineGroup(), "开始测试", self.onClickCardDropUnitTest, self)
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "播放对决小游戏timeline:")

	self.timelineNameInput = self:addInputText(self:getLineGroup(), "", "timeline名称...")
	self.attackerNameList = {
		"我方",
		"敌方"
	}
	self.attackDrop = self:addDropDown(self:getLineGroup(), "", self.attackerNameList, nil, nil, {
		total_w = 150,
		drop_w = 150,
		label_w = 0
	})

	self.addButton(self, self:getLineGroup(), "播放timeline", self.onClickPlayTimeline, self)
	self:addTitleSplitLine("测试选择")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "测试选择奖励", self.testSelectReward, self)
	self:addTitleSplitLine("资源版本")
	self:addLineIndex()

	self._resVersion = self:addInputText(self:getLineGroup(), PartyGameRoomModel._fakeResVersion or self:_getResVersion(), "指定版本号")

	self.addButton(self, self:getLineGroup(), "使用版本号", self._useVersion, self)
	self.addButton(self, self:getLineGroup(), "进入试玩界面", self._enterTrial, self)
end

function GMSubViewPartyGame:cardDropWin()
	PartyGame_GM.CardDropWin()
end

function GMSubViewPartyGame:_useVersion()
	local resVersion = self._resVersion:GetText()
	local paramList = string.splitToNumber(resVersion, ".")

	if paramList and #paramList == 3 then
		local first = paramList[1]
		local second = paramList[2]
		local third = paramList[3]
		local version, correct = PartyGameRoomModel.getVersion(first, second, third)

		if correct then
			PartyGameRoomModel._fakeResVersion = resVersion

			logError("版本号正确", resVersion, version)
		else
			logError("版本号格式错误", resVersion)
		end
	else
		logError("版本号格式错误", resVersion)
	end
end

function GMSubViewPartyGame:_getResVersion()
	local versionData = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalVersionData
	local first = versionData.first
	local second = versionData.second
	local third = versionData.third

	return string.format("%s.%s.%s", first, second, third)
end

function GMSubViewPartyGame:onClickCardDropUnitTest()
	local myCardId = tonumber(self.cardDropInputMyCardId:GetText())

	if not myCardId or myCardId < 1 then
		return
	end

	local enemyCardId = tonumber(self.cardDropInputEnemyCardId:GetText())

	if not enemyCardId or enemyCardId < 1 then
		return
	end

	local myDamage = tonumber(self.cardDropInputMyDamage:GetText())

	if not myDamage then
		return
	end

	local enemyDamage = tonumber(self.cardDropInputEnemyDamage:GetText())

	if not enemyDamage then
		return
	end

	local myDamageType = self.damage1Drop:GetValue() + 1
	local enemyDamageType = self.damage2Drop:GetValue() + 1
	local myCardValid = self.cardDropMyToggle.isOn
	local enemyCardValid = self.cardDropEnemyToggle.isOn
	local interface = PartyGameCSDefine.CardDropInterfaceCs

	interface.UnitTestCompareTwoCo(myCardId, enemyCardId, myDamage, enemyDamage, myCardValid, enemyCardValid, myDamageType, enemyDamageType)
end

function GMSubViewPartyGame:onClickPlayTimeline()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.PartyGame then
		return
	end

	local curPartyGame = PartyGameController.instance:getCurPartyGame()

	if not curPartyGame then
		return
	end

	local gameId = curPartyGame:getGameId()

	if gameId ~= 100 then
		return
	end

	local timelineName = self.timelineNameInput:GetText()

	if string.nilorempty(timelineName) then
		return
	end

	local attackSide = self.attackDrop:GetValue()
	local interface = PartyGameCSDefine.CardDropInterfaceCs
	local uid = attackSide == 0 and interface.GetMyPlayerUid() or interface.GetEnemyPlayerUid()

	CardDropTimelineController.instance:playTimeline(uid, timelineName)
	self:closeThis()
end

function GMSubViewPartyGame:onClickEditGame16()
	ViewMgr.instance:openView(ViewName.SnatchAreaEditGameView)
	self:closeThis()
end

function GMSubViewPartyGame:onClickEditCardDropGame()
	CardDropGameController.EditMode = true

	PartyGameController.instance:enterGame(100, true)
	PlayerPrefsHelper.setNumber("GM_" .. self.__cname .. "_localGameId", self._gameDrop1:GetValue())
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.LoginView)
	ViewMgr.instance:closeView(ViewName.SimulateLoginView)
end

function GMSubViewPartyGame:matchPartyGame()
	GMRpc.instance:sendGMRequest("partyMatch 1")
end

function GMSubViewPartyGame:enterLocalGame()
	PartyGameRpc.instance:setUpKcpRpcCallBack()
	PartyGameController.instance:setUpLuaCallBack()

	local id = gameIds[self._gameDrop1:GetValue() + 1]

	PartyGameController.instance:enterGame(id, true)
	PlayerPrefsHelper.setNumber("GM_" .. self.__cname .. "_localGameId", self._gameDrop1:GetValue())
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.LoginView)
	ViewMgr.instance:closeView(ViewName.SimulateLoginView)
end

function GMSubViewPartyGame:onDebugStateChangeAI()
	PartyGame_GM.SetIsUseAI(self.debugToggleAI.isOn)
end

function GMSubViewPartyGame:onDebugStateChangeLm()
	PartyGameModel.instance:setUseLmScene(self.debugToggleLm.isOn)
end

function GMSubViewPartyGame:_onDropValueChange2()
	if not self.debugToggle8 then
		return
	end

	local id = gameIds[self._gameDrop2:GetValue() + 1]
	local co = lua_partygame_param.configDict[id]

	if not co then
		return
	end

	local dict = GameUtil.splitString2(co.weight, true)

	if not dict or not dict[1] then
		return
	end

	self.debugToggle8.isOn = true

	self.debugInput:SetText(tostring(dict[1][1]))
end

function GMSubViewPartyGame:matchPartyGame2()
	local id = gameIds[self._gameDrop2:GetValue() + 1]

	PartyGameController.instance:setDebugGameId(id)

	if PartyGameController.instance:getInMatch() then
		logWarn("已经在匹配中")

		return
	end

	if self.debugToggle8.isOn and self.debugToggle2.isOn then
		PartyGame_GM.SetPlayerNum(tonumber(self.debugInput:GetText()) or 0)
	else
		PartyGame_GM.SetPlayerNum(0)
	end

	PlayerPrefsHelper.setNumber("GM_" .. self.__cname .. "_matchGameId", self._gameDrop2:GetValue())

	if self.debugToggle9.isOn then
		GMRpc.instance:sendGMRequest("partyMatchFast")
	else
		GMRpc.instance:sendGMRequest("partyMatch 2")
	end

	PartyGameController.instance:gmEnterMatch()
end

function GMSubViewPartyGame:debuggameover()
	PartyGame_GM.GameOver()
end

function GMSubViewPartyGame:dokcpgm()
	PartyGame_GM.CMD(self._txtGMInput:GetText())
end

function GMSubViewPartyGame:onDebugStateChange()
	PartyGameEnum.PartyGameConfigData.DebugLockStep = self.debugToggle.isOn
end

function GMSubViewPartyGame:onDebugStateChange3()
	PartyGameEnum.PartyGameConfigData.DebugLockStep = self.debugToggle3.isOn
	PartyGameEnum.PartyGameConfigData.DebugGameNoOver = self.debugToggle3.isOn
end

function GMSubViewPartyGame:onDebugStateChange4()
	PartyGameEnum.PartyGameConfigData.CloseClientRandom = self.debugToggle4.isOn
end

function GMSubViewPartyGame:onDebugStateChange2()
	PartyGameController.instance:setIsDebug(self.debugToggle2.isOn)
end

function GMSubViewPartyGame:testSelectReward()
	local battleRewardMo = PartyGameModel.instance:getCurBattleRewardInfo()

	if battleRewardMo == nil then
		return
	end

	local canSelectCount = battleRewardMo.selectCount
	local allIds = battleRewardMo.cardIds
	local selectReward = {}

	for i = 1, canSelectCount do
		table.insert(selectReward, allIds[i])
	end

	PartyGameRpc.instance:sendSelectCardRewardRequest(selectReward)
end

function GMSubViewPartyGame:onDebugStateChange5()
	PartyGameEnum.PartyGameConfigData.DebugLockStepWorldRecord = self.debugToggle5.isOn
end

function GMSubViewPartyGame:onDebugStateChange6()
	PartyGameEnum.PartyGameConfigData.MainPlayerIsRobot = self.debugToggle6.isOn
end

function GMSubViewPartyGame:onDebugStateChange7()
	self.debugToggle6.isOn = self.debugToggle7.isOn
	self.debugToggle5.isOn = self.debugToggle7.isOn
	self.debugToggle.isOn = self.debugToggle7.isOn
end

function GMSubViewPartyGame:_enterTrial()
	ViewMgr.instance:openView(ViewName.PartyGameLobbyTrialView)
end

function GMSubViewPartyGame:onDebugStateChangeStall()
	local stallDebug = self.debugTogglestall.isOn and 1 or 0

	UnityEngine.PlayerPrefs.SetInt("stallDebug", stallDebug)
end

UnityEngine.PlayerPrefs.SetInt("stallDebug", 0)

return GMSubViewPartyGame
