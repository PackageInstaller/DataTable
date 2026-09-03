-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterLeadStageDetailMediator.lua

MasterLeadStageDetailMediator = class("MasterLeadStageDetailMediator", DmAreaViewMediator, _M)

MasterLeadStageDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MasterLeadStageDetailMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
MasterLeadStageDetailMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["main.Panel_518.costNode.Node_button.Button_11"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickLevelUp"
	},
	["main.btn_left"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickLeft"
	},
	["main.btn_right"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickRight"
	},
	infoBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickInfoBtn"
	}
}
local leadStageIconPos = {
	cc.p(-40, -133),
	(cc.p(-1, -123))
}

function MasterLeadStageDetailMediator:initialize()
	super.initialize(self)
end

function MasterLeadStageDetailMediator:dispose()
	super.dispose(self)
end

function MasterLeadStageDetailMediator:onRegister()
	super.onRegister(self)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._changeAniBg = self:getView():getChildByName("changeAnim")
end

function MasterLeadStageDetailMediator:enterWithData(data)
	self._changeAni = data.anim

	if data.stageNum then
		self._curIndex = data.stageNum or 1
	end

	self._masterId = data.masterId

	local masterList = self._masterSystem:getShowMasterList()

	self._showMasterList = {}

	for i = 1, #masterList do
		local master = masterList[i]

		if not master:getIsLock() then
			table.insert(self._showMasterList, master)
		end
	end

	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._leadStageData = self._masterData:getLeadStageData()
	self._leadStageDetailConfig = self._leadStageData:getConfigInfo()
	self._curLeadStageLevel = self._leadStageData:getLeadStageLevel()

	if self._curIndex == 0 then
		self._curIndex = 1
	end

	for i, v in ipairs(self._showMasterList) do
		if self._masterId == v:getId() then
			self._curMasterIndex = i
		end
	end

	self:setChagneAni()
end

function MasterLeadStageDetailMediator:setChagneAni()
	self:mapEventListeners()
	self:setupView()

	if self._changeAni ~= nil then
		self._main:setVisible(false)
		self._changeAni:changeParent(self._changeAniBg)
		self._changeAni:addCallbackAtFrame(20, function()
			self._main:setVisible(true)
			self:setupTopInfoWidget()
			self:refreshView()
			self:runStartAction()
		end)
	else
		self:setupTopInfoWidget()
		self:refreshView()
		self:runStartAction()
	end
end

function MasterLeadStageDetailMediator:resumeWithData(data)
	super.resumeWithData(self, data)
end

function MasterLeadStageDetailMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEADSTASGE_UPDONE, self, self.refreshCostView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshRightPanelView)
end

function MasterLeadStageDetailMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(1001)
	topInfoNode:setVisible(true)

	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("LeadStage")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("LeadStage_StageDesc")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MasterLeadStageDetailMediator:setupView()
	self._imgBg = self._main:getChildByFullName("imgbg")
	self._backLayout = self._main:getChildByFullName("backLauyout")
	self._listView = self._main:getChildByFullName("ListView_1")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)

	self._stageIcon1 = self._main:getChildByFullName("Panel_stageicon1")
	self._stageIcon2 = self._main:getChildByFullName("Panel_stageicon2")
	self._stageIcon3 = self._main:getChildByFullName("Panel_stageicon3")
	self._nodeMaster = self._main:getChildByFullName("Node_master")
	self._nodeMaster1 = self._main:getChildByFullName("Node_master1")
	self._rightPanel = self._main:getChildByFullName("Panel_518")
	self._button = self._main:getChildByFullName("Panel_518.costNode.Node_button")
	self._boxPanel1 = self._rightPanel:getChildByFullName("boxPanel1")
	self._boxPanel2 = self._rightPanel:getChildByFullName("boxPanel2")
	self._boxPanel3 = self._rightPanel:getChildByFullName("boxPanel3")
	self._costNode = self._rightPanel:getChildByFullName("costNode")
	self._costNode1 = self._costNode:getChildByFullName("costNode_1")
	self._costNode2 = self._costNode:getChildByFullName("costNode_2")

	self._costNode1:setScale(0.7)
	self._costNode2:setScale(0.7)

	self._desPanel = self._rightPanel:getChildByFullName("desNode")
	self._icon1PosX = self._boxPanel1:getChildByFullName("icon1"):getPosition()
	self._btnLeft = self._main:getChildByFullName("btn_left")
	self._btnRight = self._main:getChildByFullName("btn_right")

	GameStyle:setCostNodeEffect(self._costNode1)
	GameStyle:setCostNodeEffect(self._costNode2)
