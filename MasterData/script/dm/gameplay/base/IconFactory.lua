-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/IconFactory.lua

IconFactory = IconFactory or {}
IconFactory.kHeroIconScale = 0.9
IconFactory.kStarScale = 0.38
IconFactory.kStarIntervalXArr = {
	0,
	21,
	22,
	22,
	18,
	16,
	10
}
IconFactory.itemAddTipPath = "btn_jiahao.png"
IconFactory.starImgPath = "common_icon_star.png"
IconFactory.starImgPath3 = "kazu_bg_ka_xingxing.png"
IconFactory.iconsPath = "asset/ui/"
IconFactory.debrisPath = "pic_icon_suipian_weihuode_smsxq.png"
IconFactory.resourceDefaultFile = "icon_jinbi.png"
IconFactory.battleQuaIndexPath = "icon_bg_ka_xiyoudi_new.png"
IconFactory.commonItemBgPath = "asset/itemRect/yizhuang_icon_bai.png"
IconFactory.redPointPath = "btn_hongdian.png"
IconFactory.redPointPath1 = "pic_hongdian_common.png"
IconFactory.kRMBDefaultFile = "sd_rmb_1.png"
IconFactory.MasterEmblemPath = "asset/master/masterRect/masterEmblem/"
IconFactory.kIconPathCfg = {
	"asset/master/",
	"asset/heros/",
	"asset/enemy/"
}
IconFactory.kIconType = {
	"HeadMain",
	"Portrait",
	"Bust1",
	"Bust2",
	"Bust3",
	"Bust4",
	"Bust5",
	"Bust6",
	"Bust7",
	"Bust8",
	"Bust9",
	"Bust10",
	"Bust11",
	"Bust12",
	"Bust13",
	"Bust14",
	"Bust15",
	"Bust16",
	"MasterHeadWide"
}
IconFactory.IconTypeIndex = {
	Bust14 = 16,
	Bust1 = 3,
	Bust4 = 6,
	HeadMain = 1,
	Bust15 = 17,
	Bust10 = 12,
	Bust13 = 15,
	Bust8 = 10,
	Bust6 = 8,
	Portrait = 2,
	Bust11 = 13,
	Bust12 = 14,
	Bust9 = 11,
	Bust7 = 9,
	Bust2 = 4,
	Bust5 = 7,
	Bust16 = 18,
	Bust3 = 5
}
IconFactory.kClikpStencil = {
	{
		path = "asset/stencil/icon_zz.png",
		scale9 = cc.rect(20, 20, 20, 20)
	},
	{
		path = "drawNode"
	},
	{
		path = "asset/stencil/kz_zz.png"
	},
	{
		path = "asset/stencil/fang_zz.png",
		scale9 = cc.rect(20, 20, 20, 20)
	},
	{
		path = "asset/stencil/fj_zz.png",
		scale9 = cc.rect(20, 20, 20, 20)
	},
	{
		path = "asset/stencil/fang1_zz.png",
		scale9 = cc.rect(20, 20, 20, 20)
	},
	{
		path = "asset/stencil/yh_jp.png",
		scale9 = cc.rect(20, 20, 20, 20)
	},
	{
		path = "asset/stencil/yh_jp1.png",
		scale9 = cc.rect(20, 20, 20, 20)
	},
	{
		path = "asset/stencil/yinghun_rwbj.png"
	},
	{
		path = "asset/stencil/jq_bg_txd_2.png"
	},
	{
		path = "asset/stencil/zc_zz_tx.png"
	},
	{
		path = "asset/stencil/smzb_bg_bzdi_stencil.png"
	},
	{
		path = "asset/stencil/bg_leadstage_kuang_caiqie1.png"
	},
	{
		path = "asset/stencil/bg_leadstage_kuang_caiqie2.png"
	}
}
IconFactory.ScaleRatio = {
	itemScaleRatio = 0.83
}

local kStarHeight = -36
local kerenlPos = {
	{
		0,
		45
	},
	{
		26,
		25
	},
	{
		42,
		0
	},
	{
		25,
		-24
	},
	{
		0,
		-40
	},
	{
		-23,
		-23
	},
	{
		-42,
		0
	},
	{
		-26,
		25
	}
}
local kernelArrowQuality = {
	"zhujue_bg_fxbai_",
	"zhujue_bg_fxlv_",
	"zhujue_bg_fxlan_",
	"zhujue_bg_fxzi_",
	"zhujue_bg_fxcheng_",
	"zhujue_bg_fxhong_"
}

IconTouchHandler = class("IconTouchHandler", objectlua.Object, _M)

function IconTouchHandler:initialize(parentViewMediator, info)
	super.initialize(self)

	self._parentViewMediator = parentViewMediator
	self._info = info
	self._beginPos = {
		x = 0,
		y = 0
	}
end

function IconTouchHandler:removeItemTipView()
	if self._parentViewMediator.zorder then
		self._parentViewMediator:getView():setLocalZOrder(self._parentViewMediator.zorder)
	end

	local itemTipView = self._parentViewMediator:getView():getChildByTag(ItemTipsViewTag)

	if itemTipView ~= nil then
		itemTipView:removeFromParent(true)
	end

	local equipTipView = self._parentViewMediator:getView():getChildByTag(EquipTipsViewTag)

	if equipTipView ~= nil then
		equipTipView:removeFromParent(true)
	end

	local composeToEquipTipView = self._parentViewMediator:getView():getChildByTag(ComposeToEquipTipsViewTag)

	if composeToEquipTipView ~= nil then
		composeToEquipTipView:removeFromParent(true)
	end

	local buffTipView = self._parentViewMediator:getView():getChildByTag(BuffTipsViewTag)

	if buffTipView ~= nil then
		buffTipView:removeFromParent(true)
	end

	local wordTipView = self._parentViewMediator:getView():getChildByTag(SomeWordTipsViewTag)

	if wordTipView ~= nil then
		wordTipView:removeFromParent(true)
	end

	local itemBuffTipView = self._parentViewMediator:getView():getChildByTag(ItemBuffTipsViewTag)

	if itemBuffTipView ~= nil then
		itemBuffTipView:removeFromParent(true)
	end

	local itemBuffTipView = self._parentViewMediator:getView():getChildByTag(ItemShowTipsViewTag)

	if itemBuffTipView ~= nil then
		itemBuffTipView:removeFromParent(true)
	end

	local tSoulTipView = self._parentViewMediator:getView():getChildByTag(TSoulTipsViewTag)

	if tSoulTipView ~= nil then
		tSoulTipView:removeFromParent(true)
	end

	local messageTipView = self._parentViewMediator:getView():getChildByTag(MessageViewTag)

	if messageTipView ~= nil then
		messageTipView:removeFromParent(true)
	end
end

function IconTouchHandler:onBegan(icon)
	local pos = icon:getTouchBeganPosition()

	self._beginPos = {
		x = pos.x,
		y = pos.y
	}

	local info = icon.info

	self:removeItemTipView()

	local mediator = self._parentViewMediator

	self._parentViewMediator.zorder = self._parentViewMediator:getView():getLocalZOrder()

	local itemTipView, tipsViewTag
	local rewardType = info.rewardType
	local id = info.id

	if rewardType == RewardType.kEquip or rewardType == RewardType.kEquipExplore then
		local Position = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", id, "Position")

		if Position == HeroEquipType.kStarItem then
			itemTipView = mediator:getInjector():getInstance("ItemTipsView")
			tipsViewTag = ItemTipsViewTag
		else
			itemTipView = mediator:getInjector():getInstance("EquipTipsView")
			tipsViewTag = EquipTipsViewTag
		end
	elseif rewardType == RewardType.kBuff then
		itemTipView = mediator:getInjector():getInstance("ItemBuffTipsView")
		tipsViewTag = ItemBuffTipsViewTag
	elseif rewardType == RewardType.kShow then
		itemTipView = mediator:getInjector():getInstance("ItemShowTipsView")
		tipsViewTag = ItemShowTipsViewTag
	elseif rewardType == RewardType.kItem then
		if RewardSystem:checkIsComposeItem(info) then
			itemTipView = mediator:getInjector():getInstance("ComposeToEquipTipsView")
			info.parentMediatorSize = mediator:getView():getContentSize()
			tipsViewTag = ComposeToEquipTipsViewTag
		else
			itemTipView = mediator:getInjector():getInstance("ItemTipsView")
			tipsViewTag = ItemTipsViewTag
		end
	elseif rewardType == RewardType.kTSoul then
		itemTipView = mediator:getInjector():getInstance("TSoulTipView")
		tipsViewTag = TSoulTipsViewTag
	elseif rewardType == RewardType.kMessage then
		itemTipView = mediator:getInjector():getInstance("GalleryMessageTipView")
		tipsViewTag = MessageViewTag
	else
		itemTipView = mediator:getInjector():getInstance("ItemTipsView")
		tipsViewTag = ItemTipsViewTag
	end

	mediator:getView():addChild(itemTipView, 99999, tipsViewTag)

	if self._info and self._info.isWidget then
		mediator:getEventDispatcher():dispatchEvent(Event:new(EVT_SHOW_ITEMTIP, {
			forVertical = true,
			info = info,
			style = icon.style,
			icon = icon
		}))
	else
		mediator:dispatch(Event:new(EVT_SHOW_ITEMTIP, {
			forVertical = true,
			info = info,
			style = icon.style,
			icon = icon
		}))
		mediator:getView():setLocalZOrder(100)
	end

	self:touchDisappear(mediator:getView(), icon.style.touchDisappear)
end

function IconTouchHandler:touchDisappear(view, touchDisappear)
	if touchDisappear then
		local winSize = cc.Director:getInstance():getVisibleSize()
		local touchLayer = ccui.Layout:create()

		touchLayer:setAnchorPoint(cc.p(0.5, 0.5))
		touchLayer:addTo(view, 99998):center(view:getContentSize())
		touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
		touchLayer:setTouchEnabled(true)
		touchLayer:setName("touchLayer99")
		touchLayer:setSwallowTouches(false)
		touchLayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				view:removeChildByName("touchLayer99")
				self:removeItemTipView()
			end
		end)
	end
end

function IconTouchHandler:onEnded(icon)
	self:removeItemTipView()
end

function IconTouchHandler:onMoved(icon)
	local pos = icon:getTouchMovePosition()
	local changeX = math.abs(pos.x - self._beginPos.x)
	local changeY = math.abs(pos.y - self._beginPos.y)

	if changeX > 20 or changeY > 20 then
		self:removeItemTipView()
	end
end

function IconTouchHandler:onCanceled(icon)
	self:removeItemTipView()
end

BuffTouchHandler = class("BuffTouchHandler", IconTouchHandler, _M)

function BuffTouchHandler:onBegan(icon)
	local pos = icon:getTouchBeganPosition()

	self._beginPos = {
		x = pos.x,
		y = pos.y
	}

	local info = icon.info

	self:removeItemTipView()

	local mediator = self._parentViewMediator

	self._parentViewMediator.zorder = self._parentViewMediator:getView():getLocalZOrder()

	local itemTipView = mediator:getInjector():getInstance("BuffTipsView")
	local tipsViewTag = BuffTipsViewTag

	mediator:getView():addChild(itemTipView, 99999, tipsViewTag)
	mediator:dispatch(Event:new(EVT_SHOW_BUFFTIP, {
		info = info,
		icon = icon,
		style = icon.style
	}))
end

SomeWordTouchHandler = class("SomeWordTouchHandler", IconTouchHandler, _M)

function SomeWordTouchHandler:onBegan(icon)
	local pos = icon:getTouchBeganPosition()

	self._beginPos = {
		x = pos.x,
		y = pos.y
	}

	local info = icon.info

	self:removeItemTipView()

	local mediator = self._parentViewMediator

	self._parentViewMediator.zorder = self._parentViewMediator:getView():getLocalZOrder()

	local oneTipView = mediator:getInjector():getInstance("ShowSomeWordTipsView")
	local tipsViewTag = SomeWordTipsViewTag

	mediator:getView():addChild(oneTipView, 99999, tipsViewTag)
	mediator:dispatch(Event:new(EVT_SHOW_SOME_WORDTIP, {
		info = info,
		icon = icon,
		style = icon.style
	}))
end

function IconFactory:bindTouchHander(icon, handler, info, style)
	icon.info = RewardSystem:parseInfo(info)
	icon.style = style or {}

	icon:setTouchEnabled(true)
	icon:setSwallowTouches((style or nil) and (style.swallowTouches or false))
	icon:addTouchEventListener(function(sender, eventType)
		if icon.callFunc then
			icon.callFunc(sender, eventType)
		end

		if eventType == ccui.TouchEventType.began then
			icon.isReturn = false

			local delayAct = cc.DelayTime:create(style.delayTime or 0.1)
			local judgeShowAct = cc.CallFunc:create(function()
				icon.isReturn = true

				if handler.onBegan ~= nil then
					handler:onBegan(icon)
				end
			end)
			local seqAct = cc.Sequence:create(delayAct, judgeShowAct)

			sender:runAction(seqAct)
		elseif eventType == ccui.TouchEventType.canceled then
			sender:stopAllActions()

			if handler.onCanceled ~= nil then
				handler:onCanceled(icon)
			end
		elseif eventType == ccui.TouchEventType.moved then
			if style and style.stopActionWhenMove then
				sender:stopAllActions()
			end

			if handler.onMoved ~= nil then
				handler:onMoved(icon)
			end
		elseif eventType == ccui.TouchEventType.ended then
			sender:stopAllActions()

			if handler.onEnded ~= nil then
				handler:onEnded(icon)
			end

			icon.isReturn = false
		end
	end)
end

function IconFactory:bindClickHander(icon, handler, info, style)
	icon.info = RewardSystem:parseInfo(info)
	icon.style = style or {}

	icon:setTouchEnabled(true)
	icon:setSwallowTouches((style or nil) and (style.swallowTouches or false))
	icon:addTouchEventListener(function(sender, eventType)
		if icon.callFunc then
			icon.callFunc(sender, eventType)
		end

		if eventType == ccui.TouchEventType.began then
			if handler.onBegan ~= nil then
				handler:onBegan(icon, true)
			end
		elseif eventType == ccui.TouchEventType.canceled then
			-- block empty
		elseif eventType == ccui.TouchEventType.moved then
			-- block empty
		elseif eventType == ccui.TouchEventType.ended then
			-- block empty
		end
	end)
end

function IconFactory:bindClickAction(icon, clickFunc, style)
	style = style or {}

	local checkFunc = style.checkFunc

	icon:setTouchEnabled(true)
	icon:setSwallowTouches(false)

	icon.hasClick = false
	icon.isRunAction = false

	icon:stopAllActions()
	icon:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			if icon.hasClick then
				return
			end

			icon.hasClick = true
		elseif eventType == ccui.TouchEventType.canceled then
			icon.hasClick = false
			icon.isRunAction = false
		elseif eventType == ccui.TouchEventType.moved then
			-- block empty
		elseif eventType == ccui.TouchEventType.ended then
			if icon.isRunAction then
				return
			end

			icon.isRunAction = true

			if style.runAction == false then
				if clickFunc then
					icon.hasClick = false
					icon.isRunAction = false

					if checkFunc then
						local factor1 = checkFunc()
						local factor2 = not checkFunc

						if checkFunc or factor2 then
							clickFunc(sender)
						end
					end
				end
			else
				icon:runAction(ClickAction:create(icon, function()
					if clickFunc then
						icon.hasClick = false
						icon.isRunAction = false

						if checkFunc then
							local factor1 = checkFunc()
							local factor2 = not checkFunc

							if checkFunc or factor2 then
								clickFunc(sender)
							end
						end
					end
				end))
			end
		end
	end)
end

function IconFactory:createSprite(path)
	return cc.Sprite:create(path)
end

function IconFactory:getRoleIconPath(id, type)
	local type = type or 1
	local rolePicId = ConfigReader:getDataByNameIdAndKey("RoleModel", id, IconFactory.kIconType[type])
	local modelID = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "Model")
	local commonResource = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "CommonResource")

	if not commonResource or commonResource == "" then
		commonResource = modelID
	end

	if rolePicId and rolePicId ~= "" then
		local picInfo = ConfigReader:getRecordById("SpecialPicture", rolePicId)

		return (string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(picInfo.Path)], commonResource, picInfo.Filename))
	end
end

function IconFactory:createRoleIconSprite(info)
	assert(false, "invalid function")

	local id = info.id

	if not info.iconType then
		local rolePicId = ConfigReader:getDataByNameIdAndKey("RoleModel", id, IconFactory.kIconType[info.iconType] or info.iconType)

		assert(rolePicId and rolePicId ~= "", string.format("未找到RoleModel表中所配字段ID:%s,字段：%s", id, IconFactory.kIconType[info.iconType] or info.iconType))

		local modelID = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "Model")
		local commonResource = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "CommonResource")

		if not commonResource or commonResource == "" then
			commonResource = modelID
		end

		local picInfo = ConfigReader:getRecordById("SpecialPicture", rolePicId)

		assert(picInfo, string.format("未找到SpecialPicture表中所配字段ID:%s", rolePicId))

		local path = string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(picInfo.Path)], commonResource, picInfo.Filename)
		local animPath, sprite, spineani

		if info.useAnim then
			animPath = string.format("asset/anim/%s.skel", picInfo.Filename)

			local imagePath = string.format("asset/anim/%s.png", picInfo.Filename)
			local plistPath = string.format("asset/anim/%s.plist", picInfo.Filename)
			local imageAlphaPath = string.format("asset/anim/%s.png@alpha", picInfo.Filename)

			if DEBUG == 0 then
				if cc.FileUtils:getInstance():isFileExist(imageAlphaPath) then
					if cc.FileUtils:getInstance():isFileExist(animPath) then
						if cc.FileUtils:getInstance():isFileExist(imagePath) then
							if cc.FileUtils:getInstance():isFileExist(plistPath) then
								local spineNode = sp.SkeletonAnimation:create(animPath)

								spineNode:playAnimation(0, "", true)
								spineNode:setTag(666)

								spineani = spineNode

								local boundingBox = spineNode:getBoundingBox()

								spineNode:playAnimation(0, "animation", true)

								local size = cc.size(boundingBox.width, boundingBox.height)
								local node = self:createBaseNode(true)

								node:setTouchEnabled(false)
								node:setContentSize(size)
								node:setAnchorPoint(cc.p(0.5, 0.5))
								spineNode:addTo(node)
								spineNode:setPosition(size.width * 0.5, 0)

								sprite = node
							end
						end
					end
				end
			end
		end

		sprite = sprite or cc.Sprite:create(path)

		if not sprite then
			sprite = cc.Sprite:create()

			CommonUtils.uploadDataToBugly("IconFactory:createRoleIconSprite", "未找到SpecialPicture表中所配文件：" .. path)
		end

		local spriteSize = sprite:getContentSize()

		if not picInfo.Coordinates then
			local coordinates = {}

			if not coordinates[1] then
				local x = 0

				if not coordinates[2] then
					local y = 0

					if info.useAnim and (x ~= 0 or y ~= 0) and picInfo.bustani then
						x = picInfo.bustani[0] or 0
						y = picInfo.bustani[1] or 0
					end

					local clipSzie = info.size

					if not clipSzie and (x ~= 0 or y ~= 0) then
						clipSzie = cc.size(spriteSize.width - x, spriteSize.height - y)
					end

					if info.stencil then
						if _G.type(info.stencil) == "number" then
							info.stencil = self:getStencilByType(info.stencil, info.size)
						end

						if not picInfo.zoom then
							local contentScale = 1
							local size = info.stencil:getContentSize()

							size.width = size.width * info.stencil:getScaleX()
							size.height = size.height * info.stencil:getScaleY()

							sprite:setAnchorPoint(cc.p(x / (spriteSize.width * contentScale), y / (spriteSize.height * contentScale)))

							if info.stencilFlip then
								sprite:setFlippedX(info.stencilFlip)
							end

							sprite:setScale(contentScale)
							info.stencil:setPosition(0, 0)
							info.stencil:setAnchorPoint(cc.p(0, 0))

							if info.offset then
								local posX = sprite:getPositionX() + info.offset[1]
								local posY = sprite:getPositionY() + info.offset[2]

								sprite:setPosition(cc.p(posX, posY))
							end

							sprite = ClippingNodeUtils.getClippingNodeByData({
								stencil = info.stencil,
								content = sprite
							}, info.alpha)

							sprite:setContentSize(size)
							sprite:setAnchorPoint(cc.p(0, 0))
							sprite:setIgnoreAnchorPointForPosition(false)
						end
					elseif clipSzie then
						local offsetX = math.max(0, x)
						local offsetY = math.max(0, spriteSize.height - y - clipSzie.height)

						if x < 0 then
							if not (clipSzie.width + x) then
								local width = clipSzie.width

								if spriteSize.height - y - clipSzie.height < 0 then
									if not (clipSzie.height + (spriteSize.height - y - clipSzie.height)) then
										local height = clipSzie.height

										sprite:setTextureRect(cc.rect(offsetX, offsetY, math.min(width, spriteSize.width - offsetX), height))
									end
								end
							end
						end
					end

					if picInfo.Deviation or picInfo.zoom then
						if picInfo.zoom and not info.stencil then
							sprite:setScale(picInfo.zoom)
						elseif not picInfo.Deviation then
							return sprite
						end

						local size = sprite:getContentSize()

						size.width = size.width * sprite:getScale()
						size.height = size.height * sprite:getScale()

						if not picInfo.Deviation[1] then
							local x = 0

							if not picInfo.Deviation[2] then
								local y = 0

								if info.useAnim and (x ~= 0 or y ~= 0) and picInfo.bustani then
									x = picInfo.bustani[0] or 0
									y = picInfo.bustani[1] or 0
								end

								local node = self:createBaseNode(true)

								node:setTouchEnabled(false)
								node:setContentSize(size)
								node:setAnchorPoint(cc.p(0.5, 0.5))
								sprite:setAnchorPoint(cc.p(0.5, 0.5))
								sprite:setName("hero")
								sprite:addTo(node)
								sprite:setPosition(x + size.width * 0.5, y + size.height * 0.5)

								sprite = node
							end
						end
					end

					return sprite, animPath, spineani, picInfo
				end
			end
		end
	end
