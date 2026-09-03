-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterEnterMediator.lua

MasterEnterMediator = class("MasterEnterMediator", DmAreaViewMediator, _M)

MasterEnterMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MasterEnterMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
require("dm.gameplay.develop.view.master.MasterEmblemMediator")

local kBtnHandlers = {
	["main.layout_1.Node_info.sliderunder.hechengbtn.button"] = "onClickMasterCombine",
	["main.btnPanel.leftBtn"] = "onClickChangeLeft",
	["main.layout_1.Node_info.sliderunder.suipianlaiyuanbtn.button"] = "onClickMasterPiecesResources",
	["main.btnPanel.rightBtn"] = "onClickChangeRight",
	["main.Node_yz.yz_touch"] = {
		clickAudio = "Se_Click_Yuanzhi",
		func = "onClickYz"
	},
	["main.layout_1.heroimage.Panel_touch"] = {
		clickAudio = "Se_Effect_Character_Info",
		func = "onClickShowCultivateView"
	}
}

function MasterEnterMediator:initialize()
	super.initialize(self)
end

function MasterEnterMediator:dispose()
	super.dispose(self)
end

function MasterEnterMediator:onRegister()
	super.onRegister(self)
	self:setupView()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MasterEnterMediator:userInject()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._player = self._developSystem:getPlayer()
	self._bagSystem = self._developSystem:getBagSystem()
	self._kernelSystem = self._developSystem:getKerenlSystem()
end

function MasterEnterMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MASTER_SYNC_UPDATE, self, self.updateMasterInfor)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MASTER_SYNC_COMBIN_SUCC, self, self.updateMasterInfor)
end

function MasterEnterMediator:onRemove()
	super.onRemove(self)
end

function MasterEnterMediator:enterWithData(data)
	local var_7_0

	if data then
		if data.tabType then
			var_7_0 = data.tabType

			if not data.tabType then
				var_7_0 = 1

				goto label_7_0
			end
		end
	end

	::label_7_0::

	self._tabType = 1
	self._showMasterList = self._masterSystem:getShowMasterList()

	if data then
		local var_7_1

		if data.id then
			var_7_1 = tostring(data.id) or self._showMasterList[1]:getId() or self._showMasterList[1]:getId()
		end
	end

	self._selectedMasterId = var_7_1

	self:setupTopInfoWidget()

	local master = self:getSelectedMasterData()

	self:refreshMonsterInforTab1(master)
	self:initAnim()
	self:setupClickEnvs()

	local iconView = cc.MovieClip:create("ss_baoshilizi")

	iconView:setPosition(cc.p(30, 41))
	iconView:setName("iconViewPanel")

	local mainStageNode = self._mExploreNode:getChildByFullName("flashPanel")

	mainStageNode:addChild(iconView)

	local name1 = self._mExploreNode:getChildByFullName("mLabelNames")
	local name2 = self._mExploreNode:getChildByFullName("mLabelNames_2")

	name1:setString(Strings:get("Master_Enter_Yz_Name_1"))
	name2:setString(Strings:get("Master_Enter_Yz_Name_2"))
end

function MasterEnterMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo_node")
	local config = {
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Master_Title_Hero")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MasterEnterMediator:setupView()
	self._main = self:getView():getChildByFullName("main")
	self._startPoint = cc.p(0, 0)

	local _layout_1 = self._main:getChildByFullName("layout_1")

	self._node_info = _layout_1:getChildByFullName("Node_info")
	self._text_power = self._node_info:getChildByFullName("Node_combat.Text_power")
	self._node_power = self._node_info:getChildByFullName("Node_combat")
	self._heroName = self._node_info:getChildByFullName("heroName")
	self._masterImg = _layout_1:getChildByFullName("heroimage")
	self._node_yz = self._main:getChildByFullName("Node_yz")
	self._lock = self._main:getChildByFullName("Node_yz.yz_lock")
	self._nodeStar = self._node_info:getChildByFullName("Node_star")
	self._mExploreNode = self._node_yz:getChildByFullName("mExploreNode")
	self._sliderunder = self._node_info:getChildByFullName("sliderunder")
	self._sliderText = self._sliderunder:getChildByFullName("slidertext")

	self._sliderText:enableOutline(cc.c4b(35, 15, 4, 127), 2)

	self._slider = self._sliderunder:getChildByFullName("slider")
	self._hechengBtn = self._sliderunder:getChildByFullName("hechengbtn")
	self._lockTip = self._sliderunder:getChildByFullName("locktip")
	self._canComTip = self._sliderunder:getChildByFullName("cancom")
	self._getPieceBtn = self._sliderunder:getChildByFullName("suipianlaiyuanbtn")

	self._lock:setVisible(not self:isYzlock())
	self:bindWidget("main.layout_1.Node_info.sliderunder.suipianlaiyuanbtn", OneLevelViceButton, {})
	self:bindWidget("main.layout_1.Node_info.sliderunder.hechengbtn", OneLevelViceButton, {})
end

function MasterEnterMediator:refreshMonsterInforTab1(mastermodel)
	self:refreshMasterAttInfo(mastermodel)
	self._masterSystem:setCurTab1MasterID(mastermodel:getId())
end

function MasterEnterMediator:updateMasterPiece(mastermodel)
	self._sliderunder:setVisible(mastermodel:getIsLock())

	if mastermodel:getIsLock() then
		print("刷新碎片显示-------", mastermodel:getName())
		self._sliderunder:setVisible(mastermodel:getIsLock())

		if mastermodel:getIsLock() then
			self:setMasterPiece(mastermodel)

			local suipian = self._sliderunder:getChildByFullName("suipianBg.suipian")
			local info = {
				name = "head",
				id = mastermodel:getModel()
			}
			local icon = IconFactory:createRoleIconSpriteNew(info)

			icon:setAnchorPoint(cc.p(0.5, 0.5))
			suipian:removeAllChildren()
			icon:addTo(suipian):center(suipian:getContentSize())

			local debrisIcon = cc.Sprite:createWithSpriteFrameName(IconFactory.debrisPath)

			suipian:addChild(debrisIcon)
			debrisIcon:setPosition(0, 0)
		end
	end
end

function MasterEnterMediator:updateMasterInfor()
	self._showMasterList = self._masterSystem:getShowMasterList()

	local master = self:getSelectedMasterData()

	self:refreshMonsterInforTab1(master)
end

function MasterEnterMediator:didFinishResumeTransition()
	self:updateMasterInfor()
end

function MasterEnterMediator:refreshMasterAttInfo(mastermodel)
	self._heroName:setString(mastermodel:getName())
	self:setMasterImg(mastermodel:getId())
	self:setStar(mastermodel:getStar())
	self._nodeStar:setVisible(not mastermodel:getIsLock())

	if not mastermodel:getIsLock() then
		self._node_power:setVisible(true)

		local combat, attrData = mastermodel:getCombat()

		self:setFightPower(combat)
	else
		self._node_power:setVisible(false)
	end

	self:updateMasterPiece(mastermodel)
end

function MasterEnterMediator:setStar(starLevel)
	for i = 1, 6 do
		local star = self._nodeStar:getChildByFullName("star_" .. tostring(i))

		star:setVisible(i <= starLevel)
	end
end

function MasterEnterMediator:setFightPower(value)
	self._text_power:setString(value)
end

function MasterEnterMediator:setMasterImg(id)
	for k, v in pairs(self._showMasterList) do
		local idNow = v:getId()
		local image = self._masterImg:getChildByName(idNow)

		if image then
			image:setVisible(idNow == id)
		end
	end
end

function MasterEnterMediator:setMasterPiece(mastermodel)
	local upid = mastermodel:getStarUpItemId()
	local number = self._bagSystem:getItemCount(upid)
	local maxnumber = mastermodel:getCompositePay()

	self._sliderText:setString(number .. "/" .. maxnumber)
	self._slider:setPercent(math.ceil(number / maxnumber * 100))
	self._lockTip:setVisible(number < maxnumber)
	self._canComTip:setVisible(maxnumber <= number)
	self._hechengBtn:setVisible(maxnumber <= number)

	if maxnumber <= number then
		self._getPieceBtn:setVisible(false)
	else
		self._getPieceBtn:setVisible(true)
	end

	self._lockTip:setVisible(false)
	self._canComTip:setVisible(false)
end

function MasterEnterMediator:getSelectedMasterData()
	for i = 1, #self._showMasterList do
		if self._showMasterList[i]:getId() == self._selectedMasterId then
			return self._showMasterList[i], i
		end
	end

	return nil
end

function MasterEnterMediator:isLock()
	return self._masterSystem:isMasterLockById(self._selectedMasterId)
end

function MasterEnterMediator:isYzlock()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local result1, tip1 = systemKeeper:isUnlock("Master_Auras")
	local result2, tip2 = systemKeeper:isUnlock("Master_Equip")

	return result1 or result2
end

function MasterEnterMediator:onClickChangeLeft(sender, eventType)
	local master, index = self:getSelectedMasterData()

	index = index - 1

	if index < 1 then
		index = #self._showMasterList
	end

	self._selectedMasterId = self._showMasterList[index]:getId()

	self:refreshMonsterInforTab1(self._showMasterList[index])
end

function MasterEnterMediator:onClickChangeRight(sender, eventType)
	local master, index = self:getSelectedMasterData()

	index = index + 1

	if index > #self._showMasterList then
		index = 1
	end

	self._selectedMasterId = self._showMasterList[index]:getId()

	self:refreshMonsterInforTab1(self._showMasterList[index])
end

function MasterEnterMediator:onClickYz()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local result1, tip1 = systemKeeper:isUnlock("Master_Auras")
	local result2, tip2 = systemKeeper:isUnlock("Master_Equip")

	if result1 or result2 then
		local playerCultivateView = self:getInjector():getInstance("MasterCultivateView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, playerCultivateView, nil, {
			showType = 2,
			tabType = 1,
			id = self._selectedMasterId
		}))
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tip1
		}))
	end
