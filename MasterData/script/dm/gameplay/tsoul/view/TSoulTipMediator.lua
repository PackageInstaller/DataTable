-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulTipMediator.lua

TSoulTipMediator = class("TSoulTipMediator", DmPopupViewMediator, _M)

TSoulTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function TSoulTipMediator:initialize()
	super.initialize(self)
end

function TSoulTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function TSoulTipMediator:onRemove()
	super.onRemove(self)
end

function TSoulTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOW_ITEMTIP, self, self.onShowContent)

	self._main = self:getView():getChildByName("main")
end

function TSoulTipMediator:enterWithData(data)
	return
end

function TSoulTipMediator:onShowContent(event)
	local data = event:getData()

	self:setUi(data)
	self:adjustPos(data.icon, data.style and data.style.direction)
end

local Tsoul_LevelMax = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_LevelMax", "content")

function TSoulTipMediator:setUi(data)
	local showData = data.info
	local tsoulId = showData.id
	local tsoulConfig = ConfigReader:getRecordById("Tsoul", tsoulId)
	local titlePanel = self._main:getChildByName("Panel_name")
	local imgIcon = titlePanel:getChildByName("icon")

	imgIcon:removeAllChildren()

	local icon = IconFactory:createTSoulIcon({
		id = tsoulId
	})

	icon:setScale(0.7)
	icon:addTo(imgIcon):center(imgIcon:getContentSize())
	titlePanel:getChildByName("Text_name"):setString(Strings:get(tsoulConfig.Name))
	titlePanel:getChildByName("textlv"):setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. Tsoul_LevelMax[tostring(tsoulConfig.Rareity)])

	local t = {
		"nodeAttr",
		"nodeSkill",
		"nodeSuit"
	}

	for i = 1, 3 do
		local node = self._main:getChildByName(t[i])
		local animNode1 = node:getChildByFullName("animNode")

		if not animNode1:getChildByFullName("BgAnim") then
			local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

			anim:addCallbackAtFrame(13, function()
				anim:stop()
			end)
			anim:addTo(animNode1)
			anim:setName("BgAnim")
			anim:offset(0, -3)
		end

		local bgAnim = animNode1:getChildByFullName("BgAnim")

		bgAnim:gotoAndPlay(1)
	end

	local nodeAttr = self._main:getChildByName("nodeAttr")
	local attrNode = nodeAttr:getChildByFullName("Node_1")
	local img = attrNode:getChildByName("image")
	local text = attrNode:getChildByName("text_name")
	local text2 = attrNode:getChildByName("text_value")
	local imgDi = attrNode:getChildByName("Image_70")
	local imgLock = attrNode:getChildByName("Image_lock")

	text2:setVisible(false)
	imgLock:setVisible(false)
	imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KNormal], ccui.TextureResType.plistType)
	img:loadTexture(AttrTypeImage[tsoulConfig.Baseattr], ccui.TextureResType.plistType)
	text:setString(getAttrNameByType(tsoulConfig.Baseattr) .. " :   " .. tsoulConfig.Baseattrnum + tsoulConfig.Levelup * (Tsoul_LevelMax[tostring(tsoulConfig.Rareity)] - 1))

	local nodeAdd = self._main:getChildByName("nodeSkill")
	local listView = nodeAdd:getChildByFullName("listView")

	listView:setScrollBarEnabled(false)
	listView:removeAllChildren()

	local width = listView:getContentSize().width
	local addAttr = tsoulConfig.Addattr
	local attrNames = {}

	for i, v in ipairs(addAttr) do
		attrNames[i] = getAttrNameByType(v)
	end

	local des = Strings:get("TimeSoul_Preview_Desc_2", {
		Addattr = table.concat(attrNames, ","),
		fontName = TTF_FONT_FZYH_M
	})
	local label = ccui.RichText:createWithXML(des, {})

	label:renderContent(width, 0)

	local h = 10
	local localLanguage = getCurrentLanguage()

	if localLanguage == "" or localLanguage == GameLanguageType.CN then
		h = 30
	end

	listView:removeAllChildren()
	label:setAnchorPoint(cc.p(0, 0))
	label:setPosition(cc.p(0, 0))

	local height = label:getContentSize().height
	local newPanel = ccui.Layout:create()

	newPanel:setContentSize(cc.size(width, height + h))
	label:addTo(newPanel)
	listView:pushBackCustomItem(newPanel)

	local nodeSuit = self._main:getChildByName("nodeSuit")
	local listView = nodeSuit:getChildByFullName("listView")

	listView:setScrollBarEnabled(false)

	local width = listView:getContentSize().width
	local suitData = ConfigReader:getRecordById("TsoulSuit", tsoulConfig.Suitid)
	local SuitDesc = suitData.SuitDesc
	local keys = {}

	keys.fontName = TTF_FONT_FZYH_M

	for k, v in pairs(SuitDesc) do
		local attrType = suitData.Suitattr[tonumber(k - 1)] or suitData.Suitlevattr[1]
		local attrNum = suitData.Partattr[tonumber(k - 1)] or suitData.Partlevattr[1]

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			attrNum = attrNum * 100 .. "%"
		end

		keys["Suitattr" .. k] = getAttrNameByType(attrType)
		keys["Partattr" .. k] = attrNum
	end

	local des = Strings:get("TimeSoul_Preview_Desc_3", keys)
	local label = ccui.RichText:createWithXML(des, {})

	label:renderContent(width, 0)

	local h = 10

	if localLanguage == "" or localLanguage == GameLanguageType.CN then
		h = 20
	end

	listView:removeAllChildren()
	label:setAnchorPoint(cc.p(0, 0))
	label:setPosition(cc.p(0, 0))

	local height = label:getContentSize().height
	local newPanel = ccui.Layout:create()

	newPanel:setContentSize(cc.size(width, height + h))
	label:addTo(newPanel)
	listView:pushBackCustomItem(newPanel)
