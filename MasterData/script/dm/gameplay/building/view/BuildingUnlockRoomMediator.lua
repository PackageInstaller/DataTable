-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingUnlockRoomMediator.lua

BuildingUnlockRoomMediator = class("BuildingUnlockRoomMediator", DmPopupViewMediator)

BuildingUnlockRoomMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")

local kBtnHandlers = {
	["Panel_base.Node_bg.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onBackClicked"
	}
}

function BuildingUnlockRoomMediator:initialize()
	super.initialize(self)
end

function BuildingUnlockRoomMediator:dispose()
	super.dispose(self)
end

function BuildingUnlockRoomMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("Panel_base.Button_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickOK, self)
		}
	})
end

function BuildingUnlockRoomMediator:enterWithData(data)
	self._roomId = data.roomId

	self:setupView()
	self:refreshView()
	self:setupClickEnvs()
end

function BuildingUnlockRoomMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("Panel_base")

	local node_name = self._mainPanel:getChildByFullName("Node_bg.title_node")

	bindWidget(self, node_name, PopupNormalTitle, {
		title = Strings:get("BuildingTitle_AreaUnlock"),
		title1 = Strings:get("UITitle_EN_Quyujiesuo"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 38 or nil
	})

	local text_name = self._mainPanel:getChildByFullName("Text_name")
	local roomName = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._roomId, "Name")

	text_name:setString(Strings:get(roomName))
	text_name:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function BuildingUnlockRoomMediator:onClickOK()
	self._buildingSystem:sendUnlockRoom(self._roomId, true)
	self:close()
end

function BuildingUnlockRoomMediator:onBackClicked(sender, eventType)
	self:close()
end

function BuildingUnlockRoomMediator:refreshView()
	local des1 = self:getView():getChildByFullName("Panel_base.Text_des1")
	local des2 = self:getView():getChildByFullName("Panel_base.Text_des2")
	local des3 = self:getView():getChildByFullName("Panel_base.Text_des3")
	local des4 = self:getView():getChildByFullName("Panel_base.Text_des4")
	local image_floor = self:getView():getChildByFullName("Panel_base.Image_floor")
	local roomDes = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._roomId, "Desc")
	local unlockBuilding = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._roomId, "UnlockBuilding")

	des1:setString(Strings:get(roomDes))
	des3:setString(Strings:get(unlockBuilding[1]))
	des4:setString(Strings:get(unlockBuilding[2]))
	des1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	des3:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	des4:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local icon = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._roomId, "Icon")

	if icon and icon ~= "" then
		image_floor:loadTexture(icon .. ".png", ccui.TextureResType.plistType)
	end
end

function BuildingUnlockRoomMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local button_ok = self:getView():getChildByFullName("Panel_base.Button_ok")

		if button_ok then
			storyDirector:setClickEnv("BuildingUnlockRoom.button_ok", button_ok, function(sender, eventType)
				storyDirector:notifyWaiting("click_BuildingUnlockRoom_button_ok")
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:onClickOK()
			end)
		end

		storyDirector:notifyWaiting("enter_buildingUnlockRoom_view")
	end))

	self:getView():runAction(sequence)
end