end

function MasterLeadStageDetailMediator:refreshView()
	self:setBackGround()
	self:refreshListView()
	self:refreshRightPanel()
	self:refreshCost()
	self:refreshBtnVisible()
end

function MasterLeadStageDetailMediator:refreshRightPanelView()
	self:refreshRightPanel()
	self:refreshCost()
end

function MasterLeadStageDetailMediator:refreshBtnVisible()
	self._btnLeft:setVisible(#self._showMasterList > 1)
	self._btnRight:setVisible(#self._showMasterList > 1)
end

function MasterLeadStageDetailMediator:refreshListView()
	self._listView:removeAllChildren(true)

	self._listTable = {}

	for i = #self._leadStageDetailConfig, 1, -1 do
		local info = self._leadStageDetailConfig[i]
		local panel = info.LeadStageLv == 1 and self._stageIcon3:clone() or info.LeadStageLv == #self._leadStageDetailConfig and self._stageIcon2:clone() or self._stageIcon1:clone()

		panel:setVisible(true)
		panel:setTag(i)
		panel:addClickEventListener(function()
			self:onClickItem(info.StageNum)
		end)
		panel:setPositionX(self._listView:getContentSize().width / 2)
		self:updataCell(panel, info.StageNum)
		self._listView:pushBackCustomItem(panel)

		self._listTable[info.StageNum] = panel
	end

	self._listView:jumpToPercentVertical(100)

	if self._curIndex > 4 then
		self._listView:jumpToPercentVertical(0)
	else
		self._listView:jumpToPercentVertical(100)
	end
end

function MasterLeadStageDetailMediator:updataCell(panel, index)
	local info = self._leadStageDetailConfig[index]
	local image = panel:getChildByFullName("Image_531")
	local text = panel:getChildByFullName("text_0")
	local select = panel:getChildByFullName("Image_603")
	local imgLock = panel:getChildByFullName("img_lock")
	local imgRedPoint = panel:getChildByFullName("redpoint")

	select:setVisible(self._curIndex == index)
	image:loadTexture(info.Icon, ccui.TextureResType.plistType)
	image:ignoreContentAdaptWithSize(true)
	text:setString(Strings:get(info.RomanNum) .. Strings:get(info.StageName))
	imgLock:setVisible(false)

	local isMaxLevel = self._leadStageData:isMaxLevel()

	if isMaxLevel then
		image:setGray(false)
	else
		image:setGray(index > self._curLeadStageLevel)
	end

	if isMaxLevel then
		imgRedPoint:setVisible(false)
	else
		local isRedPoint = true

		if index == self._curLeadStageLevel + 1 then
			local info = self._leadStageDetailConfig[index]
			local rets = self._masterSystem:checkLeadStageCondition(self._masterId, info.LeadStageLv)

			if table.indexof(rets, false) then
				isRedPoint = false
			end

			if isRedPoint then
				local cost = self._leadStageData:getCost()

				if not self:getItemEnough(cost) then
					isRedPoint = false
				end
			end
		end

		imgRedPoint:setVisible(index == self._curLeadStageLevel + 1 and isRedPoint or false)
	end
end

function MasterLeadStageDetailMediator:onClickItem(index)
	if self._curIndex == index then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local info = self._leadStageDetailConfig[index]

	if info.LeadStageControl == 0 then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("LeadStage_LockTip", {
				stageName = Strings:get(info.StageName)
			})
		}))

		return
	end

	self:runStartAction()

	local old = self._listTable[self._curIndex]
	local select = old:getChildByFullName("Image_603")

	select:setVisible(false)

	local new = self._listTable[index]
	local select = new:getChildByFullName("Image_603")

	select:setVisible(true)

	self._curIndex = index

	self:refreshRightPanel()
	self:refreshCost()