end

function MasterEnterMediator:onClickMasterPiecesResources(sender, eventType, oppoRecord)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local id = self._masterSystem:getCurTab1MasterID()
		local masterConfig = ConfigReader:getRecordById("MasterBase", tostring(id))
		local number = self._bagSystem:getItemCount(masterConfig.StarUpItemId)
		local maxnumber = masterConfig.CompositePay
		local param = {
			isNeed = true,
			hasWipeTip = true,
			itemId = masterConfig.StarUpItemId,
			hasNum = number,
			needNum = maxnumber
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	end
end

function MasterEnterMediator:onClickMasterCombine(sender, eventType, oppoRecord)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local id = self._masterSystem:getCurTab1MasterID()
		local masterConfig = ConfigReader:getRecordById("MasterBase", tostring(id))

		local function callBack()
			local masterModel = self:getSelectedMasterData()
			local view = self:getInjector():getInstance("NewMasterView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				masterModel = masterModel
			}))
		end

		self._masterSystem:sendApplyComposeMaster(masterConfig.StarUpItemId, callBack)
	end
end

function MasterEnterMediator:onClickBack()
	self:dismiss()
end

function MasterEnterMediator:onClickShowCultivateView(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if not self:isLock() then
			local touchLayer = self._masterImg:getChildByFullName("Panel_touch")

			touchLayer:setTouchEnabled(false)
			self._mcAnim:gotoAndStop(1)
			self._mcAnim:gotoAndPlay(1)
		else
			print("未解锁")
		end
	end
end

function MasterEnterMediator:initAnim()
	local mcAnim = cc.MovieClip:create("open_zhujueshuxing")

	mcAnim:addTo(self._main):center(self._main:getContentSize()):offset(0, 0)

	local leftBtn_ani = mcAnim:getChildByFullName("leftBtn")
	local rightBtn_ani = mcAnim:getChildByFullName("rightBtn")
	local node_yz_ani = mcAnim:getChildByFullName("Node_yz")
	local node_role_ani = mcAnim:getChildByFullName("Node_role")
	local node_power_ani = mcAnim:getChildByFullName("Node_power")

	mcAnim:addCallbackAtFrame(16, function(cid, mc)
		mc:gotoAndStop(1)

		local touchLayer = self._masterImg:getChildByFullName("Panel_touch")

		touchLayer:setTouchEnabled(true)

		local playerCultivateView = self:getInjector():getInstance("MasterCultivateView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, playerCultivateView, nil, {
			showType = 1,
			id = self._selectedMasterId
		}))
	end)
	mcAnim:gotoAndStop(1)

	local leftBtn = self._main:getChildByFullName("btnPanel.leftBtn")
	local rightBtn = self._main:getChildByFullName("btnPanel.rightBtn")

	self._masterImg:changeParent(node_role_ani)
	self._masterImg:setPosition(cc.p(-60, -252))
	self._node_yz:changeParent(node_yz_ani)
	self._node_yz:setPosition(cc.p(-1, -48))
	self._node_info:changeParent(node_power_ani)
	self._node_info:setPosition(cc.p(-60, 20))

	self._mcAnim = mcAnim
end

function MasterEnterMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local node_master = self._masterImg

	if node_master then
		storyDirector:setClickEnv("MasterEnterMediator.node_master", node_master, function(sender, eventType)
			self:onClickShowCultivateView(sender, eventType)
		end)
	end

	local yz_touch = self._node_yz

	if yz_touch then
		storyDirector:setClickEnv("MasterEnterMediator.yz_touch", yz_touch, function(sender, eventType)
			self:onClickYz()
		end)
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_MasterEnterMediator")
	end))

	self:getView():runAction(sequence)
end
