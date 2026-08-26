-- chunkname: @modules/logic/gm/view/GMSubViewBattle.lua

module("modules.logic.gm.view.GMSubViewBattle", package.seeall)

local GMSubViewBattle = class("GMSubViewBattle", GMSubViewBase)

function GMSubViewBattle:ctor()
	self.tabName = "战斗"
end

function GMSubViewBattle:initViewContent()
	if self._isInit then
		return
	end

	self.addButton(self, "L0", "发送战斗日志到企业微信", self.onClickSendFightLogBtn, self)
	self.addButton(self, "L1", "打印出角色平均伤害，平均承伤，平均治疗", self._onClickShowBattleCharaterParam, self)
	self.addButton(self, "L2", "开启战斗录制", self._onClickEnableGMFightRecord, self)
	self.addButton(self, "L2", "保存战斗录制", self._onClickSaveRecord, self)
	self.addButton(self, "L2", "选取录像文件", self._onClickGMFightRecordReplay, self)
	self.addButton(self, "L3", "打开战场日志", self._onClickGMFightLog, self)
	self.addButton(self, "L3", "复制最后一回合协议数据", self.onClickCopyLatRoundProtoDataNormal, self)
	self:addLabel("L4", "通过战斗id进入一牌一动")
	self.addInputText(self, "L4", PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, ""), nil, self._onLastBattleIdYiPaiYiDongChange, self)
	self.addButton(self, "L4", "进入战斗", self._onClickEnterYiPaiYiDong, self)
	self:addLabel("L5", "实时统计buff类层数 : ")

	self.buffTypeInput = self:addInputText("L5", "6003", "buff类id")
	self.statBuffToggle = self.addToggle(self, "L5", "", self.onStatBuffToggleValueChange, self)
	self.statBuffToggle.isOn = GMFightController.instance:statingBuffType()
	self.effectTypeInput = self:addInputText("L6", "", "指定effectType: id1;id2;id2", nil, nil, {
		w = 600
	})

	self.addButton(self, "L6", "复制最后一回合处理后的数据", self.onClickCopyLatRoundDataForClient, self)
	self.addButton(self, "L7", "复制最后一回合处理前的数据", self.onClickCopyLastOriginRoundDataForClient, self)
	self.addButton(self, "L7", "复制最后一回合protobuff数据", self.onClickCopyLastSrcRoundProtoData, self)
	self:addLabel("L8", "设定战斗版本号(本次登录有效)")
	self.addInputText(self, "L8", FightModel.GMForceVersion or "版本号", nil, self._onVersionChange, self)
	self.addButton(self, "L9", "使用新卡牌代码逻辑", self.onClickUseNewCardScript, self)
	self.addButton(self, "L9", "使用旧卡牌代码逻辑", self.onClickUseOldCardScript, self)

	self.rightTopElementsInput = self:addInputText("L10", "", "显示右边上层UI", nil, nil, {
		w = 600
	})

	self.addButton(self, "L10", "显示右边上层UI", self.onClickShowRightElements, self)

	local tempTable = {}

	for _, element in pairs(FightRightElementEnum.Elements) do
		table.insert(tempTable, element)
	end

	self.rightTopElementsInput:SetText(table.concat(tempTable, ","))

	self.rightBottomElementsInput = self:addInputText("L11", "", "显示右边低层UI", nil, nil, {
		w = 600
	})

	self.addButton(self, "L11", "显示所有底层UI", self.onClickShowRightBottomElements, self)

	tempTable = {}

	for _, element in pairs(FightRightBottomElementEnum.Elements) do
		table.insert(tempTable, element)
	end

	self.rightBottomElementsInput:SetText(table.concat(tempTable, ","))
	self:addLabel("L12", "艾吉奥自动战斗释放qte顺序")
	self.addInputText(self, "L12", PlayerPrefsHelper.getString(PlayerPrefsKey.GMAiJiAoQteAutoSequence, ""), nil, self.onGMAiJiAoQteAutoSequence, self)
	self.addButton(self, "L12", "设置", self.onClickSetAiJiAoAutoSequence, self)
	self.addButton(self, "L12", "取消", self.onClickRemoveAiJiAoAutoSequence, self)

	self._isInit = true
end

