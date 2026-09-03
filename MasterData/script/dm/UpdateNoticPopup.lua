-- chunkname: @/tmp/or_script/lua_compile/dm/UpdateNoticPopup.lua

local UpdateNoticPopup = {}

UpdateNoticPopup.__index = UpdateNoticPopup

function UpdateNoticPopup:new()
	local instance = {}

	setmetatable(instance, UpdateNoticPopup)

	return instance
end

function UpdateNoticPopup:alert(param)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("asset/ui/common_buttons.plist", "asset/ui/common_buttons.png")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("asset/ui/common_scale9.plist", "asset/ui/common_scale9.png")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("asset/ui/common_scale9New.plist", "asset/ui/common_scale9New.png")

	local alerUrl = "asset/ui/Alert.csb"
	local alert = cc.CSLoader:createNode(alerUrl)
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local scene = cc.Scene:create()

	director:replaceScene(scene)

	local sprite = cc.Sprite:create("asset/scene/denglu_bg_new.jpg")

	sprite:setPosition(cc.p(52, 40))
	sprite:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
	scene:addChild(sprite)

	local bgNode, contentSize = self:_createBg()

	alert:setPosition(-160, -80)
	bgNode:addChild(alert, 10)

	local anim = ccui.Layout:create()

	anim:setAnchorPoint(cc.p(0.5, 0.5))
	anim:setContentSize(winSize)
	anim:setPosition(winSize.width / 2, winSize.height / 2)
	anim:addChild(bgNode)
	scene:addChild(anim)

	local root = alert:getChildByName("main")
	local btnok = root:getChildByName("btn_ok"):getChildByName("button")
	local btncancel = root:getChildByName("btn_cancel"):getChildByName("button")
	local innerBg = root:getChildByName("Image_2")

	btnok:loadTextures("common_btn_l02.png", "common_btn_l01.png", "common_btn_l01.png", ccui.TextureResType.plistType)
	btncancel:loadTextures("common_btn_l01.png", "common_btn_l01.png", "common_btn_l01.png", ccui.TextureResType.plistType)
	innerBg:loadTexture("common_bg_tsk_4.png", ccui.TextureResType.plistType)
	innerBg:setPositionY(361)
	root:getChildByName("btn_ok"):getChildByName("name"):setString("重试")
	root:getChildByName("btn_cancel"):setVisible(false)

	local x, y = root:getChildByName("btn_ok"):getPosition()

	root:getChildByName("btn_ok"):setPosition(cc.p(winSize.width / 2, y))

	local duration = 0.15
	local fadeIn = cc.FadeIn:create(duration)
	local scaleTo1 = cc.ScaleTo:create(duration, 1.17)
	local spawn = cc.Spawn:create(fadeIn, scaleTo1)
	local easeInOut = cc.EaseInOut:create(spawn, 1)
	local scaleTo2 = cc.ScaleTo:create(duration, 1)
	local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)
	local action = cc.Sequence:create(easeInOut, easeInOut1)

	anim:runAction(action)

	param = param or {}

	if not param.msg then
		local msg = "解压失败（无可用的内存空间，清理空间后重试）"

		root:getChildByName("Text_desc1"):setString(msg)
		btnok:addClickEventListener(function()
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if param.callBack then
				param.callBack()
			end

			print("click")
		end)
	end
end

function UpdateNoticPopup:_createBg()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	bgNodeRes = "asset/ui/PopupBgDark.csb"

	local bgNode = cc.CSLoader:createNode(bgNodeRes)
	local Image_bg = bgNode:getChildByName("Image_bg")
	local Image_bg1 = bgNode:getChildByName("Image_bg1")
	local Image_bg2 = bgNode:getChildByName("Image_bg2")
	local Image_bg3 = bgNode:getChildByName("Image_bg3")
	local Image_bg4 = bgNode:getChildByName("Image_bg4")
	local title_node = bgNode:getChildByName("title_node")
	local btn_close = bgNode:getChildByName("btn_close")

	Image_bg:loadTexture("common_bg_tk_1.png", ccui.TextureResType.plistType)

	local layerSize = Image_bg:getContentSize()

	bgNode:setPosition(cc.p((winSize.width - layerSize.width) / 2, (winSize.height - layerSize.height) / 2))
	Image_bg:loadTexture("common_bg_tk_1.png", ccui.TextureResType.plistType)
	Image_bg1:loadTexture("common_bg_tsk_1.png", ccui.TextureResType.plistType)
	Image_bg2:loadTexture("common_bg_tsk_2.png", ccui.TextureResType.plistType)
	Image_bg3:loadTexture("common_bg_tsk_3.png", ccui.TextureResType.plistType)
	Image_bg4:loadTexture("common_bg_tk_3.png", ccui.TextureResType.plistType)
	btn_close:loadTextures("common_btn_fh_1.png", "common_btn_fh_1.png", "common_btn_fh_1.png", ccui.TextureResType.plistType)
	title_node:getChildByName("bg_hw"):loadTexture("common_bg_tsk_5.png", ccui.TextureResType.plistType)
	title_node:getChildByName("Text_1"):setString("注意事项")
	title_node:getChildByName("Text_2"):setString("notic")
	title_node:getChildByName("Text_1"):enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	title_node:getChildByName("Text_2"):enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	Image_bg:setCapInsets(cc.rect(55, 20, 39, 30))

	layerSize.height = layerSize.height - 40

	Image_bg:setContentSize(layerSize)
	Image_bg:setPositionY(Image_bg:getPositionY() + 40)
	Image_bg2:setPositionY(Image_bg2:getPositionY() + 40)
	Image_bg3:setPositionY(Image_bg3:getPositionY() + 40)
	Image_bg4:setPositionY(Image_bg4:getPositionY() + 40)
	Image_bg1:setVisible(false)
	btn_close:setVisible(false)

	return bgNode, layerSize
end

return UpdateNoticPopup
