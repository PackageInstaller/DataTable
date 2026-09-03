-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/DebugBustShowViewMediator3.lua

DebugBustShowViewMediator3 = class("DebugBustShowViewMediator3", DmAreaViewMediator)

DebugBustShowViewMediator3:has("_developSystem", {
	is = "r"
}):injectWith(DevelopSystem)

local kBtnHandlers = {
	["main.Button_19"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRight"
	},
	["main.Button_20"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickLeft"
	},
	["main.Button_17"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBack"
	},
	["main.Button_21"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChange"
	},
	["main.Button_20_0"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPageLeft"
	},
	["main.Button_19_0"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPageRight"
	}
}

function DebugBustShowViewMediator3:initialize()
	super.initialize(self)
end

function DebugBustShowViewMediator3:dispose()
	super.dispose(self)
end

function DebugBustShowViewMediator3:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:initData()
end

function DebugBustShowViewMediator3:onClickBack()
	self:dismiss()
end

function DebugBustShowViewMediator3:enterWithData(data)
	self._modelId = data.id
	self._frameId = self._bustFrames[1]
	self._flag = data.flag

	if data.flag == 1 then
		self._index = table.find(self._masterData, self._modelId)
	end

	if data.flag == 2 then
		self._index = table.find(self._heroData, self._modelId)
	end

	if data.flag == 3 then
		self._index = table.find(self._allData, self._modelId)
	end

	self._pageIndex = 1

	self:initView()
end

local unuse_fid = {
	"bustframe6_4",
	"bustframe4_10",
	"bustframe5_1",
	"bustframe5",
	"bustframe7_3",
	"bustframe19",
	"bustframe20"
}
local diff_fid = {
	"bustframe4_7",
	"bustframe6_6",
	"bustframe18"
}

