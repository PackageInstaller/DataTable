-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/view/MazeTowerPassMediator.lua

MazeTowerPassMediator = class("MazeTowerPassMediator", DmPopupViewMediator, _M)

MazeTowerPassMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MazeTowerPassMediator:has("_mazeTowerSystem", {
	is = "r"
}):injectWith("MazeTowerSystem")

local kBtnHandlers = {
	["main.touchPanel"] = "onTouchMaskLayer"
}

function MazeTowerPassMediator:initialize()
	super.initialize(self)
end

function MazeTowerPassMediator:dispose()
	super.dispose(self)
end

function MazeTowerPassMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeTowerPassMediator:enterWithData(data)
	self._mazeTower = self._mazeTowerSystem:getMazeTower()

	self:initWigetInfo()
end

function MazeTowerPassMediator:initWigetInfo()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._lab1 = self._main:getChildByName("text_1")
	self._lab2 = self._main:getChildByName("text_2")
	self._lab3 = self._main:getChildByName("text_4")
	self._animNode = self._main:getChildByName("animNode")

	self._lab2:setString(Strings:get("Maze_Reward_Desc", {
		Num = self._mazeTower:getTotalPointNum()
	}))

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

function MazeTowerPassMediator:onTouchMaskLayer()
	self:close()
end
