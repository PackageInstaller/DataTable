-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeHeroUpSucMediator.lua

MazeHeroUpSucMediator = class("MazeHeroUpSucMediator", DmPopupViewMediator, _M)

MazeHeroUpSucMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	upSuc = "onTouchPanel"
}
local kFirstCellPos = cc.p(0, -10)

function MazeHeroUpSucMediator:initialize()
	super.initialize(self)
end

function MazeHeroUpSucMediator:dispose()
	super.dispose(self)
end

function MazeHeroUpSucMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeHeroUpSucMediator:dispose()
	super.dispose(self)
end

function MazeHeroUpSucMediator:enterWithData(data)
	self._data = data
	self._olddata = self._data.olddata
	self._newdata = self._data.newdata
	self._heroid = self._data.heroid
	self._heroname = self._data.heroname

	self:initData()
	self:initViews()
end

function MazeHeroUpSucMediator:initData()
	local configold = ConfigReader:getRecordById("PansLabAttr", self._olddata)
	local newlv, newconfigid

	for k, v in pairs(self._newdata) do
		newconfigid = v.attrId
		newlv = v.level
	end

	local confignew = ConfigReader:getRecordById("PansLabAttr", newconfigid)

	self._oldInfo = {
		configold.Attack,
		configold.Defence,
		configold.Hp,
		configold.Level
	}
	self._newInfo = {
		confignew.Attack,
		confignew.Defence,
		confignew.Hp,
		confignew.Level
	}
end

function MazeHeroUpSucMediator:initViews()
	self._main = self:getView()
	self._sucpanel = self._main:getChildByFullName("upSuc")
	self._aninode = self._sucpanel:getChildByFullName("Node_44")

	self._sucpanel:getChildByFullName("lv_1"):setString(self._oldInfo[4])
	self._sucpanel:getChildByFullName("lv_2"):setString(self._newInfo[4])

	for i = 1, 3 do
		local info = self._sucpanel:getChildByFullName("info_" .. i)

		info:getChildByFullName("oldattr"):setString(self._newInfo[i])
		info:getChildByFullName("addattr"):setString("+" .. self._newInfo[i] - self._oldInfo[i])
	end

	self._sucpanel:getChildByFullName("Text_265"):setString(self._heroname)

	local aninnode = self._mazeSystem:createOneMasterAni(self._heroid, false, true)

	aninnode:setGray(false)
	aninnode:setPosition(0, 0)
	self._aninode:addChild(aninnode)
end

function MazeHeroUpSucMediator:onTouchPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
