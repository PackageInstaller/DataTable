-- chunkname: @modules/logic/gm/view/GMSubViewRole.lua

module("modules.logic.gm.view.GMSubViewRole", package.seeall)

local GMSubViewRole = class("GMSubViewRole", GMSubViewBase)

function GMSubViewRole:ctor()
	self.tabName = "角色"
end

function GMSubViewRole:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self._loginOpenMainThumbnail = self:addToggle("L0", "登录打开缩略页")
	self._loginOpenMainThumbnail.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewOpenMainThumbnail, 0) == 1

	self._loginOpenMainThumbnail:AddOnValueChanged(self._onMainThumbnailToggleChanged, self)

	self._inpDuration = self:addInputText("L1", "", "刷新间隔", nil, nil, {
		w = 200
	})
	self._inpSkins = self:addInputText("L1", "", "皮肤id#皮肤id", nil, nil, {
		w = 600
	})

	self.addButton(self, "L1", "主界面测试皮肤", self._onClickShowAllSkins, self)

	self._playVoiceToggle = self:addToggle("L1", "播放语音")

	self.addButton(self, "L2", "停止测试皮肤", self._onStopShowAllSkins, self)
	self.addButton(self, "L3", "梦游结算界面测试皮肤", self._onClickShowWeekWalk_2AllSkins, self)
	self.addButton(self, "L4", "诺谛卡技能替换红点存储重置", self._resetNuodiKaReplaceSkill, self)

	self._voiceId = self:addInputText("L5", "", "主界面角色语音", nil, nil, {
		w = 500
	})

	self.addButton(self, "L5", "播放语音", self._onClickPlayVoice, self)
	self.addButton(self, "L5", "打开皮肤获得界面", self._onClickShowSkinGetView, self)
	self:addTitleSplitLine("快速养成")
	self.addButton(self, "L6", "全角色获得", self.onClickGetAllHero, self)
	self.addButton(self, "L6", "全角色一键拉满（等级,共鸣，塑造）", self.onClickUpgradeAllToMax, self)
	self.addButton(self, "L7", "全角色升至最高等级", self.onClickUpgradeMaxLevel, self)
	self.addButton(self, "L7", "全角色升至最高共鸣", self.onClickUpgradeMaxTalent, self)
	self.addButton(self, "L7", "全角色升至最高塑造", self.onClickUpgradeMaxExLevel, self)
	self.addButton(self, "L8", "全满级心相获得（满等级，满增幅等级）", self.onClickGetAllEquip, self)
	self:addTitleSplitLine("狂想")

	self._destinyHeroId = self:addInputText("L9", "", "角色ID", nil, nil, {
		w = 200
	})

	self.addButton(self, "L9", "重置", self._destinyReset, self)
	self:addLabel("L9", "（角色ID传0表示角色命石表中所有角色）")

	self._destinyStage = self:addInputText("L10", "", "槽位阶段", nil, nil, {
		w = 200
	})
	self._destinyNode = self:addInputText("L10", "", "槽位节点", nil, nil, {
		w = 200
	})

	self.addButton(self, "L10", "设置", self._setDestinyLevel, self)
	self.addButton(self, "L10", "升至最高", self._setDestinyMaxLevel, self)
	self.addButton(self, "L10", "解锁命石", self._unlockDestinyStone, self)
end

function GMSubViewRole:onClickGetAllEquip()
	GMRpc.instance:sendGMRequest("add equip 0#60#5")
end

function GMSubViewRole:onClickUpgradeEquipAllToMax()
	self.upgradeEquipAllToMaxFlow = FlowSequence.New()

	self.upgradeEquipAllToMaxFlow:addWork(GmUpgradeEquipAllToMax.New())
	self.upgradeEquipAllToMaxFlow:start()
end

function GMSubViewRole:onClickGetAllHero()
	GMRpc.instance:sendGMRequest("add hero all 1")
end

function GMSubViewRole:onClickUpgradeMaxLevel()
	self.upgradeMaxLevelFlow = FlowSequence.New()

	self.upgradeMaxLevelFlow:addWork(GmUpgradeAllHeroToMaxLevel.New())
	self.upgradeMaxLevelFlow:start()
end

function GMSubViewRole:onClickUpgradeMaxTalent()
	self.upgradeMaxTalentFlow = FlowSequence.New()

	self.upgradeMaxTalentFlow:addWork(GmUpgradeAllHeroToMaxTalent.New())
	self.upgradeMaxTalentFlow:start()