end

function IconFactory:getStencilByName(stecialInfo, size)
	local stencilPath = "asset/stencil/" .. stecialInfo.name
	local stencil

	if stecialInfo.name == "drawNode" then
		if size then
			local radius = (size.width or 100) * 0.5

			stencil = cc.DrawNode:create()

			stencil:drawSolidCircle(cc.p(radius, radius), radius, 0, 100, 1, 1, cc.c4f(1, 0, 0, 1))
			stencil:setContentSize(cc.size(radius * 2, radius * 2))
			stencil:setAnchorPoint(0.5, 0.5)
		end
	else
		if stecialInfo.scale9 then
			srect = cc.rect(stecialInfo.scale9[1], stecialInfo.scale9[2], stecialInfo.scale9[3], stecialInfo.scale9[4])
			stencil = ccui.Scale9Sprite:create(srect, stencilPath)
		else
			stencil = ccui.ImageView:create()

			stencil:loadTexture(stencilPath)
			stencil:ignoreContentAdaptWithSize(false)
		end

		size = size or stencil:getContentSize()

		stencil:setContentSize(size)
	end

	return stencil
end

function IconFactory:createAsyncRoleIconSpriteNew(info)
	style = style or {}

	local node = cc.Node:create()
	local textureCache = cc.Director:getInstance():getTextureCache()

	if not node.bindExit then
		node:atExit(function()
			if node._resPath then
				textureCache:unbindImageAsync(node._resPath)
			end

			node.close = true
		end)

		node.bindExit = true
	end

	local resPath = IconFactory:getRoleIconSpriteNewPath(info)
	local id = info.id
	local roleModelInfo = ConfigReader:getRecordById("RoleModel", id)

	if info.useAnim then
		AnimLoadUtils.asyncLoadSkeletonAnimation(tostring(animationResId) .. ".skel", function()
			if not node.close then
				local rolePic = IconFactory:createRoleIconSpriteNew(info)

				rolePic:addTo(node)

				if info.callback then
					info.callback(rolePic)
				end
			end
		end)
	else
		addImageAsync(resPath, function(texture)
			if not node.close then
				local rolePic = IconFactory:createRoleIconSpriteNew(info)

				rolePic:setOpacity(0)
				rolePic:addTo(node)
				rolePic:runAction(cc.FadeIn:create(0.1))
				rolePic:setName("displayPic")

				if info.callback then
					info.callback(rolePic)
				end
			end
		end)

		node._resPath = resPath
	end

	return node
end

function IconFactory:getRoleIconSpriteNewPath(info)
	local id = info.id
	local roleModelInfo = ConfigReader:getRecordById("RoleModel", id)
	local modelID = roleModelInfo.Model
	local commonResource = roleModelInfo.CommonResource

	if not commonResource or commonResource == "" then
		commonResource = modelID
	end

	return (string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(roleModelInfo.Path)], commonResource, roleModelInfo.Filename))
end

function IconFactory:createRoleIconSpriteNew(info)
	local id = info.id

	if not info.frameId then
		return IconFactory:createRoleIconSpriteNewIcon(info)
	end

	local frameId = info.frameId
	local frameInfo = ConfigReader:getRecordById("BustFrame", frameId)
	local roleModelInfo = ConfigReader:getRecordById("RoleModel", id)
	local bustInfo = roleModelInfo[frameInfo.BustTempId]
	local stencil = frameInfo.Stencil

	if info.useAnim and not next(stencil) and frameInfo.Size[1] > 0 then
		stencil = {
			name = "icon_zz.png"
		}
	end

	local modelID = roleModelInfo.Model
	local commonResource = roleModelInfo.CommonResource

	if not commonResource or commonResource == "" then
		commonResource = modelID
	end

	local path = string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(roleModelInfo.Path)], commonResource, roleModelInfo.Filename)
	local animPath, sprite, spineani

	if id == "Model_YMHTPu" then
		info.useAnim = false
	end

	if info.useAnim then
		animPath = string.format("asset/anim/%s.skel", roleModelInfo.Filename)

		local imagePath = string.format("asset/anim/%s.png", roleModelInfo.Filename)
		local plistPath = string.format("asset/anim/%s.plist", roleModelInfo.Filename)
		local imageAlphaPath = string.format("asset/anim/%s.png@alpha", roleModelInfo.Filename)

		if DEBUG == 0 then
			if cc.FileUtils:getInstance():isFileExist(imageAlphaPath) then
				if cc.FileUtils:getInstance():isFileExist(animPath) then
					if cc.FileUtils:getInstance():isFileExist(imagePath) then
						if cc.FileUtils:getInstance():isFileExist(plistPath) then
							local spineNode = sp.SkeletonAnimation:create(animPath)

							spineNode:playAnimation(0, "", true)
							spineNode:setTag(666)

							spineani = spineNode

							local boundingBox = spineNode:getBoundingBox()

							spineNode:playAnimation(0, "animation", true)

							local size = cc.size(boundingBox.width, boundingBox.height)
							local node = self:createBaseNode(true)

							node:setTouchEnabled(false)
							node:setContentSize(size)
							node:setAnchorPoint(cc.p(0.5, 0.5))
							spineNode:addTo(node)
							spineNode:setPosition(size.width * 0.5, 0)

							sprite = node
						end
					end
				end
			end
		end
	end

	sprite = sprite or cc.Sprite:create(path)

	if not sprite then
		sprite = cc.Sprite:create()

		CommonUtils.uploadDataToBugly("IconFactory:createRoleIconSpriteNew", "未找到SpecialPicture表中所配文件：" .. path)
	end

	local bustZoom
	local spriteSize = sprite:getContentSize()

	if not frameInfo.Pos[1] then
		local x = 0

		if not frameInfo.Pos[2] then
			local y = 0
			local frameSize = cc.size(frameInfo.Size[1], frameInfo.Size[2])

			if stencil and next(stencil) then
				bustZoom = roleModelInfo.bustZoom or 1

				sprite:setScale(bustZoom)
				sprite:setPosition(cc.p(bustInfo[1], bustInfo[2]))

				local size = sprite:getContentSize()

				size.width = size.width * sprite:getScale()
				size.height = size.height * sprite:getScale()

				local spnode = self:createBaseNode(true)

				spnode:setTouchEnabled(false)
				spnode:setContentSize(size)
				spnode:setAnchorPoint(cc.p(0, 0))
				spnode:setPosition(cc.p(0, 0))
				sprite:setAnchorPoint(cc.p(0, 0))
				sprite:addTo(spnode)
				spnode:setScale(frameInfo.Scale)
				spnode:setAnchorPoint(cc.p(x / (spnode:getContentSize().width * frameInfo.Scale), y / (spnode:getContentSize().height * frameInfo.Scale)))

				stencil = self:getStencilByName(stencil, frameSize.width > 0 and frameSize or nil)

				stencil:setPosition(0, 0)
				stencil:setAnchorPoint(cc.p(0, 0))
				spnode:setPosition(cc.p(0, 0))

				sprite = ClippingNodeUtils.getClippingNodeByData({
					stencil = stencil,
					content = spnode
				}, info.alpha)

				local size = stencil:getContentSize()

				size.width = size.width * stencil:getScaleX()
				size.height = size.height * stencil:getScaleY()

				sprite:setContentSize(size)
				sprite:setAnchorPoint(cc.p(0, 0))
				sprite:setIgnoreAnchorPointForPosition(false)

				local size = sprite:getContentSize()

				size.width = size.width * sprite:getScale()
				size.height = size.height * sprite:getScale()

				local node = self:createBaseNode(true)

				node:setTouchEnabled(false)
				node:setContentSize(size)
				node:setAnchorPoint(cc.p(0.5, 0.5))
				sprite:setAnchorPoint(cc.p(0.5, 0.5))
				sprite:addTo(node)
				sprite:setPosition(size.width * 0.5, size.height * 0.5)

				if info.stencilFlip then
					node:setFlippedX(info.stencilFlip)
				end

				sprite = node
			elseif frameSize.width > 0 then
				bustZoom = roleModelInfo.bustZoom or 1

				sprite:setScale(bustZoom)
				sprite:setPosition(cc.p(bustInfo[1], bustInfo[2]))

				local size = sprite:getContentSize()

				size.width = size.width * sprite:getScale()
				size.height = size.height * sprite:getScale()

				local spnode = self:createBaseNode(true)

				spnode:setTouchEnabled(false)
				spnode:setContentSize(size)
				spnode:setAnchorPoint(cc.p(0, 0))
				spnode:setPosition(cc.p(0, 0))
				sprite:setAnchorPoint(cc.p(0, 0))
				sprite:addTo(spnode)
				spnode:setScale(frameInfo.Scale)

				local realSize = cc.size(frameSize.width / frameInfo.Scale / bustZoom, frameSize.height / frameInfo.Scale / bustZoom)
				local kuangPos = sprite:convertToNodeSpace(cc.p(x, y))
				local realPosX = kuangPos.x
				local realPosY = kuangPos.y
				local clipSzie = realSize
				local offsetX = math.max(0, realPosX)
				local offsetY = math.max(0, spriteSize.height - realPosY - clipSzie.height)

				if realPosX < 0 then
					if not (clipSzie.width + realPosX) then
						local width = clipSzie.width

						if offsetY < 0 then
							if not (clipSzie.height + offsetY) then
								local height = clipSzie.height

								sprite:setTextureRect(cc.rect(offsetX, offsetY, math.min(width, spriteSize.width - offsetX), height))
								sprite:setScale(bustZoom * frameInfo.Scale)
								spnode:setScale(1)

								local size = sprite:getContentSize()

								size.width = size.width * sprite:getScale()
								size.height = size.height * sprite:getScale()

								spnode:setContentSize(size)
								spnode:setAnchorPoint(cc.p(0.5, 0.5))
								sprite:setAnchorPoint(cc.p(0.5, 0.5))
								sprite:setPosition(size.width * 0.5, size.height * 0.5)

								sprite = spnode
							end
						end
					end
				end
			else
				local specialScaleId = frameInfo.SpecialScaleId

				bustZoom = specialScaleId and specialScaleId ~= "" and (roleModelInfo[specialScaleId] or 1) or roleModelInfo.bustZoom or 1

				sprite:setAnchorPoint(cc.p(0, 0))
				sprite:setScale(bustZoom)
				sprite:setPosition(cc.p(bustInfo[1] + x, bustInfo[2] + y))

				local size = sprite:getContentSize()

				size.width = size.width * sprite:getScale()
				size.height = size.height * sprite:getScale()

				local node = self:createBaseNode(true)

				node:setTouchEnabled(false)
				node:setContentSize(size)
				node:setAnchorPoint(cc.p(0, 0))
				node:setPosition(cc.p(0, 0))
				sprite:setName("hero")
				sprite:addTo(node)
				node:setScale(frameInfo.Scale)

				sprite = node
			end

			local picInfo = {
				zoom = bustZoom,
				Deviation = {
					bustInfo[1] + x,
					bustInfo[2] + y
				}
			}

			return sprite, animPath, spineani, picInfo
		end
	end
end

function IconFactory:createRoleIconSpriteNewIcon(info)
	local id = info.id

	if not info.iconType then
		local type = 1

		assert(type == 1 or type == 2 or type == "Portrait" or type == "MasterHeadWide", "error type")

		local path
		local modelID = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "Model")
		local commonResource = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "CommonResource")

		if not commonResource or commonResource == "" then
			commonResource = modelID
		end

		local rolePicId = ConfigReader:getDataByNameIdAndKey("RoleModel", id, IconFactory.kIconType[type] or type)

		assert(rolePicId and rolePicId ~= "", string.format("未找到RoleModel表中所配字段ID:%s,字段：%s", id, IconFactory.kIconType[type] or type))

		local picInfo = ConfigReader:getRecordById("SpecialPicture", rolePicId)

		assert(picInfo, string.format("未找到SpecialPicture表中所配字段ID:%s", rolePicId))

		path = string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(picInfo.Path)], commonResource, picInfo.Filename)

		local sprite = cc.Sprite:create(path)

		if not sprite then
			sprite = cc.Sprite:create()

			CommonUtils.uploadDataToBugly("IconFactory:createRoleIconSpriteNew", "未找到SpecialPicture表中所配文件：" .. path)
		end

		local size = sprite:getContentSize()

		size.width = size.width * sprite:getScale()
		size.height = size.height * sprite:getScale()

		local node = self:createBaseNode(true)

		node:setTouchEnabled(false)
		node:setContentSize(size)
		node:setAnchorPoint(cc.p(0.5, 0.5))
		sprite:setAnchorPoint(cc.p(0.5, 0.5))
		sprite:addTo(node)
		sprite:setPosition(size.width * 0.5, size.height * 0.5)

		sprite = node

		return node
	end
end

function IconFactory:createBaseNode(isWidget)
	local node = isWidget and ccui.Widget:create() or cc.Node:create()

	node:setAnchorPoint(0.5, 0.5)
	node:setCascadeOpacityEnabled(true)

	return node
end

function IconFactory:createIcon(info, style)
	assert(info ~= nil and info.id ~= nil, "Bad argument")

	local id = info.id

	if info.rewardType then
		if info.rewardType == RewardType.kSurface then
			local config = ConfigReader:getRecordById("Surface", id)

			if config and config.Id then
				return IconFactory:createSurfaceIcon(info, style)
			end
		elseif info.rewardType == RewardType.kHero then
			local config = ConfigReader:getRecordById("HeroBase", tostring(id))

			if config and config.Id then
				return IconFactory:createHeroIconForReward(info, style)
			end
		elseif info.rewardType == RewardType.kEquip or info.rewardType == RewardType.kEquipExplore then
			local config = ConfigReader:getRecordById("HeroEquipBase", tostring(id))

			if config and config.Id then
				return IconFactory:createRewardEquipIcon(info, style)
			end
		elseif info.rewardType == RewardType.kBuff then
			local config = ConfigReader:getRecordById("Skill", tostring(id))

			if config and config.Id then
				return IconFactory:createBuffIcon(info, style)
			end
		elseif info.rewardType == RewardType.kBackground then
			local config = ConfigReader:getRecordById("HomeBackground", tostring(id))

			if config and config.Id then
				return IconFactory:createBackgroundIcon(info, style)
			end
		elseif info.rewardType == RewardType.kRTPKEmoji then
			local config = ConfigReader:getRecordById("MasterFace", tostring(id))

			if config and config.Id then
				return IconFactory:createRTPKEmojiIcon(info, style)
			end
		end
	end

	local config = ConfigReader:getRecordById("ResourcesIcon", tostring(id))

	if config and config.Id then
		return IconFactory:createResourceIcon(info, style)
	end

	config = ConfigReader:getRecordById("ItemConfig", tostring(id))

	if config and config.Id then
		return IconFactory:createItemIcon(info, style)
	end

	config = ConfigReader:getRecordById("Skill", tostring(id))

	if config and config.Id then
		return IconFactory:createSkillPic(info, style)
	end

	config = ConfigReader:getRecordById("MasterBase", tostring(id))

	if config and config.Id then
		return IconFactory:createMasterIcon(info, style)
	end

	config = ConfigReader:getRecordById("PlayerHeadModel", tostring(id))

	if config and config.Id then
		return IconFactory:createPlayerIcon(info, style)
	end

	config = ConfigReader:getRecordById("MasterCoreBase", tostring(id))

	if config and config.Id then
		return IconFactory:createKernelIcon(info, style)
	end

	config = ConfigReader:getRecordById("PlayerHeadFrame", tostring(id))

	if config and config.Id then
		return IconFactory:createPlayerFrameIcon(info, style)
	end

	config = ConfigReader:getRecordById("Tsoul", tostring(id))

	if config and config.Id then
		return IconFactory:createTSoulIcon(info, style)
	end

	config = ConfigReader:getRecordById("ChatBubble", tostring(id))

	if config and config.Id then
		return IconFactory:createChatBubbleIcon(info, style)
	end

	config = ConfigReader:getRecordById("PlayerTitle", tostring(id))

	if config and config.Id then
		return IconFactory:createTitleIcon(info, style)
	end

	assert(false, "未找到对应id配置：" .. id)
end

function IconFactory:createRewardIcon(rewardInfo, style)
	assert(rewardInfo, "Bad argument")

	local info = RewardSystem:parseInfo(rewardInfo)

	style = style or {}
	style.hideLevel = true

	local icon = IconFactory:createIcon(info, style)

	function icon:setScaleNotCascade(scale)
		icon:setScale(scale)

		if icon.getAmountLabel then
			local label = icon:getAmountLabel()

			if label then
				label:setScale(0.8 / scale)
				label:enableOutline(cc.c4b(0, 0, 0, 255), 1)

				if icon:getChildByName("AmountBg") then
					local amountBg = icon:getChildByName("AmountBg")

					amountBg:setAnchorPoint(cc.p(1, 0))

					local width = amountBg:getContentSize().width * scale
					local scaleX = (label:getContentSize().width * 0.8 / scale + 16) / width

					amountBg:setScaleX(scaleX * scale)
				end
			end
		end
	end

	return icon
end

function IconFactory:createMasterSkillIcon(info, style, clickfun)
	if info.id then
		local id = info.id
		local isLock = info.isLock

		if info.level then
			if not info.level then
				local level = 1

				if not info.needselect then
					local needselect = false

					if not info.notneedrect then
						local notneedrect = false

						if not info.quality then
							local quality = 1
							local skillConfig = ConfigReader:getRecordById("Skill", tostring(id))
							local node = cc.Node:create()
							local root = ccui.Layout:create()

							root:setContentSize(cc.size(94, 94))
							root:setTag(66)
							node:addChild(root)

							local kLevelTag, kLockTag = 65536, 65537
							local under = ccui.ImageView:create("yh_bg_jnk_new.png", 1)

							root:addChild(under)
							under:setPosition(cc.p(50, 43))
							under:setScale(1.4)

							local kSkillTag = 65539
							local skillImg = IconFactory:createSkillPic({
								id = skillConfig.Icon
							})

							skillImg:setTag(kSkillTag)
							IconFactory:centerAddNode(node, skillImg)
							skillImg:setPosition(cc.p(47, 47))
							skillImg:setScale(0.9)

							if notneedrect == false then
								local rect = IconFactory:createSprite(GameStyle:getMasterSkillQualityRectFile(quality))

								root:addChild(rect)
								rect:setPosition(cc.p(47, 47))

								if info.isLock then
									node:setSaturation(-100)
								end
							end

							if needselect then
								local select = ccui.ImageView:create()

								select:loadTexture("cbb_zhujueshuxingimage.png", ccui.TextureResType.plistType)
								select:setPosition(cc.p(46, 46))
								select:setTag(667)
								select:setScale(1.75)
								root:addChild(select)
							end

							local btn = ccui.Button:create("asset/master/masterRect/masterSkillBottomRect/pic_tongyong_di_pzk_jn.png", "asset/master/masterRect/masterSkillBottomRect/pic_tongyong_di_pzk_jn.png")

							btn:setSwallowTouches(false)
							btn:setTag(668)
							btn:addTouchEventListener(function(sender, eventType)
								if eventType == ccui.TouchEventType.ended and clickfun then
									clickfun()
								end
							end)
							btn:setOpacity(0)
							btn:setPosition(cc.p(47, 47))
							node:addChild(btn, 999)

							function node:setLevel(lvl)
								local lvLabel = self:getChildByTag(kLevelTag)

								if not lvLabel then
									lvLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_R, 18)

									lvLabel:enableOutline(cc.c4b(60, 30, 10, 255), 2)
									node:addChild(lvLabel, 1, kLevelTag)
								end

								lvl = lvl or ""

								if lvLabel and lvl then
									lvLabel:setString("Lv." .. tostring(lvl))
									lvLabel:setAnchorPoint(cc.p(1, 1))
									lvLabel:setPosition(cc.p(90, 25))
								end

								lvLabel:setScale(1.5)
								lvLabel:setVisible(not style or not style.hideLevel)
							end

							function node:setLock(isLock)
								local lockImg = self:getChildByTag(kLockTag)

								if not lockImg then
									lockImg = ccui.ImageView:create("yh_bg_fengyin.png", 1)

									lockImg:setPosition(45, 54)
									node:addChild(lockImg, 1, kLockTag)
									lockImg:removeAllChildren()

									local lvLabel = cc.Label:createWithTTF("", CUSTOM_TTF_FONT_1, 24)

									lvLabel:setString(Strings:get("HEROS_UI3"))
									lvLabel:setColor(cc.c3b(80, 50, 20))
									lvLabel:setRotation(-7)
									lvLabel:addTo(lockImg)
									lvLabel:setPosition(cc.p(50, 28))
								end

								lockImg:setVisible(isLock)
								lockImg:setScale(1.4)

								local skillImg = self:getChildByTag(kSkillTag)

								if skillImg then
									skillImg:setGray(isLock)
								end
							end

							function node:setPassiveSkill()
								local iconData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillIcon", "content")
								local img = ccui.ImageView:create("asset/heroRect/heroSkillType/" .. iconData[info.skillType] .. "_1.png")

								img:setPosition(cc.p(90, 75))
								node:addChild(img, 1, kLevelTag)
							end

							if not info.levelHide then
								node:setLevel(level)
							end

							if info.skillType and info.skillType == "PassiveSkill" then
								node:setPassiveSkill()
							end

							node:setLock(isLock)

							return node
						end
					end
				end
			end
		end
	end
