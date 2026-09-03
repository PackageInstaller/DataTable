-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herocomponent/SortHeroListNewComponent.lua

SortHeroListNewComponent = class("SortHeroListNewComponent", DisposableObject, _M)

SortHeroListNewComponent:has("_view", {
	is = "r"
})
SortHeroListNewComponent:has("_info", {
	is = "r"
})
SortHeroListNewComponent:has("_mediator", {
	is = "r"
})

local SortHeroListComponentPath = "asset/ui/HeroSortTip.csb"

function SortHeroListNewComponent:initialize(info)
	super.initialize(self)

	self._heroShowSortList = {
		Strings:get("HEROS_UI49"),
		Strings:get("HEROS_UI31"),
		Strings:get("heroselect_paixu_xiyoudu"),
		Strings:get("HEROS_UI5")
	}

	local t = {
		"SP",
		"SSR",
		"SR",
		"R"
	}

	self._sortExtend = {}

	table.insert(self._sortExtend, Strings:get("bag_UI1"))

	for i, v in ipairs(t) do
		table.insert(self._sortExtend, v)
	end

	local TargetOccupation = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Team_TypeOrder", "content")

	for i = 1, #TargetOccupation do
		local type = TargetOccupation[i]
		local name = GameStyle:getHeroOccupation(type)

		table.insert(self._sortExtend, name)
	end

	self._info = info
	self._mediator = info.mediator
	self._sortType = self._info.sortType
	self._sortNum = #self._heroShowSortList
	self._sortExtendNum = #self._sortExtend

	self:createView(info)
end

function SortHeroListNewComponent:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode(SortHeroListComponentPath)

	local touchLayer = self._view:getChildByFullName("touchLayer")

	touchLayer:setTouchEnabled(true)
	touchLayer:addClickEventListener(function()
		self:onTouchCloseView()
	end)
	self._view:setVisible(false)

	self._mainPanel = self._view:getChildByFullName("mainpanel")

	self._mainPanel:getChildByFullName("text1"):setString(Strings:get("heroselect_paixu"))
	self._mainPanel:getChildByFullName("text2"):setString(Strings:get("heroselect_shaixuan"))

	self._btnClone = self._view:getChildByFullName("nodepanel")

	self._btnClone:setVisible(false)

	self._extandBtnClone = self._view:getChildByFullName("extandBtnPanel")

	self._extandBtnClone:setVisible(false)

	self._btnCache = {}
	self._btnCache1 = {}

	for i = 1, self._sortNum do
		local newBtn = self._btnClone:clone()

		newBtn:setVisible(true)

		self._btnCache[#self._btnCache + 1] = newBtn

		newBtn:setPosition(cc.p(117 + (i - 1) * 106, 224))
		self._mainPanel:addChild(newBtn, 1)
		newBtn:getChildByFullName("namelabel"):setString(self._heroShowSortList[i])

		local image = i == self._sortType and "common_btn_s01.png" or "common_btn_s02.png"

		newBtn:getChildByFullName("selectimg"):loadTexture(image, 1)
		newBtn:addClickEventListener(function()
			self:onClickSortIcon(i)
		end)
	end

	local count = math.ceil(self._sortExtendNum / 5)

	for i = 1, count do
		for j = 1, 5 do
			local index = (i - 1) * 5 + j

			if index <= self._sortExtendNum then
				local extendinfo = self._sortExtend[index]
				local newBtn1 = self._extandBtnClone:clone()

				newBtn1:setVisible(true)
				newBtn1:getChildByFullName("namelabel"):setString(extendinfo)

				local selectimg = newBtn1:getChildByFullName("selectimg")

				selectimg:loadTexture("kazu_btn_fenlei_1.png", 1)

				selectimg.selectStatus = false
				newBtn1.index = index
				self._btnCache1[#self._btnCache1 + 1] = newBtn1

				local posX = 112 + (j - 1) * 88
				local posY = 143 - (i - 1) * 53

				newBtn1:setPosition(cc.p(posX, posY))
				self._mainPanel:addChild(newBtn1, 1)
				newBtn1:addClickEventListener(function()
					self:onClickSortExtend(index, selectimg)
				end)
			end
		end
	end
end

function SortHeroListNewComponent:refreshView()
	for i = 1, #self._btnCache do
		local newBtn = self._btnCache[i]
		local image = i == self._sortType and "common_btn_s01.png" or "common_btn_s02.png"

		newBtn:getChildByFullName("selectimg"):loadTexture(image, 1)
	end

	for i = 1, #self._btnCache1 do
		local newBtn = self._btnCache1[i]
		local selectimg = newBtn:getChildByFullName("selectimg")
		local image = selectimg.selectStatus and "kazu_btn_fenlei_2.png" or "kazu_btn_fenlei_1.png"

		selectimg:loadTexture(image, 1)
	end
end

function SortHeroListNewComponent:getRootNode()
	return self._view
end

function SortHeroListNewComponent:dispose()
	super.dispose(self)
end

function SortHeroListNewComponent:onClickSortIcon(i)
	if self._sortType == i then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Tab_4", false)

	self._sortType = i

	for i, v in ipairs(self._btnCache1) do
		v.selectStatus = false
	end

	self:refreshView()

	if self._info and self._info.callBack then
		self._info.callBack({
			sortType = i,
			subSortType = self:getSubSelects(),
			sortStr = self._heroShowSortList[self._sortType]
		})
	end
end

function SortHeroListNewComponent:onClickSortExtend(subSortType, selectimg)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

	selectimg.selectStatus = not selectimg.selectStatus

	if subSortType == 1 and selectimg.selectStatus then
		for i = 2, #self._btnCache1 do
			local newBtn = self._btnCache1[i]
			local selectimg = newBtn:getChildByFullName("selectimg")

			selectimg.selectStatus = false
		end
	elseif subSortType > 1 and selectimg.selectStatus then
		local newBtn = self._btnCache1[1]
		local selectimg = newBtn:getChildByFullName("selectimg")

		selectimg.selectStatus = false
	end

	if self._info and self._info.callBack then
		self._info.callBack({
			sortType = self._sortType,
			subSortType = self:getSubSelects(),
			sortStr = self._heroShowSortList[self._sortType]
		})
	end

	self:refreshView()
end

function SortHeroListNewComponent:getSubSelects()
	local subs = {}

	for i, v in ipairs(self._btnCache1) do
		if v:getChildByFullName("selectimg").selectStatus then
			table.insert(subs, v.index)
		end
	end

	table.sort(subs)

	return subs
end

function SortHeroListNewComponent:onTouchCloseView()
	AudioEngine:getInstance():playEffect("Se_Click_Fold_2", false)
	self:getRootNode():setVisible(false)
end
