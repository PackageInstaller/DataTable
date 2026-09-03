-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/HeroTSoulInfoView.lua

HeroTSoulInfoView = class("HeroTSoulInfoView", DisposableObject, _M)

HeroTSoulInfoView:has("_view", {
	is = "r"
})
HeroTSoulInfoView:has("_info", {
	is = "r"
})
HeroTSoulInfoView:has("_mediator", {
	is = "r"
})

local componentPath = "asset/ui/TSoulTip.csb"

function HeroTSoulInfoView:initialize(info)
	self._info = info
	self._mediator = info.mediator
	self._developSystem = self._mediator:getInjector():getInstance("DevelopSystem")
	self._tSoulSystem = self._developSystem:getTSoulSystem()

	self:createView(info)
	super.initialize(self)

	self._main = self._view:getChildByFullName("main")
end

function HeroTSoulInfoView:dispose()
	super.dispose(self)
end

function HeroTSoulInfoView:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode(componentPath)
end

function HeroTSoulInfoView:refreshTSoulInfo(data)
	self._heroId = data.heroId
	self._index = data.index
	self._tSoulData = self._tSoulSystem:getTSoulById(data.chooseId)

	local panelTitle = self._main:getChildByFullName("Panel_name")
	local panelAttr = self._main:getChildByFullName("nodeAttr")
	local panelSuit = self._main:getChildByFullName("nodeSkill")
	local panelBtn = self._main:getChildByFullName("Panel_button")

	panelTitle:getChildByFullName("Text_name"):setString(Strings:get(self._tSoulData:getName()))
	panelTitle:getChildByFullName("textlv"):setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. Strings:get(self._tSoulData:getLevel()))

	local imgIcon = panelTitle:getChildByFullName("icon")

	imgIcon:removeAllChildren()

	local icon = IconFactory:createTSoulIcon({
		id = self._tSoulData:getConfigId()
	})

	icon:setScale(0.7)
	icon:addTo(imgIcon):center(imgIcon:getContentSize())

	local animNode1 = panelAttr:getChildByFullName("animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -3)
	end

	self._bgAnim1 = animNode1:getChildByFullName("BgAnim")

	self._bgAnim1:gotoAndPlay(1)

	local totalNum = self._tSoulData:getMaxAttrNum() + 1
	local attrs = getTSoulAttNumber(self._tSoulData:getAllAttr())
	local nodeBase = self._view:getChildByFullName("cloneCell")
	local listView = panelAttr:getChildByFullName("listView")

	listView:setScrollBarEnabled(false)
	listView:removeAllChildren()

	local width = listView:getContentSize().width

	for i = 1, #attrs do
		local node = nodeBase:clone()
		local img = node:getChildByName("image")
		local text = node:getChildByName("text_name")
		local text2 = node:getChildByName("text_value")
		local imgDi = node:getChildByName("Image_70")
		local imgLock = node:getChildByName("Image_lock")

		img:setVisible(false)
		text:setVisible(false)
		text2:setVisible(false)
		imgLock:setVisible(false)

		if attrs[i] then
			imgDi:loadTexture((i == 1 or nil) and (KTSoulAttrBgName[KTSoulAttrBgState.KNormal] or KTSoulAttrBgName[KTSoulAttrBgState.KKong]), ccui.TextureResType.plistType)
			img:setVisible(true)
			text:setVisible(true)
			text2:setVisible(true)
			img:loadTexture(attrs[i].icon, ccui.TextureResType.plistType)
			text:setString(attrs[i].attrName .. " :   " .. attrs[i].num)
			text2:setString("")
		elseif i <= totalNum then
			imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KKong], ccui.TextureResType.plistType)
		else
			imgLock:setVisible(true)
			imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KLock], ccui.TextureResType.plistType)
		end

		listView:pushBackCustomItem(node)
	end

	local listView = panelSuit:getChildByFullName("listView")

	listView:setScrollBarEnabled(false)
	listView:removeAllChildren()

	local width = listView:getContentSize().width
	local suitData = self._tSoulData:getSuitData()

	if suitData then
		local animNode1 = panelSuit:getChildByFullName("animNode")

		if not animNode1:getChildByFullName("BgAnim") then
			local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

			anim:addCallbackAtFrame(13, function()
				anim:stop()
			end)
			anim:addTo(animNode1)
			anim:setName("BgAnim")
			anim:offset(0, -3)
		end

		self._bgAnim2 = animNode1:getChildByFullName("BgAnim")

		self._bgAnim2:gotoAndPlay(1)

		local SuitDesc = suitData.SuitDesc
		local index = 1

		for k, v in pairs(SuitDesc) do
			if index < 3 then
				local attrType = suitData.Suitattr[tonumber(k) - 1] or suitData.Suitlevattr[1]
				local attrNum = suitData.Partattr[tonumber(k) - 1] or suitData.Partlevattr[1]

				if AttributeCategory:getAttNameAttend(attrType) ~= "" then
					attrNum = attrNum * 100 .. "%"
				end

				local des = Strings:get(v, {
					Suitattr = getAttrNameByType(attrType),
					Partattr = attrNum,
					fontName = TTF_FONT_FZYH_M
				})
				local label = ccui.RichText:createWithXML(des, {})

				label:renderContent(width, 0)
				label:setAnchorPoint(cc.p(0, 0))
				label:setPosition(cc.p(0, 8))

				local newPanel = ccui.Layout:create()
				local height = label:getContentSize().height + 12

				newPanel:setContentSize(cc.size(width, height))
				label:addTo(newPanel)
				listView:pushBackCustomItem(newPanel)

				local pic = ccui.ImageView:create("timesoul_img_ycdi_3.png", ccui.TextureResType.plistType)

				pic:setScale9Enabled(true)
				pic:setContentSize(cc.size(width, 1.4))
				pic:setAnchorPoint(cc.p(0, 0))
				pic:addTo(newPanel):posite(0, 0)
			else
				local Tsoul_SuitLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_SuitLevel", "content")
				local maxLevel = {}

				for level, id in pairs(Tsoul_SuitLevel) do
					table.insert(maxLevel, level)
				end

				table.sort(maxLevel, function(a, b)
					return tonumber(a) < tonumber(b)
				end)

				for key, level in pairs(maxLevel) do
					local attrName = Tsoul_SuitLevel[level]
					local attrType = suitData.Suitlevattr[1]

					if suitData[attrName] then
						local attrNum = suitData[attrName][1]

						if AttributeCategory:getAttNameAttend(attrType) ~= "" then
							attrNum = attrNum * 100 .. "%"
						end

						local des = Strings:get(v, {
							level = level,
							Suitattr = getAttrNameByType(attrType),
							Partattr = attrNum,
							fontName = TTF_FONT_FZYH_M
						})
						local label = ccui.RichText:createWithXML(des, {})

						label:renderContent(width, 0)
						label:setAnchorPoint(cc.p(0, 0))
						label:setPosition(cc.p(0, 8))

						local height = label:getContentSize().height + 12
						local newPanel = ccui.Layout:create()

						newPanel:setContentSize(cc.size(width, height))
						label:addTo(newPanel)
						listView:pushBackCustomItem(newPanel)
					end
				end
			end

			index = index + 1
		end
	end

	local btn = self._main:getChildByFullName("Panel_button.btn_change")
	local redPoint = btn:getChildByTag(12138)

	if redPoint then
		redPoint:setVisible(false)
	end
end

function HeroTSoulInfoView:setDemountBtnVis(vis)
	self._main:getChildByFullName("Panel_button.btn_demout"):setVisible(vis)
end

function HeroTSoulInfoView:setChangeRedpoint()
	local btn = self._main:getChildByFullName("Panel_button.btn_change")
	local redPoint = btn:getChildByTag(12138)

	if not redPoint then
		redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint:addTo(btn)
		redPoint:setPosition(cc.p(51, 106))
		redPoint:setTag(12138)
		redPoint:setLocalZOrder(999)
	end

	redPoint:setPosition(cc.p(45, 15))
	redPoint:setVisible(true)
end