end

function IconFactory:createMasterSkillIconEx(info, style)
	if info.id then
		local id = info.id

		if not info.quality then
			local quality = 1
			local skillConfig = ConfigReader:getRecordById("Skill", tostring(id))
			local node = cc.Node:create()
			local root = ccui.Layout:create()

			root:setContentSize(cc.size(94, 94))
			node:addChild(root)

			local under = IconFactory:createSprite(GameStyle:getMasterSkillQualityBottomFileEx(quality))

			root:addChild(under)
			under:setPosition(cc.p(47, 47))

			local skillImg = IconFactory:createSkillPic({
				id = skillConfig.Icon
			})

			IconFactory:centerAddNode(node, skillImg)
			skillImg:setPosition(cc.p(47, 47))

			local rect = IconFactory:createSprite(GameStyle:getMasterSkillQualityRectFileEx(quality))

			root:addChild(rect)
			rect:setPosition(cc.p(47, 47))

			return node
		end
	end
end

function IconFactory:createMasterIcon(info, style)
	if info.id then
		if not info.id then
			local id = "Master_XueZhan"
			local qualityconfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_DefaultQuality", "content")

			if info.level then
				if not info.level then
					if not info.star then
						local star = 0
						local quality = tonumber(qualityconfig) or 1
						local quaRectImg = IconFactory:createSprite(GameStyle:getMasterQualityRectFile(quality, style and style.isRect))
						local colorRectSize = quaRectImg:getContentSize()
						local bottomFile = GameStyle:getMasterIconBottomFile(quality, style and style.isRect)
						local bottomImg = IconFactory:createSprite(bottomFile)
						local node = self:createBaseNode(style and style.isWidget)

						node:setContentSize(cc.size(colorRectSize.width, colorRectSize.width))

						if not info.scale then
							info.id = IconFactory:getRoleModelByKey("MasterBase", id)

							local heroImg = self:createRoleIconSpriteNew(info)

							if heroImg == nil then
								heroImg = self:createSprite("asset/master/1001/1001_head.png")
							end

							if info.clipType then
								heroImg = self:addStencilForIcon(heroImg, info.clipType, info.size)
							end

							node:setScale(info.scale)
							IconFactory:centerAddNode(node, bottomImg)
							IconFactory:centerAddNode(node, heroImg)

							if not style.notShowQulity == true then
								IconFactory:centerAddNode(node, quaRectImg)
							end

							local kLevelTag, kStarTag = 65536, 65537

							function node:setStar(star)
								local starNode = self:getChildByTag(kStarTag)

								if starNode == nil then
									starNode = cc.Node:create()

									IconFactory:centerAddNode(node, starNode, 0, kStarTag)
								end

								starNode:removeAllChildren(true)

								if not IconFactory.kStarIntervalXArr[star] then
									local intervalX = 0
									local startX = -(star - 1) * 0.5 * intervalX

									for index = 1, star do
										local starImg = cc.Sprite:createWithSpriteFrameName(IconFactory.starImgPath)

										starImg:setPosition(startX + (index - 1) * intervalX, kStarHeight)
										starNode:addChild(starImg)
										starImg:setScale(IconFactory.kStarScale)
									end
								end
							end

							node:setStar(star)

							return node
						end
					end
				end
			end
		end
	end
end

function IconFactory:createMasterIcon(info, style)
	if info.id then
		if not info.id then
			local id = "Master_XueZhan"
			local node = self:createBaseNode(style and style.isWidget)

			node:setContentSize(cc.size(81, 81))

			if not info.scale then
				local scale = 1

				info.id = IconFactory:getRoleModelByKey("MasterBase", id)

				local heroImg = self:createRoleIconSpriteNew(info)

				assert(heroImg ~= nil, "主角没有头像。")

				if info.clipType then
					heroImg = self:addStencilForIcon(heroImg, info.clipType, info.size)
				end

				local bottomImg = ccui.Scale9Sprite:createWithSpriteFrameName("sz_bg_xzd.png")
				local capInsets = cc.rect(4, 4, 4, 4)

				bottomImg:setCapInsets(capInsets)

				local size = heroImg:getContentSize()

				bottomImg:setContentSize(cc.size(size.width + 20, size.height + 20))
				node:setScale(scale)
				IconFactory:centerAddNode(node, bottomImg)
				IconFactory:centerAddNode(node, heroImg)

				return node
			end
		end
	end
end

function IconFactory:getRoleModelByKey(tableName, id)
	local roleModel

	if tableName == "HeroBase" then
		local surfaceId = ConfigReader:requireDataByNameIdAndKey(tableName, id, "SurfaceList")[1]

		roleModel = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "Model")
	else
		roleModel = ConfigReader:requireDataByNameIdAndKey(tableName, id, "RoleModel")
	end

	assert(roleModel, string.format("未找到%s表中所配字段ID:%s,字段：%s", tableName, id, "RoleModel"))

	return roleModel
end

