-- chunkname: @modules/logic/antique/view/AntiqueView.lua

module("modules.logic.antique.view.AntiqueView", package.seeall)

local AntiqueView = class("AntiqueView", BaseView)

function AntiqueView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagegifticon = gohelper.findChildSingleImage(self.viewGO, "Item/#simage_gifticon")
	self._simagesign = gohelper.findChildSingleImage(self.viewGO, "Item/#simage_sign")
	self._imgsignIcon = gohelper.findChildImage(self.viewGO, "Item/#txt_name/#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "Item/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "Item/#txt_name/#txt_nameen")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._txttitleen = gohelper.findChildText(self.viewGO, "#txt_title/#txt_titleen")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "#txt_title/#btn_Play")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._txttime = gohelper.findChildText(self.viewGO, "#txt_time")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AntiqueView:addEvents()
	self._btnPlay:AddClickListener(self._onClickPlayBtn, self)
end

function AntiqueView:removeEvents()
	self._btnPlay:RemoveClickListener()
end

function AntiqueView:_onClickPlayBtn()
	local config = AntiqueConfig.instance:getAntiqueCo(self._antiqueId)

	StoryController.instance:playStory(config.storyId)
end

function AntiqueView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getAntiqueIcon("antique_fullbg"))
end

function AntiqueView:onOpen()
	self._antiqueId = self.viewParam

	self:_refreshUI()
end

local iconAreaType = {
	{
		x = -80,
		y = -10,
		anchorMin = Vector2(0, 0.5),
		anchorMax = Vector2(0, 0.5)
	},
	{
		x = 80,
		y = -10,
		anchorMin = Vector2(1, 0.5),
		anchorMax = Vector2(1, 0.5)
	},
	{
		x = 0,
		y = 50,
		anchorMin = Vector2(0.5, 1),
		anchorMax = Vector2(0.5, 1)
	},
	{
		x = 0,
		y = -80,
		anchorMin = Vector2(0.5, 0),
		anchorMax = Vector2(0.5, 0)
	}
}

function AntiqueView:_refreshUI()
	local config = AntiqueConfig.instance:getAntiqueCo(self._antiqueId)

	self._txtname.text = config.name
	self._txtnameen.text = config.nameen
	self._txttitle.text = config.title
	self._txttitleen.text = config.titleen
	self._txtdesc.text = config.desc

	local mo = AntiqueModel.instance:getAntique(self._antiqueId)

	if not mo then
		gohelper.setActive(self._btnPlay.gameObject, false)

		self._txttime.text = ""
	else
		gohelper.setActive(self._btnPlay.gameObject, config.storyId and config.storyId > 0)

		local time = TimeUtil.localTime2ServerTimeString(math.floor(mo.getTime / 1000))

		self._txttime.text = "——" .. string.format(luaLang("receive_time"), time)
	end

	self._simagegifticon:LoadImage(ResUrl.getAntiqueIcon(config.gifticon))

	local iconArea = config.iconArea

	if iconArea > 0 then
		local _iconAreaType = iconAreaType[iconArea]

		self._imgsignIcon.transform.anchorMax = _iconAreaType.anchorMax
		self._imgsignIcon.transform.anchorMin = _iconAreaType.anchorMin

		recthelper.setAnchor(self._imgsignIcon.transform, _iconAreaType.x, _iconAreaType.y)
		gohelper.setActive(self._imgsignIcon.gameObject, true)
		gohelper.setActive(self._simagesign.gameObject, false)
		UISpriteSetMgr.instance:setAntiqueSprite(self._imgsignIcon, config.sign, true)
	else
		gohelper.setActive(self._imgsignIcon.gameObject, false)
		gohelper.setActive(self._simagesign.gameObject, true)
		self._simagesign:LoadImage(ResUrl.getSignature(config.sign))
	end

	local effectName = config.effect
	local showEffect = not string.nilorempty(effectName)

	gohelper.setActive(self._goeffect, showEffect)

	if showEffect then
		local effectPath = ResUrl.getAntiqueEffect(effectName)

		self._loader = self._loader or PrefabInstantiate.Create(self._goeffect)

		if self._effectPrefab then
			gohelper.destroy(self._effectPrefab)
			self._loader:dispose()

			self._effectPrefab = nil
		end

		self._loader:startLoad(effectPath, self.onLoadCallBack, self)
	end
end

function AntiqueView:onLoadCallBack()
	self._effectPrefab = self._loader:getInstGO()
end

function AntiqueView:onClose()
	return
end

function AntiqueView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagegifticon:UnLoadImage()
	self._simagesign:UnLoadImage()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return AntiqueView
