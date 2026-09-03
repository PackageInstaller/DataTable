-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingMainComponent.lua

BuildingMainComponent = class("BuildingMainComponent", DmBaseUI)

BuildingMainComponent:has("_buildingMediator", {
	is = "rw"
})
BuildingMainComponent:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingMainComponent:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local layer_btn = {
	buy = "Layer_buy",
	operation = "layer_Operation",
	normal = "Layer_normal"
}
local __btnOperationList = {
	"infoBtn",
	"lvUpBtn",
	"recycleBtn",
	"btnSure",
	"goldButton",
	"expButton",
	"crystalButton"
}
local kBtnHandlers = {
	["main.Layer_normal.Button_put"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickPutHero"
	},
	["main.Layer_normal.Button_build"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBuild"
	},
	["main.Layer_normal.Button_bag"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBag"
	},
	["main.Layer_normal.Button_overview"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickOverview"
	},
	["main.Layer_normal.Button_buyRes"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBuyRes"
	},
	["main.Layer_buy.createcheck"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickOk"
	},
	["main.Layer_buy.createcancle"] = {
		clickAudio = "Se_Click_Cancle",
		func = "onClickCanel"
	},
	["main.layer_Operation.infoBtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBuildInfoBtn"
	},
	["main.layer_Operation.btnSure"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickOperationBuildOkBtn"
	},
	["main.layer_Operation.lvUpBtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBuildLvUp"
	},
	["main.layer_Operation.recycleBtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickRecycle"
	},
	["main.layer_Operation.goldButton"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBuyGold"
	},
	["main.layer_Operation.expButton"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBuyExp"
	},
	["main.layer_Operation.crystalButton"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickBuyCrystal"
	},
	["main.Node_comfort.btn_show"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickCombatAttShow"
	},
	["main.Node_comfort.Node_comfortTip.touchLayer"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickCombatAttHide"
	},
	["main.Layer_normal.Button_overview.Node_queue.Button"] = {
		clickAudio = "Se_Click_Open_2",
		func = "showQueueTip"
	}
}

function BuildingMainComponent:initialize(data)
	super.initialize(self)

	self._layerBtnList = {}
	self._btnOperationList = {}
	self._outInfoList = {}

	self:setView(data.view)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:intiView()
end

function BuildingMainComponent:intiView()
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())

	local image_bottom = self:getView():getChildByFullName("main.Image_bottom")
	local image_top = self:getView():getChildByFullName("main.Image_top")
	local image_right = self:getView():getChildByFullName("main.Image_right")
	local image_left = self:getView():getChildByFullName("main.Image_left")

	AdjustUtils.ignorSafeAreaRectForNode(image_top, AdjustUtils.kAdjustType.Top)
	AdjustUtils.ignorSafeAreaRectForNode(image_bottom, AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.ignorSafeAreaRectForNode(image_left, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(image_right, AdjustUtils.kAdjustType.Right)

	local text_put = self:getView():getChildByFullName("main.Layer_normal.Button_put.Text_15")
	local text_build = self:getView():getChildByFullName("main.Layer_normal.Button_build.Text_15")
	local text_bag = self:getView():getChildByFullName("main.Layer_normal.Button_bag.Text_15")
	local text_overView = self:getView():getChildByFullName("main.Layer_normal.Button_overview.Text")

	for k, v in pairs(layer_btn) do
		local name = "main." .. v

		self._layerBtnList[k] = self:getView():getChildByFullName(name)
	end

	local layer_Operation = self._layerBtnList.operation

	for k, v in pairs(__btnOperationList) do
		self._btnOperationList[v] = layer_Operation:getChildByFullName(v)
	end

	self._node_comfort = self:getView():getChildByFullName("main.Node_comfort")
	self._panelBtnY = self._layerBtnList.normal:getPositionY()

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(212, 221, 255, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	text_put:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	text_build:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	text_bag:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 254, 238, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 188, 109, 255)
		}
	}

	text_overView:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, lineGradiantDir))
	text_put:enableOutline(cc.c4b(65, 65, 70, 204), 2)
	text_build:enableOutline(cc.c4b(65, 65, 70, 204), 2)
	text_bag:enableOutline(cc.c4b(65, 65, 70, 204), 2)
	text_overView:enableOutline(cc.c4b(90, 37, 21, 255), 2)

	local queue_num = self:getView():getChildByFullName("main.Layer_normal.Button_overview.Node_queue.num")
	local queue_des = self:getView():getChildByFullName("main.Layer_normal.Button_overview.Node_queue.des")

	queue_num:enableOutline(cc.c4b(28, 18, 38, 204), 2)
	queue_des:enableOutline(cc.c4b(28, 18, 38, 204), 2)

	self._queue_num = queue_num

	local outGold = self:getView():getChildByFullName("main.Node_resouse.Node_1")
	local outJingShi = self:getView():getChildByFullName("main.Node_resouse.Node_2")
	local outExp = self:getView():getChildByFullName("main.Node_resouse.Node_3")

	outGold:getChildByFullName("Text"):enableOutline(cc.c4b(0, 0, 0, 204), 1)
	outJingShi:getChildByFullName("Text"):enableOutline(cc.c4b(0, 0, 0, 204), 1)
	outExp:getChildByFullName("Text"):enableOutline(cc.c4b(0, 0, 0, 204), 1)

	self._outInfoList[#self._outInfoList + 1] = {
		t = KBuildingType.kGoldOre,
		n = outGold
	}
	self._outInfoList[#self._outInfoList + 1] = {
		t = KBuildingType.kCrystalOre,
		n = outJingShi
	}
	self._outInfoList[#self._outInfoList + 1] = {
		t = KBuildingType.kExpOre,
		n = outExp
	}