function DebugBustShowViewMediator3:initData()
	self._masterData = {}
	self._heroData = {}
	self._awakeData = {}
	self._surface = {}
	self._allData = {}

	local dataTable = ConfigReader:getDataTable("RoleModel")

	for k, v in pairs(dataTable) do
		local picType = v.PicType
		local path = v.Path

		if path and path ~= "" then
			if picType == 1 then
				table.insert(self._masterData, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 2 then
				table.insert(self._heroData, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 3 then
				table.insert(self._surface, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 5 then
				table.insert(self._heroData, v.Id)
				table.insert(self._awakeData, v.Id)
				table.insert(self._allData, v.Id)
			end
		end
	end

	self._bustFrames = {}

	local dataTable = ConfigReader:getDataTable("BustFrame")

	for k, v in pairs(dataTable) do
		local fid = v.Id

		if not table.find(unuse_fid, fid) and not table.find(diff_fid, fid) then
			table.insert(self._bustFrames, v.Id)
		end
	end

	self._zhujueFrames = {
		"bustframe13_3",
		"bustframe13_4",
		"bustframe13_7",
		"bustframe13_8",
		"bustframe13_9",
		"bustframe13_10",
		"bustframe1",
		"bustframe2_2",
		"bustframe4_1",
		"bustframe4_2",
		"bustframe4_3",
		"bustframe4_4",
		"bustframe4_5",
		"bustframe4_9",
		"bustframe6_1",
		"bustframe6_2",
		"bustframe6_3"
	}
	self._huobanframes = {
		"bustframe3",
		"bustframe4_8",
		"bustframe7_1",
		"bustframe7_2",
		"bustframe8",
		"bustframe13_1",
		"bustframe13_2"
	}
	self._huobanAndZhujueFrames = {
		"bustframe10",
		"bustframe11"
	}
	self._noStencialFrames = {
		"bustframe2_1",
		"bustframe6_5",
		"bustframe9",
		"bustframe16",
		"bustframe17",
		"bustframe15",
		"bustframe2_5"
	}
end

function DebugBustShowViewMediator3:initView()
	self._main = self:getView():getChildByFullName("main")
	self._panel = self._main:getChildByFullName("Panel_36")
	self._editBox = self._main:getChildByFullName("TextField")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setString("")
	end

	self._editBox:setString(self._modelId)

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:onEvent(function(eventName, sender)
		return
	end)
	self:refreshView2()
end

function DebugBustShowViewMediator3:refreshView2()
	self._panel:removeAllChildren()

	self._hand = nil

	if self._flag == 1 then
		local view = cc.CSLoader:createNode("asset/ui/TowerMasterShowDetails.csb")

		view:setScale(0.5)
		view:addTo(self._panel):posite(0, 320)

		local mainPanel = view:getChildByFullName("mainpanel")
		local roleNode = mainPanel:getChildByName("roleNode")

		roleNode:setScale(1)
		roleNode:setPosition(cc.p(1573, 300))

		local moveto = cc.MoveTo:create(0.12, cc.p(700, 300))
		local moveto1 = cc.MoveTo:create(0.08, cc.p(750, 300))
		local seq = cc.Sequence:create(moveto, moveto1)

		roleNode:runAction(seq)

		local realImage = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe2_5",
			id = self._modelId
		})

		realImage:setPosition(cc.p(-350, -300))
		roleNode:addChild(realImage)

		local editBox = self._main:getChildByFullName("TextField_" .. 1)

		editBox:setString("bustframe2_5")

		local view = cc.CSLoader:createNode("asset/ui/MasterCultivateUI.csb")

		view:setScale(0.5)
		view:addTo(self._panel):posite(0, 0)

		local mainPanel = view:getChildByFullName("mainpanel")

		mainPanel:stopAllActions()

		local action = cc.CSLoader:createTimeline("asset/ui/MasterCultivateUI.csb")

		mainPanel:runAction(action)
		action:clearFrameEventCallFunc()
		action:gotoFrameAndPlay(0, 57, false)
		action:setTimeSpeed(1.1)

		local rolePanel = mainPanel:getChildByFullName("rolePanel")

		rolePanel:removeChildByName("MasterAnim")

		self._rolePanelAnim = cc.MovieClip:create("renwu_yinghun")

		self._rolePanelAnim:addTo(rolePanel)
		self._rolePanelAnim:setName("MasterAnim")
		self._rolePanelAnim:addCallbackAtFrame(30, function()
			self._rolePanelAnim:stop()
		end)
		self._rolePanelAnim:setPosition(cc.p(300, 275))
		self._rolePanelAnim:setPlaySpeed(1.5)

		local panel = self._rolePanelAnim:getChildByName("heroPanel")

		panel:removeAllChildren()

		local role = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe2_1",
			id = self._modelId
		})

		role:addTo(panel):posite(-500, -220)

		local editBox = self._main:getChildByFullName("TextField_" .. 5)

		editBox:setString("bustframe2_1")

		local view = cc.CSLoader:createNode("asset/ui/NewHero.csb")

		view:setScale(0.5)
		view:addTo(self._panel):posite(600, 0)

		local main = view:getChildByFullName("main")
		local anim = cc.MovieClip:create("zonghe_choukahuodeyinghun")

		anim:addTo(main:getChildByName("animPanel"))
		anim:setPosition(cc.p(100, 100))
		anim:addEndCallback(function()
			anim:stop()
		end)

		local heroNode = anim:getChildByName("heroNode")

		anim:addCallbackAtFrame(6, function()
			if heroNode then
				local heroAnim = cc.MovieClip:create("renwu_choukahuodeyinghun")

				heroAnim:addEndCallback(function()
					heroAnim:stop()
				end)

				local roleNode = heroAnim:getChildByName("roleNode")
				local realImage = IconFactory:createRoleIconSpriteNew({
					useAnim = true,
					frameId = "bustframe2_1",
					id = self._modelId
				})

				realImage:setAnchorPoint(0.5, 0.5)
				realImage:addTo(roleNode)
				realImage:setPosition(cc.p(0, 100))
				heroAnim:addTo(heroNode)
				heroAnim:setPosition(cc.p(0, 0))
			end
		end)

		local editBox = self._main:getChildByFullName("TextField_" .. 7)

		editBox:setString("bustframe2_1")
		self._editBox:setText(self._modelId)

		local text_fid = self._main:getChildByFullName("text_page")

		text_fid:setString(self._index .. "/" .. #self._masterData)
	end

	if self._flag == 3 then
		if self._pageIndex == 1 then
			local view = cc.CSLoader:createNode("asset/ui/ActivityBlockMain.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(0, 320)

			local roleNode = view:getChildByFullName("main.roleNode")

			roleNode:removeAllChildren()

			local img, jsonPath = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				frameId = "bustframe9",
				id = self._modelId
			})

			img:addTo(roleNode):posite(50, -100)
			img:setScale(0.78)

			local editBox = self._main:getChildByFullName("TextField_" .. 1)

			editBox:setString("bustframe9")

			local view = cc.CSLoader:createNode("asset/ui/MainScene.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(600, 320)

			local homePanel = view:getChildByName("mHomePanel")
			local showHeroPanel = homePanel:getChildByName("heroPanel")
			local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				frameId = "bustframe9",
				id = self._modelId
			})

			heroSprite:addTo(showHeroPanel)
			heroSprite:setPosition(cc.p(160, -70))

			local surfaceId
			local sList = ConfigReader:getDataTable("Surface")

			for k, v in pairs(sList) do
				if v.Model == self._modelId then
					surfaceId = k

					break
				end
			end

			if surfaceId then
				local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
				local num = #surfaceData

				for i = 1, num do
					local _info = surfaceData[i]
					local touchPanel = ccui.Layout:create()

					touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

					local point = _info.point
					local size = heroSprite:getContentSize()

					if point[1] == "all" then
						touchPanel:setContentSize(cc.size(size.width, size.height))
						touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
					else
						touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))
						touchPanel:setPosition(cc.p(_info.point[1] * picInfo.zoom + picInfo.Deviation[1] + size.width / 2, _info.point[2] * picInfo.zoom + picInfo.Deviation[2]))
					end

					if not GameConfigs.HERO_TOUCHVIEW_DEBUG then
						-- block empty
					end

					touchPanel:setBackGroundColorType(1)
					touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
					touchPanel:setBackGroundColorOpacity(60)
					touchPanel:addTo(heroSprite, num + 1 - i)
				end
			end

			local editBox = self._main:getChildByFullName("TextField_" .. 3)

			editBox:setString("bustframe9")

			local view = cc.CSLoader:createNode("asset/ui/BlockFightWinLayer.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(0, 0)

			local mvpSprite = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				frameId = "bustframe17",
				id = self._modelId
			})

			mvpSprite:setScale(0.8)

			local anim = cc.MovieClip:create("stageshengli_fubenjiesuan")
			local bgPanel = view:getChildByFullName("content.heroAndBgPanel")
			local mvpSpritePanel = anim:getChildByName("roleNode")

			mvpSpritePanel:addChild(mvpSprite)
			mvpSprite:setPosition(cc.p(-200, -200))
			anim:addCallbackAtFrame(45, function()
				anim:stop()
			end)
			anim:addTo(bgPanel):center(bgPanel:getContentSize())
			anim:gotoAndPlay(1)

			local editBox = self._main:getChildByFullName("TextField_" .. 5)

			editBox:setString("bustframe17")

			local view = cc.CSLoader:createNode("asset/ui/BlockFightLoseLayer.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(600, 0)

			local svpSprite = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				frameId = "bustframe17",
				id = self._modelId
			})

			svpSprite:setScale(0.8)

			local anim = cc.MovieClip:create("shibai_fubenjiesuan")
			local bgPanel = view:getChildByFullName("content.heroAndBgPanel")

			anim:addCallbackAtFrame(45, function()
				anim:stop()
			end)
			anim:addTo(bgPanel):center(bgPanel:getContentSize())

			local svpSpritePanel = anim:getChildByName("roleNode")

			svpSpritePanel:addChild(svpSprite)
			svpSprite:setPosition(cc.p(-200, -200))
			anim:gotoAndPlay(1)

			local editBox = self._main:getChildByFullName("TextField_" .. 7)

			editBox:setString("bustframe17")
		end

		if self._pageIndex == 2 then
			for i = 1, 8 do
				local editBox = self._main:getChildByFullName("TextField_" .. i)

				editBox:setString("")
			end

			local anim = cc.MovieClip:create("zdhb_yinghunshangchang")

			anim:addTo(self._panel):posite(600, 300)

			local heroTipAimPic = anim:getChildByFullName("heroPic")
			local portrait = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe15",
				id = self._modelId
			})

			portrait:addTo(heroTipAimPic)
			portrait:offset(200, -110)

			local viewNode = cc.CSLoader:createNode("asset/ui/HeroCardTipsWidget.csb")

			BattleHeroTipWidget:new(viewNode)
			viewNode:addTo(anim:getChildByFullName("widget")):offset(-119, -267)
			anim:addEndCallback(function()
				anim:stop()
			end)

			local editBox = self._main:getChildByFullName("TextField_" .. 1)

			editBox:setString("bustframe15")

			local surfaceId
			local sList = ConfigReader:getDataTable("Surface")

			for k, v in pairs(sList) do
				if v.Model == self._modelId then
					surfaceId = k

					break
				end
			end

			if surfaceId then
				local heroSp, _, _, picInfo = IconFactory:createRoleIconSpriteNew({
					useAnim = true,
					frameId = "bustframe9",
					id = self._modelId
				})

				heroSp:addTo(self._panel):posite(900, 100)

				local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
				local _info = surfaceData[1]
				local touchPanel = ccui.Layout:create()

				touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

				local size = heroSp:getContentSize()
				local offSetX = size.width / 2

				touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))

				local posX = _info.point[1] * picInfo.zoom + picInfo.Deviation[1] + offSetX
				local posY = _info.point[2] * picInfo.zoom + picInfo.Deviation[2]

				touchPanel:setPosition(cc.p(posX, posY))
				touchPanel:setTouchEnabled(false)

				if not GameConfigs.HERO_TOUCHVIEW_DEBUG then
					-- block empty
				end

				touchPanel:setBackGroundColorType(1)
				touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
				touchPanel:setBackGroundColorOpacity(180)

				if not self._hand then
					local pic = ccui.ImageView:create("zc_img_hand.png", ccui.TextureResType.plistType)

					pic:setScale(0.5)

					self._hand = pic

					self._hand:addTo(self._panel)
				end

				touchPanel:addTo(heroSp)
				self._hand:changeParent(heroSp)

				self._handPosX = posX
				self._handPosY = posY + _info.range[2] * picInfo.zoom / 2

				self._hand:setPosition(cc.p(self._handPosX, self._handPosY))
			end
		end

		self._editBox:setText(self._modelId)

		local text_fid = self._main:getChildByFullName("text_page")

		text_fid:setString(self._index .. "/" .. #self._allData)
	end
end

function DebugBustShowViewMediator3:onClickLeft()
	if self._flag == 1 then
		self._index = self._index - 1
		self._index = math.max(self._index, 1)
		self._modelId = self._masterData[self._index]
	end

	if self._flag == 3 then
		self._index = self._index - 1
		self._index = math.max(self._index, 1)
		self._modelId = self._allData[self._index]
	end

	self:refreshView2()
end

function DebugBustShowViewMediator3:onClickRight()
	if self._flag == 1 then
		self._index = self._index + 1
		self._index = math.min(self._index, #self._masterData)
		self._modelId = self._masterData[self._index]
	end

	if self._flag == 3 then
		self._index = self._index + 1
		self._index = math.min(self._index, #self._allData)
		self._modelId = self._allData[self._index]
	end

	self:refreshView2()
end

function DebugBustShowViewMediator3:onClickPageLeft()
	self._pageIndex = 1

	self:refreshView2()
end

function DebugBustShowViewMediator3:onClickPageRight()
	self._pageIndex = 2

	self:refreshView2()
end

function DebugBustShowViewMediator3:onClickChange()
	return
end