end

function TSoulTipMediator:adjustPos(icon, direction)
	local view = self:getView()

	view:setAnchorPoint(cc.p(0.5, 0.5))
	view:setIgnoreAnchorPointForPosition(false)

	local kUpMargin, kDownMargin, kLeftMargin, kRightMargin = 0, 0, 0, 0
	local viewSize = view:getContentSize()
	local iconBoundingBox = icon:getBoundingBox()
	local worldPos = icon:getParent():convertToWorldSpace(cc.p(iconBoundingBox.x, iconBoundingBox.y))
	local scene = cc.Director:getInstance():getRunningScene()
	local winSize = scene:getContentSize()

	direction = direction or worldPos.y + iconBoundingBox.height + viewSize.height + kUpMargin <= winSize.height - 30 and ItemTipsDirection.kUp or worldPos.x + iconBoundingBox.width * 0.5 < winSize.width * 0.5 and ItemTipsDirection.kRight or ItemTipsDirection.kLeft

	local iconBox = {
		x = worldPos.x,
		y = worldPos.y,
		width = icon:getContentSize().width * icon:getScale(),
		height = icon:getContentSize().height * icon:getScale()
	}
	local x, y

	if direction == ItemTipsDirection.kUp then
		x = iconBox.x + iconBox.width * 0.5
		y = iconBox.y + iconBox.height + viewSize.height * 0.5 + kUpMargin
	elseif direction == ItemTipsDirection.kDown then
		x = iconBox.x + iconBox.width * 0.5
		y = iconBox.y - viewSize.height * 0.5 - kDownMargin
	elseif direction == ItemTipsDirection.kLeft then
		x = iconBox.x - viewSize.width * 0.5 - kLeftMargin
		y = iconBox.y + iconBox.height - viewSize.height * 0.5
	elseif direction == ItemTipsDirection.kRight then
		x = iconBox.x + iconBox.width + viewSize.width * 0.5 + kRightMargin
		y = iconBox.y + iconBox.height - viewSize.height * 0.5
	end

	local nodePos = view:getParent():convertToWorldSpace(cc.p(0, 0))
	local kLeftMinMargin, kRightMinMargin, kUpMinMargin, kDownMinMargin = 0, 0, 0, 0

	if kLeftMinMargin >= x - viewSize.width * 0.5 then
		x = kLeftMinMargin + viewSize.width * 0.5
	elseif x + viewSize.width * 0.5 >= winSize.width - kRightMinMargin then
		x = winSize.width - kRightMinMargin - viewSize.width * 0.5
	end

	if kDownMinMargin > y - viewSize.height * 0.5 then
		y = kDownMinMargin + viewSize.height * 0.5
	elseif y + viewSize.height * 0.5 > winSize.height - kUpMinMargin then
		y = winSize.height - kUpMinMargin - viewSize.height * 0.5
	end

	view:setPosition(cc.p(x - nodePos.x, y - nodePos.y))
end