end

function MasterLeadStageDetailMediator:refreshRightPanel()
	self._roleSpine = {}

	local info = self._leadStageDetailConfig[self._curIndex]

	self._nodeMaster:setVisible(false)

	local image = self._nodeMaster:getChildByFullName("Image_icon")
	local text = self._nodeMaster:getChildByFullName("Text_104")
	local imageMaster = self._nodeMaster:getChildByFullName("Image_master")

	image:loadTexture(info.Icon, ccui.TextureResType.plistType)
	image:ignoreContentAdaptWithSize(true)
	text:setString(Strings:get(info.RomanNum) .. Strings:get(info.StageName))
	text:setTextColor(GameStyle:getLeadStageColor(self._curIndex))
	text:setPosition((info.LeadStageLv == #self._leadStageDetailConfig or nil) and (leadStageIconPos[2] or leadStageIconPos[1]))
	self._nodeMaster1:removeAllChildren()

	local node = MasterLeadStageKuang:createWidgetNode()

	node:addTo(self._nodeMaster1)
	self:autoManageObject(self:getInjector():injectInto(MasterLeadStageKuang:new(node, {
		stageId = info.Id,
		stageLevel = self._curIndex,
		modelId = info.ModelId
	})))

	local icon1 = self._boxPanel1:getChildByFullName("icon1")
	local icon2Layout = self._boxPanel1:getChildByFullName("layout")
	local icon2 = icon2Layout:getChildByFullName("icon1_0")

	icon1:removeAllChildren()
	icon2:removeAllChildren()

	local text = self._boxPanel1:getChildByFullName("text")

	text:setString(Strings:get("LeadStage_ModelText", {
		stageName = Strings:get(info.StageName)
	}))

	local defModelId, curModelId

	if info.StageNum == 1 then
		defModelId = ConfigReader:getDataByNameIdAndKey("MasterBase", self._masterId, "RoleModel")
		curModelId = info.ModelId
	else
		defModelId = self._leadStageDetailConfig[self._curIndex - 1].ModelId
		curModelId = info.ModelId
	end

	local isChange = defModelId ~= curModelId

	icon1:setPositionX((isChange or nil) and (self._icon1PosX or 100))
	icon2Layout:setVisible(isChange)
	self:setRoleAnim(icon1, defModelId, 1)

	if defModelId ~= curModelId then
		self:setRoleAnim(icon2, curModelId, 2)
	end

	local isLeadStageOver = self._curLeadStageLevel >= info.LeadStageLv or self._leadStageData:isMaxLevel()
	local conState, nums = self._masterSystem:checkLeadStageCondition(self._masterId, info.LeadStageLv, true)
	local showContidion = self._leadStageData:getShowConditionByStageLv(info.LeadStageLv)
	local desTable = {}

	nums = nums or {}

	for i, v in ipairs(showContidion) do
		local des
		local kind = v.key
		local value = v.value

		if isLeadStageOver then
			nums[i] = value.Count or nums[i]
		end

		if nums[i] == nil then
			nums[i] = 0
		end

		if kind == MasterLeadStageCondiState.KAwaken then
			local occupationName = GameStyle:getHeroOccupation(value.Job)

			des = Strings:get("LeadStage_UpCondition_Awaken", {
				num1 = nums[i] .. "/" .. value.Count,
				num2 = occupationName
			})
		elseif kind == MasterLeadStageCondiState.KEquip then
			local rarity = GameStyle:getHeroRarityText(value.EquipRareity)
			local posKey = ConfigReader:getRecordById("ConfigValue", "Equip_Translate").content[value.Location]

			des = Strings:get("LeadStage_UpCondition_Equip", {
				num1 = nums[i] .. "/" .. value.Count,
				num2 = rarity,
				num3 = Strings:get(posKey)
			})
		elseif kind == MasterLeadStageCondiState.KLeadStage then
			local showInfo = self._leadStageDetailConfig[value.Lv]

			des = Strings:get("LeadStage_UpCondition_LeadStage", {
				num1 = nums[i] .. "/" .. value.Count,
				num2 = Strings:get(showInfo.RomanNum) .. Strings:get(showInfo.StageName)
			})
		elseif kind == MasterLeadStageCondiState.KRareityHero then
			local rarity = GameStyle:getHeroRarityText(value.Rareity)
			local occupationName = GameStyle:getHeroOccupation(value.Job)

			des = Strings:get("LeadStage_UpCondition_RareityHero", {
				num1 = nums[i] .. "/" .. value.Count,
				num2 = rarity,
				num3 = occupationName
			})
		elseif kind == MasterLeadStageCondiState.KStarHero then
			local occupationName = GameStyle:getHeroOccupation(value.Job)

			des = Strings:get("LeadStage_UpCondition_StarHero", {
				num1 = nums[i] .. "/" .. value.Count,
				num2 = value.HeroStar,
				num3 = occupationName
			})
		elseif kind == MasterLeadStageCondiState.KSuit then
			local rarity = GameStyle:getHeroRarityText(value.EquipRareity)

			des = Strings:get("LeadStage_UpCondition_SuitLevel", {
				num1 = nums[i] .. "/" .. value.Count,
				num2 = rarity,
				num3 = value.SuitLevel
			})
		elseif kind == MasterLeadStageCondiState.KEquipRareityLevel then
			local rarity = GameStyle:getHeroRarityText(value.EquipRareity)
			local posStr = ConfigReader:getRecordById("ConfigValue", "Equip_Translate").content
			local posKey = posStr[value.Location[1]]

			des = Strings:get("LeadStage_UpCondition_EquipRareityLevel", {
				num1 = nums[i] .. "/" .. value.Count,
				num2 = value.Level,
				num3 = rarity,
				num4 = Strings:get(posKey)
			})
		end

		table.insert(desTable, des)
	end

	local text = self._boxPanel2:getChildByFullName("text")

	text:setString(Strings:get("LeadStage_ConditionText"))

	local listView = self._boxPanel2:getChildByFullName("Panel_list")
	local itemClone = self._boxPanel2:getChildByFullName("Panel_252")

	itemClone:setVisible(false)

	local upPanel = self._boxPanel3:getChildByFullName("Image_457")

	upPanel:setVisible(false)

	local newPanel = self._boxPanel3:getChildByFullName("Image_530")

	newPanel:setVisible(false)
	listView:removeAllChildren(true)

	local panelList = {}

	for i, v in ipairs(desTable) do
		local panel = itemClone:clone()

		panel:setVisible(true)
		panel:getChildByFullName("text"):setString(v)
		panel:getChildByFullName("text"):setColor((conState[i] or isLeadStageOver) and cc.c3b(202, 245, 53) or cc.c3b(255, 255, 255))
		panel:getChildByFullName("Image_237"):setColor((conState[i] or isLeadStageOver) and cc.c3b(202, 245, 53) or cc.c3b(255, 0, 0))
		table.insert(panelList, panel)
		panel:addTo(listView)
	end

	if #panelList == 1 then
		panelList[1]:setPositionY(33)
	elseif #panelList == 2 then
		panelList[1]:setPositionY(48)
		panelList[2]:setPositionY(18)
	elseif #panelList == 3 then
		for i, v in ipairs(panelList) do
			v:setPositionY(63 - (i - 1) * 30)
		end
	end

	local text = self._boxPanel3:getChildByFullName("text")

	text:setString(Strings:get("LeadStage_SkillTitleText", {
		stageName = Strings:get(info.StageName)
	}))

	local skillPanel = self._boxPanel3:getChildByFullName("Panel_515")

	skillPanel:removeAllChildren()

	local allSkills = info.skills

	for i, v in ipairs(allSkills) do
		local skillId = v

		local function clickFun()
			local skillData = {}

			skillData.skillId = skillId
			skillData.masterData = self._masterData
			skillData.stageLevel = info.LeadStageLv
			skillData.mediator = self
			skillData.isShowCurLv = true
			skillData.skillIndex = i

			self:showSkillTip(skillData, i)
		end

		local skillIcon = IconFactory:createMasterLeadStageSkillIcon({
			scale = 0.9,
			id = v,
			isLock = allSkills[skillId].state == MasterLeadStageSkillState.KLOCK
		}, nil, clickFun)

		skillIcon:addTo(skillPanel):posite(80 * (i - 1), 10)
		skillIcon:setScale(0.6)

		if allSkills[skillId].state == MasterLeadStageSkillState.KUP then
			local u = upPanel:clone()

			u:setVisible(true)
			u:addTo(skillPanel):posite(80 * (i - 1) + 48, 68)
		elseif allSkills[skillId].state == MasterLeadStageSkillState.KNew then
			local n = newPanel:clone()

			n:setVisible(true)
			n:addTo(skillPanel):posite(80 * (i - 1) + 48, 68)
		end
	end
end

function MasterLeadStageDetailMediator:showSkillTip(skillData, index)
	if not self._skillTipNode then
		self._skillTipNode = MasterLeadStageSkillTip:createWidgetNode()

		self._skillTipNode:setVisible(false)
		self._skillTipNode:addTo(self:getView()):posite(0, 200)
		self._skillTipNode:setLocalZOrder(1002)

		self._skillShowWidget = self:autoManageObject(self:getInjector():injectInto(MasterLeadStageSkillTip:new(self._skillTipNode, skillData)))
	end

	self._skillTipNode:setPosition(cc.p(self._boxPanel3:getParent():getPositionX() + 70 * index - 60, 265))
	self._skillShowWidget:refreshInfo(skillData)

	if self._skillTipNode:isVisible() then
		self._skillTipNode:setVisible(false)
	else
		self._skillTipNode:setVisible(true)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function MasterLeadStageDetailMediator:refreshCostView()
	self._masterSystem:setDoStageLvUpAnim(true)
	self:onClickBack()
end

function MasterLeadStageDetailMediator:refreshCost()
	local info = self._leadStageDetailConfig[self._curIndex]
	local title = self._desPanel:getChildByFullName("text_0")
	local time = self._desPanel:getChildByFullName("text_0_0")

	if self._curLeadStageLevel >= info.LeadStageLv or self._leadStageData:isMaxLevel() then
		self._costNode:setVisible(false)
		self._desPanel:setVisible(true)
		time:setVisible(true)
		title:setString(Strings:get(info.StageUpText))

		local t = self._leadStageData:getActiveTime(info.Id) or 0

		time:setString(Strings:get("LeadStage_StageDate", {
			time = TimeUtil:localDate("%Y.%m.%d", t / 1000)
		}))
	else
		local isNotLeadStage = self._curLeadStageLevel + 1 ~= info.LeadStageLv

		self._costNode:setVisible(true)
		self._desPanel:setVisible(false)

		local cost = self._leadStageData:getCost(info.LeadStageLv)

		for i = 1, 2 do
			local node = self._costNode:getChildByFullName("costNode_" .. i)

			node:setVisible(cost[i] ~= nil)

			if cost[i] ~= nil then
				local data = {
					onlyShowNeed = true,
					id = cost[i].id,
					needNum = cost[i].n
				}
				local injector = self:getInjector()

				self._costNodeWidget = injector:injectInto(CostNodeWidget:new(self, node))

				self._costNodeWidget:updateView(data)
			end
		end

		local node = self._button:getChildByFullName("Button_11")
		local animAwaken = node:getChildByFullName("texiao")

		if not animAwaken then
			animAwaken = cc.MovieClip:create("juexingrukou_juexingrukou")

			animAwaken:addTo(node):offset(-232, 237)
			animAwaken:setName("texiao")
		end

		animAwaken:gotoAndPlay(0)

		local ret = true
		local rets = self._masterSystem:checkLeadStageCondition(self._masterId, info.LeadStageLv)

		if table.indexof(rets, false) then
			ret = false
		end

		animAwaken:setVisible((not self:getItemEnough(cost) or nil) and false and not isNotLeadStage)
		node:setGray(isNotLeadStage)
	end
end

function MasterLeadStageDetailMediator:getItemEnough(cost)
	for i, v in ipairs(cost) do
		local need = v.n
		local have = self._bagSystem:getItemCount(v.id)

		if have < need then
			local itemConfig = self._bagSystem:getItemConfig(v.id)

			return false, i
		end
	end

	return true
end

function MasterLeadStageDetailMediator:setRoleAnim(node, modelId)
	local model = ConfigReader:requireRecordById("RoleModel", modelId).Model
	local role = RoleFactory:createRoleAnimation(model, nil, {
		once = false
	})

	role:setName("RoleAnim")
	role:addTo(node):setScale(0.4):posite(50, 5)
end

function MasterLeadStageDetailMediator:onClickLevelUp()
	local info = self._leadStageDetailConfig[self._curIndex]
	local isNotLeadStage = self._curLeadStageLevel + 1 ~= info.LeadStageLv

	if isNotLeadStage then
		local showInfo = self._leadStageDetailConfig[self._curIndex - 1]

		self:dispatch(ShowTipEvent({
			tip = Strings:get("LeadStage_StageUpTip03", {
				prestage = Strings:get(showInfo.RomanNum) .. Strings:get(showInfo.StageName)
			})
		}))

		return
	end

	local rets = self._masterSystem:checkLeadStageCondition(self._masterId, info.LeadStageLv)

	if table.indexof(rets, false) then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("LeadStage_StageUpTip02")
		}))

		return
	end

	local cost = self._leadStageData:getCost()
	local ret, des = self:getItemEnough(cost)

	if not ret then
		self:onClickCostItem(des)

		return
	end

	self._masterSystem:requestLeadStageUp(self._masterId)