function IconFactory:createHeroIcon(info, style)
	style = style or {}

	local id = info.id
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(id)
	local heroConfig = heroPrototype:getConfig()

	if info.level then
		if not info.level then
			local lvl = 1

			if info.quality then
				if not info.quality then
					local quality = ConfigReader:getRecordById("HeroQuality", heroConfig.BaseQualityAttr).Quality

					if info.star then
						if not info.star then
							local star = heroConfig.BaseStar

							if info.rareity then
								if not info.rareity then
									local rareity = heroConfig.Rareity

									if info.name then
										if not info.name then
											local name = Strings:get(heroConfig.Name)

											if info.qualityLevel then
												if not info.qualityLevel then
													local qualityLevel = 0

													if style.isGray then
														if not style.isGray then
															local isGray = false

															if info.type then
																if not info.type then
																	local type = heroConfig.Type
																	local offsetY = 6

																	if not info.size then
																		local size = cc.size(125, 134)

																		if style and (style.hideName or style.hideAll) then
																			size = cc.size(125, 138)
																			offsetY = 3.5
																		end

																		local kQualityImgTag = 65573
																		local qualityBgPath = GameStyle:getHeroQualityRectFile(quality)[1]
																		local quaRectImg = IconFactory:createSprite(qualityBgPath)

																		quaRectImg:setTag(kQualityImgTag)

																		local colorRectSize = quaRectImg:getContentSize()
																		local node = self:createBaseNode(style and style.isWidget)

																		node:setContentSize(cc.size(colorRectSize.width, colorRectSize.height))

																		if style.scale then
																			node:setScale(style.scale)
																		end

																		function node:setQualityBg(quality)
																			quaRectImg = self:getChildByTag(kQualityImgTag)

																			quaRectImg:setTexture(GameStyle:getHeroQualityRectFile(quality)[1])
																		end

																		if not style.notShowQulity == true then
																			IconFactory:centerAddNode(node, quaRectImg)
																		end

																		function node:getId()
																			return id
																		end

																		local kHeroImgTag = 65572
																		local kHeroSpriteTag = 65569

																		info.id = IconFactory:getRoleModelByKey("HeroBase", id)

																		local heroImg = self:createRoleIconSpriteNew(info)

																		heroImg:setTag(kHeroSpriteTag)

																		heroImg = self:addStencilForIcon(heroImg, info.clipType or 4, info.size)

																		IconFactory:centerAddNode(node, heroImg)
																		heroImg:setTag(kHeroImgTag)
																		heroImg:offset(-2.5, offsetY)

																		function node:setHeroImg(info)
																			local heroNode = self:getChildByTag(kHeroImgTag)

																			heroImg = heroNode:getChildByTag(kHeroSpriteTag)

																			heroImg:removeFromParent()

																			heroImg = IconFactory:createRoleIconSpriteNew(info)

																			heroImg:setTag(kHeroSpriteTag)
																			heroImg:addTo(heroNode)

																			if not info.size then
																				local size = cc.size(125, 134)

																				heroImg:setPosition(info.size.width * 0.5, info.size.height * 0.5)
																			end
																		end

																		local kRarietyTag = 65542

																		function node:setRariety(rareity)
																			local leftNumber = self:getChildByTag(kRarietyTag)

																			if not leftNumber then
																				leftNumber = ccui.ImageView:create()

																				leftNumber:setAnchorPoint(cc.p(0, 0.5))
																				leftNumber:setPosition(cc.p(4, 133))
																				leftNumber:setTag(kRarietyTag)
																				node:addChild(leftNumber)
																				leftNumber:setScale(0.6)
																				leftNumber:setRotation(-7)
																			end

																			leftNumber:loadTexture(GameStyle:getHeroRarityImage(rareity), 1)
																		end

																		local kQuaIndexTag = 65539
																		local quaIndexImg = cc.Sprite:createWithSpriteFrameName(IconFactory.battleQuaIndexPath)

																		quaIndexImg:setPosition(cc.p(125, 126))
																		node:addChild(quaIndexImg)
																		quaIndexImg:setTag(kQuaIndexTag)
																		quaIndexImg:setScale(0.4)
																		quaIndexImg:offset(0, 2)

																		function node:setNodeGary(isGary)
																			local heroImgIcon = self:getChildByTag(kHeroImgTag)

																			if heroImgIcon then
																				heroImgIcon:setSaturation(1)

																				if isGary then
																					heroImgIcon:setSaturation(-100)
																				end
																			end
																		end

																		local kCostTag = 65538

																		function node:setCost(cost, hideCose)
																			quaIndexImg:setVisible(cost and cost > 0)

																			local quaIndexLabel = quaIndexImg:getChildByTag(kCostTag)

																			if not quaIndexLabel then
																				quaIndexLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 24)

																				IconFactory:centerAddNode(quaIndexImg, quaIndexLabel)
																				quaIndexLabel:setTag(kCostTag)
																				quaIndexLabel:offset(-7, 4)
																				quaIndexLabel:enableOutline(cc.c4b(20, 20, 20, 204), 2)
																				quaIndexLabel:setScale(2.5)
																			end

																			cost = cost or ""

																			quaIndexLabel:setString(cost)

																			if hideCose == true then
																				quaIndexLabel:setVisible(not hideCose)
																				quaIndexImg:setVisible(not hideCose)
																			end
																		end

																		local heightOffset = 0

																		if style.isRect and style.hideName then
																			heightOffset = -18
																		end

																		local kLevelTag = 65536

																		function node:setLevel(lvl, hasAction, hideLevel)
																			local lvLabel = self:getChildByTag(kLevelTag)

																			if not lvLabel then
																				lvLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_R, 24)

																				lvLabel:enableOutline(cc.c4b(20, 20, 20, 102), 2)
																				node:addChild(lvLabel, 1, kLevelTag)
																				lvLabel:setAnchorPoint(cc.p(1, 0.5))
																			end

																			lvl = lvl or ""

																			if lvLabel and lvl then
																				lvLabel:setString("Lv." .. tostring(lvl))
																				lvLabel:setPosition(node:getContentSize().width - 15, ((style.isRect or nil) and 64) + heightOffset)
																				lvLabel:setColor(cc.c3b(255, 255, 255))
																				lvLabel:setRotation(-5)
																				lvLabel:setVisible(not hideLevel)

																				if hasAction then
																					local time = 0.06
																					local scale1 = 1.4
																					local scale2 = 1

																					lvLabel.initColor = lvLabel.initColor or lvLabel:getColor()

																					if lvLabel.red then
																						lvLabel:setColor(GameStyle:getColor(6))
																					else
																						lvLabel:setColor(cc.c3b(24, 255, 0))
																					end

																					local function stopAction()
																						lvLabel:setColor(lvLabel.initColor)
																					end

																					local actionTo1 = cc.ScaleTo:create(time, scale1)
																					local actionTo2 = cc.ScaleTo:create(time, scale2)
																					local callfunc = cc.CallFunc:create(stopAction)
																					local seq = cc.Sequence:create(actionTo1, actionTo2, callfunc)

																					lvLabel:runAction(seq)
																				end
																			end
																		end

																		function node:getLevelLabel()
																			return self:getChildByTag(kLevelTag)
																		end

																		local kStarTag = 65537
																		local starHeight = kStarHeight

																		if style.isRect and style.hideName then
																			starHeight = 6
																		elseif style.isRect and not style.hideName then
																			starHeight = 24
																		end

																		function node:setStar(star, quality, hideStar)
																			local qualityStarBg = GameStyle:getHeroQualityRectFile(quality)[2]
																			local starNode = self:getChildByTag(kStarTag)

																			if not starNode then
																				starNode = IconFactory:createSprite(qualityStarBg)

																				starNode:setAnchorPoint(cc.p(1, 0))
																				starNode:setPosition(cc.p(node:getContentSize().width - 2, starHeight))
																				starNode:addTo(node)
																				starNode:setTag(kStarTag)
																			end

																			starNode:setTexture(qualityStarBg)
																			starNode:setVisible(not hideStar)
																			starNode:removeAllChildren(true)

																			local startX = 10
																			local offsetX = 15

																			for index = 1, star do
																				local starImg = cc.Sprite:createWithSpriteFrameName(IconFactory.starImgPath3)

																				starImg:setPosition(startX + (index - 1) * offsetX, 13 + (index - 1) + 0.2)
																				starNode:addChild(starImg)
																			end
																		end

																		local nameTag = 65571

																		function node:setName(name, qualityLevel, quality)
																			local nameNode = self:getChildByTag(nameTag)

																			if nameNode == nil then
																				nameNode = ccui.ImageView:create("kazu_bg_ka_mzd.png", 1)

																				nameNode:setAnchorPoint(cc.p(1, 0))
																				nameNode:setPosition(cc.p(node:getContentSize().width - 9, 12))
																				nameNode:addTo(node)
																				nameNode:setTag(nameTag)
																				nameNode:setScaleX(1.01)
																			end

																			nameNode:removeAllChildren(true)
																			nameNode:setVisible(not style or not style.hideName)

																			local layer = cc.Layer:create()

																			layer:setAnchorPoint(cc.p(0, 0))
																			layer:addTo(nameNode)

																			local nameLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 16)

																			GameStyle:setHeroNameByQuality(nameLabel, quality)
																			nameLabel:setAnchorPoint(cc.p(0, 0.5))
																			nameLabel:addTo(layer)
																			nameLabel:setPosition(cc.p(0, 13))
																			nameLabel:setString(name)

																			local qualityLevelLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 16)

																			GameStyle:setHeroNameByQuality(qualityLevelLabel, quality)
																			qualityLevelLabel:setAnchorPoint(cc.p(0, 0.5))
																			qualityLevelLabel:addTo(layer)
																			qualityLevelLabel:setPosition(cc.p(nameLabel:getContentSize().width, 13))
																			qualityLevelLabel:setString(qualityLevel == 0 and "" or " +" .. qualityLevel)
																			layer:setContentSize(cc.size(nameLabel:getContentSize().width + qualityLevelLabel:getContentSize().width, 20))
																			layer:setPosition(cc.p(nameNode:getContentSize().width / 2 - layer:getContentSize().width / 2 - 3, -2.5))
																		end

																		local redTag = 65584

																		function node:refreshRedPoint(visible)
																			local redNode = self:getChildByTag(redTag)

																			if redNode == nil then
																				redNode = ccui.ImageView:create(IconFactory.redPointPath, 1)

																				redNode:addTo(node)
																				redNode:setTag(redTag)
																				redNode:setPosition(cc.p(node:getContentSize().width - 8, node:getContentSize().height - 12))
																				redNode:setLocalZOrder(100000)
																			end

																			redNode:setVisible(visible)
																		end

																		function node:setOccupation(occupationType)
																			local occupationName, occupationIcon = GameStyle:getHeroOccupation(occupationType)
																			local occupationImg = node:getChildByName("OccupationImg")

																			if not occupationImg then
																				occupationImg = ccui.ImageView:create()

																				occupationImg:setPosition(cc.p(26, 28))
																				occupationImg:setName("OccupationImg")
																				occupationImg:addTo(node)
																				occupationImg:setScale(0.7)
																			end

																			occupationImg:loadTexture(occupationIcon)
																		end

																		node:setQualityBg(quality)
																		node:setHeroImg(info)
																		node:setRariety(rareity)
																		node:setCost(heroConfig.Cost, style and style.hideCose)
																		node:setName(name, qualityLevel, quality)
																		node:setStar(star, quality, style and style.hideStar)
																		node:setLevel(lvl, false, style and style.hideLevel)
																		node:setOccupation(type)
																		node:setNodeGary(isGray)
																		node:refreshRedPoint(false)

																		if style and style.hideAll then
																			node:getChildByTag(nameTag):setVisible(false)
																			node:getChildByTag(kStarTag):setVisible(false)
																			node:getChildByTag(kLevelTag):setVisible(false)
																			node:getChildByTag(kQuaIndexTag):setVisible(false)
																			node:getChildByTag(kRarietyTag):setVisible(false)
																		end

																		return node
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function IconFactory:createHeroSmallIcon(info, style)
	style = style or {}

	local id = info.id
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(id)
	local heroConfig = heroPrototype:getConfig()

	if info.quality then
		if not info.quality then
			local quality = ConfigReader:getRecordById("HeroQuality", heroConfig.BaseQualityAttr).Quality

			if info.star then
				if not info.star then
					local star = heroConfig.BaseStar

					if info.rareity then
						if not info.rareity then
							local rarity = heroConfig.Rareity

							if info.cost then
								if not info.cost then
									local cost = heroConfig.Cost

									if info.type then
										if not info.type then
											local type = heroConfig.Type

											if info.maxStar then
												if not info.maxStar then
													local maxStar = heroConfig.MaxStar

													info.id = self:getRoleModelByKey("HeroBase", info.id)

													local rootPanel = ccui.Layout:create()

													rootPanel:setAnchorPoint(cc.p(0.5, 0.5))
													rootPanel:setContentSize(127, 129)
													rootPanel:setTouchEnabled(false)
													rootPanel:setSwallowTouches(false)

													if not rootPanel:getChildByName("HeroBg") then
														local bg = ccui.ImageView:create()

														bg:setAnchorPoint(cc.p(0, 0))
														bg:setPosition(cc.p(0, 0))
														bg:setName("HeroBg")
														bg:addTo(rootPanel)
													end

													rootPanel:getChildByName("HeroBg"):loadTexture(GameStyle:getHeroQualityRectFile(quality)[4])
													rootPanel:removeChildByName("HeroIcon")

													local heroImg = IconFactory:createRoleIconSpriteNew(info)

													heroImg:setScale(0.6)

													heroImg = IconFactory:addStencilForIcon(heroImg, 4, cc.size(102, 104))

													heroImg:setPosition(cc.p(63, 69))
													heroImg:setName("HeroIcon")
													heroImg:addTo(rootPanel)

													if not rootPanel:getChildByName("RarityImg") then
														local rarityImg = ccui.ImageView:create()

														rarityImg:setRotation(-7)
														rarityImg:setScale(0.6)
														rarityImg:setAnchorPoint(cc.p(0, 0.5))
														rarityImg:setPosition(cc.p(9, 105))
														rarityImg:setName("RarityImg")
														rarityImg:addTo(rootPanel)
													end

													rootPanel:getChildByName("RarityImg"):loadTexture(GameStyle:getHeroRarityImage(rarity), 1)

													if not rootPanel:getChildByName("CostImg") then
														local costImg = ccui.ImageView:create(IconFactory.battleQuaIndexPath, 1)

														costImg:setScale(0.4)
														costImg:setPosition(cc.p(112, 100))
														costImg:setName("CostImg")
														costImg:addTo(rootPanel)
													end

													if not rootPanel:getChildByName("CostLabel") then
														local costLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 24)

														costLabel:setTextColor(GameStyle:getColor(1))
														costLabel:enableOutline(cc.c4b(20, 20, 20, 204), 2)
														costLabel:setPosition(cc.p(111, 103))
														costLabel:setName("CostLabel")
														costLabel:addTo(rootPanel)
													end

													rootPanel:getChildByName("CostLabel"):setString(cost)

													local occupationName, occupationIcon = GameStyle:getHeroOccupation(type)

													if not rootPanel:getChildByName("OccupationImg") then
														local occupationImg = ccui.ImageView:create()

														occupationImg:setPosition(cc.p(26, 28))
														occupationImg:setName("OccupationImg")
														occupationImg:addTo(rootPanel)
														occupationImg:setScale(0.65)
													end

													rootPanel:getChildByName("OccupationImg"):loadTexture(occupationIcon)

													if not rootPanel:getChildByName("StarImg") then
														local starImg = ccui.ImageView:create()

														starImg:setPosition(cc.p(62, 24))
														starImg:setName("StarImg")
														starImg:addTo(rootPanel)

														local startX = 25
														local offsetX = 15

														for index = 1, maxStar do
															local starIcon = cc.Sprite:createWithSpriteFrameName(IconFactory.starImgPath3)

															starIcon:setPosition(startX + (index - 1) * offsetX, 14 + (index - 1) * 1.2)
															starIcon:setTag(index)
															starImg:addChild(starIcon)
														end
													end

													local starImg = rootPanel:getChildByName("StarImg")

													starImg:loadTexture(GameStyle:getHeroQualityRectFile(quality)[5])

													for i = 1, maxStar do
														starImg:getChildByTag(i):setVisible(i <= star)
													end

													if style and style.hideOccu then
														rootPanel:getChildByName("OccupationImg"):setVisible(false)
													end

													if style and style.hideStar then
														rootPanel:getChildByName("StarImg"):setVisible(false)
													end

													if style and style.hideAll then
														rootPanel:getChildByName("OccupationImg"):setVisible(false)
														rootPanel:getChildByName("StarImg"):setVisible(false)
														rootPanel:getChildByName("RarityImg"):setVisible(false)
														rootPanel:getChildByName("CostImg"):setVisible(false)
														rootPanel:getChildByName("CostLabel"):setVisible(false)
														rootPanel:getChildByName("OccupationImg"):setVisible(false)
													end

													if style and style.scale then
														rootPanel:setScale(style.scale)
													end

													return rootPanel
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local kHeroRarityAnim = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"r_yingxiongxuanze",
	"r_yingxiongxuanze",
	"sr_yingxiongxuanze",
	"ssr_yingxiongxuanze",
	"sp_xiao_urequipeff"
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function IconFactory:createHeroLargeIcon(info, style)
	local rootNode = cc.CSLoader:createNode("asset/ui/comHeroIcon.csb")
	local actionNode = rootNode:getChildByFullName("main.actionNode")

	style = style or {}

	local id = info.id
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(id)
	local heroConfig = heroPrototype:getConfig()

	if info.quality then
		if not info.quality then
			local quality = ConfigReader:getRecordById("HeroQuality", heroConfig.BaseQualityAttr).Quality

			if info.star then
				if not info.star then
					local star = heroConfig.BaseStar

					if info.rarity then
						if not info.rarity then
							local rarity = heroConfig.Rareity

							if info.cost then
								if not info.cost then
									local cost = heroConfig.Cost

									if info.type then
										if not info.type then
											local type = heroConfig.Type

											if info.maxStar then
												if not info.maxStar then
													local maxStar = heroConfig.MaxStar

													if info.name then
														if not info.name then
															local name = Strings:get(heroConfig.Name)

															if info.level then
																if not info.level then
																	local level = 0

																	if info.littleStar ~= nil then
																		if not info.littleStar then
																			local littleStar = false

																			if info.qualityLevel then
																				if not info.qualityLevel then
																					local qualityLevel = 0

																					info.id = info.roleModel or IconFactory:getRoleModelByKey("HeroBase", id)

																					local heroPanel = actionNode:getChildByName("hero")
																					local heroImg = IconFactory:createRoleIconSpriteNew({
																						id = info.id
																					})

																					heroPanel:addChild(heroImg)
																					heroImg:setScale(0.68)
																					heroImg:center(heroPanel:getContentSize())

																					local occupationBg = actionNode:getChildByName("occupationBg")
																					local occupation = actionNode:getChildByName("occupation")

																					occupation:ignoreContentAdaptWithSize(true)

																					local raritybg = actionNode:getChildByFullName("rarityBg.rarity")

																					raritybg:ignoreContentAdaptWithSize(true)

																					local levelLabel = actionNode:getChildByName("level")
																					local levelImage = actionNode:getChildByName("levelImage")
																					local starBg = actionNode:getChildByName("starBg")
																					local selectImage = actionNode:getChildByName("selectImage")

																					selectImage:setVisible(false)

																					local bg = actionNode:getChildByName("bg")
																					local bg1 = bg:getChildByName("bg")
																					local bg2 = actionNode:getChildByName("bg1")
																					local namePanel = actionNode:getChildByName("namePanel")
																					local nameLabel = namePanel:getChildByName("name")
																					local qualityLevelLabel = namePanel:getChildByName("qualityLevel")
																					local costLabel = actionNode:getChildByFullName("costBg.cost")

																					costLabel:getParent():setVisible(not style.hideCost)
																					costLabel:setString(cost)

																					local rarityBg = actionNode:getChildByFullName("rarityBg")
																					local nameImage = actionNode:getChildByFullName("image")

																					if style.rarityAnim then
																						rarityBg:removeAllChildren()

																						local rarityAnim = cc.MovieClip:create(kHeroRarityAnim[rarity])

																						rarityAnim:addTo(rarityBg):center(rarityBg:getContentSize())
																						rarityAnim:offset(0, 2)
																						bg2:loadTexture(GameStyle:getHeroRarityBg(rarity)[2])
																						bg:removeAllChildren()
																						bg2:removeAllChildren()

																						if kHeroRarityBgAnim[rarity] then
																							local anim = cc.MovieClip:create(kHeroRarityBgAnim[rarity])

																							anim:addTo(bg):center(bg:getContentSize())

																							if rarity <= 14 then
																								anim:offset(-1, -30)
																							else
																								anim:offset(-3, 0)
																							end

																							if rarity >= 14 then
																								local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

																								anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
																							end
																						else
																							local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(rarity)[1])

																							sprite:addTo(bg):center(bg:getContentSize())
																						end
																					else
																						raritybg:loadTexture(GameStyle:getHeroRarityImage(rarity), 1)
																						bg1:loadTexture(GameStyle:getHeroRarityBg(rarity)[1])
																						bg2:loadTexture(GameStyle:getHeroRarityBg(rarity)[2])
																					end

																					if style.hideAll then
																						local imageNode = actionNode:getChildByName("image")

																						starBg:removeFromParent()
																						starBg:removeFromParent()
																						levelLabel:removeFromParent()
																						levelImage:removeFromParent()
																						occupationBg:removeFromParent()
																						occupation:removeFromParent()
																						imageNode:removeFromParent()
																						namePanel:removeFromParent()
																						actionNode:getChildByFullName("rarityBg"):removeFromParent()
																						actionNode:getChildByFullName("costBg"):removeFromParent()
																					else
																						if style.hideOcc then
																							occupationBg:removeFromParent()
																							occupation:removeFromParent()
																						else
																							local occupationName, occupationImg = GameStyle:getHeroOccupation(type)

																							occupation:loadTexture(occupationImg)
																						end

																						if style.hideName then
																							local imageNode = actionNode:getChildByName("image")

																							namePanel:removeFromParent()
																							imageNode:removeFromParent()
																						else
																							nameLabel:setString(name)

																							if getCurrentLanguage() ~= GameLanguageType.CN then
																								nameLabel:setScale(1.7)
																							end

																							qualityLevelLabel:setString(qualityLevel == 0 and "" or " +" .. qualityLevel)
																							GameStyle:setHeroNameByQuality(nameLabel, quality)
																							GameStyle:setHeroNameByQuality(qualityLevelLabel, quality)
																							nameLabel:disableEffect(1)
																							qualityLevelLabel:disableEffect(1)
																							nameLabel:setPositionX(0)

																							if getCurrentLanguage() ~= GameLanguageType.CN then
																								nameLabel:setPositionX(-40)
																							end

																							nameLabel:setTextAreaSize(cc.size(110, 30))

																							local virtualRenderer = nameLabel:getVirtualRenderer()

																							virtualRenderer:setOverflow(cc.LabelOverflow.NONE)
																							virtualRenderer:setOverflow(cc.LabelOverflow.SHRINK)
																							nameLabel:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
																							nameLabel:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
																							qualityLevelLabel:setPositionX(nameLabel:getContentSize().width * (getCurrentLanguage() ~= GameLanguageType.CN and 1.7 or 1))
																							namePanel:setContentSize(cc.size(nameLabel:getContentSize().width + qualityLevelLabel:getContentSize().width, 30))
																						end

																						if style.hideStar then
																							starBg:removeFromParent()

																							if not style.hideName then
																								namePanel:offset(0, 19)
																								actionNode:getChildByName("image"):offset(0, 17)
																							end
																						else
																							for i = 1, HeroStarCountMax do
																								local _star = starBg:getChildByName("star_" .. i)

																								_star:setVisible(i <= maxStar)

																								local path = i <= star and "img_yinghun_img_star_full.png" or i == star + 1 and littleStar and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

																								if info.awakenLevel and info.awakenLevel > 0 then
																									path = "jx_img_star.png"
																								end

																								if i <= (info.identityAwakenLevel or 0) then
																									path = "yinghun_img_awake_star.png"
																								end

																								_star:setScale(0.55)
																								_star:loadTexture(path, 1)
																							end
																						end

																						if style.hideStarBg then
																							starBg:loadTexture("toumingtu.png", 1)
																						end

																						if style.hideLevel then
																							levelLabel:removeFromParent()
																							levelImage:removeFromParent()
																						else
																							levelLabel:setString(Strings:get("Strenghten_Text78", {
																								level = level
																							}))

																							local levelImageWidth = levelImage:getContentSize().width
																							local levelWidth = levelLabel:getContentSize().width

																							levelImage:setScaleX((levelWidth + 20) / levelImageWidth)
																						end

																						if style.hideRarity then
																							rarityBg:setVisible(false)
																						end

																						if style.hideCost then
																							actionNode:getChildByFullName("costBg"):setVisible(false)
																						end
																					end

																					if info.awakenLevel and info.awakenLevel > 0 then
																						local weak = actionNode:getChildByName("weak")
																						local weakTop = actionNode:getChildByName("weakTop")
																						local anim = cc.MovieClip:create("dikuang_yinghunxuanze")

																						anim:addTo(weak):center(weak:getContentSize())
																						anim:setScale(2)
																						anim:offset(-5, 18)

																						anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

																						anim:addTo(weakTop):center(weakTop:getContentSize())
																						anim:setScale(2)
																						anim:offset(-5, 18)
																					end

																					function rootNode:setBrightType(heroShowType)
																						local brightNess = heroShowType == HeroShowType.kNotOwn and -75 or 0
																						local saturation = heroShowType == HeroShowType.kNotOwn and -80 or 0

																						heroPanel:setBrightness(brightNess)
																						heroPanel:setSaturation(saturation)
																						bg1:setBrightness(brightNess)
																						bg1:setSaturation(saturation)
																						bg2:setBrightness(brightNess)
																						bg2:setSaturation(saturation)
																						actionNode:getChildByFullName("rarityBg"):setBrightness(brightNess)
																						actionNode:getChildByFullName("rarityBg"):setSaturation(saturation)
																						actionNode:getChildByFullName("costBg"):setBrightness(brightNess)
																						actionNode:getChildByFullName("costBg"):setSaturation(saturation)
																						starBg:setBrightness(brightNess)
																						starBg:setSaturation(saturation)
																					end

																					return rootNode
																				end
																			end
																		end
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function IconFactory:createHeroLargeNotRemoveIcon(info, style)
	local rootNode = cc.CSLoader:createNode("asset/ui/comHeroIcon.csb")
	local actionNode = rootNode:getChildByFullName("main.actionNode")

	style = style or {}

	local id = info.id
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(id)
	local heroConfig = heroPrototype:getConfig()

	if info.quality then
		if not info.quality then
			local quality = ConfigReader:getRecordById("HeroQuality", heroConfig.BaseQualityAttr).Quality

			if info.star then
				if not info.star then
					local star = heroConfig.BaseStar

					if info.rarity then
						if not info.rarity then
							local rarity = heroConfig.Rareity

							if info.cost then
								if not info.cost then
									local cost = heroConfig.Cost

									if info.type then
										if not info.type then
											local type = heroConfig.Type

											if info.maxStar then
												if not info.maxStar then
													local maxStar = heroConfig.MaxStar

													if info.name then
														if not info.name then
															local name = Strings:get(heroConfig.Name)

															if info.level then
																if not info.level then
																	local level = 0

																	if info.qualityLevel then
																		if not info.qualityLevel then
																			local qualityLevel = 0

																			info.id = info.roleModel or IconFactory:getRoleModelByKey("HeroBase", id)

																			local heroPanel = actionNode:getChildByName("hero")
																			local heroImg = IconFactory:createRoleIconSpriteNew({
																				id = info.id
																			})

																			heroPanel:addChild(heroImg)
																			heroImg:setScale(0.68)
																			heroImg:center(heroPanel:getContentSize())

																			local occupationBg = actionNode:getChildByName("occupationBg")
																			local occupation = actionNode:getChildByName("occupation")

																			occupation:ignoreContentAdaptWithSize(true)

																			local raritybg = actionNode:getChildByFullName("rarityBg.rarity")

																			raritybg:ignoreContentAdaptWithSize(true)

																			local levelLabel = actionNode:getChildByName("level")
																			local levelImage = actionNode:getChildByName("levelImage")
																			local starBg = actionNode:getChildByName("starBg")
																			local selectImage = actionNode:getChildByName("selectImage")

																			selectImage:setVisible(false)

																			local bg1 = actionNode:getChildByName("bg")
																			local bg2 = actionNode:getChildByName("bg1")
																			local namePanel = actionNode:getChildByName("namePanel")
																			local nameLabel = namePanel:getChildByName("name")
																			local qualityLevelLabel = namePanel:getChildByName("qualityLevel")
																			local costLabel = actionNode:getChildByFullName("costBg.cost")

																			costLabel:getParent():setVisible(not style.hideCost)
																			costLabel:setString(cost)
																			raritybg:loadTexture(GameStyle:getHeroRarityImage(rarity), 1)
																			bg1:loadTexture(GameStyle:getHeroRarityBg(rarity)[1])
																			bg2:loadTexture(GameStyle:getHeroRarityBg(rarity)[2])

																			local weak = actionNode:getChildByName("weak")
																			local weakTop = actionNode:getChildByName("weak")

																			weak:removeAllChildren()
																			weakTop:removeAllChildren()

																			if info and info.awakenLevel and info.awakenLevel > 0 then
																				local anim = cc.MovieClip:create("dikuang_yinghunxuanze")

																				anim:addTo(weak):center(weak:getContentSize())
																				anim:setScale(2)
																				anim:offset(-5, 18)

																				anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

																				anim:addTo(weakTop):center(weakTop:getContentSize())
																				anim:setScale(2)
																				anim:offset(-5, 18)
																			end

																			if style.hideAll then
																				starBg:setVisible(false)
																				levelLabel:setVisible(false)
																				levelImage:setVisible(false)
																				occupation:setVisible(false)

																				local imageNode = actionNode:getChildByName("image")

																				imageNode:setVisible(false)
																				namePanel:setVisible(false)
																				actionNode:getChildByFullName("rarityBg"):setVisible(false)
																				actionNode:getChildByFullName("costBg"):setVisible(false)
																			else
																				if style.hideOcc then
																					occupation:setVisible(false)
																					occupationBg:setVisible(false)
																				else
																					local occupationName, occupationImg = GameStyle:getHeroOccupation(type)

																					occupation:loadTexture(occupationImg)
																				end

																				if style.hideName then
																					nameLabel:setVisible(false)
																					qualityLevelLabel:setVisible(false)

																					local imageNode = actionNode:getChildByName("image")

																					imageNode:setVisible(false)
																				else
																					nameLabel:setString(name)
																					qualityLevelLabel:setString(qualityLevel == 0 and "" or " +" .. qualityLevel)
																					GameStyle:setHeroNameByQuality(nameLabel, quality)
																					GameStyle:setHeroNameByQuality(qualityLevelLabel, quality)
																					nameLabel:disableEffect(1)
																					qualityLevelLabel:disableEffect(1)
																					nameLabel:setPositionX(0)
																					qualityLevelLabel:setPositionX(nameLabel:getContentSize().width)
																					namePanel:setContentSize(cc.size(nameLabel:getContentSize().width + qualityLevelLabel:getContentSize().width, 30))
																				end

																				if style.hideStar then
																					starBg:setVisible(false)
																				else
																					for i = 1, HeroStarCountMax do
																						local _star = starBg:getChildByName("star_" .. i)

																						_star:setVisible(i <= maxStar)

																						local starImage = i <= star and "asset/common/common_icon_small01.png" or "asset/common/common_icon_small02.png"

																						_star:loadTexture(starImage)
																					end
																				end

																				if style.hideLevel then
																					levelLabel:setVisible(false)
																					levelImage:setVisible(false)
																				else
																					levelLabel:setString(Strings:get("Strenghten_Text78", {
																						level = level
																					}))

																					local levelImageWidth = levelImage:getContentSize().width
																					local levelWidth = levelLabel:getContentSize().width

																					levelImage:setScaleX((levelWidth + 20) / levelImageWidth)
																				end
																			end

																			function rootNode:setBrightType(heroShowType)
																				local brightNess = heroShowType == HeroShowType.kNotOwn and -75 or 0
																				local saturation = heroShowType == HeroShowType.kNotOwn and -80 or 0

																				heroPanel:setBrightness(brightNess)
																				heroPanel:setSaturation(saturation)
																				bg1:setBrightness(brightNess)
																				bg1:setSaturation(saturation)
																				bg2:setBrightness(brightNess)
																				bg2:setSaturation(saturation)
																				actionNode:getChildByFullName("rarityBg"):setBrightness(brightNess)
																				actionNode:getChildByFullName("rarityBg"):setSaturation(saturation)
																				actionNode:getChildByFullName("costBg"):setBrightness(brightNess)
																				actionNode:getChildByFullName("costBg"):setSaturation(saturation)
																				starBg:setBrightness(brightNess)
																				starBg:setSaturation(saturation)
																			end

																			return rootNode
																		end
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function IconFactory:createSurfaceIcon(info, style)
	style = style or {}

	local itemId = info.id
	local config = ConfigReader:getRecordById("Surface", itemId) or {}

	if not config.Quality then
		local quality = 1

		info.clipIndex = info.clipIndex or 1
		info.stencilSize = info.stencilSize or cc.size(105, 105)

		if style and style.rectType then
			if not style.rectType then
				local quaImgType = 1
				local qualityImg = GameStyle:getItemQuaRectFile(quality, quaImgType)
				local quaRectImg = IconFactory:createSprite(qualityImg)

				if quaImgType == 2 then
					quaRectImg:setScale(1.2)
				end

				local size = cc.size(110, 110)
				local node = self:createBaseNode(style and style.isWidget)

				node:setContentSize(size)

				if not style.notShowQulity == true then
					IconFactory:centerAddNode(node, quaRectImg)
				end

				local itemImg = self:createRoleIconSpriteNew({
					id = config.Model
				})

				itemImg:setScale((style and style.ignoreScaleSize or nil) and 1)

				local nodeTemp = ccui.Widget:create()

				nodeTemp:setContentSize(cc.size(itemImg:getContentSize().width, itemImg:getContentSize().height))
				nodeTemp:setAnchorPoint(cc.p(0.5, 0.5))
				itemImg:addTo(nodeTemp):center(nodeTemp:getContentSize())

				itemImg = nodeTemp

				if info.scaleRatio then
					itemImg:setScale(info.scaleRatio)
				end

				itemImg = self:addStencilForIcon(itemImg, info.clipIndex, info.stencilSize, info.offset)

				IconFactory:centerAddNode(node, itemImg)

				local markImg = ccui.ImageView:create("asset/common/pf_bg_sz.png")

				markImg:setRotation(30)
				markImg:setPosition(node:getContentSize().width - 20, node:getContentSize().height - 20)
				node:addChild(markImg)

				local label = cc.Label:createWithTTF("", "asset/font/CustomFont_FZYH_R.TTF", 18)

				label:setString(Strings:get("Surface_ShowTip"))
				label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
				label:setOverflow(cc.LabelOverflow.SHRINK)
				label:setDimensions(50, 27)
				label:addTo(markImg):center(markImg:getContentSize()):offset(0, 3)

				return node
			end
		end
	end
end

function IconFactory:createHeroIconForReward(info, style)
	local newInfo = {}

	table.deepcopy(info, newInfo)

	style = style or {}

	if newInfo.id then
		if not newInfo.id then
			local id = 100001
			local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(id)
			local heroConfig = heroPrototype:getConfig()

			if newInfo.star then
				if not newInfo.star then
					local star = heroConfig.BaseStar
					local qualityImg = GameStyle:getItemQuaRectFile((heroConfig.Rareity == 15 or nil) and 7, 1)
					local quaRectImg = IconFactory:createSprite(qualityImg)
					local colorRectSize = cc.size(110, 110)
					local node = self:createBaseNode(style and style.isWidget)

					node:setContentSize(cc.size(colorRectSize.width, colorRectSize.height))

					if not style.notShowQulity == true then
						IconFactory:centerAddNode(node, quaRectImg)
					end

					function node:getId()
						return id
					end

					newInfo.id = IconFactory:getRoleModelByKey("HeroBase", id)

					local heroImg = self:createRoleIconSpriteNew(newInfo)

					heroImg:setScale(0.55)

					local offset = {
						0,
						0
					}

					heroImg = self:addStencilForIcon(heroImg, newInfo.clipType or 1, newInfo.size or cc.size(105, 105), offset)

					local kHeroImgTag = 65572

					heroImg:setTag(kHeroImgTag)
					IconFactory:centerAddNode(node, heroImg)

					local starNode = cc.Node:create()

					starNode:setPosition(0, 0)
					starNode:addTo(node)

					for index = 1, star do
						local starImg = ccui.ImageView:create("img_yinghun_img_star_full.png", 1)

						starImg:setScale(0.4)
						starImg:setAnchorPoint(0, 0)
						starImg:setPosition(-1 + 20 * (index - 1), -5)
						starNode:addChild(starImg)
					end

					return node
				end
			end
		end
	end
end

function IconFactory:createEquipPic(info, style)
	assert(info and info.id, "Bad argument")

	local config = ConfigReader:getRecordById("HeroEquipBase", info.id)
	local icon

	if config then
		local iconName = config.Icon
		local path = "asset/items/" .. iconName .. ".png"

		icon = cc.Sprite:create(path)

		local size = icon:getContentSize()

		if size.width > 200 then
			icon:setScale(0.42)
		end
	else
		icon = cc.Sprite:create()
	end

	return icon
end

local HeroEquipExp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExp", "content")
local HeroEquipStar = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStar", "content")

