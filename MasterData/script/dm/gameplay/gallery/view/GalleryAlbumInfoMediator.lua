-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryAlbumInfoMediator.lua

GalleryAlbumInfoMediator = class("GalleryAlbumInfoMediator", DmAreaViewMediator, _M)

GalleryAlbumInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryAlbumInfoMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	shareBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickShare"
	},
	deleteBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickDelete"
	},
	saveBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSave"
	}
}
local bgFile = "asset/scene/"

function GalleryAlbumInfoMediator:initialize()
	super.initialize(self)
end

function GalleryAlbumInfoMediator:dispose()
	super.dispose(self)
end

function GalleryAlbumInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function GalleryAlbumInfoMediator:refreshBySync()
	local id = self._photoData.id
	local photos = self._gallerySystem:getAlbumPhotosMap()

	self._photoData = photos[id]

	self:initView()
end

function GalleryAlbumInfoMediator:enterWithData(data)
	self:initData(data)

	if not self._isTakePhoto then
		self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_TAKE_PHOTO_SUCC, self, self.refreshBySync)
	end

	self:initWidgetInfo()
	self:initView()
	self:takePhoto()
	self:setupTopInfoWidget()
end

function GalleryAlbumInfoMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._deleteBtn = self:getView():getChildByName("deleteBtn")
	self._saveBtn = self:getView():getChildByName("saveBtn")
	self._photoImg = self._main:getChildByName("photoImg")
	self._photoDate = self._main:getChildByFullName("bottomImg.photoDate")

	self:ignoreSafeArea()
	self:setEffect()
end

function GalleryAlbumInfoMediator:ignoreSafeArea()
	local shareBtn = self:getView():getChildByFullName("shareBtn")
	local deleteBtn = self:getView():getChildByFullName("deleteBtn")
	local saveBtn = self:getView():getChildByFullName("saveBtn")

	AdjustUtils.ignorSafeAreaRectForNode(shareBtn, AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(deleteBtn, AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(saveBtn, AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(self._photoDate, AdjustUtils.kAdjustType.Right)
end

function GalleryAlbumInfoMediator:setEffect()
	self._photoDate:enableOutline(cc.c4b(48, 35, 27, 153), 2)
end

function GalleryAlbumInfoMediator:initData(data)
	self._photoData = data.photoData
	self._isTakePhoto = data.takePhoto or false
end

function GalleryAlbumInfoMediator:initView()
	self._saveBtn:setVisible(not self._photoData.photoTime)
	self._deleteBtn:setVisible(not not self._photoData.photoTime)
	self._main:getChildByFullName("bottomImg"):setVisible(not not self._photoData.photoTime)

	local icon = self._photoData.backGround

	self._photoImg:loadTexture(bgFile .. icon)

	local date = TimeUtil:localDate("*t", self._photoData.photoTime)

	if date.month < 10 then
		if not ("0" .. date.month) then
			local month = date.month

			if date.day < 10 then
				if not ("0" .. date.day) then
					local day = date.day

					if date.min < 10 then
						if not ("0" .. date.min) then
							local min = date.min
							local dateStr = date.year .. "/" .. month .. "/" .. day .. "  " .. date.hour .. ":" .. min

							self._photoDate:setString(dateStr)
							self._photoImg:removeAllChildren()

							local heroes = self._photoData.heroes

							for id, value in pairs(heroes) do
								local img = IconFactory:createRoleIconSpriteNew({
									frameId = "bustframe9",
									id = id
								})

								img:addTo(self._photoImg)
								img:setScale(value.scale)
								img:setAnchorPoint(cc.p(value.anchor[1], value.anchor[2]))
								img:setPosition(cc.p(value.position[1], value.position[2]))
								img:setLocalZOrder(value.order)
							end
						end
					end
				end
			end
		end
	end
end

function GalleryAlbumInfoMediator:onClickBack()
	self:dismiss()
end

function GalleryAlbumInfoMediator:onClickShare()
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:get("Source_General_Unknown")
	}))
end

function GalleryAlbumInfoMediator:onClickDelete()
	local function func()
		local photoIndex = self._photoData.index

		self._gallerySystem:requestGalleryAlbumDelete(photoIndex, function()
			self:dispatch(ShowTipEvent({
				tip = Strings:get("GALLERY_UI24")
			}))
			self:dismiss()
		end)
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			func()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
		content = Strings:get("GALLERY_UI23"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function GalleryAlbumInfoMediator:onClickSave()
	local function func()
		local data = self._photoData

		self._gallerySystem:requestGalleryAlbumSave(data, function()
			self:dispatch(ShowTipEvent({
				tip = Strings:get("GALLERY_UI25")
			}))
		end)
	end

	if #self._gallerySystem:getAlbumPhotos() == self._gallerySystem:getAlbumPhotosLimit() then
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				func()
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("GALLERY_UI22"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	else
		func()
	end
end

function GalleryAlbumInfoMediator:takePhoto()
	if self._isTakePhoto then
		self._saveBtn:setVisible(false)
		self._deleteBtn:setVisible(false)
		self._main:getChildByFullName("bottomImg"):setVisible(false)
		self:getView():getChildByFullName("shareBtn"):setVisible(false)

		return
	end
end

function GalleryAlbumInfoMediator:runStartAnim()
	local maskImage = self:getView():getChildByName("maskImage")

	maskImage:setOpacity(255)

	local fade = cc.FadeOut:create(0.4)

	maskImage:runAction(fade)
end

function GalleryAlbumInfoMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end
