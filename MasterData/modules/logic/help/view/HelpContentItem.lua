-- chunkname: @modules/logic/help/view/HelpContentItem.lua

module("modules.logic.help.view.HelpContentItem", package.seeall)

local HelpContentItem = class("HelpContentItem", LuaCompBase)

function HelpContentItem:ctor(propObj)
	return
end

function HelpContentItem:init(param)
	self._go = param.go
	self._config = param.config
	self._index = param.index
	self._txtObj = gohelper.findChild(self._go, "txtobj")
	self._imgObj = gohelper.findChild(self._go, "imgobj")
	self._gocontentRoot = gohelper.findChild(self._go, "imgobj/#go_content")
	self._btnquit = gohelper.findChildButtonWithAudio(self._imgObj, "#btn_quit")

	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	gohelper.addUIClickAudio(self._btnquit.gameObject, AudioEnum.UI.UI_help_close)
	transformhelper.setLocalPos(self._go.transform, param.pos, 0, 0)

	if not string.nilorempty(self._config.icon) then
		self._conImg = gohelper.findChildSingleImage(self._imgObj, "img")

		self:setImageContent()
	elseif not string.nilorempty(self._config.text) then
		self._conGameObject = gohelper.findChild(self._txtObj, "#scroll_desc/viewport/content/desctxt")

		gohelper.setActive(self._conGameObject, false)

		self._titleTxt = SLFramework.GameObjectHelper.FindChildComponent(self._txtObj, "titletxt", typeof(TMPro.TextMeshProUGUI))
		self._conTexts = {}

		self:setTextContent()
	end
end

function HelpContentItem:updatePos(pos)
	transformhelper.setLocalPos(self._go.transform, pos, 0, 0)
end

function HelpContentItem:_btnquitOnClick()
	ViewMgr.instance:closeView(ViewName.HelpView)
end

function HelpContentItem:setImageContent()
	gohelper.setActive(self._imgObj, true)
	gohelper.setActive(self._txtObj, false)
	self._conImg:LoadImage(ResUrl.getHelpItem(self._config.icon, self._config.isCn == 1))

	if not string.nilorempty(self._config.iconText) then
		local assetPath = string.format("ui/viewres/help/imgcontent/%s.prefab", self._config.iconText)

		self._resLoader = PrefabInstantiate.Create(self._gocontentRoot)

		self._resLoader:startLoad(assetPath, self._onHelpImgLoaded, self)
	end
end

function HelpContentItem:_onHelpImgLoaded()
	self._imgPrefGo = self._resLoader:getInstGO()

	gohelper.setActive(self._imgPrefGo, true)
end

function HelpContentItem:setTextContent()
	gohelper.setActive(self._imgObj, false)
	gohelper.setActive(self._txtObj, true)

	self._titleTxt.text = self._config.title

	local texts = string.split(self._config.text, "\n")

	for i = 1, #texts do
		local conText = self._conTexts[i]

		if not conText then
			local go = gohelper.cloneInPlace(self._conGameObject, "item" .. i)

			conText = go:GetComponent(typeof(TMPro.TextMeshProUGUI))

			table.insert(self._conTexts, conText)
		end

		local text = texts[i]
		local lefttag = luaLang("helpcontentitem_lefttag")

		if GameUtil.utf8sub(text, 1, 1) == lefttag then
			local righttag = luaLang("helpcontentitem_righttag")

			text = string.gsub(text, lefttag, "<line-height=108%%><size=32><color=#323c34><alpha=#FF>" .. lefttag, 1)
			text = string.gsub(text, righttag, righttag .. "</size></color>\n<line-height=100%%><margin=14>", 1)
		else
			text = "<margin=14><alpha=#BF>" .. text
		end

		conText.text = text

		gohelper.setActive(conText.gameObject, true)
	end

	for i = #texts + 1, #self._conTexts do
		gohelper.setActive(self._conTexts[i], false)
	end
end

function HelpContentItem:showQuitBtn(show)
	gohelper.setActive(self._btnquit.gameObject, show)
end

function HelpContentItem:updateItem()
	return
end

function HelpContentItem:addEventListeners()
	return
end

function HelpContentItem:removeEventListeners()
	return
end

function HelpContentItem:onStart()
	return
end

function HelpContentItem:destroy()
	if self._conImg then
		self._conImg:UnLoadImage()

		self._conImg = nil
	end

	if self._resloader then
		self._resloader:dispose()

		self._resloader = nil
	end

	self._btnquit:RemoveClickListener()
end

return HelpContentItem
