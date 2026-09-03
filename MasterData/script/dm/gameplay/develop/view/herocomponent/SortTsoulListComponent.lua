-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herocomponent/SortTsoulListComponent.lua

SortTsoulListComponent = class("SortTsoulListComponent", DisposableObject, _M)

SortTsoulListComponent:has("_view", {
	is = "r"
})
SortTsoulListComponent:has("_info", {
	is = "r"
})
SortTsoulListComponent:has("_mediator", {
	is = "r"
})

local SortTsoulListComponentPath = "asset/ui/TsoulSortTip.csb"
local PosY = {
	447,
	388,
	330,
	220
}

function SortTsoulListComponent:initialize(info)
	super.initialize(self)

	self._info = info
	self._mediator = info.mediator
	self._sortType = self._info.sortType
	self._developSystem = self._mediator:getInjector():getInstance(DevelopSystem)
	self._stageSystem = self._developSystem:getTSoulSystem()
	self._sortExtendNum = self._stageSystem:getSortExtendNum()

	self:createView(info)
end

function SortTsoulListComponent:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode(SortTsoulListComponentPath)

	local touchLayer = self._view:getChildByFullName("touchLayer")

	touchLayer:setTouchEnabled(true)
	touchLayer:addClickEventListener(function()
		self:onTouchCloseView()
	end)
	self._view:setVisible(false)

	self._mainPanel = self._view:getChildByFullName("mainpanel")

	self._mainPanel:setVisible(false)

	self._extandPanel = self._view:getChildByFullName("extandPanel")

	self._extandPanel:setVisible(true)

	self._btnClone = self._view:getChildByFullName("nodepanel")

	self._btnClone:setVisible(false)

	self._extandBtnClone = self._view:getChildByFullName("extandBtnPanel")

	self._extandBtnClone:setVisible(false)

	self._resetBtn = self._extandPanel:getChildByFullName("resetBtn")
	self._btnCache = {}
	self._btnCache1 = {}

	for i = 1, self._sortExtendNum do
		local length = self._stageSystem:getSortExtendMaxNum()
		local extendParams = self._stageSystem:getSortExtandParam(i)

		for j = 1, length do
			local extendinfo = extendParams[j]

			if extendinfo then
				local newBtn1

				if i <= 2 then
					newBtn1 = self._extandBtnClone:clone()

					newBtn1:setVisible(true)
					newBtn1:getChildByFullName("namelabel"):setString(extendinfo)

					local selectimg = newBtn1:getChildByFullName("selectimg")

					selectimg:loadTexture("kazu_btn_fenlei_1.png", 1)

					selectimg.selectStatus = false
				end

				newBtn1.index = i
				self._btnCache1[#self._btnCache1 + 1] = newBtn1

				local posX = 153 + 80 * (j - 1)
				local posY = PosY[i]

				if j > 5 then
					posY = posY - 43
					posX = 153 + 80 * (j - 6)
				end

				newBtn1:setPosition(cc.p(posX, posY))
				self._extandPanel:addChild(newBtn1, 1)

				local selectimg = newBtn1:getChildByFullName("selectimg")

				newBtn1:addClickEventListener(function()
					self:onClickSortExtend(i, j, selectimg)
				end)
			end
		end
	end

	self._resetBtn:addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)
		self._stageSystem:resetSortExtand()
		self:refreshView()
		self._extandPanel:setVisible(true)
		self._mediator:dispatch(Event:new(EVT_REFRESH_TSOULS, {}))
	end)
end

function SortTsoulListComponent:refreshView()
	for i = 1, #self._btnCache do
		local newBtn = self._btnCache[i]
		local nameStr = self._stageSystem:getSortTypeStr(i)

		newBtn:getChildByFullName("namelabel"):setString(tostring(nameStr))

		local image = i == self._sortType and "common_btn_s01.png" or "common_btn_s02.png"

		newBtn:getChildByFullName("selectimg"):loadTexture(image, 1)
	end

	for i = 1, #self._btnCache1 do
		local newBtn = self._btnCache1[i]
		local selectimg = newBtn:getChildByFullName("selectimg")

		if newBtn.index <= 3 then
			selectimg:loadTexture("kazu_btn_fenlei_1.png", 1)

			selectimg.selectStatus = false
		else
			selectimg.selectStatus = false

			selectimg:setVisible(false)
		end
	end

	self._extandPanel:setVisible(true)
end

function SortTsoulListComponent:getRootNode()
	return self._view
end

function SortTsoulListComponent:dispose()
	super.dispose(self)
end

function SortTsoulListComponent:onClickSortIcon(i)
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

	self._view:setVisible(true)
	self:refreshView()
end

function SortTsoulListComponent:onClickSortExtend(sortType, sortExtangType, selectimg)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)
	self._stageSystem:setSortExtand(sortType, sortExtangType)

	selectimg.selectStatus = not selectimg.selectStatus

	if sortType <= 3 then
		local image = selectimg.selectStatus and "kazu_btn_fenlei_2.png" or "kazu_btn_fenlei_1.png"

		selectimg:loadTexture(image, 1)
	else
		selectimg:setVisible(selectimg.selectStatus)
	end

	self._mediator:dispatch(Event:new(EVT_REFRESH_TSOULS, {}))
end

function SortTsoulListComponent:showExtand()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self:refreshView()
	self._extandPanel:setVisible(true)
	self._mainPanel:setVisible(false)
end

function SortTsoulListComponent:showNormal()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self:refreshView()
	self._extandPanel:setVisible(false)
	self._mainPanel:setVisible(false)
end

function SortTsoulListComponent:onTouchCloseView()
	AudioEngine:getInstance():playEffect("Se_Click_Fold_2", false)
	self:getRootNode():setVisible(false)
end
