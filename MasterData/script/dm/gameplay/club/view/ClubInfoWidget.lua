-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubInfoWidget.lua

ClubInfoWidget = class("ClubInfoWidget", BaseWidget, _M)

ClubInfoWidget:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
ClubInfoWidget:has("_headId", {
	is = "rw"
})
ClubInfoWidget:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubInfoWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function ClubInfoWidget.class:createWidgetNode()
	local resFile = "uiasset/club_New/widget/ClubInfoWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function ClubInfoWidget:initialize(view)
	super.initialize(self, view)

	self._view = view
end

function ClubInfoWidget:dispose()
	self:getEventDispatcher():removeEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
	super.dispose(self)
end

function ClubInfoWidget:initSubviews()
	local winSize = cc.Director:getInstance():getWinSize()

	self._main = self._view:getChildByName("main")
	self._infoPanel = self._main:getChildByFullName("info_panel")
	self._name = self._infoPanel:getChildByFullName("name_text")
	self._level = self._infoPanel:getChildByFullName("level_text")
	self._headRectNode = self._infoPanel:getChildByFullName("head_icon")
	self._expBar = self._infoPanel:getChildByFullName("progressBg.exBar")
end

function ClubInfoWidget:setName(name)
	if self._name then
		self._name:setString(name or "")
	end
end

function ClubInfoWidget:setLevel(level)
	self._level:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. level)
end

function ClubInfoWidget:setHeadId(headId)
	if self._headRectNode then
		local rectNode = self._headRectNode

		rectNode:removeAllChildren(true)

		local headIcon = IconFactory:createClubIcon({
			id = headId
		}, {
			isWidget = true
		})

		headIcon:addTo(rectNode):center(rectNode:getContentSize())
		IconFactory:bindClickAction(headIcon, function()
			return self:onClickHead()
		end)
	end
end

function ClubInfoWidget:setExpProgress(pointData)
	local percent = 0

	if pointData then
		percent = pointData:getExp() / pointData:getUpgradeExp() * 100
	end

	if percent > 100 then
		percent = 100
	end

	self._expBar:setPercent(percent)
end

function ClubInfoWidget:setupView()
	self:updateView()
	self:getEventDispatcher():addEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
end

function ClubInfoWidget:updateView()
	self._clubInfo = self._clubSystem:getClubInfoOj()

	local technologys = self._clubSystem:getTechnologyListOj()
	local technologyList = technologys:getList()
	local pointData = technologyList[1]:getPointById("Club_Contribute_1")

	self:setName(self._clubInfo:getName())
	self:setLevel(pointData:getLevel())
	self:setHeadId(self._clubInfo:getIcon())
	self:setExpProgress(pointData)
end

function ClubInfoWidget:onClickHead(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
	self._clubSystem:showClubInfoView("", true)
end