end

function GMSubViewRole:onClickUpgradeMaxExLevel()
	self.upgradeMaxExLevelFlow = FlowSequence.New()

	self.upgradeMaxExLevelFlow:addWork(GmUpgradeAllHeroToMaxExLevel.New())
	self.upgradeMaxExLevelFlow:start()
end

function GMSubViewRole:onClickUpgradeAllToMax()
	self.upgradeAllToMaxFlow = FlowSequence.New()

	self.upgradeAllToMaxFlow:addWork(GmUpgradeAllHeroAllToMax.New())
	self.upgradeAllToMaxFlow:start()
end

function GMSubViewRole:_onClickPlayVoice()
	self:closeThis()

	local id = tonumber(self._voiceId:GetText())

	CharacterController.instance:dispatchEvent(CharacterEvent.MainHeroGmPlayVoice, id)
end

function GMSubViewRole:_onClickShowSkinGetView()
	self:closeThis()

	local id = tonumber(self._voiceId:GetText())

	CharacterController.instance:openCharacterSkinGainView({
		skinId = id
	})
end

function GMSubViewRole:_onMainThumbnailToggleChanged()
	local value = self._loginOpenMainThumbnail.isOn and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewOpenMainThumbnail, value)
	GameFacade.showToast(2674, value == 1 and "设置登录打开缩略页开启" or "设置登录打开缩略页关闭")
end

function GMSubViewRole:_onStopShowAllSkins()
	TaskDispatcher.cancelTask(self._checkSkinAndVoice, self)
	TaskDispatcher.cancelTask(self._checkWeekWalk_2Skin, self)
end