function IconFactory:createRewardEquipIcon(info, style)
	if info.showEquipAmount then
		if not info.showEquipAmount then
			local showEquipAmount = false
			local amount = info.amount

			if not info.rarity then
				local rarity = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", info.id, "Rareity")
				local star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStar[tostring(rarity)], "StarLevel")
				local level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExp[tostring(rarity)], "ShowLevel")
				local starId = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", info.id, "StartEquipStarID")

				info = {
					id = info.id,
					rarity = rarity,
					level = level,
					star = (starId or nil) and ConfigReader:getDataByNameIdAndKey("HeroEquipStar", starId, "StarLevel")
				}

				if showEquipAmount then
					info.amount = amount
				end
			end

			return IconFactory:createEquipIcon(info, style)
		end
	end
end

function IconFactory:createEquipIcon(info, style)
	style = style or {}

	local id = info.id

	if info.level then
		if not info.level then
			local lvl = 1

			if info.star then
				if not info.star then
					local star = 1

					if info.rarity then
						if not info.rarity then
							local rarity = 11

							if not info.lock then
								local lock = false

								if info.amount then
									if not info.amount then
										local amount = 0
										local size = cc.size(110, 110)

										if style.showAllSprite == true then
											size = cc.size(200, 200)
										end

										local node = self:createBaseNode(style and style.isWidget)

										node:setContentSize(size)

										local bgFile = GameStyle:getEquipRarityRectFile(rarity)
										local bgImage = IconFactory:createSprite(bgFile)
										local bgAnim

										if not style.notShowQulity == true then
											IconFactory:centerAddNode(node, bgImage)

											if rarity >= 15 then
												local flashFile = GameStyle:getEquipRarityRectFlashFile(rarity)
												local bgAnim = cc.MovieClip:create(flashFile)

												IconFactory:positionAddNode(node, bgAnim, cc.p(size.width / 2, size.height / 2))
											end
										end

										local equipImg = self:createEquipPic(info)
										local scale = equipImg:getScale()
										local contentScale = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", id, "zoom") or 1

										equipImg:setScale(contentScale * scale)
										equipImg:setAnchorPoint(cc.p(0.5, 0.5))
										equipImg:setIgnoreAnchorPointForPosition(false)
										IconFactory:centerAddNode(node, equipImg)

										local kLevelTag = "LevelLabel"

										function node:setLevel(lvl)
											local lvLabel = self:getChildByName(kLevelTag)

											if not lvLabel then
												local amountBg = cc.Sprite:create("asset/common/common_icon_sld.png")

												amountBg:setAnchorPoint(cc.p(1, 1))
												amountBg:setPosition(cc.p(size.width + 1, size.height))
												amountBg:addTo(self)
												amountBg:setName("AmountBg")

												lvLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 20)

												lvLabel:enableOutline(cc.c4b(35, 15, 5, 255), 1)
												lvLabel:setAnchorPoint(cc.p(1, 1))
												lvLabel:setPosition(cc.p(size.width - 6, size.height))
												node:addChild(lvLabel)
												lvLabel:setName("kLevelTag")
											end

											lvLabel:setString(Strings:get("Strenghten_Text78", {
												level = lvl
											}))

											local amountBg = self:getChildByName("AmountBg")
											local width = amountBg:getContentSize().width
											local scaleX = (lvLabel:getContentSize().width + 16) / width

											amountBg:setScaleX(scaleX)
										end

										function node:getLevelLabel()
											return self:getChildByName(kLevelTag)
										end

										local kStarTag = "StarImage"

										function node:setStar(star)
											local starNode = self:getChildByName(kStarTag)

											if not starNode then
												starNode = ccui.Widget:create()

												starNode:addTo(self)
												starNode:setAnchorPoint(cc.p(0.5, 0))
												starNode:setPosition(cc.p(size.width / 2, 2))
												starNode:setScale(0.61)
											end

											starNode:removeAllChildren()

											local index = 0
											local posXOffset

											for i = 1, 5 do
												if star - i >= 5 then
													index = index + 1

													local image = ccui.ImageView:create("asset/common/yinghun_img_star_color.png")

													image:addTo(starNode)
													image:setPosition(cc.p(13 + 32 * (index - 1), 19.5))
												elseif star - i >= 0 then
													posXOffset = posXOffset or index == 0 and 17 or 13
													index = index + 1

													local image = ccui.ImageView:create("img_yinghun_img_star_full.png", 1)

													image:addTo(starNode):setScale(0.625)
													image:setPosition(cc.p(posXOffset + 34 * (index - 1), 21.5))
												end
											end

											starNode:setContentSize(cc.size(34 * index, 43))
										end

										local kRarityName = "RarityImage"

										function node:setRarity(rarity)
											if rarity >= 15 then
												local flashFile = GameStyle:getEquipRarityFlash(rarity)
												local anim = cc.MovieClip:create(flashFile)

												anim:addTo(node):posite(16, size.height - 14)
											else
												local imageFile = GameStyle:getEquipRarityImage(rarity)
												local rarityImage = self:getChildByName(kRarityName)

												if not rarityImage then
													rarityImage = ccui.ImageView:create(imageFile)

													rarityImage:addTo(node)
													rarityImage:setName(kRarityName)
													rarityImage:setAnchorPoint(cc.p(0, 1))
													rarityImage:setPosition(cc.p(-12, size.height + 14))
													rarityImage:setScale(0.7)
													rarityImage:ignoreContentAdaptWithSize(true)
												end

												rarityImage:loadTexture(imageFile)
											end
										end

										local kLockName = "LockImage"

										function node:setLock(lock)
											local lockImage = self:getChildByName(kLockName)

											if not lockImage then
												lockImage = ccui.ImageView:create("yinghun_img_lock.png", ccui.TextureResType.plistType)

												lockImage:addTo(node)
												lockImage:setName(kLockName)
												lockImage:setAnchorPoint(cc.p(0, 0))
												lockImage:setPosition(cc.p(3, 24))
												lockImage:setScale(0.9)
											end

											lockImage:setVisible(lock)
										end

										local kAmountTag = 65536
										local mySelf = self

										function node:setAmount(amount)
											if style and style.showAmount == false then
												return
											end

											if type(amount) == "number" and amount <= 0 then
												return
											end

											amount = amount or ""

											local label = self:getChildByTag(kAmountTag)

											if not label then
												local amountBg = cc.Sprite:create("asset/common/common_icon_sld.png")

												amountBg:setAnchorPoint(cc.p(1, 0))
												amountBg:addTo(self):posite(109, -5)
												amountBg:setName("AmountBg")

												label = mySelf:_createAmountLabel(info, nil, self)

												label:setTag(kAmountTag)
												label:setAnchorPoint(1, 0.5)
												label:setPosition(cc.p(100, 15))
											end

											if type(amount) == "number" and amount > 99999 then
												local str = Strings:get("Common_Time_01")
												local amountTemp = amount / 10000

												label:setString(math.floor(amountTemp) .. str)
											else
												label:setString(amount)
											end

											local amountBg = self:getChildByName("AmountBg")
											local width = amountBg:getContentSize().width
											local scaleX = (label:getContentSize().width + 16) / width

											amountBg:setScaleX(scaleX)
											amountBg:setVisible(amount ~= "" and tonumber(amount) > 0)
										end

										function node:adjustAmountBg()
											if style and style.showAmount == false then
												return
											end

											local label = self:getChildByTag(kAmountTag)
											local amountBg = self:getChildByName("AmountBg")

											if not label or not amountBg then
												return
											end

											local width = amountBg:getContentSize().width
											local scaleX = (label:getContentSize().width + 16) / width

											amountBg:setScaleX(scaleX)
										end

										function node:getAmountLabel()
											return self:getChildByTag(kAmountTag)
										end

										if not style or not style.hideLevel then
											node:setLevel(lvl)
										end

										if not style or not style.hideStar then
											node:setStar(star)
										end

										node:setRarity(rarity)
										node:setLock(lock)
										node:setAmount(amount)

										return node
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function IconFactory:createBuffIcon(info, style)
	style = style or {}

	if info.id then
		local id = info.id
		local skillConfig = ConfigReader:getRecordById("Skill", tostring(id))
		local isLock = info.isLock
		local isGray = info.isGray
		local node = self:createBaseNode(style and style.isWidget)
		local bottomImg = ccui.ImageView:create("yh_bg_jnk_new.png", 1)
		local size = bottomImg:getContentSize()

		node:setContentSize(cc.size(size.width, size.width))
		IconFactory:centerAddNode(node, bottomImg)

		if style.hideBg then
			bottomImg:setVisible(false)
		end

		local kSkillTag = 65539
		local skillImg = IconFactory:createSkillPic({
			id = skillConfig.Icon
		})

		IconFactory:centerAddNode(node, skillImg)
		skillImg:setScale(0.64)
		skillImg:offset(-1.8, 2)
		skillImg:setTag(kSkillTag)

		local kLevelTag, kLockTag = 65536, 65537

		function node:setNodeGary(isGary)
			return
		end

		function node:setLock(isLock)
			local lockImg = self:getChildByTag(kLockTag)

			if not lockImg then
				lockImg = ccui.ImageView:create("mjt_img_lock.png", 1)

				lockImg:setScale(0.8)
				lockImg:addTo(node):center(node:getContentSize()):offset(-3, 0)
			end

			lockImg:setVisible(isLock)

			local skillImage = self:getChildByTag(kSkillTag)

			if skillImage then
				skillImage:setGray(isGray)
			end
		end

		node:setLock(isLock)
		node:setScale(style.scale or 1)

		return node
	end
end

local kEquipTypeToImage = {
	[HeroEquipType.kWeapon] = "yinghun_wuqi.png",
	[HeroEquipType.kDecoration] = "yinghun_peishi.png",
	[HeroEquipType.kTops] = "yinghun_yifu.png",
	[HeroEquipType.kShoes] = "yinghun_xie.png"
}

function IconFactory:createEquipEmpty(type)
	local node = self:createBaseNode()
	local imageBg = ccui.ImageView:create("asset/itemRect/common_pz_bai.png")

	imageBg:addTo(node):setScale(0.6)

	if not kEquipTypeToImage[type] then
		local imageFile = kEquipTypeToImage[HeroEquipType.kWeapon]
		local image = ccui.ImageView:create(imageFile, 1)

		image:addTo(node)

		return node
	end
end

function IconFactory:createHeroSkillIcon(info, style)
	if info.id then
		local id = info.id
		local skillConfig = ConfigReader:getRecordById("Skill", tostring(id))
		local isLock = info.isLock

		if info.level then
			if not info.level then
				local level = 1
				local node = self:createBaseNode(style and style.isWidget)
				local bottomImg = ccui.ImageView:create("yh_bg_jnk_new.png", 1)
				local size = bottomImg:getContentSize()

				node:setContentSize(cc.size(size.width, size.width))
				IconFactory:centerAddNode(node, bottomImg)

				if info.hideBg then
					bottomImg:setVisible(false)
				end

				local kSkillTag = 65539
				local skillImg = IconFactory:createSkillPic({
					id = skillConfig.Icon
				})

				IconFactory:centerAddNode(node, skillImg)
				skillImg:setScale(0.64)
				skillImg:offset(-1.8, 2)
				skillImg:setTag(kSkillTag)

				local kLevelTag, kLockTag = 65536, 65537

				function node:getLevelLabel(lvl)
					return
				end

				function node:setNodeGary(isGary)
					return
				end

				function node:setLevel(lvl)
					local lvLabel = self:getChildByTag(kLevelTag)

					if not lvLabel then
						local image = ccui.ImageView:create("asset/common/common_bd_sx.png")

						image:setAnchorPoint(cc.p(1, 0))
						image:addTo(node):posite(96, -12)
						image:setName("LevelBg")
						image:setScaleY(0.6)

						lvLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

						lvLabel:enableOutline(cc.c4b(0, 0, 0, 255), 2)
						node:addChild(lvLabel, 1, kLevelTag)
						lvLabel:setAnchorPoint(cc.p(1, 1))
						lvLabel:setPosition(cc.p(90, 25))
					end

					local levelBg = node:getChildByFullName("LevelBg")

					lvl = lvl or ""

					if lvLabel and lvl then
						lvLabel:setString("Lv." .. lvl)
						levelBg:setScaleX((lvLabel:getContentSize().width + 13) / levelBg:getContentSize().width)
					end

					lvLabel:setVisible(not style or not style.hideLevel)
					levelBg:setVisible(not style or not style.hideLevel)
				end

				function node:setLock(isLock)
					local lockImg = self:getChildByTag(kLockTag)

					if not lockImg then
						lockImg = ccui.ImageView:create("yh_bg_fengyin.png", 1)

						lockImg:setPosition(54, 54)
						node:addChild(lockImg, 1, kLockTag)
						lockImg:removeAllChildren()

						local lvLabel = cc.Label:createWithTTF("", CUSTOM_TTF_FONT_1, 24)

						lvLabel:setString(Strings:get("HEROS_UI3"))
						lvLabel:setColor(cc.c3b(80, 50, 20))
						lvLabel:setRotation(-7)
						lvLabel:addTo(lockImg)
						lvLabel:setPosition(cc.p(50, 28))
					end

					lockImg:setVisible(isLock)

					local skillImage = self:getChildByTag(kSkillTag)

					if skillImage then
						skillImage:setGray(isLock)
					end
				end

				if not info.levelHide then
					node:setLevel(level)
				end

				node:setLock(isLock)

				return node
			end
		end
	end
end

local Box_Rarity = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Box_Rarity", "content")

function IconFactory:createItemIcon(info, style)
	style = style or {}

	if not info.id then
		local itemId = info.itemId
		local config = ConfigReader:getRecordById("ItemConfig", tostring(itemId)) or {}

		if not config.Quality then
			local quality = 1
			local amount = info.amount

			info.clipIndex = info.clipIndex or 1
			info.stencilSize = info.stencilSize or cc.size(105, 105)

			if not info.lock then
				local isLock = false
				local useNoEnough = true

				if info.useNoEnough ~= nil then
					useNoEnough = info.useNoEnough
				end

				if style and style.rectType then
					if not style.rectType then
						local quaImgType = 1
						local qualityImg = GameStyle:getItemQuaRectFile(quality, quaImgType)
						local quaRectImg = IconFactory:createSprite(qualityImg)

						if quaImgType == 2 then
							quaRectImg:setScale(1.2)
						end

						local size = cc.size(110, 110)
						local node = self:createBaseNode(style and style.isWidget)

						node:setContentSize(size)

						if not style.notShowQulity == true then
							IconFactory:centerAddNode(node, quaRectImg)
						end

						local itemImg, debrisIcon = self:createItemPic(info)

						itemImg = self:addStencilForIcon(itemImg, info.clipIndex, info.stencilSize, info.offset)

						IconFactory:centerAddNode(node, itemImg)

						if style and style.color then
							itemImg:setColor(style.color)
						end

						if debrisIcon then
							debrisIcon:setAnchorPoint(0, 0)
							debrisIcon:setPosition(node:getContentSize().width * 0.1, node:getContentSize().height * 0.06)
							node:addChild(debrisIcon, 999)
							debrisIcon:setName("debrisIcon")
						end

						local kAmountTag = 65536
						local mySelf = self

						function node:setNotEngouhState(notEngouh)
							if not style.notGray then
								local opacityNum = notEngouh and 122 or 255

								itemImg:setOpacity(opacityNum)
								itemImg:setGray(notEngouh)
								quaRectImg:setGray(notEngouh)
							end
						end

						local kLockName = "LockImage"

						function node:setLock(lock)
							local lockImage = self:getChildByName(kLockName)

							if not lockImage then
								lockImage = ccui.ImageView:create("yinghun_img_lock.png", ccui.TextureResType.plistType)

								lockImage:addTo(node)
								lockImage:setName(kLockName)
								lockImage:setAnchorPoint(cc.p(0, 0))
								lockImage:setPosition(cc.p(3, 24))
								lockImage:setScale(0.9)
							end

							lockImage:setVisible(lock)
						end

						function node:setAmount(amount, effect)
							if style and style.showAmount == false then
								return
							end

							amount = amount or ""

							local label = self:getChildByTag(kAmountTag)

							if not label then
								local amountBg = cc.Sprite:create("asset/common/common_icon_sld.png")

								amountBg:setAnchorPoint(cc.p(1, 0))
								amountBg:addTo(self):posite(109, -5)
								amountBg:setName("AmountBg")

								label = mySelf:_createAmountLabel(info, nil, self)

								label:setTag(kAmountTag)
								label:setAnchorPoint(1, 0.5)
								label:setPosition(cc.p(100, 15))
							end

							if type(amount) == "number" and amount > 99999 then
								local str = Strings:get("Common_Time_01")
								local amountTemp = amount / 10000

								label:setString(math.floor(amountTemp) .. str)
							else
								label:setString(amount)
							end

							local amountBg = self:getChildByName("AmountBg")
							local width = amountBg:getContentSize().width
							local scaleX = (label:getContentSize().width + 16) / width

							amountBg:setScaleX(scaleX)

							if type(amount) == "number" then
								if useNoEnough then
									amountBg:setVisible(tonumber(amount) > 0)
								end
							else
								amountBg:setVisible(amount ~= "")
							end

							if effect then
								if effect.color then
									label:setTextColor(effect.color)
								end

								if effect.outline then
									label:disableEffect(1)
									label:enableOutline(effect.outline, 1)
								end
							elseif type(amount) == "number" then
								if useNoEnough then
									label:setVisible(tonumber(amount) > 0)
								elseif tonumber(amount) == 0 then
									label:setColor(cc.c3b(220, 0, 0))
								else
									label:setColor(cc.c3b(255, 255, 255))
								end
							else
								label:setVisible(amount ~= "")
							end

							if useNoEnough then
								self:setNotEngouhState(amount == 0)
							end
						end

						function node:adjustAmountBg()
							if style and style.showAmount == false then
								return
							end

							local label = self:getChildByTag(kAmountTag)
							local amountBg = self:getChildByName("AmountBg")

							if not label or not amountBg then
								return
							end

							local width = amountBg:getContentSize().width
							local scaleX = (label:getContentSize().width + 16) / width

							amountBg:setScaleX(scaleX)
						end

						function node:getAmountLabel()
							return self:getChildByTag(kAmountTag)
						end

						node:setAmount(amount)

						if style and style.shine then
							IconFactory:_createShineAnim(nil, nil, node)
						end

						local kRarityName = "RarityImage"

						function node:setRarity(rarity)
							if rarity >= 15 then
								local flashFile = GameStyle:getEquipRarityFlash(rarity)
								local anim = cc.MovieClip:create(flashFile)

								anim:addTo(node):posite(16, size.height - 14)
							else
								local imageFile = GameStyle:getEquipRarityImage(rarity)
								local rarityImage = self:getChildByName(kRarityName)

								if not rarityImage then
									rarityImage = ccui.ImageView:create(imageFile)

									rarityImage:addTo(node)
									rarityImage:setName(kRarityName)
									rarityImage:setAnchorPoint(cc.p(0, 1))
									rarityImage:setPosition(cc.p(-10, size.height + 10))
									rarityImage:setScale(0.7)
									rarityImage:ignoreContentAdaptWithSize(true)
								end

								rarityImage:loadTexture(imageFile)
							end
						end

						if table.indexof(Box_Rarity, itemId) or ItemTypes.K_EQUIP_EXP == config.Type or ItemTypes.K_EQUIP_STAREXP == config.Type or ItemTypes.K_EQUIP_STARITEM == config.Type then
							info.rarity = quality + 9
						end

						if info.rarity then
							node:setRarity(info.rarity)
						end

						if style and style.showLock then
							node:setLock(isLock)
						end

						return node
					end
				end
			end
		end
	end
end

function IconFactory:createEatItemIcon(info, style)
	style = style or {}

	if not info.id then
		info.clipIndex = info.clipIndex or 1

		local amount = info.amount
		local quaRectImg = ccui.ImageView:create("asset/common/yinghun_itemname2.png")

		quaRectImg:setScale(0.84)

		local node = self:createBaseNode(style and style.isWidget)

		node:setContentSize(cc.size(90, 90))
		quaRectImg:offset(0, -10)

		if not style.notShowQulity == true then
			IconFactory:centerAddNode(node, quaRectImg)
		end

		local itemImg, debrisIcon = self:createItemPic(info)

		IconFactory:centerAddNode(node, itemImg)

		if debrisIcon then
			debrisIcon:setPosition(debrisIcon:getContentSize().width, debrisIcon:getContentSize().height)
			node:addChild(debrisIcon, 999)
		end

		local kAmountTag = 65536
		local kImageTag = 65537
		local mySelf = self

		function node:setNotEngouhState(notEngouh)
			local opacityNum = notEngouh and 122 or 255

			itemImg:setOpacity(opacityNum)
			itemImg:setGray(notEngouh)
			quaRectImg:setGray(notEngouh)
		end

		function node:setAmount(amount)
			if style and style.showAmount == false then
				return
			end

			amount = amount or ""

			local image = self:getChildByTag(kImageTag)

			if not image then
				image = ccui.Scale9Sprite:createWithSpriteFrameName("yinghun_amount.png", cc.rect(9, 9, 7, 7))

				image:setAnchorPoint(cc.p(1, 0))
				image:addTo(self)
				image:setPosition(cc.p(106, 5))
				image:setTag(kImageTag)
			end

			local label = self:getChildByTag(kAmountTag)

			if not label then
				label = mySelf:_createAmountLabel(info, {
					fontSize = 18,
					font = TTF_FONT_FZYH_M
				}, self)

				label:offset(15, 3)
				label:setTextColor(cc.c3b(255, 255, 255))
				label:setTag(kAmountTag)
				label:disableEffect(1)
			end

			label:setLocalZOrder(10)
			label:setString(amount)
			image:setContentSize(cc.size(label:getContentSize().width + 15, 20))
			self:setNotEngouhState(amount == 0)
		end

		node:setAmount(amount)

		return node
	end
