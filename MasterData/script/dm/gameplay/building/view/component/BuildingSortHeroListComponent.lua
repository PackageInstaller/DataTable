-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingSortHeroListComponent.lua

BuildingSortHeroListComponent = class("BuildingSortHeroListComponent", DisposableObject, _M)

BuildingSortHeroListComponent:has("_view", {
	is = "r"
})
BuildingSortHeroListComponent:has("_info", {
	is = "r"
})
BuildingSortHeroListComponent:has("_mediator", {
	is = "r"
})

local SortHeroListComponentPath = "asset/ui/BuildingSortTip.csb"
local PosY = {
	179,
	104,
	60
}

function BuildingSortHeroListComponent:initialize(info)
	super.initialize(self)

	self._info = info
	self._mediator = info.mediator
	self._sortType = self._info.sortType
	self._buildingSystem = self._mediator:getInjector():getInstance(BuildingSystem)
	self._sortNum = self._buildingSystem:getSortNum()
	self._sortExtendNum = self._buildingSystem:getSortExtendNum()
	self._isHide = info.isHide

	self:createView(info)
end

function BuildingSortHeroListComponent:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode(SortHeroListComponentPath)

	local touchLayer = self._view:getChildByFullName("touchLayer")

	touchLayer:setTouchEnabled(true)
	touchLayer:addClickEventListener(function()
		self:onTouchCloseView()
	end)
	self._view:setVisible(false)

	self._mainPanel = self._view:getChildByFullName("mainpanel")
	self._extandPanel = self._view:getChildByFullName("extandPanel")

	self._extandPanel:setVisible(false)
	self:initShowHideBtn()

	self._btnClone = self._view:getChildByFullName("nodepanel")

	self._btnClone:setVisible(false)

	self._extandBtnClone = self._view:getChildByFullName("extandBtnPanel")

	self._extandBtnClone:setVisible(false)

	self._extandPartyBtnPanel = self._view:getChildByFullName("extandPartyBtnPanel")

	self._extandPartyBtnPanel:setVisible(false)

	self._btnCache = {}
	self._btnCache1 = {}
	self._btnCache2 = {}

	for i = 1, self._sortNum do
		local newBtn = self._btnClone:clone()

		newBtn:setVisible(true)

		self._btnCache[#self._btnCache + 1] = newBtn

		newBtn:setPosition(cc.p(136.5, 11 + 51 * (self._sortNum - i)))
		self._mainPanel:addChild(newBtn, 1)

		local nameStr = self._buildingSystem:getSortTypeStr(i)

		newBtn:getChildByFullName("namelabel"):setString(tostring(nameStr))

		local image = i == self._sortType and "common_btn_s01.png" or "common_btn_s02.png"

		newBtn:getChildByFullName("selectimg"):loadTexture(image, 1)
		newBtn:addClickEventListener(function()
			self:onClickSortIcon(i)
		end)
	end

	self._extandPanel:getChildByFullName("text1"):setVisible(false)
	self._extandPanel:getChildByFullName("text2"):setVisible(false)
	self._extandPanel:getChildByFullName("text3"):setVisible(false)

	for i = 1, self._sortExtendNum do
		self._extandPanel:getChildByFullName("text" .. i):setVisible(true)
		self._extandPanel:getChildByFullName("text" .. i):setString(self._buildingSystem:getSortExtandStr(i))

		local length = self._buildingSystem:getSortExtendMaxNum()
		local extendParams = self._buildingSystem:getSortExtandParam(i)

		for j = 1, length do
			local extendinfo = extendParams[j]

			if extendinfo then
				if i ~= 2 then
					local newBtn1 = self._extandBtnClone:clone()

					newBtn1:setVisible(true)

					self._btnCache1[#self._btnCache1 + 1] = newBtn1

					local posX = 303 + 80 * (j - 1)
					local posY = PosY[i]

					if j > 7 then
						posY = posY - 43
						posX = 303 + 80 * (j - 8)
					end

					newBtn1:setPosition(cc.p(posX, posY))
					self._extandPanel:addChild(newBtn1, 1)
					newBtn1:getChildByFullName("namelabel"):setString(extendinfo)

					local selectimg = newBtn1:getChildByFullName("selectimg")

					selectimg:loadTexture("kazu_btn_fenlei_1.png", 1)

					selectimg.selectStatus = false

					newBtn1:addClickEventListener(function()
						self:onClickSortExtand(i, j, selectimg)
					end)
				else
					local newBtn1 = self._extandPartyBtnPanel:clone()

					newBtn1:setVisible(true)

					self._btnCache2[#self._btnCache2 + 1] = newBtn1

					local posX = 303 + 52 * (j - 1)
					local posY = PosY[i]

					newBtn1:setPosition(cc.p(posX, posY))
					self._extandPanel:addChild(newBtn1, 1)
					newBtn1:getChildByFullName("Image"):loadTexture(IconFactory:getPartyPath(extendinfo, "building"))

					local selectimg = newBtn1:getChildByFullName("selectimg")

					selectimg:setVisible(false)

					selectimg.selectStatus = false

					newBtn1:addClickEventListener(function()
						self:onClickSortExtand1(i, extendinfo, selectimg)
					end)
				end
			end
		end
	end

	self:initShowHideBtn()
end

function BuildingSortHeroListComponent:initShowHideBtn()
	self._showBtn = self._mainPanel:getChildByFullName("showExtand")

	self._showBtn:setVisible(self._isHide)
	self._showBtn:setTouchEnabled(true)
	self._showBtn:addClickEventListener(function()
		self:onClickExtand(true)
	end)

	local hideBtn = self._extandPanel:getChildByFullName("hideExtand")

	hideBtn:setTouchEnabled(true)
	hideBtn:addClickEventListener(function()
		self:onClickExtand(false)
	end)
end

function BuildingSortHeroListComponent:refreshView()
	for i = 1, #self._btnCache do
		local newBtn = self._btnCache[i]
		local nameStr = self._buildingSystem:getSortTypeStr(i)

		newBtn:getChildByFullName("namelabel"):setString(tostring(nameStr))

		local image = i == self._sortType and "common_btn_s01.png" or "common_btn_s02.png"

		newBtn:getChildByFullName("selectimg"):loadTexture(image, 1)
	end

	for i = 1, #self._btnCache1 do
		local newBtn = self._btnCache1[i]
		local selectimg = newBtn:getChildByFullName("selectimg")

		selectimg:loadTexture("kazu_btn_fenlei_1.png", 1)

		selectimg.selectStatus = false
	end

	for i = 1, #self._btnCache2 do
		local newBtn = self._btnCache2[i]
		local selectimg = newBtn:getChildByFullName("selectimg")

		selectimg.selectStatus = false

		selectimg:setVisible(false)
	end

	self._extandPanel:setVisible(false)
	self._showBtn:setVisible(self._isHide)
end

function BuildingSortHeroListComponent:getRootNode()
	return self._view
end

function BuildingSortHeroListComponent:dispose()
	super.dispose(self)
end

function BuildingSortHeroListComponent:onClickSortIcon(i)
	if self._sortType == i then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Tab_4", false)

	if self._info and self._info.callBack then
		self._info.callBack({
			sortType = i
		})
	end

	self._sortType = i

	self._view:setVisible(not self._isHide)

	if not self._isHide then
		self:refreshView()
	end
end

function BuildingSortHeroListComponent:onClickSortExtand(sortType, sortExtangType, selectimg)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)
	self._buildingSystem:setSortExtand(sortType, sortExtangType)

	selectimg.selectStatus = not selectimg.selectStatus

	local image = selectimg.selectStatus and "kazu_btn_fenlei_2.png" or "kazu_btn_fenlei_1.png"

	selectimg:loadTexture(image, 1)
	self._mediator:dispatch(Event:new(EVT_TEAM_REFRESH_PETS, {}))
end

function BuildingSortHeroListComponent:onClickSortExtand1(sortType, sortExtangType, selectimg)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)
	self._buildingSystem:setSortExtand(sortType, sortExtangType)

	selectimg.selectStatus = not selectimg.selectStatus

	if selectimg.selectStatus then
		selectimg:setVisible(true)
	else
		selectimg:setVisible(false)
	end

	self._mediator:dispatch(Event:new(EVT_TEAM_REFRESH_PETS, {}))
end

function BuildingSortHeroListComponent:onClickExtand(isShow)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._extandPanel:setVisible(isShow)
	self._showBtn:setVisible(not isShow)
end

function BuildingSortHeroListComponent:onTouchCloseView()
	AudioEngine:getInstance():playEffect("Se_Click_Fold_2", false)
	self._showBtn:setVisible(true)
	self:getRootNode():setVisible(false)
end