function GMSubViewBattle:onGMAiJiAoQteAutoSequence(value)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMAiJiAoQteAutoSequence, value)
end

function GMSubViewBattle:onClickSetAiJiAoAutoSequence()
	local str = PlayerPrefsHelper.getString(PlayerPrefsKey.GMAiJiAoQteAutoSequence, "")
	local data = FightDataModel.instance:initAiJiAoAutoSequenceForGM()

	data.autoSequence = {}
	data.index = 0

	for i = 1, #str do
		local char = string.sub(str, i, i)
		local num = tonumber(char)

		if num then
			table.insert(data.autoSequence, num)
		end
	end
end

function GMSubViewBattle:onClickRemoveAiJiAoAutoSequence()
	FightDataModel.instance.aiJiAoAutoSequenceForGM = nil
end

function GMSubViewBattle:onClickSendFightLogBtn()
	SendWeWorkFileHelper.sendFightLogFile()
end

function GMSubViewBattle:onClickShowRightElements()
	local fightViewContainer = ViewMgr.instance:getContainer(ViewName.FightView)

	if not fightViewContainer then
		return
	end

	local inputList = self.rightTopElementsInput:GetText()

	if string.nilorempty(inputList) then
		for _, element in pairs(FightRightElementEnum.Elements) do
			FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, element)
		end

		return
	end

	local list = string.splitToNumber(inputList, ",")

	for _, element in pairs(FightRightElementEnum.Elements) do
		if tabletool.indexOf(list, element) then
			FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, element)
		else
			FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, element)
		end
	end
end

function GMSubViewBattle:onClickShowRightBottomElements()
	local fightViewContainer = ViewMgr.instance:getContainer(ViewName.FightView)

	if not fightViewContainer then
		return
	end

	local inputList = self.rightBottomElementsInput:GetText()

	if string.nilorempty(inputList) then
		for _, element in pairs(FightRightBottomElementEnum.Elements) do
			FightController.instance:dispatchEvent(FightEvent.RightBottomElements_HideElement, element)
		end

		return
	end

	local list = string.splitToNumber(inputList, ",")

	for _, element in pairs(FightRightBottomElementEnum.Elements) do
		if tabletool.indexOf(list, element) then
			FightController.instance:dispatchEvent(FightEvent.RightBottomElements_ShowElement, element)
		else
			FightController.instance:dispatchEvent(FightEvent.RightBottomElements_HideElement, element)
		end
	end
end

function GMSubViewBattle:onClickCopyLatRoundDataForClient()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	if not roundData then
		return
	end

	FightLogFilterHelper.setFilterEffectList(self.effectTypeInput:GetText())

	local log = FightLogHelper.getFightRoundString(roundData)

	ZProj.GameHelper.SetSystemBuffer(log)
end

function GMSubViewBattle:onClickCopyLastOriginRoundDataForClient()
	local originRoundData = FightDataHelper.roundMgr:getOriginRoundData()

	if not originRoundData then
		return
	end

	FightLogFilterHelper.setFilterEffectList()

	local log = FightLogProtobufHelper.getFightRoundString(originRoundData)

	ZProj.GameHelper.SetSystemBuffer(log)
end

function GMSubViewBattle:onClickCopyLastSrcRoundProtoData()
	local proto = FightDataHelper.protoCacheMgr:getLastRoundProto()

	if not proto then
		ZProj.GameHelper.SetSystemBuffer("nil")

		return
	end

	local log = tostring(proto)

	ZProj.GameHelper.SetSystemBuffer(log)
end

function GMSubViewBattle:onClickCopyLatRoundProtoDataNormal()
	local proto = FightDataHelper.protoCacheMgr:getLastRoundProto()

	if not proto then
		ZProj.UGUIHelper.CopyText("没有数据")

		return
	end

	local str = ""
	local roundNum = FightDataHelper.protoCacheMgr:getLastRoundNum()

	if roundNum then
		str = str .. "回合" .. roundNum .. "\n"
	end

	str = str .. FightEditorStateLogView.processStr(tostring(proto))

	ZProj.UGUIHelper.CopyText(str)
end

function GMSubViewBattle:_onLastBattleIdYiPaiYiDongChange(value)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, value)
end

function GMSubViewBattle:_onVersionChange(value)
	FightModel.GMForceVersion = tonumber(value)