end

local moveOffet = 100

function MasterLeadStageDetailMediator:setBackGround()
	self._imgBg:removeAllChildren()
	self._imgBg:ignoreContentAdaptWithSize(true)
	self._imgBg:loadTexture("asset/scene/bd_bg_bj.jpg", ccui.TextureResType.localType)
	self._imgBg:setLocalZOrder(-3)
	self._backLayout:stopAllActions()

	self._anim = cc.MovieClip:create("eff_zong_xingkong_yuanjiebeijingeff")

	self._anim:gotoAndPlay(1)
	self._anim:addEndCallback(function()
		self._anim:gotoAndPlay(1)
	end)
	self._anim:addTo(self._backLayout):center(self._backLayout:getContentSize()):offset(0, moveOffet * -1)
	self._backLayout:setLocalZOrder(-2)

	for i = 1, 2 do
		local mc_img1 = self._anim:getChildByFullName("img_bg" .. i)
		local mc_bg = mc_img1:getChildByFullName("bg")
		local img1 = ccui.ImageView:create("asset/scene/leadStage_scene_xq.jpg")

		if i == 2 then
			img1:setFlippedX(true)
		end

		img1:addTo(mc_bg)
	end

	local x, y = self._anim:getPosition()
	local moveto = cc.MoveTo:create(0.3333333333333333, cc.p(x, y + moveOffet))
	local callFunc2 = cc.CallFunc:create(function()
		return
	end)
	local seq = cc.Sequence:create(moveto, callFunc2)

	self._anim:runAction(seq)

	local background = cc.Sprite:create("asset/ui/mastercultivate/leadStage_img_xq_cjzz.png")

	background:setAnchorPoint(cc.p(0.5, 0.5))
	background:setPosition(cc.p(568, 320))
	background:addTo(self._main, -1)