end

function BuildingMainComponent:enterWithData()
	self:refreshLayerBtn()
	self:refreshComfort()
	self:refreshQueueNum()
	self:refreshRedPoint()
	self:refreshBuildOutPut()
	self:setupCornerMask()

	local button_build = self:getView():getChildByFullName("main.Layer_normal.Button_build")
	local button_put = self:getView():getChildByFullName("main.Layer_normal.Button_put")
	local systemKeeper = self._buildingSystem:getSystemKeeper()
	local unlock, tips = systemKeeper:isUnlock("VillageShopDecorate")

	if not unlock then
		button_build:setVisible(false)
		button_put:setPositionX(button_build:getPositionX())
	end
end

function BuildingMainComponent:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo_node")
	local currencyInfo = {}
	local currencyInfoWidget = ConfigReader:requireDataByNameIdAndKey("UnlockSystem", "Village_Building", "ResourcesBanner")

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Building_UI_BuildUp")
	}
	local injector = self._buildingMediator:getInjector()

	self._topInfoWidget = self._buildingMediator:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function BuildingMainComponent:setupCornerMask()
	local adjustType = {
		AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Bottom,
		AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top,
		AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom,
		AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Top
	}
	local idx = 1

	self._maskImg = self._maskImg or {}

	if #self._maskImg == 0 then
		local mainNode = self:getView():getChildByFullName("main")
		local size = mainNode:getContentSize()

		for x = 1, 2 do
			for y = 1, 2 do
				local maskImg = ccui.ImageView:create("asset/ui/building/pic_jiaodu.png", ccui.TextureResType.localType)

				maskImg:setAnchorPoint(cc.p(0, 0))
				maskImg:setScaleX(x > 1 and -1 or 1)
				maskImg:setScaleY(y > 1 and -1 or 1)
				maskImg:setOpacity(0)
				AdjustUtils.adjustLayoutByType(maskImg, adjustType[idx])
				self:getView():addChild(maskImg, -1)
				table.insert(self._maskImg, maskImg)

				local offsetX = cc.Director:getInstance():getWinSize().width - 1136

				maskImg:setPosition(cc.p((x - 1) * size.width - offsetX * (x > 1 and -1 or 1), (y - 1) * size.height))

				idx = idx + 1
			end
		end
	end
end

function BuildingMainComponent:showCornerMask()
	for k, v in pairs(self._maskImg) do
		local fadeIn = cc.FadeIn:create(0.25)
		local callback = cc.CallFunc:create(function()
			return
		end)

		v:runAction(cc.Sequence:create(fadeIn, callback))
	end
