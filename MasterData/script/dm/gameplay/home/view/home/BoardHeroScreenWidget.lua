-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/home/BoardHeroScreenWidget.lua

BoardHeroScreenWidget = class("BoardHeroScreenWidget", DisposableObject, _M)

BoardHeroScreenWidget:has("_view", {
	is = "r"
})
BoardHeroScreenWidget:has("_info", {
	is = "r"
})
BoardHeroScreenWidget:has("_mediator", {
	is = "r"
})

local TargetOccupation = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Team_TypeOrder", "content")

function BoardHeroScreenWidget:initialize(info)
	super.initialize(self)

	self._screenList = {}
	self._screenList[1] = {
		"SP",
		"SSR",
		"SR",
		"R"
	}
	self._screenList[2] = {}

	for i = 1, #TargetOccupation do
		local type = TargetOccupation[i]
		local name = GameStyle:getHeroOccupation(type)

		table.insert(self._screenList[2], name)
	end

	self._screenList[3] = {
		GalleryPartyType.kWNSXJ,
		GalleryPartyType.kXD,
		GalleryPartyType.kBSNCT,
		GalleryPartyType.kDWH,
		GalleryPartyType.kMNJH,
		GalleryPartyType.kSSZS,
		GalleryPartyType.kUNKNOWN
	}
	self._info = info
	self._mediator = info.mediator
	self._select = {}

	self:createView(info)
end

function BoardHeroScreenWidget:dispose()
	super.dispose(self)
end

function BoardHeroScreenWidget:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode("asset/ui/BoardHeroScreenTip.csb")

	local touchLayer = self._view:getChildByFullName("touchLayer")

	touchLayer:setTouchEnabled(true)
	touchLayer:addClickEventListener(function()
		self:onTouchCloseView()
	end)

	self._main = self._view:getChildByFullName("main")
	self._btnClone = self._view:getChildByFullName("btnPanel")

	self._btnClone:setVisible(false)

	self._partyBtnClone = self._view:getChildByFullName("partyBtnPanel")

	self._partyBtnClone:setVisible(false)

	self._btnCache = {}

	local PosY = {
		380,
		310
	}

	for i = 1, 2 do
		for j = 1, 8 do
			local info = self._screenList[i][j]

			if info then
				local posX = 133 + 90 * (j - 1)
				local posY = PosY[i]

				if j > 4 then
					posY = posY - 53
					posX = 133 + 90 * (j - 5)
				end

				local button = self:createButtonNode("button", info)

				button:addTo(self._main):posite(posX, posY)

				button.index = i
				button.subIndex = j
				self._btnCache[#self._btnCache + 1] = button
			end
		end
	end

	local infoList = self._screenList[3]

	for i, info in pairs(infoList) do
		local button = self:createButtonNode("party", info)

		button:addTo(self._main):posite(113 + (i - 1) * 65, 180)

		button.index = 3
		button.subIndex = i
		self._btnCache[#self._btnCache + 1] = button
	end
end

function BoardHeroScreenWidget:createButtonNode(uiType, info)
	local button

	if uiType == "button" then
		button = self._btnClone:clone()

		button:getChildByFullName("namelabel"):setString(info)

		local selectimg = button:getChildByFullName("selectimg")

		selectimg:loadTexture("kazu_btn_fenlei_1.png", 1)

		selectimg.selectStatus = false
	elseif uiType == "party" then
		button = self._partyBtnClone:clone()

		button:getChildByFullName("Image"):loadTexture(IconFactory:getPartyPath(info, "building"))

		local selectimg = button:getChildByFullName("selectimg")

		selectimg:setVisible(false)

		selectimg.selectStatus = false
	end

	button:setVisible(true)

	local selectimg = button:getChildByFullName("selectimg")

	button:addClickEventListener(function()
		self:onClickScreenButton(button, selectimg)
	end)

	return button
end

function BoardHeroScreenWidget:refreshView(screenType)
	screenType = screenType or self._select

	if screenType then
		for i, button in ipairs(self._btnCache) do
			local selectimg = button:getChildByFullName("selectimg")

			selectimg.selectStatus = screenType[button.index] and screenType[button.index] == button.subIndex

			if button.index < 3 then
				local image = selectimg.selectStatus and "kazu_btn_fenlei_2.png" or "kazu_btn_fenlei_1.png"

				selectimg:loadTexture(image, 1)
			else
				selectimg:setVisible(selectimg.selectStatus)
			end
		end
	end
end

function BoardHeroScreenWidget:onClickScreenButton(button, selectimg)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

	selectimg.selectStatus = not selectimg.selectStatus

	if selectimg.selectStatus then
		self._select[button.index] = button.subIndex or nil
	end

	self:refreshView()

	if self._info and self._info.callBack then
		self._info.callBack({
			screenType = self:getSelects()
		})
	end
end

function BoardHeroScreenWidget:getSelects()
	local selects = {}

	for i, v in ipairs(self._btnCache) do
		if v:getChildByFullName("selectimg").selectStatus then
			selects[v.index] = v.subIndex
		end
	end

	return selects
end

function BoardHeroScreenWidget:onTouchCloseView()
	AudioEngine:getInstance():playEffect("Se_Click_Fold_2", false)
	self:getView():setVisible(false)
end