end

function IconFactory:createResourceIcon(info, style)
	assert(info ~= nil, "Bad argument")

	local config = ConfigReader:getRecordById("ResourcesIcon", tostring(info.id))

	style = style or {}

	if config ~= nil then
		local index, iconNode

		if info.amount then
			for i, num in ipairs(config.Segmentation) do
				if num > info.amount then
					index = i - 1

					break
				end
			end

			index = index ~= nil and math.max(index, 1) or math.min(#config.Segmentation, #config.LargeIcons)

			local iconName = config.LargeIcons[index]

			iconNode = ccui.ImageView:create(iconName .. ".png", 1)
		else
			index = 1
			iconNode = ccui.ImageView:create(config.Licon .. ".png", 1)
		end

		if iconNode == nil then
			iconNode = self:createSprite(GameStyle:getDefaultUnfoundFile())
		end

		iconNode:setScale(0.6)

		local node = ccui.Widget:create()

		node:setContentSize(cc.size(iconNode:getContentSize().width, iconNode:getContentSize().height))
		node:setAnchorPoint(cc.p(0.5, 0.5))
		iconNode:addTo(node):center(node:getContentSize())

		iconNode = node

		if info.scaleRatio then
			iconNode:setScale(info.scaleRatio)
		else
			iconNode:setScale(1)
		end

		if not info.quality then
			local quality = RewardSystem:getQuality(info)

			if style and style.rectType then
				if not style.rectType then
					local quaImgType = 1
					local qualityImg1 = GameStyle:getItemQuaRectFile(quality, quaImgType)
					local quaRectImg = IconFactory:createSprite(qualityImg1)

					if quaImgType == 2 then
						quaRectImg:setScale(1.2)
					end

					local size = cc.size(110, 110)
					local node = self:createBaseNode(style and style.isWidget)

					node:setContentSize(size)

					if not style.notShowQulity == true then
						IconFactory:centerAddNode(node, quaRectImg)
					end

					IconFactory:centerAddNode(node, iconNode)

					local kAmountTag = 65536
					local mySelf = self

					function node:setAmount(amount)
						if style and style.showAmount == false then
							return
						end

						amount = amount or ""

						local label = self:getChildByTag(kAmountTag)

						if not label then
							local amountBg = cc.Sprite:create("asset/common/common_icon_sld.png")

							amountBg:setAnchorPoint(cc.p(1, 0))
							amountBg:addTo(self):posite(109, -5)
							amountBg:setName("AmountBg")

							label = mySelf:_createAmountLabel(info, nil, self)

							label:setTag(kAmountTag)
							label:setAnchorPoint(1, 0.5)
							label:setPosition(cc.p(100, 15))
						end

						if type(amount) == "number" and amount > 99999 then
							local str = Strings:get("Common_Time_01")
							local amountTemp = amount / 10000

							label:setString(math.floor(amountTemp) .. str)
						else
							label:setString(amount)
						end

						local amountBg = self:getChildByName("AmountBg")
						local width = amountBg:getContentSize().width
						local scaleX = (label:getContentSize().width + 16) / width

						amountBg:setScaleX(scaleX)
						amountBg:setVisible(amount ~= "" and tonumber(amount) > 0)
					end

					function node:adjustAmountBg()
						if style and style.showAmount == false then
							return
						end

						local label = self:getChildByTag(kAmountTag)
						local amountBg = self:getChildByName("AmountBg")

						if not label or not amountBg then
							return
						end

						local width = amountBg:getContentSize().width
						local scaleX = (label:getContentSize().width + 16) / width

						amountBg:setScaleX(scaleX)
					end

					function node:getAmountLabel()
						return self:getChildByTag(kAmountTag)
					end

					node:setAmount(info.amount)

					if style and style.shine then
						IconFactory:_createShineAnim(nil, nil, node)
					end

					return node
				end
			end
		end
	end
end

function IconFactory:createMasterEmblemIcon(info, style)
	local config = ConfigReader:getRecordById("MasterEmblemBase", tostring(info.id)) or {}

	if not info.quality then
		local quality = 1
		local quaRectImg = IconFactory:createSprite(GameStyle:getEmblemQuaRectFile(quality))
		local colorRectSize = quaRectImg:getContentSize()
		local bottomFile = GameStyle:getEmblemBottomFile(quality)
		local bottomImg = IconFactory:createSprite(bottomFile)
		local node = self:createBaseNode(style and style.isWidget)

		node:setContentSize(quaRectImg:getContentSize())
		IconFactory:centerAddNode(node, bottomImg)

		if not style.notShowQulity == true then
			IconFactory:centerAddNode(node, quaRectImg)
		end

		node:setScale(0.89)

		local path = IconFactory.MasterEmblemPath .. config.ResourcesIcon .. ".png"
		local icon = cc.Sprite:create(path)

		IconFactory:centerAddNode(node, icon)

		if itemImg ~= nil then
			-- block empty
		end

		return node
	end
end

function IconFactory:createPic(info, style)
	assert(info ~= nil and info.id ~= nil, "Bad argument")

	local id = tostring(info.id)

	if info.id == IconFactory.kRMBDefaultFile then
		local icon = cc.Sprite:createWithSpriteFrameName(IconFactory.kRMBDefaultFile)

		icon:setScale(0.26)

		return icon
	end

	local config = ConfigReader:getRecordById("ResourcesIcon", id)

	if config and config.Id then
		return (IconFactory:createResourcePic(info, style))
	end

	config = ConfigReader:getRecordById("ItemConfig", id)

	if config and config.Id then
		return IconFactory:createItemPic(info, style)
	end

	config = ConfigReader:getRecordById("HeroEquipBase", id)

	if config and config.Id then
		return IconFactory:createEquipPic(info, style)
	end

	config = ConfigReader:getRecordById("Skill", id)

	if config and config.Id then
		return IconFactory:createSkillPic(info, style)
	end

	config = ConfigReader:getRecordById("PlayerHeadFrame", id)

	if config and config.Id then
		return IconFactory:createHeadFramePic(info, style)
	end

	config = ConfigReader:getRecordById("ChatBubble", id)

	if config and config.Id then
		return IconFactory:createChatBubblePic(info, style)
	end

	return self:createSprite(GameStyle:getDefaultUnfoundFile())
end

function IconFactory:createItemPic(info, style)
	assert(info and info.id, "Bad argument")

	local config = ConfigReader:getRecordById("ItemConfig", tostring(info.id))
	local path = "asset/items/" .. config.Icon .. ".png"
	local icon = self:createSprite()

	info.offset = info.offset or {
		0,
		0
	}

	if config.Type == ItemTypes.K_HERO_F or config.Type == ItemTypes.K_MASTER_F then
		local tableName = config.Type == ItemTypes.K_HERO_F and "HeroBase" or "MasterBase"
		local roleModel = self:getRoleModelByKey(tableName, config.TargetId.id)

		icon = self:createRoleIconSpriteNew({
			id = roleModel
		})
	elseif config.Icon ~= "" then
		icon = self:createSprite(path)

		if icon == nil then
			local ResourcesIconConfig = ConfigReader:getRecordById("ResourcesIcon", tostring(info.id))

			if ResourcesIconConfig then
				icon = self:createResourcePic(config, {
					ignoreScaleSize = true,
					largeIcon = true
				})
			end
		end
	elseif config.Icon == "" then
		local ResourcesIconConfig = ConfigReader:getRecordById("ResourcesIcon", tostring(info.id))

		if ResourcesIconConfig then
			icon = self:createResourcePic(config, {
				ignoreScaleSize = true,
				largeIcon = true
			})
		end
	end

	assert(icon ~= nil, "createItemPic icon is nil " .. path)

	local scale = 0.6

	if style and style.showWidth then
		scale = style.showWidth / icon:getContentSize().width
	end

	if style and style.ignoreScaleSize then
		scale = 1
	end

	local size = icon:getContentSize()

	if size.width > 200 then
		scale = 200 / size.width * scale
	end

	icon:setScale(scale)

	local node = ccui.Widget:create()

	node:setContentSize(cc.size(icon:getContentSize().width, icon:getContentSize().height))
	node:setAnchorPoint(cc.p(0.5, 0.5))
	icon:addTo(node):center(node:getContentSize())

	if info.scaleRatio then
		node:setScale(info.scaleRatio)
	end

	local debrisIcon

	if config.Type == ItemTypes.K_HERO_F or config.Type == ItemTypes.K_EQUIP_F or config.Type == ItemTypes.K_MASTER_F then
		debrisIcon = cc.Sprite:createWithSpriteFrameName(IconFactory.debrisPath)
	end

	if config.DescConfig then
		local descConfig = config.DescConfig

		if descConfig.Desc then
			if descConfig.fontFace then
				if not ("asset/font/" .. descConfig.fontFace) then
					local font = CUSTOM_TTF_FONT_1
					local text = ccui.Text:create(Strings:get(descConfig.Desc), font, descConfig.fontSize)

					text:addTo(icon):center(icon:getContentSize()):offset(0, 24)
					text:setTextColor(GameStyle:stringToColor(descConfig.color))

					if descConfig.outline then
						text:enableOutline(GameStyle:stringToColor(descConfig.outline), 2)
					end
				end
			end
		end
	end

	icon = node

	if style and style.showWidth then
		local showWidth = style.showWidth

		IconFactory:autoPicSize(icon, showWidth)
	end

	return icon, debrisIcon
end

function IconFactory:getStencilByType(clipIndex, size)
	local info = IconFactory.kClikpStencil[clipIndex]
	local stencilPath = info.path
	local stencil

	if clipIndex == 2 then
		if size then
			local radius = (size.width or 100) * 0.5

			stencil = cc.DrawNode:create()

			stencil:drawSolidCircle(cc.p(radius, radius), radius, 0, 100, 1, 1, cc.c4f(1, 0, 0, 1))
			stencil:setContentSize(cc.size(radius * 2, radius * 2))
			stencil:setAnchorPoint(0.5, 0.5)
		end
	else
		if info.scale9 then
			stencil = ccui.Scale9Sprite:create(info.scale9, stencilPath)
		else
			stencil = ccui.ImageView:create()

			stencil:loadTexture(stencilPath)
		end

		size = size or stencil:getContentSize()

		stencil:setContentSize(size)
	end

	return stencil
end

function IconFactory:addStencilForIcon(node, clipIndex, size, offset)
	offset = offset or {}

	local stencil = self:getStencilByType(clipIndex, size)

	stencil:setAnchorPoint(cc.p(0, 0))

	size = size or stencil:getContentSize()

	if not offset[1] then
		local offsetX = 0

		if not offset[2] then
			local offsetY = 0

			node:setPosition(size.width * 0.5 + offsetX, size.height * 0.5 + offsetY)

			local clipSprite = ClippingNodeUtils.getClippingNodeByData({
				stencil = stencil,
				content = node
			})

			clipSprite:setContentSize(size)
			clipSprite:setAnchorPoint(cc.p(0.5, 0.5))

			return clipSprite
		end
	end
end

function IconFactory:autoPicSize(img, width)
	local isScale = width / img:getContentSize().width

	img:setScale(isScale)

	return isScale
end

function IconFactory:createSkillPic(info, style)
	local path = info.id

	path = "asset/skillIcon/" .. path .. ".png"

	local icon = self:createSprite(path)

	icon = icon or self:createSprite(GameStyle:getDefaultUnfoundFile())

	return icon
end

function IconFactory:createResourcePic(info, style)
	assert(info ~= nil, "Bad argument")

	if info.id == IconFactory.kRMBDefaultFile then
		local icon = cc.Sprite:createWithSpriteFrameName(IconFactory.kRMBDefaultFile)

		icon:setScale(0.26)

		return icon
	end

	if info.id then
		if not info.id then
			local id = info.Id
			local config = ConfigReader:getRecordById("ResourcesIcon", tostring(id))
			local icon

			if config then
				local scale = 0.4
				local iconName = config.Sicon .. ".png"

				if style and style.largeIcon then
					iconName = config.Licon .. ".png"
					scale = 0.6
				end

				if style and style.ignoreScaleSize then
					scale = 1
				end

				icon = cc.Sprite:createWithSpriteFrameName(iconName)

				icon:setScale(scale)

				local node = ccui.Widget:create()

				node:setContentSize(cc.size(icon:getContentSize().width, icon:getContentSize().height))
				node:setAnchorPoint(cc.p(0.5, 0.5))
				icon:addTo(node):center(node:getContentSize())

				icon = node

				if info.scaleRatio then
					icon:setScale(info.scaleRatio)
				end
			end

			if icon == nil then
				icon = cc.Sprite:createWithSpriteFrameName(IconFactory.resourceDefaultFile)
			end

			return icon
		end
	end
end

function IconFactory:_createBasicNode(style)
	local isWidget = style and style.isWidget
	local widgetSize = style and style.widgetSize

	widgetSize = widgetSize or cc.size(106, 106)

	local node

	if isWidget then
		node = ccui.Widget:create()

		node:setSwallowTouches(false)
		node:setTouchEnabled(true)
	else
		node = cc.Node:create()
	end

	node:setContentSize(widgetSize)
	node:setAnchorPoint(0.5, 0.5)
	node:setCascadeOpacityEnabled(true)

	return node
end

function IconFactory:createPlayerIcon(info)
	local playerHeadImgConfig = ConfigReader:getRecordById("PlayerHeadModel", info.id)

	assert(playerHeadImgConfig ~= nil, "PlayerHeadModel表中没有" .. info.id .. "的配置")

	playerHeadImgConfig = playerHeadImgConfig or ConfigReader:getRecordById("PlayerHeadModel", "Head_ZTXChang")

	local id = playerHeadImgConfig.HeroMasterId
	local imageType = playerHeadImgConfig.Type
	local icon, offset

	if imageType == 1 then
		local modelId = IconFactory:getRoleModelByKey("HeroBase", id)

		icon = self:createRoleIconSpriteNew({
			id = modelId
		})
		offset = {
			0,
			0
		}
	elseif imageType == 2 then
		local modelId = ConfigReader:getDataByNameIdAndKey("MasterBase", id, "RoleModel")

		icon = self:createRoleIconSpriteNew({
			id = modelId
		})
		offset = {
			0,
			0
		}
	else
		icon = cc.Sprite:create(playerHeadImgConfig.IconPath)
		offset = {
			0,
			0
		}
	end

	if not icon then
		local cjson = require("cjson.safe")
		local msg = string.format("id=%s, config=%s", tostring(info.id), cjson.encode(playerHeadImgConfig))

		CommonUtils.uploadDataToBugly("ExploreCaseDebug", msg)

		icon = cc.Sprite:create()
	end

	local oldIcon = icon

	icon = self:addStencilForIcon(icon, info.clipType or 1, info.size or cc.size(100, 100), offset)

	local awakenBaseScale = 1

	if info.size then
		awakenBaseScale = info.size.width / 100
	end

	local node = self:createBaseNode(true)

	node:setTouchEnabled(false)

	local size = icon:getContentSize()

	if info.frameStyle then
		local bottomImg

		if info.frameStyle == 1 then
			bottomImg = cc.Sprite:create("asset/head/commonUserHeadBg.png")
		elseif info.frameStyle == 2 then
			bottomImg = cc.Sprite:create("asset/itemRect/yizhuang_icon_bai.png")

			oldIcon:setScale(0.37)
		elseif info.frameStyle == 3 then
			bottomImg = ccui.Scale9Sprite:createWithSpriteFrameName("common_bg_wjtx.png")

			local capInsets = cc.rect(2, 2, 2, 2)

			bottomImg:setCapInsets(capInsets)
			bottomImg:setContentSize(cc.size(86, 86))
			oldIcon:setScale(0.4)
		end

		local frameSize = bottomImg:getContentSize()

		node:setContentSize(frameSize)
		bottomImg:addTo(node):center(frameSize)

		if info.frameStyle == 1 then
			bottomImg:offset(0, -4)
		elseif info.frameStyle == 3 then
			bottomImg:setScale(0.98)
			bottomImg:offset(-0.5, 0)
		end
	else
		node:setContentSize(size)
	end

	icon:addTo(node):center(node:getContentSize())

	if imageType == 4 then
		local anim = cc.MovieClip:create("saoguang_juexingtouxiang")

		anim:addTo(node):center(node:getContentSize()):setName("awakenSao")

		if info.frameStyle and info.frameStyle == 3 then
			anim:offset(7, -10)
			anim:setScaleX(1.5 * awakenBaseScale)
			anim:setScaleY(1.5 * awakenBaseScale)
		elseif info.frameStyle and info.frameStyle == 2 then
			anim:offset(7, -10)
			anim:setScaleX(1.5 * awakenBaseScale)
			anim:setScaleY(1.5 * awakenBaseScale)
		else
			anim:offset(7, -10)
			anim:setScaleX(1.5 * awakenBaseScale)
			anim:setScaleY(1.5 * awakenBaseScale)
		end
	end

	if info.headFrameId and info.headFrameId ~= "" then
		local img = ConfigReader:getDataByNameIdAndKey("PlayerHeadFrame", info.headFrameId, "Picture")

		if img then
			local frame = ccui.ImageView:create("asset/head/" .. img .. ".png")

			if not info.headFrameScale then
				local scale = frame:getContentSize().width / icon:getContentSize().width * 0.14

				frame:setAnchorPoint(cc.p(0.5, 0.5)):setScale(scale)
				frame:addTo(node):center(node:getContentSize())
			end
		end
	end

	if imageType == 4 then
		local anim = cc.MovieClip:create("touxiang_juexingtouxiang")

		anim:addTo(node):center(node:getContentSize())
		anim:setScale(1.4 * awakenBaseScale):offset(0, 0)

		local image = ccui.ImageView:create("asset/commonLang/jx_icon_jue.png")

		image:addTo(node):setScale(1.2 * awakenBaseScale):center(node:getContentSize()):offset(30 * awakenBaseScale, 30 * awakenBaseScale)
	end

	return node, oldIcon
end

function IconFactory:createBackgroundIcon(info, style)
	assert(info ~= nil, "Bad argument")

	local config = ConfigReader:getRecordById("HomeBackground", tostring(info.id))

	style = style or {}

	if config ~= nil then
		local index, iconNode

		iconNode = ccui.ImageView:create("asset/items/" .. config.Information.img .. ".png")

		if iconNode == nil then
			iconNode = self:createSprite(GameStyle:getDefaultUnfoundFile())
		end

		iconNode:setScale(0.5)

		local node = ccui.Widget:create()

		node:setContentSize(cc.size(iconNode:getContentSize().width, iconNode:getContentSize().height))
		node:setAnchorPoint(cc.p(0.5, 0.5))

		local quality = cc.Sprite:create("asset/itemRect/common_pz_huang.png")

		node:addChild(quality)
		quality:setPosition(100, 100)
		iconNode:addTo(node):center(node:getContentSize())

		iconNode = node

		if info.scaleRatio then
			iconNode:setScale(info.scaleRatio)
		else
			iconNode:setScale(1)
		end

		local size = cc.size(110, 110)
		local node = self:createBaseNode(style and style.isWidget)

		node:setContentSize(size)
		IconFactory:centerAddNode(node, iconNode)

		local kAmountTag = 65536
		local mySelf = self

		function node:setAmount(amount)
			if style and style.showAmount == false then
				return
			end

			amount = amount or ""

			local label = self:getChildByTag(kAmountTag)

			if not label then
				local amountBg = cc.Sprite:create("asset/common/common_icon_sld.png")

				amountBg:setAnchorPoint(cc.p(1, 0))
				amountBg:addTo(self):posite(109, -5)
				amountBg:setName("AmountBg")

				label = mySelf:_createAmountLabel(info, nil, self)

				label:setTag(kAmountTag)
				label:setAnchorPoint(1, 0.5)
				label:setPosition(cc.p(100, 15))
			end

			if type(amount) == "number" and amount > 99999 then
				local str = Strings:get("Common_Time_01")
				local amountTemp = amount / 10000

				label:setString(amountTemp .. str)
			else
				label:setString(amount)
			end

			local amountBg = self:getChildByName("AmountBg")
			local width = amountBg:getContentSize().width
			local scaleX = (label:getContentSize().width + 16) / width

			amountBg:setScaleX(scaleX)
			amountBg:setVisible(amount ~= "" and tonumber(amount) > 0)
		end

		function node:adjustAmountBg()
			if style and style.showAmount == false then
				return
			end

			local label = self:getChildByTag(kAmountTag)
			local amountBg = self:getChildByName("AmountBg")

			if not label or not amountBg then
				return
			end

			local width = amountBg:getContentSize().width
			local scaleX = (label:getContentSize().width + 16) / width

			amountBg:setScaleX(scaleX)
		end

		function node:getAmountLabel()
			return self:getChildByTag(kAmountTag)
		end

		node:setAmount(info.amount)

		if style and style.shine then
			IconFactory:_createShineAnim(nil, nil, node)
		end

		return node
	end
end

function IconFactory:createPlayerFrameIcon(info, style)
	assert(info ~= nil, "Bad argument")

	local config = ConfigReader:getRecordById("PlayerHeadFrame", tostring(info.id))

	style = style or {}

	if config ~= nil then
		local index, iconNode

		if info.amount then
			local iconName = config.Picture

			iconNode = ccui.ImageView:create("asset/head/" .. iconName .. ".png")
		end

		if iconNode == nil then
			iconNode = self:createSprite(GameStyle:getDefaultUnfoundFile())
		end

		iconNode:setScale(0.5)

		local node = ccui.Widget:create()

		node:setContentSize(cc.size(iconNode:getContentSize().width, iconNode:getContentSize().height))
		node:setAnchorPoint(cc.p(0.5, 0.5))
		iconNode:addTo(node):center(node:getContentSize())

		iconNode = node

		if info.scaleRatio then
			iconNode:setScale(info.scaleRatio)
		else
			iconNode:setScale(1)
		end

		local size = cc.size(110, 110)
		local node = self:createBaseNode(style and style.isWidget)

		node:setContentSize(size)
		IconFactory:centerAddNode(node, iconNode)

		local kAmountTag = 65536
		local mySelf = self

		function node:setAmount(amount)
			if style and style.showAmount == false then
				return
			end

			amount = amount or ""

			local label = self:getChildByTag(kAmountTag)

			if not label then
				local amountBg = cc.Sprite:create("asset/common/common_icon_sld.png")

				amountBg:setAnchorPoint(cc.p(1, 0))
				amountBg:addTo(self):posite(109, -5)
				amountBg:setName("AmountBg")

				label = mySelf:_createAmountLabel(info, nil, self)

				label:setTag(kAmountTag)
				label:setAnchorPoint(1, 0.5)
				label:setPosition(cc.p(100, 15))
			end

			if type(amount) == "number" and amount > 99999 then
				local str = Strings:get("Common_Time_01")
				local amountTemp = amount / 10000

				label:setString(amountTemp .. str)
			else
				label:setString(amount)
			end

			local amountBg = self:getChildByName("AmountBg")
			local width = amountBg:getContentSize().width
			local scaleX = (label:getContentSize().width + 16) / width

			amountBg:setScaleX(scaleX)
			amountBg:setVisible(amount ~= "" and tonumber(amount) > 0)
		end

		function node:adjustAmountBg()
			if style and style.showAmount == false then
				return
			end

			local label = self:getChildByTag(kAmountTag)
			local amountBg = self:getChildByName("AmountBg")

			if not label or not amountBg then
				return
			end

			local width = amountBg:getContentSize().width
			local scaleX = (label:getContentSize().width + 16) / width

			amountBg:setScaleX(scaleX)
		end

		function node:getAmountLabel()
			return self:getChildByTag(kAmountTag)
		end

		node:setAmount(info.amount)

		if config.Type == "LIMIT" and not info.notShowFrameLimit and getCurrentLanguage() == GameLanguageType.CN then
			local tnode = self:createBaseNode()
			local img = ccui.ImageView:create("asset/common/common_bg_xb_4.png", ccui.TextureResType.localType)

			IconFactory:centerAddNode(tnode, img)

			local lvLabel = cc.Label:createWithTTF("", CUSTOM_TTF_FONT_1, 18)

			lvLabel:setString(Strings:get("ActivityBlock_UI_13"))
			lvLabel:setColor(cc.c3b(255, 255, 255))
			lvLabel:addTo(tnode):offset(0, 5)
			tnode:setScale(1.2)
			tnode:addTo(node):posite(90, 100)
		end

		if style and style.shine then
			IconFactory:_createShineAnim(nil, nil, node)
		end

		return node
	end
end

function IconFactory:createHeadFramePic(info, style)
	local config = ConfigReader:getRecordById("PlayerHeadFrame", tostring(info.id))
	local size = cc.size(110, 110)
	local node = self:createBaseNode(style and style.isWidget)

	node:setContentSize(size)

	if not config.Picture then
		local img = "sz_bg_txk"

		img = "asset/head/" .. img .. ".png"

		local icon = ccui.ImageView:create(img)

		icon:addTo(node):setScale(0.5):center(node:getContentSize())

		if config.Type == "LIMIT" then
			local tnode = IconFactory:createBaseNode()
			local img = ccui.ImageView:create("asset/common/common_bg_xb_4.png", ccui.TextureResType.localType)

			IconFactory:centerAddNode(tnode, img)

			local lvLabel = cc.Label:createWithTTF("", CUSTOM_TTF_FONT_1, 18)

			lvLabel:setString(Strings:get("ActivityBlock_UI_13"))
			lvLabel:setColor(cc.c3b(255, 255, 255))
			lvLabel:addTo(tnode):offset(0, 5)
			tnode:setScale(1 / icon:getScale() * 0.8)
			tnode:addTo(icon):center(icon:getContentSize()):offset(70, 90)
		end

		return node
	end
end

function IconFactory:createRactHeadImage(info)
	local playerHeadImgConfig = ConfigReader:getRecordById("PlayerHeadModel", info.id)
	local id = playerHeadImgConfig.HeroMasterId
	local imageType = playerHeadImgConfig.Type
	local icon, offset

	if imageType == 1 then
		local modelId = IconFactory:getRoleModelByKey("HeroBase", id)

		icon = self:createRoleIconSpriteNew({
			id = modelId,
			frameId = info.frameId
		})
		offset = {
			0,
			0
		}
	elseif imageType == 2 then
		local modelId = ConfigReader:getDataByNameIdAndKey("MasterBase", id, "RoleModel")

		icon = self:createRoleIconSpriteNew({
			id = modelId,
			frameId = info.frameId
		})
		offset = {
			0,
			0
		}
	elseif imageType == 4 then
		local modelId = ConfigReader:getDataByNameIdAndKey("HeroAwaken", id, "ModelId")

		icon = self:createRoleIconSpriteNew({
			id = modelId,
			frameId = info.frameId
		})
	elseif imageType == 5 then
		local skinId = playerHeadImgConfig.SurfaceMasterId
		local modelId = ConfigReader:getDataByNameIdAndKey("Surface", skinId, "Model")

		icon = self:createRoleIconSpriteNew({
			id = modelId,
			frameId = info.frameId
		})
	else
		icon = cc.Sprite:create(playerHeadImgConfig.IconPath)

		icon:setScale(0.4)

		offset = {
			-40,
			10
		}

		if playerHeadImgConfig.HeadMove then
			offset = playerHeadImgConfig.HeadMove
		end
	end

	local oldIcon = icon

	return icon, oldIcon
end

function IconFactory:createPetRaceHeadImage(info)
	local playerHeadImgConfig = ConfigReader:getRecordById("PlayerHeadModel", info.id)
	local id = playerHeadImgConfig.HeroMasterId
	local imageType = playerHeadImgConfig.Type
	local icon, offset

	if imageType == 1 then
		local modelId = IconFactory:getRoleModelByKey("HeroBase", id)

		icon = self:createRoleIconSpriteNew({
			useAnim = false,
			frameId = "bustframe11_4",
			id = modelId
		})
		offset = {
			50,
			0
		}
	elseif imageType == 2 then
		local modelId = ConfigReader:getDataByNameIdAndKey("MasterBase", id, "RoleModel")

		icon = self:createRoleIconSpriteNew({
			useAnim = false,
			frameId = "bustframe11_4",
			id = modelId
		})
		offset = {
			50,
			0
		}
	elseif imageType == 4 then
		local modelId = ConfigReader:getDataByNameIdAndKey("HeroAwaken", id, "ModelId")

		icon = self:createRoleIconSpriteNew({
			useAnim = false,
			frameId = "bustframe11_4",
			id = modelId
		})
		offset = {
			50,
			0
		}
	elseif imageType == 5 then
		local skinId = playerHeadImgConfig.SurfaceMasterId
		local modelId = ConfigReader:getDataByNameIdAndKey("Surface", skinId, "Model")

		icon = self:createRoleIconSpriteNew({
			useAnim = false,
			frameId = "bustframe11_4",
			id = modelId
		})
		offset = {
			50,
			0
		}
	else
		icon = cc.Sprite:create(playerHeadImgConfig.IconPath)

		icon:setScale(0.4)

		offset = {
			10,
			0
		}
	end

	local node = self:createBaseNode(true)

	node:setTouchEnabled(false)

	local size = icon:getContentSize()

	node:setContentSize(size)
	icon:addTo(node):center(node:getContentSize())

	return node
end

function IconFactory:createKernelIcon(info, style)
	local var_121_0 = info.configId

	if not info.configId then
		var_121_0 = info.Id

		if not info.Id then
			local id = info.id

			style = style or {}

			local config = ConfigReader:getRecordById("MasterCoreBase", tostring(id))
			local node = self:createBaseNode(style and style.isWidget)

			if info.rewardType then
				if style and style.rectType then
					if not style.rectType then
						do
							local quaImgType = 1
							local quaRectImg = IconFactory:createSprite(GameStyle:getItemQuaRectFile(config.Quality, quaImgType))

							if quaImgType == 2 then
								quaRectImg:setScale(1.2)
							end

							if not style.notShowQulity == true then
								node:addChild(quaRectImg)
							end
						end

						local qualityRound = cc.Sprite:create("asset/itemRect/pinzhikuang_" .. config.Quality .. ".png")

						node:addChild(qualityRound)

						local configicon = config.Icon
						local icon = cc.Sprite:create("asset/items/" .. configicon .. ".png")

						icon:setTag(666)
						node:addChild(icon)

						for i = 1, 8 do
							local arrowname = kernelArrowQuality[config.Quality] .. i .. ".png"
							local directionImg = cc.Sprite:createWithSpriteFrameName(arrowname)

							directionImg:setPosition(cc.p(kerenlPos[i][1], kerenlPos[i][2]))
							directionImg:setVisible(i == config.Position)
							node:addChild(directionImg)

							if info.rewardType then
								directionImg:setScale(0.8)
								directionImg:setPosition(cc.p(kerenlPos[i][1], kerenlPos[i][2] - 10))
							end
						end

						if info.rewardType then
							qualityRound:setScale(0.8)
							icon:setScale(0.8)
						end

						if not style.isSuiteExpand then
							local levelbg = cc.Sprite:createWithSpriteFrameName("zhujue_bg_xcd.png")
							local label = cc.Label:createWithTTF("", "asset/font/CustomFont_FZYH_R.TTF", 18)

							label:setString("+" .. (info.level or 1))
							label:setPosition(node:getContentSize().width * 0.8, node:getContentSize().height * 0.2)
							levelbg:addChild(label)
							levelbg:setAnchorPoint(0, 0)
							levelbg:setPosition(cc.p(5, -25))
							label:setPosition(levelbg:getContentSize().width * 0.5, levelbg:getContentSize().height * 0.1)
							node:addChild(levelbg, 10)

							if style.hideLevel then
								levelbg:setVisible(not style.hideLevel)
								label:setVisible(not style.hideLevel)
							end
						end

						local btn = ccui.Button:create("asset/items/" .. configicon .. ".png", "asset/items/" .. configicon .. ".png", "asset/items/" .. configicon .. ".png")

						btn:setSwallowTouches(false)
						btn:setTag(668)
						node:addChild(btn)

						local idlabel = cc.Label:createWithTTF("", "asset/font/CustomFont_FZYH_R.TTF", 20)

						if style.isEquip then
							idlabel:setString(info.id)
						else
							idlabel:setString(info.serverkey)
						end

						if style.needSelect then
							local select = cc.Sprite:createWithSpriteFrameName("zhujue_bg_duigou.png")

							select:setPosition(-15, 25)
							select:setVisible(false)
							select:setTag(888)
							node:addChild(select)
						end

						idlabel:setColor(cc.c3b(0, 0, 0))
						node:addChild(idlabel)

						if info.count then
							local clabel = cc.Label:createWithTTF("", "asset/font/CustomFont_FZYH_R.TTF", 20)

							clabel:setString(info.count)
							node:addChild(clabel)
						end

						local kAmountTag = 65536
						local mySelf = self

						function node:setNotEngouhState(notEngouh)
							local label = self:getChildByTag(kAmountTag)

							if notEngouh then
								label:setColor(cc.c3b(193, 193, 193))
							else
								label:setColor(cc.c3b(255, 255, 255))
							end
						end

						function node:setAmount(amount)
							if style and style.showAmount == false then
								return
							end

							amount = amount or ""

							local label = self:getChildByTag(kAmountTag)

							if not label then
								label = mySelf:_createAmountLabel(info, nil, self)

								if label then
									label:setTag(kAmountTag)
								end

								label:setPosition(cc.p(35, -45))
							end

							label:setString(tostring(amount))
							self:setNotEngouhState(amount == 0)
						end

						function node:getAddTipImg()
							return self:getChildByTag(kAddTipTag)
						end

						function node:getAmountLabel()
							return self:getChildByTag(kAmountTag)
						end

						if info.amount then
							node:setAmount(info.amount)
						end

						return node
					end
				end
			end
		end
	end
end

function IconFactory:createClubIcon(info, style)
	local node = self:_createBasicNode(style)
	local backImg = cc.Sprite:create("asset/itemRect/yizhuang_icon_bai.png")

	backImg:addTo(node):center(node:getContentSize())

	if style and style.isNoBG then
		backImg:setVisible(false)
	end

	local clubIconMap = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Icon", "content")
	local clubIconImage

	for k, v in ipairs(clubIconMap) do
		if v.id == info.id then
			clubIconImage = v.value

			break
		end
	end

	assert(clubIconImage, "ConfigValue表中Club_Icon字段配置中没有社团图标id为" .. info.id .. "未找到该社团图标")

	local icon = cc.Sprite:create("asset/ui/club/" .. clubIconImage .. ".png")

	icon:setScale(0.5)
	icon:addTo(node):center(node:getContentSize())

	node.backImg = backImg
	node.icon = icon

	return node
end

local relationTitlePath = {
	"img_suming_dengji_lan.png",
	"img_suming_dengji_zi.png",
	"img_suming_dengji_huang.png"
}
local imgPartPath = "asset/ui/herorelation/"

function IconFactory:createRelationTitleIcon(info, style)
	info = info or {}

	if not info.level then
		local level = 0
		local iconBg = cc.Sprite:create("asset/itemRect/pinzhikuang_1.png")

		iconBg:addTo(panel)
		iconBg:setPosition(cc.p(25, 24))
		iconBg:setScale(0.6)

		return (cc.Sprite:create(imgPartPath .. relationTitlePath[level == 0 and 1 or level]))
	end
end

function IconFactory:_createText(parent, str, fontSize, tag, fontFile)
	local text = parent:getChildByTag(tag)

	fontFile = fontFile or TTF_FONT_FZYH_M

	if not text then
		text = ccui.Text:create("", fontFile, fontSize)

		parent:addChild(text, 1, tag)
		text:setColor(cc.c3b(255, 255, 235))
		text:enableOutline(cc.c4b(0, 0, 0, 255), 2)
	end

	text:setString(tostring(str))

	return text
end

function IconFactory:_createItemBackImg(info, style, node)
	local backImg = self:createSprite(IconFactory.commonItemBgPath)

	IconFactory:centerAddNode(node, backImg)
	backImg:setLocalZOrder(-99)

	return backImg
end

function IconFactory:_createAmountLabel(info, style, node)
	if style and style.font then
		if not style.font then
			local font = TTF_FONT_FZYH_M

			if style and style.fontSize then
				if not style.fontSize then
					local fontSize = 18
					local label = cc.Label:createWithTTF("", font, fontSize)

					if info.amount and info.amount >= 1 then
						local amountStr

						label:setString(info.amount >= 100000 and tostring(math.floor(info.amount / 10000)) .. "w" or tostring(info.amount))
					end

					label:setAnchorPoint(1, 0)
					label:setPosition(info.pos or cc.p(node:getContentSize().width - 8, 2))
					label:setTextColor(GameStyle:getColor(1))
					node:addChild(label)

					return label
				end
			end
		end
	end
end

function IconFactory:centerAddNode(parent, node, zOrder, tag)
	if not node then
		return
	end

	node:addTo(parent):center(parent:getContentSize())

	if zOrder then
		node:setLocalZOrder(zOrder)
	end

	if tag then
		node:setTag(tag)
	end
end

function IconFactory:positionAddNode(parent, node, position, zOrder, tag)
	if not node then
		return
	end

	node:addTo(parent)
	node:setPosition(position)

	if zOrder then
		node:setLocalZOrder(zOrder)
	end

	if tag then
		node:setTag(tag)
	end
end

function IconFactory:_createShineAnim(info, style, node)
	local anim = cc.MovieClip:create("xinxin_beibaojinpin")

	anim:addTo(node):center(node:getContentSize())
	anim:setScale(1.1)
	anim:setLocalZOrder(999)
end

function IconFactory:initialize()
	self._styleFuncMap = {
		showAmount = IconFactory._createAmountLabel,
		addBackImg = IconFactory._createItemBackImg,
		shine = IconFactory._createShineAnim
	}
end

function IconFactory:_parseStyles(info, style, node, userdata)
	if style then
		for k, v in pairs(style) do
			local func = self._styleFuncMap[k]

			if func then
				func(self, info, style, node, userdata)
			end
		end
	end
end

function IconFactory:createLoveUpAnim(heroId, num, roleModel, isLoveLevelMax)
	local renderNode = cc.CSLoader:createNode("asset/ui/StoryLove.csb")
	local isLoveLevelMax = isLoveLevelMax

	local function getAnimName(num)
		local data = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StoryLoveType", "content")
		local hate = data.hate
		local normal = data.normal
		local animName

		if num >= hate[1] and num <= hate[2] then
			animName = "animNone"

			AudioEngine:getInstance():playEffect("Se_Alert_Favor_Down", false)
		elseif num >= normal[1] and num <= normal[2] then
			animName = "animOne"

			AudioEngine:getInstance():playEffect("Se_Alert_Favor_Up", false)
		else
			animName = "animThree"

			AudioEngine:getInstance():playEffect("Se_Alert_Favor_Up", false)
		end

		return animName
	end

	local function createNumLabel(value)
		local node = cc.Node:create()

		if isLoveLevelMax then
			local child = ccui.ImageView:create("jq_word_max.png", 1)

			child:setAnchorPoint(cc.p(0.5, 0.5))
			child:setPosition(0, 0)
			node:addChild(child)

			return node
		end

		local width = 0

		for i = 1, utf8.len(value) do
			local num = string.sub(tostring(value), i, i)
			local child = ccui.ImageView:create("jq_word_" .. num .. ".png", 1)

			child:setAnchorPoint(cc.p(0.5, 0.5))
			child:setPosition(width, 0)
			node:addChild(child)

			width = width + child:getContentSize().width - 20
		end

		return node
	end

	local function createHeadImg(heroId, roleModel)
		roleModel = roleModel or IconFactory:getRoleModelByKey("HeroBase", heroId)

		local heroInfo = {
			id = roleModel
		}
		local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

		headImgName:setScale(0.6)

		headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(100, 100))

		return headImgName
	end

	local animName = getAnimName(num)
	local animBaseNode = renderNode:getChildByName("Node_anim")

	animBaseNode:removeAllChildren()

	local animNode = cc.MovieClip:create(animName .. "_juqinghaogandutisheng")

	animNode:setPlaySpeed(1.5)
	animBaseNode:addChild(animNode)
	animNode:setName(animName)
	animNode:addCallbackAtFrame(80, function(cid, mc)
		renderNode:removeFromParent()
	end)
	animNode:gotoAndPlay(1)

	local headNode = renderNode:getChildByName("Node_head")

	headNode:removeAllChildren()

	local imgHead = createHeadImg(heroId, roleModel)

	headNode:addChild(imgHead)

	local numLabel = animNode:getChildByFullName("labelNode.numNode")

	if numLabel then
		numLabel:removeAllChildren()

		if isLoveLevelMax then
			local plusBtn = animNode:getChildByFullName("labelNode.plusBtn")

			if plusBtn then
				plusBtn:setVisible(false)
			end
		end

		if num > 0 then
			local numNode = createNumLabel(num)

			numLabel:addChild(numNode)
		end
	end

	local nameLabel = renderNode:getChildByName("Text_name")
	local heroName = Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name"))

	nameLabel:setString(heroName)

	return renderNode