end

function MasterLeadStageDetailMediator:onClickCostItem(index)
	local cost = self._leadStageData:getCost()
	local hasNum = self._bagSystem:getItemCount(cost[index].id)
	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = cost[index].id,
		hasNum = hasCount,
		needNum = cost[index].n
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function MasterLeadStageDetailMediator:onClickLeft()
	self:switchMaster(-1)
end

function MasterLeadStageDetailMediator:onClickRight()
	self:switchMaster(1)
end

function MasterLeadStageDetailMediator:switchMaster(add)
	self._curMasterIndex = self._curMasterIndex + add

	if self._curMasterIndex < 1 then
		self._curMasterIndex = #self._showMasterList
	end

	if self._curMasterIndex > #self._showMasterList then
		self._curMasterIndex = 1
	end

	self._masterId = self._showMasterList[self._curMasterIndex]:getId()

	self:dispatch(Event:new(EVT_LEADSTASGE_SWITCH_HERO, self._masterId))

	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._leadStageData = self._masterData:getLeadStageData()
	self._leadStageDetailConfig = self._leadStageData:getConfigInfo()
	self._curLeadStageLevel = self._leadStageData:getLeadStageLevel()

	local curLevel = self._curLeadStageLevel
	local isMax = self._leadStageData:isMaxLevel()

	if not isMax then
		local info = self._leadStageDetailConfig[curLevel + 1]

		if info.LeadStageControl == 1 then
			curLevel = curLevel + 1
		end
	end

	self._curIndex = curLevel

	self:runStartAction()
	self:refreshListView()
	self:refreshRightPanel()
	self:refreshCost()
