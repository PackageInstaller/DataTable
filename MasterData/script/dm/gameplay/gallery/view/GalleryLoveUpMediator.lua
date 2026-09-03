-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryLoveUpMediator.lua

GalleryLoveUpMediator = class("GalleryLoveUpMediator", DmPopupViewMediator, _M)

GalleryLoveUpMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {}

function GalleryLoveUpMediator:initialize()
	super.initialize(self)
end

function GalleryLoveUpMediator:dispose()
	super.dispose(self)
end

function GalleryLoveUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._animPanel = self:getView():getChildByName("animPanel")
	self._main = self:getView():getChildByName("main")

	self._main:setVisible(true)

	self._soundPanel = self:getView():getChildByName("soundPanel")

	self._soundPanel:setVisible(false)

	local text = self._main:getChildByFullName("text")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		text:setContentSize(cc.size(80, 60))
	end
end

function GalleryLoveUpMediator:enterWithData(data)
	local titleData = data.title
	local descData = data.desc
	local attrData = data.attr

	self._sounds = data.sounds
	self._model = data.model
	self._callback = data.callback

	AudioEngine:getInstance():playEffect("Se_Alert_Pop", false)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(self._animPanel)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("GALLERY_UI47"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Xinxidengru"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	self._main:setOpacity(0)
	anim:addCallbackAtFrame(14, function()
		self._main:fadeIn({
			time = 0.2
		})
	end)

	local title = self._main:getChildByFullName("text_2")

	title:setString(titleData)

	local desc = self._main:getChildByFullName("text_3")

	desc:setString(descData)
	GameStyle:setCommonOutlineEffect(title)
	GameStyle:setCommonOutlineEffect(desc)

	local attributePanel = self._main:getChildByFullName("attributePanel")
	local node1 = attributePanel:getChildByFullName("node_1")
	local node2 = attributePanel:getChildByFullName("node_2")

	node1:setVisible(false)
	node2:setVisible(false)

	local nodeArr = {
		node1,
		node2
	}

	for i = 1, #attrData do
		local node = nodeArr[i]

		if node then
			node:setVisible(true)
			node:getChildByFullName("Text_value"):setString(attrData[i].value)
			node:getChildByFullName("Text_add"):setString("+" .. attrData[i].addValue)
			node:getChildByFullName("Image_di.Image_attr"):loadTexture(AttrTypeImage[attrData[i].type], 1)
		end
	end

	if #attrData < 2 then
		nodeArr[1]:setPositionY(-1)
	end
end

function GalleryLoveUpMediator:initSoundView(sound)
	AudioEngine:getInstance():playEffect("Se_Alert_Pop", false)

	local roleNode = self._soundPanel:getChildByFullName("roleNode")

	if not roleNode:getChildByFullName("HeroIcon") then
		local heroInfo = {
			clipType = 3,
			id = self._model
		}
		local icon = IconFactory:createRoleIconSpriteNew(heroInfo)

		icon:setScale(0.6)

		icon = IconFactory:addStencilForIcon(icon, 2, cc.size(99, 99))

		icon:addTo(roleNode)
		icon:setName("HeroIcon")
	end

	self._animPanel:removeAllChildren()
	self._main:setVisible(false)
	self._soundPanel:setVisible(true)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(self._animPanel)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("GALLERY_UI58"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Xinyuyinjiesuo"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	self._soundPanel:setOpacity(0)
	anim:addCallbackAtFrame(14, function()
		self._soundPanel:fadeIn({
			time = 0.2
		})
	end)
	self._soundPanel:getChildByFullName("text"):setString(sound:getText())
end

function GalleryLoveUpMediator:onTouchMaskLayer()
	if #self._sounds > 0 then
		AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)

		local sound = table.remove(self._sounds, 1)

		self:initSoundView(sound)
	else
		if self._callback then
			self._callback()
		end

		AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
		self:close()
	end
end
