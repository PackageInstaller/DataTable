-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/club/ClubBuildingMediator.lua

ClubBuildingMediator = class("ClubBuildingMediator", BuildingMediator)

ClubBuildingMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
ClubBuildingMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

function ClubBuildingMediator:initialize()
	super.initialize(self)
end

function ClubBuildingMediator:dispose()
	super.dispose(self)
end

function ClubBuildingMediator:enterWithData(enterData)
	super.enterWithData(self, enterData)

	self._userInfo = enterData.userInfo

	if self._mainComponent then
		self._mainComponent:refreshClubInfo(self._userInfo)
	end
end

function ClubBuildingMediator:setupView()
	super.setupView(self)
end

function ClubBuildingMediator:addTouchComponent()
	local touchComponent = cc.Layer:create():addTo(self._panel_base, 1):center(self._panel_base:getContentSize())

	self._touchComponent = self:getInjector():instantiate("ClubBuildingTouchComponent", {
		view = touchComponent
	})

	self._touchComponent:setBuildingMediator(self)
	self._touchComponent:enterWithData()
end

function ClubBuildingMediator:addMainComponent()
	local buildingMain = self:getInjector():getInstance("BuildingMain")

	self._mainComponent = self:getInjector():instantiate("ClubBuildingMainComponent", {
		view = buildingMain
	})

	buildingMain:addTo(self._panel_base, 3):center(self._panel_base:getContentSize())
	self._mainComponent:setBuildingMediator(self)
	self._mainComponent:setupTopInfoWidget()
	self._mainComponent:enterWithData()

	self._mainComponentView = self._mainComponent:getView()
end

function ClubBuildingMediator:addShare()
	super.addShare(self)
	DmGame:getInstance()._injector:getInstance(ShareSystem):setShareVisible({
		status = false,
		enterType = ShareEnterType.KBuilding,
		node = self:getView()
	})
end

function ClubBuildingMediator:enterShowAll()
	super.enterShowAll(self)
	DmGame:getInstance()._injector:getInstance(ShareSystem):setShareVisible({
		status = false,
		enterType = ShareEnterType.KBuilding,
		node = self:getView()
	})
end