end

function IconFactory:createMazeClueHead(info)
	local id = info.heroId
	local num = info.num
	local csbNode = cc.CSLoader:createNode("asset/ui/MazeClueHead.csb")
	local rootNode = csbNode:getChildByName("ClueNode")

	local function createHeadImg(heroId)
		local heroInfo = {
			clipType = 3,
			id = heroId
		}
		local headImgName = self:createRoleIconSpriteNew(heroInfo)

		headImgName:setScale(0.5)

		headImgName = self:addStencilForIcon(headImgName, 2, cc.size(50, 50))

		return headImgName
	end

	local headNode = rootNode:getChildByName("headNode")
	local imgHead = createHeadImg(id)

	imgHead:addTo(headNode):center(headNode:getContentSize()):offset(0, 0)

	local textClue = rootNode:getChildByName("textClue")

	if num >= 0 then
		textClue:setString("+" .. tostring(num))
	else
		textClue:setString(tostring(num))
	end

	return csbNode
end

function IconFactory:createStoryMazeClueHead(info)
	local id = info.heroId
	local num = info.num
	local suspectId = info.suspectId
	local csbNode = cc.CSLoader:createNode("asset/ui/StoryMazeClue.csb")
	local rootNode = csbNode

	local function createHeadImg(heroId)
		local heroInfo = {
			clipType = 3,
			id = heroId
		}
		local headImgName = self:createRoleIconSpriteNew(heroInfo)

		headImgName:setScale(1)

		headImgName = self:addStencilForIcon(headImgName, 2, cc.size(100, 100))

		return headImgName
	end

	local headNode = rootNode:getChildByName("headNode")
	local imgHead = createHeadImg(id)

	imgHead:addTo(headNode):center(headNode:getContentSize()):offset(0, 0)

	local textClue = rootNode:getChildByName("textClue")

	if num >= 0 then
		textClue:setString("+" .. tostring(num))
	else
		textClue:setString(tostring(num))
	end

	local nameLabel = rootNode:getChildByName("Text_name")
	local heroName = Strings:get(ConfigReader:getDataByNameIdAndKey("PansLabSuspects", suspectId, "Name"))

	nameLabel:setString(heroName)

	return csbNode
end

