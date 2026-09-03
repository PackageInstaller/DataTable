-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/view/DreamHousePassMediator.lua

DreamHousePassMediator = class("DreamHousePassMediator", DmPopupViewMediator, _M)

DreamHousePassMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")
DreamHousePassMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.nextBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickNext"
	},
	["main.closeBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickClose"
	}
}

function DreamHousePassMediator:initialize()
	super.initialize(self)
end

function DreamHousePassMediator:dispose()
	super.dispose(self)
end

function DreamHousePassMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function DreamHousePassMediator:onRemove()
	super.onRemove(self)
end

function DreamHousePassMediator:enterWithData(data)
	self._mapId = data.mapId
	self._pointId = data.pointId
	self._keyStr = data.keyStr
	self._mapData = self._dreamSystem:getMapById(self._mapId)
	self.pointData = self._mapData:getPointById(self._pointId)

	self:initWidget()
	self:refreshView()
	self:save(self._keyStr)
	self:initAnim()
end

function DreamHousePassMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._anim = self._main:getChildByName("anim")
	self._name = self._main:getChildByName("name")

	self._name:setOpacity(0)

	self._leftBtn = self._main:getChildByName("nextBtn")
	self._rightBtn = self._main:getChildByName("closeBtn")

	self._main:getChildByName("mask"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickClose()
		end
	end)
end

function DreamHousePassMediator:refreshView()
	local mapName = Strings:get(ConfigReader:getDataByNameIdAndKey("DreamHouseMap", self._mapId, "Name"))
	local pointName = Strings:get(ConfigReader:getDataByNameIdAndKey("DreamHousePoint", self._pointId, "Name"))

	self._name:setString(mapName .. "-" .. pointName)
	self._leftBtn:setVisible(false)
	self._rightBtn:setVisible(false)
end

function DreamHousePassMediator:initAnim()
	self._anim:removeAllChildren()

	local anim = cc.MovieClip:create((self.pointData:isPerfectPass() or nil) and "wanmeitongguang_bumengguangwanmeitongguang")

	anim:setPlaySpeed(0.7)
	anim:setPosition(cc.p(0, 0))
	anim:addTo(self._anim):offset(0, 0)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
	end)
	anim:addCallbackAtFrame(17, function(cid, mc)
		local fadeIn = cc.FadeIn:create(0.1)
		local scaleTo1 = cc.ScaleTo:create(0.1, 1.1)
		local spawn = cc.Spawn:create(fadeIn, scaleTo1)
		local scaleTo2 = cc.ScaleTo:create(0.1, 1)
		local action = cc.Sequence:create(spawn, scaleTo2)

		self._name:runAction(action)
	end)
end

function DreamHousePassMediator:onClickNext()
	local nextPointId = Strings:get(ConfigReader:getDataByNameIdAndKey("DreamHousePoint", self._pointId, "NextPoint"))

	if nextPointId and nextPointId ~= "" then
		self:dispatch(Event:new(EVT_POINT_REFRESH_NEXT, {
			mapId = self._mapId,
			pointId = nextPointId
		}))
	end

	self:close()
end

function DreamHousePassMediator:onClickClose()
	self:close()
end

function DreamHousePassMediator:save(pointId)
	if type(pointId) ~= "string" then
		return
	end

	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	customDataSystem:setValue(PrefixType.kGlobal, pointId, true)
end
