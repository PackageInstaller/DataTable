-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RoguePropTipsView.lua

module("logic.extensions.roguelike.view.explore.RoguePropTipsView", package.seeall)

local PropItem = class("PropItem")

function PropItem:ctor(go)
	self._go = go.gameObject
end

function PropItem:Awake()
	self:init()
end

function PropItem:init()
	local go = self._go

	self._goSelect = goutil.findChild(go, "select")
	self._goSign = goutil.findChild(go, "sign")
	self._txtName = goutil.findChildComponent(go, "txtName", UIComponentType.Text)
	self._txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.Text)
	self._imgQuality = goutil.findChildImageComponent(go, "propItem/backpack_item/imgQuality")
	self._imgQuality2 = goutil.findChildImageComponent(go, "propQuality")
	self._imgIcon = goutil.findChildImageComponent(go, "propItem/backpack_item/imgIcon")
	self._btnClick = UIComponentType.ButtonAdapter(go)

	self._btnClick:AddClickListener(self.onClick, self)
end

function PropItem:onClick()
	if self._callback then
		self._callback(self._propId)
	end
end

function PropItem:updateData(data)
	local propId = data.propId

	if propId == nil then
		goutil.setActive(self._go, false)

		return
	end

	self._propId = propId

	local propCo = RoguelikeConfig.instance:getPropById(propId)

	self._callback = data.callback
	self._txtName.text = propCo.name

	local linkText = propCo.link ~= "" and "\n\n" .. propCo.link or ""

	self._txtContent.text = StringUtil.replaceAllGraphicText2(propCo.descirption .. linkText)

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, propCo.art)
	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(propCo.rarity + 1))
	IconLoader.setSprite(self._imgQuality2, IconType.DynSpriteAtlas_Dice, GameUrl.getRoguePropItemQualityUrl(propCo.rarity + 1))

	local isSign = false
	local effectIds = propCo.effectIds

	for k, v in pairs(effectIds or {}) do
		if v == 10000000 then
			isSign = true
		end
	end

	goutil.setActive(self._goSign, isSign)
	self:setSelect(false)
	goutil.setActive(self._go, true)
end

function PropItem:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function PropItem:OnDestroy()
	self._txtName = nil
	self._txtContent = nil
	self._callback = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

local M = class("RoguePropTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._goProp = self:getGo("props_select_view_701021865")
	self._goRoles = self:getGo("props_select_view_-363431592")
	self._btnClose = self:getBtn("0&empty_mask_tips_29887572")
	self._goTitle = self:getGo("props_select_view_copy_1709762514")

	goutil.setActive(self._goTitle, false)
	self:initPropItems()
end

function M:initPropItems()
	self._propItems = {}

	for i = 1, 3 do
		local itemGo = goutil.findChild(self._goProp, "prop_" .. i)
		local propItem = Astral.LuaComponentContainer.Add(itemGo, PropItem)

		table.insert(self._propItems, propItem)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
end

function M:checkClose()
	self:close()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local params = self:getFirstParam()

	self:showPropTips({
		params
	})
end

function M:onExit()
	return
end

function M:showPropTips(propIds)
	goutil.setActive(self._goProp, true)
	goutil.setActive(self._goRoles, false)

	local count = 0
	local curPropId = 0

	for index, item in ipairs(self._propItems) do
		local data = {}

		data.propId = propIds[index]

		function data.callback(pid)
			self._selectPropId = pid

			self:close()
		end

		item:updateData(data)

		if data.propId ~= nil then
			count = count + 1
			curPropId = data.propId
		end
	end
end

return M