end

function BuildingMainComponent:hideCornerMask()
	for k, v in pairs(self._maskImg) do
		local fadeout = cc.FadeOut:create(0.25)
		local callback = cc.CallFunc:create(function()
			return
		end)

		v:runAction(cc.Sequence:create(fadeout, callback))
	end
end

function BuildingMainComponent:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingSystem:getMapShowType() == KBuildingMapShowType.kInRoom then
			AudioEngine:getInstance():playEffect("Se_Click_Close_1")
			self._buildingMediator:enterShowAll()
		else
			AudioEngine:getInstance():playEffect("Se_Click_Home_2")
			self._buildingMediator:dismiss()
		end
	end
end

function BuildingMainComponent:onClickPutHero(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local systemKeeper = self._buildingSystem:getSystemKeeper()
		local unlock, tips = systemKeeper:isUnlock("HeroAfk")

		if not unlock then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = tips
			}))

			return
		end

		local roomId = self._buildingSystem:getShowRoomId()

		if self._buildingSystem._mapShowType == KBuildingMapShowType.kAll then
			roomId = self._buildingSystem:getFristRoomId()

			self._buildingMediator:enterRoom(roomId, 0.2)
		end

		local view = self:getInjector():getInstance("BuildingPutHeroView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			roomId = roomId
		})

		self:dispatch(event)
	end
end

function BuildingMainComponent:onClickBuild(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local systemKeeper = self._buildingSystem:getSystemKeeper()
		local unlock, tips = systemKeeper:isUnlock("VillageShopDecorate")

		if not unlock then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = tips
			}))

			return
		end

		local roomId = self._buildingSystem:getShowRoomId()

		if self._buildingSystem._mapShowType == KBuildingMapShowType.kAll then
			roomId = self._buildingSystem:getFristRoomId()

			self._buildingMediator:enterRoom(roomId, 0.2)
		end

		local view = self:getInjector():getInstance("BuildingBuildView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			roomId = roomId
		})

		self:dispatch(event)
	end
end

function BuildingMainComponent:onClickBag(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local roomId = self._buildingSystem:getShowRoomId()

		if self._buildingSystem._mapShowType == KBuildingMapShowType.kAll then
			roomId = self._buildingSystem:getFristRoomId()

			self._buildingMediator:enterRoom(roomId, 0.2)
		end

		local view = self:getInjector():getInstance("BuildingBuildView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			showType = 2,
			roomId = roomId
		})

		self:dispatch(event)
	end
end

function BuildingMainComponent:onClickOverview(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local roomId = self._buildingSystem:getShowRoomId()

		if self._buildingSystem._mapShowType == KBuildingMapShowType.kAll or self._buildingSystem:getRoom(roomId) == nil then
			roomId = "Room2"

			self._buildingMediator:enterRoom("Room2", 0.2)
		end

		local view = self:getInjector():getInstance("BuildingOverviewView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			roomId = roomId
		})

		self:dispatch(event)
	end
end

function BuildingMainComponent:onClickBuyRes(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local view = self:getInjector():getInstance("NewCurrencyBuyPopView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kGold
		}))
	end
end

function BuildingMainComponent:onClickBuyGold(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local view = self:getInjector():getInstance("NewCurrencyBuyPopView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kGold
		}))
	end
end

function BuildingMainComponent:onClickBuyExp(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local view = self:getInjector():getInstance("NewCurrencyBuyPopView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kExp
		}))
	end
end

function BuildingMainComponent:onClickBuyCrystal(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._buildingMediator:getActionRuning() then
			return
		end

		local view = self:getInjector():getInstance("NewCurrencyBuyPopView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kCrystal
		}))
	end
end

