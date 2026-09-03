-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceSwearTipsMediator.lua

WordPeaceSwearTipsMediator = class("WordPeaceSwearTipsMediator", DmPopupViewMediator, _M)

WordPeaceSwearTipsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function WordPeaceSwearTipsMediator:initialize()
	super.initialize(self)
end

function WordPeaceSwearTipsMediator:dispose()
	super.dispose(self)
end

function WordPeaceSwearTipsMediator:onRegister()
	super.onRegister(self)
end

function WordPeaceSwearTipsMediator:mapEventListeners()
	return
end

function WordPeaceSwearTipsMediator:onRemove()
	super.onRemove(self)
end

function WordPeaceSwearTipsMediator:enterWithData(data)
	local rewards = data.rewards
	local rankdata = data.rank
	local parent = data.parent
	local closeCall = data.closeCall
	local isRet = false
	local anim1 = cc.MovieClip:create("tanchuan_qifen_xia_qxnmazhan")

	anim1:addTo(self:getView():getChildByFullName("main.anim1"), 1):offset(0, -30)
	anim1:addEndCallback(function()
		anim1:stop()
		anim1:removeFromParent()

		isRet = true
	end)

	local anim2 = cc.MovieClip:create("tanchuan_qifen_shang_qxnmazhan")

	anim2:addTo(self:getView():getChildByFullName("main.anim2"), 1):offset(0, -30)
	anim2:addEndCallback(function()
		anim2:stop()
		anim2:removeFromParent()
	end)

	self._tipLabel = self:getView():getChildByFullName("main.tipLabel")

	local anim = cc.MovieClip:create("zonghe_gongxihuode")

	anim:addTo(self:getView():getChildByFullName("main.animNode"), 1):offset(0, 130)
	anim:addCallbackAtFrame(55, function()
		anim:stop()
	end)

	local anim = cc.MovieClip:create("icon_group_gongxihuode")

	anim:setPlaySpeed(1.5)
	anim:addTo(self:getView():getChildByFullName("main.animNode"), 1):offset(0, 130)
	anim:setPosition(cc.p(0, 103))
	anim:addEndCallback(function()
		anim:stop()
	end)

	local iconRoot = self:getView():getChildByFullName("main.iconpanel")
	local icons = {}

	for k, v in pairs(rewards) do
		local icon = IconFactory:createRewardIcon(v, {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconRoot)
		icon:setScaleNotCascade(0.6)

		if #rewards % 2 == 0 then
			local index = k - (#rewards / 2 + 0.5)

			icon:offset(index * 100, 20)
		else
			local index = k - (#rewards + 1) / 2

			icon:offset(index * 100, 20)
		end

		icons[v.code] = icon
	end

	self:getView():getChildByFullName("main.mask"):addClickEventListener(function()
		if not isRet then
			return
		end

		self:getView():getChildByFullName("main.mask"):runAction(cc.FadeOut:create(0.1))
		self:getView():getChildByFullName("main.animNode"):runAction(cc.FadeOut:create(0.1))
		self:getView():getChildByFullName("main.title"):runAction(cc.FadeOut:create(0.1))
		self:getView():getChildByFullName("main.anim1"):runAction(cc.FadeOut:create(0.1))
		self:getView():getChildByFullName("main.anim2"):runAction(cc.FadeOut:create(0.1))

		local posMap = parent:collectWorldPos()
		local animIndex = 0
		local index = 0

		for k, v in pairs(icons) do
			if posMap[k] then
				animIndex = animIndex + 1
				index = index + 1

				local posLocal = iconRoot:convertToNodeSpace(posMap[k])

				v:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.5, posLocal), cc.ScaleTo:create(0.5, 0.4)), cc.CallFunc:create(function()
					animIndex = animIndex - 1

					v:setVisible(false)

					if animIndex <= 0 then
						delayCallByTime(200, function()
							if DisposableObject:isDisposed(self) then
								return
							end

							self:close()

							if closeCall then
								closeCall()
							end
						end)
					end
				end)))
			end
		end
	end)
	iconRoot:setOpacity(0)
	anim:addCallbackAtFrame(6, function()
		self._tipLabel:fadeIn({
			time = 0.2
		})
		iconRoot:fadeIn({
			time = 0.5
		})
	end)

	local rank = self:getView():getChildByFullName("main.title")

	rank:loadTexture("swear_img_pingfen" .. rankdata .. ".png", 1)
end

function WordPeaceSwearTipsMediator:willBeClosed(payload)
	return
end

function WordPeaceSwearTipsMediator:refreshView(data)
	return
end

function WordPeaceSwearTipsMediator:refreshView1(data)
	return
end

function WordPeaceSwearTipsMediator:onTouchMaskLayer()
	self:close()
end
