-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/toasts/BuildingToast.lua

BuildingToast = class("BuildingToast", SimpleToast)

function BuildingToast:setup(parentLayer, parentFrame, options, activeToasts)
	self._data = options.data or nil
	self._options = options

	local view = self:getView()

	view:setCascadeOpacityEnabled(true)
	parentLayer:addChild(self:getView(), 1001)
	view:setPosition(0, 0)

	local buildName = view:getChildByFullName("node.buildName")
	local relaxNum = view:getChildByFullName("node.infoPanel.relaxNum")
	local text = view:getChildByFullName("node.infoPanel.text")

	buildName:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	relaxNum:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	return true
end

function BuildingToast:startAnimation(endCallback)
	local view = self:getView()

	view:setPosition(-568, -320)

	if not self._data then
		view:removeFromParent()
		endCallback(self)

		return
	end

	local dispatcher = DmGame:getInstance()
	local injector = dispatcher._injector
	local buildingSystem = injector:getInstance("BuildingSystem")
	local node = view:getChildByFullName("node")
	local infoPanel = node:getChildByFullName("infoPanel")

	node:setVisible(false)
	node:setOpacity(0)

	local buildName = node:getChildByFullName("buildName")
	local text = infoPanel:getChildByFullName("text")
	local relaxNum = infoPanel:getChildByFullName("relaxNum")
	local comfort = 0
	local buildingData = buildingSystem:getBuildingData(self._data.roomId, self._data.id)
	local config = buildingSystem:getBuildingConfig(self._data.buildingId)
	local str = Strings:get(config.Name)

	if buildingData then
		str = str .. " Lv." .. self._data.level or buildingData._level

		local skinId = buildingData._skinId
		local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

		comfort = skinConfig.Comfort or 0
	else
		local skinId = config.DefaultSurface
		local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

		comfort = skinConfig.Comfort or 0
	end

	comfort = comfort == 0 and "" or "+" .. comfort

	if comfort == "" then
		local var_2_0 = Strings:get("Buildingfinish_Tips")

		if not var_2_0 then
			var_2_0 = Strings:get("Building_UI_Relax")

			local tip = var_2_0

			buildName:setString(str)
			relaxNum:setString(comfort)
			text:setString(tip)

			local width1 = text:getContentSize().width
			local width2 = relaxNum:getContentSize().width

			infoPanel:setContentSize(cc.size(width1 + width2), 37)
			text:setPositionX(0)
			relaxNum:setPositionX(width1 + 5)

			local animNode = view:getChildByFullName("animNode")
			local anim = cc.MovieClip:create("huodetishi_huodetishi")

			anim:addTo(animNode, 1)
			anim:addCallbackAtFrame(55, function()
				local storyDirector = injector:getInstance(story.StoryDirector)

				storyDirector:notifyWaiting("close_BuildingToast_view")
				self:getView():removeFromParent()
				endCallback(self)
			end)

			local cnText = anim:getChildByFullName("cnText")
			local enText = anim:getChildByFullName("enText")
			local title = ""
			local titleEn = ""

			if self._data.showType == 1 then
				title = Strings:get("Tips_3010021")
				titleEn = Strings:get("UITitle_EN_Shengjichenggong")
			elseif self._data.showType == 2 then
				title = Strings:get("Build_Finish_Title")
				titleEn = Strings:get("UITitle_EN_Jianzaochenggong")
			end

			local title1 = cc.Label:createWithTTF(title, CUSTOM_TTF_FONT_1, 50)

			title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			title1:addTo(cnText):offset(0, -3)

			local title2 = cc.Label:createWithTTF(titleEn, TTF_FONT_FZYH_M, 18)

			title2:setColor(cc.c3b(150, 160, 255))
			title2:addTo(enText)

			local buildNode = anim:getChildByFullName("icon")
			local iconNode = cc.Node:create()
			local buildingDecorate = injector:instantiate("BuildingDecorate", {
				view = iconNode
			})

			buildingDecorate:setBuildingInfo(self._data.roomId, self._data.buildingId, self._data.id)
			buildingDecorate:enterWithData()

			local skinId = buildingSystem:getBuildingSkinId(self._data.roomId, self._data.buildingId, self._data.id)
			local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

			if skinConfig then
				iconNode:setScale(skinConfig.PicScale[3] or 1)
			end

			iconNode:addTo(buildNode):offset(0, -30)
			anim:addCallbackAtFrame(9, function()
				local callFunc = cc.CallFunc:create(function()
					node:setVisible(true)
				end)
				local fadeIn = cc.FadeIn:create(0.3)
				local seq = cc.Sequence:create(callFunc, fadeIn)

				node:runAction(seq)
			end)
			anim:addCallbackAtFrame(40, function()
				local callFunc = cc.CallFunc:create(function()
					node:setVisible(false)
				end)
				local fadeIn = cc.FadeOut:create(0.1)
				local seq = cc.Sequence:create(callFunc, fadeIn)

				node:runAction(seq)
			end)
		end
	end
end

function ShowBuildingTipEvent(args)
	local toastView = cc.CSLoader:createNode("asset/ui/BuildingLvUpSuc.csb")
	local toast = BuildingToast:new(toastView)

	return ToastEvent:new(EVT_SHOW_REWARD_TOAST, toast, args)
end
