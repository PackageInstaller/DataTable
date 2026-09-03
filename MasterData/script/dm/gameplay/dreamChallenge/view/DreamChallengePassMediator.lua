-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/DreamChallengePassMediator.lua

DreamChallengePassMediator = class("DreamChallengePassMediator", DmPopupViewMediator, _M)

DreamChallengePassMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamChallengePassMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")

local kBtnHandlers = {
	["main.touchPanel"] = "onTouchMaskLayer"
}

function DreamChallengePassMediator:initialize()
	super.initialize(self)
end

function DreamChallengePassMediator:dispose()
	super.dispose(self)
end

function DreamChallengePassMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function DreamChallengePassMediator:enterWithData(data)
	self._data = data
	self._mapId = self._data.mapId
	self._pointId = self._data.pointId

	self:initWigetInfo()
end

function DreamChallengePassMediator:initWigetInfo()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._lab1 = self._main:getChildByName("text_1")
	self._lab2 = self._main:getChildByName("text_2")
	self._lab3 = self._main:getChildByName("text_4")
	self._animNode = self._main:getChildByName("animNode")

	local passNode = self._main:getChildByName("passNode")
	local image = ccui.ImageView:create("mjt_z_pass.png", ccui.TextureResType.plistType)

	image:addTo(passNode)
	self._lab1:setString(self._dreamSystem:getMapName(self._mapId))
	self._lab2:setString(self._dreamSystem:getPointName(self._pointId))
	self._lab3:setString(self._dreamSystem:getPointPassDesc(self._pointId))

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(220, 204, 226, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 255, 255, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = 1
	}

	self._lab1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local anim = cc.MovieClip:create("mengjingta_mengjingta")

	anim:addTo(self._animNode, 1)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
	end)
end

function DreamChallengePassMediator:onTouchMaskLayer()
	self:close()
end
