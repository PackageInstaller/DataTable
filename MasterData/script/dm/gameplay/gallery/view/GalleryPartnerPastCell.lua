-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryPartnerPastCell.lua

GalleryPartnerPastCell = class("GalleryPartnerPastCell", DmAreaViewMediator, _M)

function GalleryPartnerPastCell:initialize()
	super.initialize(self)
end

function GalleryPartnerPastCell:dispose()
	super.dispose(self)
end

function GalleryPartnerPastCell:setupView(data)
	self:initData(data)
	self:initWidgetInfo()
	self:refreshView()
end

function GalleryPartnerPastCell:getView()
	return self._main
end

function GalleryPartnerPastCell:initData(data)
	self._meditor = data.mediator
	self._main = data.node
	self._heroId = data.id or ""
	self._curIndex = 1
	self._storyArray = data.storyArray
	self._curStoryData = self._storyArray[self._curIndex]
	self._canChange = true
	self._maxIndex = 0
	self._customDataSystem = self._meditor:getInjector():getInstance(CustomDataSystem)

	local customKey = CustomDataKey.kHeroGalleryPast .. self._heroId
	local customValue = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if customValue then
		self._maxIndex = tonumber(customValue)
	end

	self._main:getChildByFullName("left.button"):addClickEventListener(function()
		self:onClickLeft()
	end)
	self._main:getChildByFullName("right.button"):addClickEventListener(function()
		self:onClickRight()
	end)
end

function GalleryPartnerPastCell:initWidgetInfo()
	self._leftBtn = self._main:getChildByFullName("left.leftBtn")
	self._rightBtn = self._main:getChildByFullName("right.rightBtn")
	self._newTip = self._main:getChildByFullName("newTip")

	self._newTip:setVisible(false)

	self._title = self._main:getChildByFullName("title")
	self._page = self._main:getChildByFullName("page")
	self._desc = self._main:getChildByFullName("desc")

	self._desc:setLineSpacing(5)
end

function GalleryPartnerPastCell:refreshData()
	self._curStoryData = self._storyArray[self._curIndex]
end

function GalleryPartnerPastCell:refreshView()
	self:refreshArrowState()
	self._page:setString(self._curIndex .. "/" .. #self._storyArray)

	if not self._curStoryData then
		return
	end

	self._newTip:setVisible(self._curIndex > self._maxIndex)
	self._title:setString(self._curStoryData.title)
	self._desc:setString(self._curStoryData.desc)

	self._maxIndex = math.max(self._maxIndex, self._curIndex)

	local customKey = CustomDataKey.kHeroGalleryPast .. self._heroId

	self._maxIndex = math.max(self._maxIndex, self._curIndex)

	local customValue = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if not customValue or tonumber(customValue) ~= self._maxIndex then
		self._customDataSystem:setValue(PrefixType.kGlobal, customKey, self._maxIndex)
	end
end

function GalleryPartnerPastCell:refreshArrowState()
	self._leftBtn:setVisible(self._curIndex ~= 1 and #self._storyArray > 0)
	self._rightBtn:setVisible(self._curIndex ~= #self._storyArray and #self._storyArray > 0)
end

function GalleryPartnerPastCell:onClickLeft(sender, eventType)
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIndex = self._curIndex - 1

	if self._curIndex <= 1 then
		self._curIndex = 1
	end

	self:refreshData()
	self:refreshView()
end

function GalleryPartnerPastCell:onClickRight(sender, eventType)
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIndex = self._curIndex + 1

	if self._curIndex >= #self._storyArray then
		self._curIndex = #self._storyArray
	end

	local storyData = self._storyArray[self._curIndex]

	if storyData and not storyData.unlock then
		local targetLevel, targetExp = storyData.targetLevel, storyData.targetExp
		local tip = Strings:get("GALLERY_UnlockTips", {
			num = targetLevel
		})

		self._meditor:dispatch(ShowTipEvent({
			tip = (targetExp ~= 0 or nil) and Strings:get("GALLERY_UnlockTips2", {
				num = targetLevel,
				exp = targetExp
			})
		}))

		self._curIndex = self._curIndex - 1

		return
	end

	self:refreshData()
	self:refreshView()
end