end

function GMSubViewBattle:_onClickEnterYiPaiYiDong()
	local battleId = PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, "")

	if string.nilorempty(battleId) then
		return
	end

	battleId = tonumber(battleId)

	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		local fightParam = FightController.instance:setFightParamByBattleId(battleId)

		HeroGroupModel.instance:setParam(battleId, nil, nil)

		local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

		if not curGroupMO then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		local main, mainCount = curGroupMO:getMainList()
		local sub, subCount = curGroupMO:getSubList()
		local equips = curGroupMO:getAllHeroEquips()

		self:closeThis()

		for i, v in ipairs(lua_episode.configList) do
			if v.battleId == battleId then
				fightParam.episodeId = v.id
				FightResultModel.instance.episodeId = v.id

				DungeonModel.instance:SetSendChapterEpisodeId(v.chapterId, v.id)

				break
			end
		end

		fightParam.episodeId = fightParam.episodeId or 10101

		fightParam:setMySide(curGroupMO.clothId, main, sub, equips)

		fightParam.fightActType = FightEnum.FightActType.Season2

		FightController.instance:sendTestFightId(fightParam)
	end
end

function GMSubViewBattle:_onClickShowBattleCharaterParam()
	local text = GMBattleModel.instance:getBattleParam()

	if not string.nilorempty(text) then
		text = string.gsub(text, "{", "\n{\n")
		text = string.gsub(text, ",", ",\n")

		logError(text)
	else
		logError("数据为空")
	end
end

function GMSubViewBattle:_onClickEnableGMFightRecord()
	GMBattleModel.instance:setGMFightRecordEnable()
	GameFacade.showToast(ToastEnum.IconId, "开启战斗录制，请在结算界面点击保存")
end

function GMSubViewBattle:_onClickSaveRecord()
	self.addEventCb(self, FightController.instance, FightEvent.OnGMFightWithRecordAllReply, self._onGetRecord, self)
	FightRpc.instance:sendGetFightRecordAllRequest()
end

function GMSubViewBattle:_onGetRecord()
	self.removeEventCb(self, FightController.instance, FightEvent.OnGMFightWithRecordAllReply, self._onGetRecord, self)
	FightGMRecordView.saveRecord()
end

function GMSubViewBattle:_onClickGMFightRecordReplay()
	local jsonStr = WindowsUtil.getSelectFileContent("选取战斗录制文件", "json")
	local jsonTable = cjson.decode(jsonStr)
	local mo = ProtoTestCaseMO.New()

	mo:deserialize(jsonTable)

	local proto = mo:buildProtoMsg()
	local saveFightParam = jsonTable.fightParam
	local fightParam = FightController.instance:setFightParamByEpisodeId(saveFightParam.episodeId, true, 1, saveFightParam.battleId)

	fightParam.isShowSettlement = false

	FightRpc.instance:sendFightWithRecordAllRequest(proto)
end

function GMSubViewBattle:_onClickGMFightLog()
	ViewMgr.instance:openView(ViewName.FightEditorStateView)
	ViewMgr.instance:closeView(ViewName.GMToolView)
end

function GMSubViewBattle:onStatBuffToggleValueChange()
	if not GameSceneMgr.instance:isFightScene() then
		return
	end

	if not self._isInit then
		return
	end

	if self.statBuffToggle.isOn then
		local buffTypeId = self.buffTypeInput:GetText()

		buffTypeId = tonumber(buffTypeId)

		local co = buffTypeId and lua_skill_bufftype.configDict[buffTypeId]

		if not co then
			GameFacade.showToastString(string.format("buff类 : %s 不存在", buffTypeId))

			self.statBuffToggle.isOn = false

			return
		end

		GMFightController.instance:startStatBuffType(buffTypeId)
	else
		GMFightController.instance:stopStatBuffType()
	end
end

function GMSubViewBattle:onClickUseNewCardScript()
	FightMgr.instance:changeCardScript(true)
	logError("使用新卡牌逻辑")
end

function GMSubViewBattle:onClickUseOldCardScript()
	FightMgr.instance:changeCardScript(false)
	logError("使用旧卡牌逻辑")
end

function GMSubViewBattle:onDestroyView()
	return
end

return GMSubViewBattle