function BuildingMainComponent:onClickOk(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kBuy then
			if self._buildingSystem:getBuildingCanChangeToPos(info.roomId, info.buildingId, info.pos, nil, info.revert) then
				local params = {}

				params.roomId = info.roomId
				params.buildConfigId = info.buildingId
				params.x = info.pos.x
				params.y = info.pos.y
				params.turn = info.revert and 1 or 0
				params.useAnother = info.another and 1 or 0

				local config = self._buildingSystem:getBuildingConfig(info.buildingId)

				if not config.Type then
					self._buildingSystem:sendBuyBuilding(params, true)
				else
					self._buildingSystem:sendBuyNPlaceSystemBuilding(params, true)
				end
			else
				self:dispatch(ShowTipEvent({
					duration = 0.5,
					tip = Strings:get("Building_Tips_Cover")
				}))
			end
		elseif info and info.operateType == KBuildingOperateType.kRecycle then
			if self._buildingSystem:getBuildingCanChangeToPos(info.roomId, info.buildingId, info.pos, nil, info.revert) then
				local params = {}

				params.roomId = info.roomId
				params.buildId = info.id
				params.posX = info.pos.x
				params.posY = info.pos.y
				params.turn = info.revert and 1 or 0

				self._buildingSystem:sendWarehouseToMap(params, true)
			else
				self:dispatch(ShowTipEvent({
					duration = 0.5,
					tip = Strings:get("Building_Tips_Cover")
				}))
			end
		end
	end
end

function BuildingMainComponent:onClickCanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kBuy then
			self._buildingMediator:removeBuyBuilding()
		elseif info and info.operateType == KBuildingOperateType.kRecycle then
			self._buildingMediator:removeWarehouseBuilding()
		end
	end
end

function BuildingMainComponent:onClickBuildInfoBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kMove then
			local data = {
				roomId = info.roomId,
				buildingId = info.buildingId,
				id = info.id
			}
			local view = self:getInjector():getInstance("BuildingInfoView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data)

			self:dispatch(event)
		end
	end
end

function BuildingMainComponent:onClickOperationBuildOkBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info.operateType == KBuildingOperateType.kMove then
			self._buildingMediator:onMoveBuildingFinsh()
		end
	end
end

function BuildingMainComponent:onClickDoNotOpen(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("Building_Tips_SurfaceLock")
		}))
	end
end