end

function MasterLeadStageDetailMediator:onClickInfoBtn()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Rule", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end

function MasterLeadStageDetailMediator:runStartAction()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/MasterLeadStageDetail.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.5)

	local bgAnim1 = self._boxPanel1:getChildByFullName("bgAnim1")

	if not bgAnim1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim1)
		anim:setName("BgAnim")
	end

	bgAnim1:getChildByFullName("BgAnim"):gotoAndStop(1)

	local bgAnim2 = self._boxPanel2:getChildByFullName("bgAnim1")

	if not bgAnim2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim2)
		anim:setName("BgAnim")
	end

	bgAnim2:getChildByFullName("BgAnim"):gotoAndStop(1)

	local bgAnim3 = self._boxPanel3:getChildByFullName("bgAnim1")

	if not bgAnim3:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim3)
		anim:setName("BgAnim")
	end

	bgAnim3:getChildByFullName("BgAnim"):gotoAndStop(1)
	self._costNode1:setOpacity(0)
	self._costNode2:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "BgAnim1" then
			bgAnim1:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "BgAnim2" then
			bgAnim2:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "BgAnim3" then
			bgAnim3:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "CostAnim1" then
			self._costNode1:setOpacity(255)
			GameStyle:runCostAnim(self._costNode1)
		end

		if str == "CostAnim2" then
			self._costNode2:setOpacity(255)
			GameStyle:runCostAnim(self._costNode2)
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function MasterLeadStageDetailMediator:onClickBack()
	self._main:stopAllActions()
	self._anim:stopAllActions()

	self._anim = nil

	self._changeAni:removeFromParent()

	self._changeAni = nil

	self:dismiss()
end
