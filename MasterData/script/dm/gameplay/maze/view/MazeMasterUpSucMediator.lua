-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeMasterUpSucMediator.lua

MazeMasterUpSucMediator = class("MazeMasterUpSucMediator", DmPopupViewMediator, _M)

MazeMasterUpSucMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	upSuc = "onTouchPanel"
}
local kFirstCellPos = cc.p(0, -10)

function MazeMasterUpSucMediator:initialize()
	super.initialize(self)
end

function MazeMasterUpSucMediator:dispose()
	super.dispose(self)
end

function MazeMasterUpSucMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeMasterUpSucMediator:dispose()
	super.dispose(self)
end

function MazeMasterUpSucMediator:enterWithData(data)
	self._data = data
	self._olddata = self._data.olddata
	self._newdata = self._data.newdata
	self._difdata = self._data.difdata
	self._heroid = self._data.masterid
	self._heroname = self._data.heroname

	self:initData()
	self:initViews()
end

function MazeMasterUpSucMediator:initData()
	self._oldInfo = {
		self._olddata.atk,
		self._olddata.def,
		self._olddata.hp,
		self._mazeSystem._masterOldLv
	}
	self._newInfo = {
		self._newdata.atk,
		self._newdata.def,
		self._newdata.hp,
		self._mazeSystem._masterNewLv
	}
end

function MazeMasterUpSucMediator:initViews()
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

function MazeMasterUpSucMediator:onTouchPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local mlv = self._mazeSystem:getSelectMasterLv()

		self._allBuffData = self._mazeSystem._mazeChapter:getTeamBuff()
		self._curBuffData = self._allBuffData[tostring(mlv)]

		if self._curBuffData then
			local view = self:getInjector():getInstance("MazeMasterBuffView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil))
		end

		self:close()
	end
end