function BuildingMainComponent:onClickBuildLvUp(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kMove then
			local data = {
				roomId = info.roomId,
				buildingId = info.buildingId,
				id = info.id
			}
			local config = self._buildingSystem:getBuildingConfig(info.buildingId)
			local view = self:getInjector():getInstance("BuildingLvUpView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data)

			self:dispatch(event)
		end
	end
end

function BuildingMainComponent:onClickBuildLvUpCanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kMove then
			local data = {
				roomId = info.roomId,
				buildingId = info.buildingId,
				id = info.id
			}
			local view = self:getInjector():getInstance("BuildingCancelCheckView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data)

			self:dispatch(event)
		end
	end
end

function BuildingMainComponent:onClickBuildLvUpImmediately(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kMove then
			local params = {}

			params.roomId = info.roomId
			params.buildId = info.id
			params.type = 1

			self._buildingSystem:sendBuildingLvUpFinish(params, true)
		end
	end
end

function BuildingMainComponent:onClickPointOre(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kMove then
			local data = {
				roomId = info.roomId,
				buildingId = info.buildingId,
				id = info.id
			}
			local view = self:getInjector():getInstance("BuildingSubOrcInfoView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data)

			self:dispatch(event)
		end
	end
end

function BuildingMainComponent:onClickRecycle(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local info = self._buildingSystem:getOperateInfo()

		if info and info.operateType == KBuildingOperateType.kMove then
			local params = {}

			params.roomId = info.roomId
			params.buildId = info.id

			self._buildingSystem:sendRecycleBuilding(params, true)
		end
	end
end

function BuildingMainComponent:refreshLayerBtn()
	for k, v in pairs(self._layerBtnList) do
		v:setVisible(false)
	end

	local info = self._buildingSystem:getOperateInfo()

	if info and (info.operateType == KBuildingOperateType.kBuy or info.operateType == KBuildingOperateType.kRecycle) then
		self._layerBtnList.buy:setVisible(true)

		local decorateComponent = self._buildingMediator._decorateComponent
		local mainNode = self:getView():getChildByFullName("main")
		local node

		if info.operateType == KBuildingOperateType.kBuy then
			node = decorateComponent:getBuyingBuilding()
		elseif info.operateType == KBuildingOperateType.kRecycle then
			node = decorateComponent:getWarehouseBuilding()
		end

		if node and node.__mediator then
			local centerNode = node.__mediator._centerNode
			local buildWorldPos = centerNode:convertToWorldSpace(cc.p(0, 0))
			local mainNodeWorldPos = mainNode:convertToWorldSpace(cc.p(0, 0))

			self._layerBtnList.buy:setPosition(cc.p(buildWorldPos.x - mainNodeWorldPos.x, buildWorldPos.y - mainNodeWorldPos.y - 35))
		end

		self:hideBackBtn()
	elseif info then
		self._layerBtnList.operation:setVisible(true)
		self:refreshOperationBtn(info.roomId, info.buildingId, info.id)

		local decorateComponent = self._buildingMediator._decorateComponent
		local mainNode = self:getView():getChildByFullName("main")
		local node = decorateComponent:getOperationBuilding()

		if node and node.__mediator then
			local centerNode = node.__mediator._centerNode
			local buildWorldPos = centerNode:convertToWorldSpace(cc.p(0, 0))
			local mainNodeWorldPos = mainNode:convertToWorldSpace(cc.p(0, 0))

			self._layerBtnList.operation:setPosition(cc.p(buildWorldPos.x - mainNodeWorldPos.x, buildWorldPos.y - mainNodeWorldPos.y - 35))
		end

		self:hideBackBtn()
	else
		self._layerBtnList.normal:setVisible(true)
		self:runMoveAction(self._layerBtnList.normal)
		self:showBackBtn()
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local sequence = cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		storyDirector:notifyWaiting("notify_Building_refreshLayerBtn")
	end))

	self:getView():runAction(sequence)
end

function BuildingMainComponent:refreshOperationBtn(roomId, buildingId, id)
	for k, v in pairs(self._btnOperationList) do
		v:setVisible(false)
	end

	local showList = {}
	local config = self._buildingSystem:getBuildingConfig(buildingId)

	showList = (config.Type == nil or config.Type == "") and {
		"infoBtn",
		"recycleBtn",
		"btnSure"
	} or config.Type == KBuildingType.kGoldOre and {
		"infoBtn",
		"lvUpBtn",
		"goldButton",
		"btnSure"
	} or config.Type == KBuildingType.kCrystalOre and {
		"infoBtn",
		"lvUpBtn",
		"crystalButton",
		"btnSure"
	} or config.Type == KBuildingType.kExpOre and {
		"infoBtn",
		"lvUpBtn",
		"expButton",
		"btnSure"
	} or config.Type == KBuildingType.kCamp and {
		"infoBtn",
		"lvUpBtn",
		"btnSure"
	} or {
		"infoBtn",
		"lvUpBtn",
		"btnSure"
	}

	local len = 112
	local numBtn = #showList

	for k, v in pairs(showList) do
		self._btnOperationList[v]:setVisible(true)

		local initX = 0 - (numBtn - 1) * 0.5 * len

		self._btnOperationList[v]:setPosition(cc.p(initX + (k - 1) * len, 0))
	end
end

function BuildingMainComponent:refreshComfort()
	local comfort = self._buildingSystem:getAllComfort()
	local text_num = self._node_comfort:getChildByFullName("Text_num")

	text_num:setString(comfort)
end

function BuildingMainComponent:runMoveAction(node)
	node:stopActionByTag(9090)
	node:setPositionY(self._panelBtnY - 110)

	local moveAction = cc.MoveTo:create(0.2, cc.p(node:getPositionX(), self._panelBtnY))

	moveAction:setTag(9090)
	node:runAction(moveAction)
end

function BuildingMainComponent:onClickCombatAttShow()
	local node_comfortTip = self:getView():getChildByFullName("main.Node_comfort.Node_comfortTip")

	node_comfortTip:setVisible(true)

	local text_num = node_comfortTip:getChildByFullName("Text_num")
	local text1 = node_comfortTip:getChildByFullName("Text_num_1")
	local text2 = node_comfortTip:getChildByFullName("Text_num_2")
	local text3 = node_comfortTip:getChildByFullName("Text_num_3")
	local text4 = node_comfortTip:getChildByFullName("Text_num_4")
	local comfort = self._buildingSystem:getAllComfort()

	text_num:setString(comfort)

	local attInfo = self._buildingSystem:getComfortAtt()

	text1:setString("+" .. attInfo.ATK)
	text2:setString("+" .. attInfo.DEF)
	text3:setString("+" .. attInfo.HP)
	text4:setString("+" .. attInfo.SPEED)
	text1:setPositionX(node_comfortTip:getChildByFullName("Text_1"):getContentSize().width + node_comfortTip:getChildByFullName("Text_1"):getPositionX())
	text2:setPositionX(node_comfortTip:getChildByFullName("Text_2"):getContentSize().width + node_comfortTip:getChildByFullName("Text_2"):getPositionX())
	text3:setPositionX(node_comfortTip:getChildByFullName("Text_3"):getContentSize().width + node_comfortTip:getChildByFullName("Text_3"):getPositionX())
	text4:setPositionX(node_comfortTip:getChildByFullName("Text_4"):getContentSize().width + node_comfortTip:getChildByFullName("Text_4"):getPositionX())
end

function BuildingMainComponent:onClickCombatAttHide()
	local node_comfortTip = self:getView():getChildByFullName("main.Node_comfort.Node_comfortTip")

	node_comfortTip:setVisible(false)
end

function BuildingMainComponent:hideBackBtn()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo_node")
	local btn = topInfoNode:getChildByFullName("back_btn")
	local circle = topInfoNode:getChildByFullName("circle")

	btn:setVisible(false)
	circle:setVisible(false)

	if self._topInfoWidget._mc then
		self._topInfoWidget._mc:setVisible(false)
	end
end

function BuildingMainComponent:showBackBtn()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo_node")
	local btn = topInfoNode:getChildByFullName("back_btn")
	local circle = topInfoNode:getChildByFullName("circle")

	circle:setVisible(false)
	btn:setVisible(true)

	if self._topInfoWidget._mc then
		self._topInfoWidget._mc:setVisible(true)
	end
end

function BuildingMainComponent:refreshQueueNum()
	local num = self._buildingSystem:getBuildingQueueNum()
	local allNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_BuildingQueue_Free", "content")

	self._queue_num:setString(num .. "/" .. allNum)

	local node_free = self:getView():getChildByFullName("main.Layer_normal.Button_overview.Node_free")
	local node_build = self:getView():getChildByFullName("main.Layer_normal.Button_overview.Node_build")

	node_free:setVisible(false)
	node_build:setVisible(false)

	if num > 0 then
		node_free:setVisible(true)
	else
		node_build:setVisible(true)
	end

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local des = self:getView():getChildByFullName("main.Layer_normal.Button_overview.Node_queue.des")
		local width = des:getContentSize().width - 45

		node_free:setPositionX(278 + width)
		node_build:setPositionX(278 + width)
	end
end

function BuildingMainComponent:refreshRedPoint()
	local redPoint = self:getView():getChildByFullName("main.Layer_normal.Button_overview.redPoint")

	if self._buildingSystem:getBuildLvOrBuildSta() then
		redPoint:setVisible(true)
	else
		redPoint:setVisible(false)
	end
end

function BuildingMainComponent:showQueueTip()
	local view = self:getInjector():getInstance("BuildingQueueBuyView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	})

	self:dispatch(event)
end

function BuildingMainComponent:refreshBuildOutPut()
	local showList = {}
	local outList, resList = self._buildingSystem:getAllBuildOutAndRes()

	for index, info in pairs(self._outInfoList) do
		local t = info.t
		local node = info.n

		node:setVisible(false)

		if outList[t] and outList[t] > 0 then
			showList[#showList + 1] = node

			node:getChildByFullName("Text"):setString(outList[t] .. Strings:get("Building_Product_Unit"))
		end
	end

	for index, node in pairs(showList) do
		node:setVisible(true)
		node:setPositionY(-27 - (index - 1) * 50)
	end
end