function GMSubViewRole:_onClickShowWeekWalk_2AllSkins()
	local time = tonumber(self._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", time))
	gohelper.setActive(self._subViewGo, false)

	self._index = 1
	self._skinList = {}

	if not self:_initInputSkins() then
		for i, v in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(v.characterId) then
				table.insert(self._skinList, v)
			end
		end
	end

	self._skinNum = #self._skinList

	TaskDispatcher.cancelTask(self._checkWeekWalk_2Skin, self)
	TaskDispatcher.runRepeat(self._checkWeekWalk_2Skin, self, time)
end

function GMSubViewRole:_checkWeekWalk_2Skin()
	if self._index > self._skinNum then
		print("====结束播放====")
		gohelper.setActive(self._subViewGo, true)
		TaskDispatcher.cancelTask(self._checkWeekWalk_2Skin, self)

		return
	end

	local skinCo = self._skinList[self._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", skinCo.name, skinCo.id, self._index, self._skinNum))

	self._index = self._index + 1

	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnShowSkin, skinCo.id, true)
end

function GMSubViewRole:_onClickShowAllSkins()
	local time = tonumber(self._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", time))
	gohelper.setActive(self._subViewGo, false)

	self._index = 1
	self._skinList = {}

	if not self:_initInputSkins() then
		for i, v in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(v.characterId) then
				table.insert(self._skinList, v)
			end
		end
	end

	self._skinNum = #self._skinList

	TaskDispatcher.cancelTask(self._checkSkinAndVoice, self)
	TaskDispatcher.runRepeat(self._checkSkinAndVoice, self, time)
	self:_showSkin()
end

function GMSubViewRole:_initInputSkins()
	local inputSkins = self._inpSkins:GetText()

	if string.nilorempty(inputSkins) then
		return
	end

	local list = string.splitToNumber(inputSkins, "#")

	if #list == 1 then
		local skinId = list[1]

		for i, v in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(v.characterId) then
				table.insert(self._skinList, v)

				if v.id == skinId then
					self._index = #self._skinList
				end
			end
		end

		return true
	end

	for i, v in ipairs(list) do
		local config = lua_skin.configDict[v]

		table.insert(self._skinList, config)
	end

	return true
end

function GMSubViewRole:_showSkin()
	local skinCo = self._skinList[self._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", skinCo.name, skinCo.id, self._index, self._skinNum))

	self._index = self._index + 1

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, skinCo, true)

	self._skinCo = skinCo

	if self._playVoiceToggle.isOn then
		self._voiceList = self:_getCharacterVoicesCO(skinCo.characterId, skinCo.id)

		if self._voiceList then
			self._voiceLen = #self._voiceList or 0
		end
	end
end

function GMSubViewRole:_checkSkinAndVoice()
	if self:_checkPlayVoice() then
		return
	end

	self:_checkShowSkin()
end

function GMSubViewRole:_checkShowSkin()
	if self._index > self._skinNum then
		print("====结束播放====")
		gohelper.setActive(self._subViewGo, true)
		TaskDispatcher.cancelTask(self._checkSkinAndVoice, self)

		return
	end

	self:_showSkin()
end

function GMSubViewRole:_checkPlayVoice()
	if not self._voiceList or #self._voiceList == 0 then
		return
	end

	local config = table.remove(self._voiceList, 1)

	print(string.format("======auto playVoice skinId:%s audio:%s name:%s progress:%s/%s", self._skinCo.id, config.audio, config.name, self._voiceLen - #self._voiceList, self._voiceLen))

	local mainViewContainer = ViewMgr.instance:getContainer(ViewName.MainView)
	local mainHeroView = mainViewContainer:getMainHeroView()

	mainHeroView:onlyPlayVoice(config)

	return true
end

function GMSubViewRole:_getCharacterVoicesCO(heroId, targetSkinId)
	local voicesCO = {}
	local configs = lua_character_voice.configDict[heroId]

	if configs then
		for audioId, config in pairs(configs) do
			if CharacterDataConfig.instance:_checkSkin(config, targetSkinId) then
				table.insert(voicesCO, config)
			end
		end
	end

	return voicesCO
end

function GMSubViewRole:_resetNuodiKaReplaceSkill()
	local heroId = 3120

	CharacterModel.instance:setPropKeyValueNuodikaReddot(heroId, 0)
	GameUtil.playerPrefsGetNumberByUserId(CharacterModel.AnimKey_ReplaceSkillPlay .. heroId, 0)
end

function GMSubViewRole:onDestroyView()
	TaskDispatcher.cancelTask(self._checkSkinAndVoice, self)
	TaskDispatcher.cancelTask(self._checkWeekWalk_2Skin, self)

	if self.upgradeMaxLevelFlow then
		self.upgradeMaxLevelFlow:destroy()

		self.upgradeMaxLevelFlow = nil
	end

	if self.upgradeMaxTalentFlow then
		self.upgradeMaxTalentFlow:destroy()

		self.upgradeMaxTalentFlow = nil
	end

	if self.upgradeMaxExLevelFlow then
		self.upgradeMaxExLevelFlow:destroy()

		self.upgradeMaxExLevelFlow = nil
	end

	if self.upgradeAllToMaxFlow then
		self.upgradeAllToMaxFlow:destroy()

		self.upgradeAllToMaxFlow = nil
	end
end

function GMSubViewRole:_destinyReset()
	local heroId = self._destinyHeroId:GetText()

	if string.nilorempty(heroId) then
		return
	end

	local input = string.format("destinyReset %s", heroId)

	GMRpc.instance:sendGMRequest(input)
end

function GMSubViewRole:_setDestinyLevel()
	local heroId = self._destinyHeroId:GetText()

	if string.nilorempty(heroId) then
		return
	end

	local stage = self._destinyStage:GetText()

	if string.nilorempty(stage) then
		return
	end

	local node = self._destinyStage:GetText()

	if string.nilorempty(node) then
		return
	end

	local input = string.format("setDestinyLevel %s %s %s", heroId, stage, node)

	GMRpc.instance:sendGMRequest(input)
end

function GMSubViewRole:_setDestinyMaxLevel()
	local heroId = tonumber(self._destinyHeroId:GetText())

	if string.nilorempty(heroId) then
		return
	end

	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local destinyStoneMo = heroMo.destinyStoneMo

	if not destinyStoneMo then
		return
	end

	local maxStage = destinyStoneMo.maxRank
	local maxNode = destinyStoneMo.maxLevel[maxStage]
	local input = string.format("setDestinyLevel %s %s %s", heroId, maxStage, maxNode)

	GMRpc.instance:sendGMRequest(input)
end

function GMSubViewRole:_unlockDestinyStone()
	local heroId = tonumber(self._destinyHeroId:GetText())

	if string.nilorempty(heroId) then
		return
	end

	local input = string.format("unlockDestinyStone %s", heroId)

	GMRpc.instance:sendGMRequest(input)
end

return GMSubViewRole