local kHeroPartyImagePath = {
	building = {
		[GalleryPartyType.kBSNCT] = "asset/common/sl_bg_bsn.png",
		[GalleryPartyType.kXD] = "asset/common/sl_bg_xd.png",
		[GalleryPartyType.kMNJH] = "asset/common/sl_bg_mvjh.png",
		[GalleryPartyType.kDWH] = "asset/common/sl_bg_dwh.png",
		[GalleryPartyType.kWNSXJ] = "asset/common/sl_bg_wns.png",
		[GalleryPartyType.kSSZS] = "asset/common/sl_bg_smzs.png",
		[GalleryPartyType.kUNKNOWN] = "asset/common/sl_bg_unknown.png"
	}
}

function IconFactory:getHeroPartyPath(heroId, key)
	local config = PrototypeFactory:getInstance():getHeroPrototype(heroId):getConfig()

	return self:getPartyPath(config.Party, key)
end

function IconFactory:getPartyPath(party, key)
	if key and kHeroPartyImagePath[key] then
		local pathList = kHeroPartyImagePath[key]

		if pathList[party] then
			return pathList[party]
		end
	end
end

function IconFactory:getHeroRarityAnim(rarity)
	if rarity and kHeroRarityAnim[rarity] then
		return cc.MovieClip:create(kHeroRarityAnim[rarity])
	end
end

local rtpkAnimOffset = {
	{
		0.5,
		-32
	},
	{
		0,
		-50
	},
	{
		0,
		-19
	},
	{
		0,
		-27
	},
	{
		0,
		-25
	},
	{
		-3,
		-30
	},
	{
		0,
		2
	}
}

function IconFactory:createRTPKGradeIcon(gradeId, style)
	style = style or {}

	local gradeConfig = ConfigReader:getRecordById("RTPKGrade", gradeId)
	local icon = ccui.ImageView:create(gradeConfig.GradePic .. ".png", ccui.TextureResType.plistType)

	if not style.hideName then
		local namedi = ccui.ImageView:create("rtpk_badge_hengfu.png", ccui.TextureResType.plistType)

		namedi:addTo(icon):center(icon:getContentSize())

		local nameText = ccui.Text:create(Strings:get(gradeConfig.Name), TTF_FONT_FZYH_M, 24)
		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(182, 200, 212, 255)
			}
		}

		nameText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		nameText:addTo(icon):center(icon:getContentSize()):offset(0, -142)
		nameText:enableOutline(cc.c4b(90, 91, 171, 200), 2)
	end

	icon.gradeId = gradeId

	if style.useAnim then
		local animName = "duanwei" .. gradeConfig.GradeType .. "_tiantiduanweieff"
		local anim = cc.MovieClip:create(animName)

		if anim then
			local offset = rtpkAnimOffset[gradeConfig.GradeType]

			anim:addTo(icon):center(icon:getContentSize()):offset(offset[1], offset[2])
		end
	end

	return icon
end

function IconFactory:createLeadStageIconVer(id, lv, style)
	if lv == 0 then
		return nil
	end

	style = style or {}

	if style.font then
		if not style.font then
			local font = TTF_FONT_FZYH_M

			if style.fontSize then
				if not style.fontSize then
					local fontSize = 18

					if style.needBg then
						if not style.needBg then
							local needBg = 1
							local layout = ccui.Layout:create()

							if needBg == 1 then
								local iconBg = ccui.ImageView:create("bg_leadstage_zhezhao0" .. 9 - lv .. ".png", ccui.TextureResType.plistType)

								iconBg:addTo(layout):offset(6, -9)
							elseif needBg == 2 then
								local iconBg = ccui.ImageView:create("bg_zhezhao_hei.png", ccui.TextureResType.plistType)

								iconBg:addTo(layout):offset(4, 0)
							end

							local config = ConfigReader:getRecordById("MasterLeadStage", id)
							local icon = ccui.ImageView:create(config.Icon, ccui.TextureResType.plistType)

							icon:ignoreContentAdaptWithSize(true)
							icon:addTo(layout):center(layout:getContentSize())
							icon:setScale(lv == 8 and 0.5 or lv == 1 and 0.6 or 0.8)

							local nameText = ccui.Text:create(Strings:get(config.RomanNum) .. Strings:get(config.StageName), font, fontSize)

							nameText:enableOutline(cc.c4b(255, 255, 255, 255), 2)
							nameText:setTextColor(GameStyle:getLeadStageColor(lv))
							nameText:addTo(layout):center(layout:getContentSize()):offset(0, -35)
							print("id,lv " .. id .. lv .. nameText:getString())

							return layout
						end
					end
				end
			end
		end
	end
end

function IconFactory:createLeadStageIconHor(id, lv, style)
	if lv == 0 then
		return nil
	end

	style = style or {}

	if style.font then
		if not style.font then
			local font = TTF_FONT_FZYH_M

			if style.fontSize then
				if not style.fontSize then
					local fontSize = 18
					local kind = style.kind
					local layout = ccui.Layout:create()

					if kind then
						local iconBg = ccui.ImageView:create("asset/common/common_bd_sx.png", ccui.TextureResType.localType)

						iconBg:addTo(layout):posite(lv == 8 and 32.7 or 26, -15)
						iconBg:setAnchorPoint(cc.p(0, 0.5))
						iconBg:setScale(0.9)
					else
						local iconBg = ccui.ImageView:create("bg_zj_leadstage_heidi.png", ccui.TextureResType.plistType)

						iconBg:setAnchorPoint(cc.p(0, 0.5))
						iconBg:addTo(layout):posite(lv == 8 and 25 or 21, -5)
					end

					local config = ConfigReader:getRecordById("MasterLeadStage", id)
					local icon = ccui.ImageView:create(config.Icon, ccui.TextureResType.plistType)

					icon:ignoreContentAdaptWithSize(true)
					icon:addTo(layout):posite(0, -5)
					icon:setScale(lv == 8 and 0.3 or lv == 1 and 0.4 or 0.5)

					local nameText = ccui.Text:create(Strings:get(config.RomanNum) .. Strings:get(config.StageName), font, fontSize)

					nameText:enableOutline(cc.c4b(255, 255, 255, 255), 2)
					nameText:setAnchorPoint(cc.p(0, 0.5))
					nameText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
					nameText:setTextColor(GameStyle:getLeadStageColor(lv))
					nameText:addTo(layout):posite(lv == 8 and 27 or 23, -5)

					if kind then
						icon:setScale(lv == 8 and 0.5 or lv == 1 and 0.6 or 0.8)
						nameText:posite(lv == 8 and 41.7 or 35, -5)
					end

					return layout
				end
			end
		end
	end
end

function IconFactory:createMasterLeadStageSkillIcon(info, style, clickfun)
	style = style or {}

	if info.id then
		local id = info.id
		local isLock = info.isLock

		if not info.isGray then
			local isGray = false

			if style.kind then
				if not style.kind then
					local kind = 0

					if info.scale then
						if not info.scale then
							local scale = 1
							local skillConfig = ConfigReader:getRecordById("Skill", tostring(id))
							local node = cc.Node:create()
							local root = ccui.Layout:create()

							root:setContentSize(cc.size(94, 94))
							root:setTag(66)
							node:addChild(root)

							local kLevelTag, kLockTag = 65536, 65537

							if kind == 0 then
								local under = ccui.ImageView:create("leadStage_img_jinegndi.png", 1)

								root:addChild(under)
								under:setPosition(cc.p(47, 47))
								under:setScale(1.65)
							else
								local under = ccui.ImageView:create("yh_bg_jnk_new.png", 1)

								root:addChild(under)
								under:setPosition(cc.p(50, 44))
								under:setScale(1.4)
							end

							local kSkillTag = 65539
							local skillImg = IconFactory:createSkillPic({
								id = skillConfig.Icon
							})

							skillImg:setTag(kSkillTag)
							IconFactory:centerAddNode(node, skillImg)
							skillImg:setPosition(cc.p(47, 47))
							skillImg:setScale(scale)

							local btn = ccui.Button:create("asset/master/masterRect/masterSkillBottomRect/pic_tongyong_di_pzk_jn.png", "asset/master/masterRect/masterSkillBottomRect/pic_tongyong_di_pzk_jn.png")

							btn:setSwallowTouches(false)
							btn:setTag(668)
							btn:addTouchEventListener(function(sender, eventType)
								if eventType == ccui.TouchEventType.ended and clickfun then
									clickfun()
								end
							end)
							btn:setOpacity(0)
							btn:setPosition(cc.p(47, 47))
							node:addChild(btn, 999)

							function node:setLock(isLock)
								local lockImg = self:getChildByTag(kLockTag)

								if not lockImg then
									lockImg = ccui.ImageView:create("asset/common/common_icon_lock_new.png")

									lockImg:setPosition(80, 100)
									node:addChild(lockImg, 1, kLockTag)
								end

								lockImg:setVisible(isLock)
								lockImg:setScale(1.4)

								local skillImg = self:getChildByTag(kSkillTag)

								if skillImg then
									skillImg:setGray(isLock)

									if isGray then
										skillImg:setGray(isGray)
									end
								end
							end

							node:setLock(isLock)

							return node
						end
					end
				end
			end
		end
	end
end

function IconFactory:createRTPKEmojiIcon(info, style)
	local config = ConfigReader:getRecordById("MasterFace", info.id)

	if config then
		local quaImgType = 1
		local qualityImg = GameStyle:getItemQuaRectFile(5, quaImgType)
		local quaRectImg = IconFactory:createSprite(qualityImg)
		local size = cc.size(110, 110)
		local node = self:createBaseNode(style and style.isWidget)

		node:setContentSize(size)
		IconFactory:centerAddNode(node, quaRectImg)

		local emojiImg = ccui.ImageView:create("asset/emotion/" .. config.EMJPic, 0)

		emojiImg:addTo(node):center(node:getContentSize()):setScale(0.54)

		return node
	end
end

function IconFactory:getSpMvpBattleEndMid(model)
	local mid = model
	local configShow = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Bust_Battleend_Show", "content") or {}

	if table.indexof(configShow, mid) then
		local linkMid = ConfigReader:getDataByNameIdAndKey("RoleModel", mid, "BattleShow")

		if linkMid and linkMid ~= "" then
			mid = linkMid
		end
	end

	return mid
end

function IconFactory:createTSoulPic(info, style)
	assert(info and info.id, "Bad argument")

	local config = ConfigReader:getRecordById("Tsoul", info.id)
	local icon

	if config then
		local iconName = config.Icon
		local path = "asset/items/" .. iconName .. ".png"

		icon = cc.Sprite:create(path)

		local size = icon:getContentSize()

		if size.width > 200 then
			icon:setScale(0.42)
		end
	else
		icon = cc.Sprite:create()
	end

	return icon
end

function IconFactory:createTSoulIcon(info, style)
	style = style or {}

	if not info.id then
		local itemId = info.itemId
		local config = ConfigReader:getRecordById("Tsoul", tostring(itemId)) or {}

		if not config.Rareity then
			local quality = 1

			if not config.Rareity then
				local rarity = 1

				if not config.Type then
					local pos = 1
					local useNoEnough = true

					if info.useNoEnough ~= nil then
						useNoEnough = info.useNoEnough
					end

					if style and style.rectType then
						if not style.rectType then
							local quaImgType = 1
							local qualityImg = GameStyle:getItemQuaRectFile(quality, quaImgType)
							local quaRectImg = IconFactory:createSprite(qualityImg)

							if quaImgType == 2 then
								quaRectImg:setScale(1.2)
							end

							local size = cc.size(110, 110)
							local node = self:createBaseNode(style and style.isWidget)

							node:setContentSize(size)

							if not style.notShowQulity == true then
								IconFactory:centerAddNode(node, quaRectImg)
							end

							local itemImg = self:createTSoulPic(info)

							itemImg:setScale(0.6)
							IconFactory:centerAddNode(node, itemImg)

							if style and style.color then
								itemImg:setColor(style.color)
							end

							local kLevelTag = "LevelLabel"

							function node:setLevel(lvl)
								local lvLabel = self:getChildByName(kLevelTag)

								if not lvLabel then
									local amountBg = cc.Sprite:create("asset/common/common_icon_sld.png")

									amountBg:setAnchorPoint(cc.p(1, 1))
									amountBg:setPosition(cc.p(size.width + 1, size.height))
									amountBg:addTo(self)
									amountBg:setName("AmountBg")

									lvLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 20)

									lvLabel:enableOutline(cc.c4b(35, 15, 5, 255), 1)
									lvLabel:setAnchorPoint(cc.p(1, 1))
									lvLabel:setPosition(cc.p(size.width - 6, size.height))
									node:addChild(lvLabel)
									lvLabel:setName("kLevelTag")
								end

								lvLabel:setString(Strings:get("Strenghten_Text78", {
									level = lvl
								}))

								local amountBg = self:getChildByName("AmountBg")
								local width = amountBg:getContentSize().width
								local scaleX = (lvLabel:getContentSize().width + 16) / width

								amountBg:setScaleX(scaleX)
							end

							if info.level then
								node:setLevel(info.level)
							end

							local kRarityName = "RarityImage"

							function node:setRarity(rarity)
								local imageFile = GameStyle:getEquipRarityImage(rarity)
								local rarityImage = self:getChildByName(kRarityName)

								if not rarityImage then
									rarityImage = ccui.ImageView:create(imageFile)

									rarityImage:addTo(node)
									rarityImage:setName(kRarityName)
									rarityImage:setAnchorPoint(cc.p(0, 1))
									rarityImage:setPosition(cc.p(-10, size.height + 10))
									rarityImage:setScale(0.7)
									rarityImage:ignoreContentAdaptWithSize(true)
								end

								rarityImage:loadTexture(imageFile)
							end

							node:setRarity(rarity + 9)

							local kLockName = "LockImage"

							function node:setLock(lock)
								local lockImage = self:getChildByName(kLockName)

								if not lockImage then
									lockImage = ccui.ImageView:create("yinghun_img_lock.png", ccui.TextureResType.plistType)

									lockImage:addTo(node)
									lockImage:setName(kLockName)
									lockImage:setAnchorPoint(cc.p(0, 0))
									lockImage:setPosition(cc.p(3, 24))
									lockImage:setScale(0.9)
								end

								lockImage:setVisible(lock)
							end

							node:setLock(info.lock)

							local kPosName = "PosImage"

							function node:setPosImg(pos)
								local imageFile = GameStyle:getTSoulPosImage(pos)
								local posImage = self:getChildByName(kPosName)

								if not posImage then
									posImage = ccui.ImageView:create(imageFile)

									posImage:addTo(node)
									posImage:setName(kRarityName)
									posImage:setAnchorPoint(cc.p(1, 0))
									posImage:setPosition(cc.p(size.width + 6, -2))
									posImage:setScale(0.7)
									posImage:ignoreContentAdaptWithSize(true)
								end

								posImage:loadTexture(imageFile)
							end

							node:setPosImg(pos)

							return node
						end
					end
				end
			end
		end
	end
end

function IconFactory:createChatBubbleIcon(info, style)
	style = style or {}

	local id = info.id
	local config = ConfigReader:getRecordById("ChatBubble", id) or {}

	if not config.Quality then
		local quality = 3

		if style and style.rectType then
			if not style.rectType then
				local quaImgType = 1
				local qualityImg = GameStyle:getItemQuaRectFile(quality, quaImgType)
				local quaRectImg = IconFactory:createSprite(qualityImg)

				if quaImgType == 2 then
					quaRectImg:setScale(1.2)
				end

				local size = cc.size(110, 110)
				local node = self:createBaseNode(style and style.isWidget)

				node:setContentSize(size)
				IconFactory:centerAddNode(node, quaRectImg)

				local path = "asset/ui/chatBubble/" .. config.Icon .. ".png"
				local icon = ccui.ImageView:create(path)

				icon:addTo(node):center(node:getContentSize())

				local markImg = ccui.ImageView:create("asset/common/common_bg_xb_3.png")

				markImg:setRotation(30)
				markImg:setPosition(node:getContentSize().width - 20, node:getContentSize().height - 20)
				node:addChild(markImg)
				markImg:setScale(1.3)

				local label = cc.Label:createWithTTF("", "asset/font/CustomFont_FZYH_R.TTF", 18)

				label:setString(Strings:get("Bubble_Name"))
				label:setTextColor(cc.c3b(0, 0, 0))
				label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
				label:setOverflow(cc.LabelOverflow.SHRINK)
				label:setDimensions(50, 27)
				label:addTo(markImg):center(markImg:getContentSize()):offset(0, 3)

				return node
			end
		end
	end
end

function IconFactory:createChatBubblePic(info, style)
	style = style or {}

	local id = info.id
	local size = cc.size(110, 110)
	local node = self:createBaseNode(style and style.isWidget)

	node:setContentSize(size)

	local config = ConfigReader:getRecordById("ChatBubble", id) or {}
	local path = "asset/ui/chatBubble/" .. config.Icon .. ".png"
	local icon = ccui.ImageView:create(path)

	icon:addTo(node):center(node:getContentSize()):setScale(1.3)

	return node
end

function IconFactory:createTitleIcon(info, style)
	local id = info.id
	local config = ConfigReader:getRecordById("PlayerTitle", id)

	if not config then
		return
	end

	local size = cc.size(110, 110)
	local node = self:createBaseNode(style and style.isWidget)

	node:setContentSize(size)

	local diImg = ccui.ImageView:create(config.Icon .. ".png", 1)

	diImg:addTo(node):center(node:getContentSize())

	local nameText = ccui.Text:create("", CUSTOM_TTF_FONT_1, 18)

	nameText:addTo(node):center(node:getContentSize()):offset(-4, -4)

	local virtualRenderer = nameText:getVirtualRenderer()

	virtualRenderer:setAlignment(1, 1)
	virtualRenderer:setOverflow(cc.LabelOverflow.SHRINK)
	virtualRenderer:setDimensions(120, 30)
	nameText:setString(Strings:get(config.Name))

	return node
end

IconFactory:initialize()

local adjustLayoutPushIcon = {
	[KShopPushPackageScene.KHeroLevelUp] = AdjustUtils.kAdjustType.Right,
	[KShopPushPackageScene.KHeroStarUp] = AdjustUtils.kAdjustType.Right,
	[KShopPushPackageScene.KDrawCard] = AdjustUtils.kAdjustType.Right,
	[KShopPushPackageScene.KWifeGrow] = AdjustUtils.kAdjustType.Left,
	[KShopPushPackageScene.KEquip] = AdjustUtils.kAdjustType.Right,
	[KShopPushPackageScene.KMaster] = AdjustUtils.kAdjustType.Right,
	[KShopPushPackageScene.KSTAGE_FAIL] = AdjustUtils.kAdjustType.Left
}

function IconFactory:createPushBackBoxIcon(parentNode, pos, sceneId)
	parentNode:removeChildByName("packageAnim")

	if parentNode.timer then
		parentNode.timer:stop()

		parentNode.timer = nil
	end

	local develop = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local pushData = develop:getPushPackageData()
	local pushGiftScene = develop:getPushSceneIds()
	local pushPackageTimeList = develop:getPushGiftTimeList()
	local packageId

	for k, v in pairs(pushGiftScene) do
		if v == sceneId then
			packageId = k

			break
		end
	end

	if not packageId then
		parentNode:removeChildByName("packageAnim")

		return
	end

	local packageData

	for i, v in ipairs(pushData) do
		if packageId == v:getId() then
			packageData = v

			break
		end
	end

	if not packageData then
		parentNode:removeChildByName("packageAnim")

		return
	end

	local Price_Box = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Price_Box", "content")
	local kind = Price_Box[tostring(packageData:getPrice())]
	local animName = KPushPackageAnimName[kind]
	local layer = ccui.Layout:create()

	layer:setAnchorPoint(cc.p(0.5, 0.5))
	layer:setContentSize(cc.size(100, 120))
	layer:addTo(parentNode, 9999):posite(pos[1], pos[2] + 40)
	layer:setTouchEnabled(true)
	layer:setSwallowTouches(true)
	layer:setName("packageAnim")
	layer:addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		develop:showPushPackageView({
			packageId = packageData:getId()
		})
	end)

	local anim = RoleFactory:createRoleAnimation(animName)

	anim:setScale(0.45)
	anim:addTo(layer):posite(50, 0)

	if adjustLayoutPushIcon[sceneId] then
		AdjustUtils.adjustLayoutByType(layer, adjustLayoutPushIcon[sceneId])
	end

	local textRemainTime = ccui.Text:create("", TTF_FONT_FZYH_M, 18)

	textRemainTime:addTo(layer):posite(46, 18)
	setTextWithFontStyle(textRemainTime, "FontZWMBText")

	if not pushPackageTimeList[packageId] then
		local limitTime = 0

		local function update()
			local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
			local remainTime = math.max(limitTime - curTime, 0)
			local fmtStr = "${d}:${HH}:${M}:${SS}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = parts[1]
			timeTab.hour = parts[2]
			timeTab.min = parts[3]
			timeTab.sec = parts[4]

			textRemainTime:setString(tonumber(timeTab.day) > 0 and timeTab.day .. ":" .. timeTab.hour or tonumber(timeTab.hour) > 0 and timeTab.hour .. ":" .. timeTab.min .. ":" .. timeTab.sec or tonumber(timeTab.min) > 0 and "00:" .. timeTab.min .. ":" .. timeTab.sec or "00:" .. "00:" .. timeTab.sec)

			if remainTime == 0 then
				parentNode:removeChildByName("packageAnim")
				parentNode.timer:stop()

				parentNode.timer = nil
			end
		end

		parentNode.timer = LuaScheduler:getInstance():schedule(update, 1, false)

		update()
	end
end
