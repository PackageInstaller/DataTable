-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleScreenEffectLayer.lua

local BattleMCEffectConfigs = {
	ReadyGo = {
		libName = "readygo_zhandoureadygo",
		sounds = {
			{
				5,
				"Voice_Ready_Se1"
			},
			{
				29,
				"Se_Go_Se1"
			}
		}
	},
	Danger = {
		libName = "qiangdidh_qiangdilaixi",
		sounds = {
			{
				1,
				"se_warning_se1"
			}
		}
	},
	KO = {
		libName = "KO_zhandouko",
		sounds = {
			{
				3,
				"Voice_Ko_Se1"
			}
		}
	},
	AbortCombo = {
		libName = "daduandh_daduanchenggong"
	}
}

BattleScreenEffectLayer = class("BattleScreenEffectLayer", BaseWidget)

function BattleScreenEffectLayer:initialize(view)
	super.initialize(self, view)

	self._portraitList = {}

	self:setupView()
end

function BattleScreenEffectLayer:dispose()
	super.dispose(self)

	if self._readyTask then
		self._readyTask:stop()

		self._readyTask = nil
	end

	if self._view then
		self._view:removeAllChildren()
		self._view:removeFromParent()

		self._view = nil
	end
end

function BattleScreenEffectLayer:adjustLayout(targetFrame)
	self.targetFrame = targetFrame

	AdjustUtils.adjustLayoutByType(self:getView(), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.ignorSafeAreaRectForNode(self:getView(), AdjustUtils.kAdjustType.Left)

	local winSize = cc.Director:getInstance():getWinSize()

	self.blackMaskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), winSize.width * 2, winSize.height * 2)

	self.blackMaskLayer:setPosition(-winSize.width / 2, -winSize.height / 2)
	self:getView():addChild(self.blackMaskLayer, -1)
	self.blackMaskLayer:setVisible(false)
end

function BattleScreenEffectLayer:setupViewContext(context)
	self._viewContext = context
	self._mainMediator = context:getValue("BattleMainMediator")
end

function BattleScreenEffectLayer:setupView()
	return
end

function BattleScreenEffectLayer:pushPortraitEffect(portrait, model, skillDesc, right, isAwakenEffect, awakePortrait, offsetId, isCutin)
	local params = {
		portrait = portrait,
		desc = skillDesc,
		right = right,
		key = model,
		isAwakenEffect = isAwakenEffect,
		awakePortrait = awakePortrait,
		offsetId = offsetId,
		isCutin = isCutin
	}
	local listLength = #self._portraitList

	if listLength > 0 then
		self._portraitList[listLength + 1] = params
	else
		self._portraitList[1] = params

		self:showPortraitEffect()
	end
end

local animMap = {
	"zongdh_bishatexie",
	"sp_SPbishatexie",
	"zongdh_bishatexie"
}
local awakenAnimMap = {
	"zhezhaodonghua_juexingtexie",
	"sp_SPbishatexie",
	"zhezhaodonghua_juexingtexie"
}

function BattleScreenEffectLayer:showPortraitEffect()
	local params = self._portraitList[1]
	local modelId = params.portrait
	local right = params.right
	local desc = params.desc
	local key = params.key
	local flag = params.key
	local offsetId = params.offsetId
	local isCutin = params.isCutin
	local isAwakenEffect = params.isAwakenEffect

	if isAwakenEffect then
		if not awakenAnimMap[key] then
			local animName = animMap[key]
			local var_7_1

			if animName == nil or desc == nil then
				table.remove(self._portraitList, 1)

				if #self._portraitList > 0 then
					self:showPortraitEffect()
				end

				do return end

				var_7_1 = cc.Director:getInstance()
			end

			local frame = cc.size(var_7_1:getWinSize().width, self.targetFrame.height)
			local portraitAnim = cc.MovieClip:create(animName, "BattleMCGroup")

			portraitAnim:setPosition(frame.width / 2, frame.height / 2)
			portraitAnim:addTo(self:getView())
			portraitAnim:gotoAndPlay(1)

			local text

			if flag == 1 then
				if isAwakenEffect then
					portraitAnim:setScale(0.8)

					if not params.awakePortrait then
						local awakePortrait = ""
						local portraitNode = portraitAnim:getChildByFullName("role")
						local portrait = ccui.ImageView:create("asset/heros/" .. modelId .. "/" .. awakePortrait .. ".png", ccui.TextureResType.localType)

						portrait:setScale(1.5)
						portrait:addTo(portraitNode)

						local offsetConfig = ConfigReader:getDataByNameIdAndKey("HeroAwaken", offsetId, "CutIn")

						if offsetConfig then
							portrait:setScale(offsetConfig[3] or 1.5)
							portrait:setPositionX(offsetConfig[2] or 0)
							portrait:setPositionY(offsetConfig[1] or 0)
						end

						local textNode = portraitAnim:getChildByFullName("text")

						text = ccui.ImageView:create(ASSET_LANG_SKILL_WORD .. desc .. (right and "_R.png" or ".png"))

						text:addTo(textNode)
					end
				else
					local portraitNode = portraitAnim:getChildByFullName("model.image")
					local portrait

					;(isCutin and ccui.ImageView:create("asset/heros/" .. modelId .. ".png", ccui.TextureResType.localType) or IconFactory:createRoleIconSpriteNew({
						frameId = "bustframe21",
						id = modelId
					})):addTo(portraitNode):offset(128, 22)

					local textNode = portraitAnim:getChildByFullName("model.name")

					text = ccui.ImageView:create(ASSET_LANG_SKILL_WORD .. desc .. (right and "_R.png" or ".png"))

					text:addTo(textNode)
					text:offset(-90, 0)
				end

				AudioEngine:getInstance():playEffect("Se_Alert_Common_Pic", false)
			else
				local portraitNode = portraitAnim:getChildByFullName("model")
				local portraitNode1 = portraitAnim:getChildByFullName("model_shine")
				local portraitNode2 = portraitAnim:getChildByFullName("model_shine2")
				local portrait = isCutin and ccui.ImageView:create("asset/heros/" .. modelId .. ".png", ccui.TextureResType.localType) or IconFactory:createRoleIconSpriteNew({
					frameId = "bustframe21",
					id = modelId
				})

				portrait:addTo(portraitNode):offset(128, 22)
				portrait:clone():addTo(portraitNode1):offset(128, 22)
				portrait:clone():addTo(portraitNode2):offset(128, 22)

				local textNode = portraitAnim:getChildByFullName("name")

				text = ccui.ImageView:create(ASSET_LANG_SKILL_WORD .. desc .. (right and "_R.png" or ".png"))

				text:addTo(textNode)
				text:offset(-90, 0)
				AudioEngine:getInstance():playEffect("Se_Alert_Common_Pic_SP", false)
			end

			portraitAnim:addEndCallback(function(cid, mc)
				table.remove(self._portraitList, 1)
				mc:removeFromParent(true)

				if #self._portraitList > 0 then
					self:showPortraitEffect()
				end
			end)

			if right then
				portraitAnim:setScaleX(isAwakenEffect and -0.8 or -1)
				text:setScaleX(-1)
			end
		end
	end
end

function BattleScreenEffectLayer:perilous(show, speed)
	local anim = self:getView():getChildByName("Perilous")

	if not anim then
		local animSize = cc.size(1386, 852)
		local frame = self.targetFrame

		anim = cc.MovieClip:create("hongguangdh_daxuetiao", "BattleMCGroup")

		anim:setPosition(frame.width / 2 - frame.left, frame.height / 2)
		anim:setName("Perilous")
		anim:addTo(self:getView())
		anim:setScale(display.width / animSize.width, display.height / animSize.height)
	end

	if show and anim:isVisible() == false then
		anim:gotoAndPlay(1)
	end

	anim:setVisible(show)
	anim:setPlaySpeed(speed or 1)
end

function BattleScreenEffectLayer:createMCEffect(name, groupName)
	local effectConfig = BattleMCEffectConfigs[name]

	if effectConfig == nil then
		return nil
	end

	assert(effectConfig.libName ~= nil, "Invalid effect config: " .. name)

	local mcAnim = cc.MovieClip:create(effectConfig.libName, groupName)
	local sounds = effectConfig.sounds

	if sounds then
		for i, sound in ipairs(sounds) do
			local frame, soundRes = sound[1], sound[2]

			mcAnim:addCallbackAtFrame(frame, function(fid, mc, frameIndex)
				AudioEngine:getInstance():playEffect(soundRes, false)
			end)
		end
	end

	return mcAnim
end

function BattleScreenEffectLayer:playMCEffect(mcAnim, onComplete)
	if mcAnim == nil then
		return
	end

	mcAnim:addTo(self:getView())
	mcAnim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:removeFromParent(true)

		if onComplete then
			onComplete(mc)
		end
	end)
end

function BattleScreenEffectLayer:showReadyStart(callback)
	AudioEngine:getInstance():playEffect("Se_Alert_Battle_Start", false)

	local anim = MemCacheUtils:getMovieClip("xkz_xinkaizhan")

	anim:setTimelineGroupByName("BattleMCGroup")
	anim:removeFromParent()
	anim:clearCallbacks()
	anim:setVisible(true)

	local frame = cc.Director:getInstance():getWinSize()

	anim:setPosition(frame.width / 2, frame.height / 2)
	anim:gotoAndPlay(1)
	anim:setName("xkz_xinkaizhan")
	anim:addTo(self._view)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:removeFromParent()
	end)
	anim:addCallbackAtFrame(5, function(cid, mc)
		self:addGroundBlackCount(120)
	end)
	anim:addCallbackAtFrame(55, function(cid, mc)
		self:subGroundBlackCount()

		if callback then
			callback()
		end
	end)
end

function BattleScreenEffectLayer:addGroundBlackCount(opacity)
	self._groundBlackCount = self._groundBlackCount or 0
	self._groundBlackCount = self._groundBlackCount + 1

	self.blackMaskLayer:setOpacity(opacity or 180)
	self.blackMaskLayer:setVisible(true)
end

function BattleScreenEffectLayer:subGroundBlackCount()
	if not self._groundBlackCount then
		return
	end

	self._groundBlackCount = self._groundBlackCount - 1

	if self._groundBlackCount == 0 then
		self.blackMaskLayer:setOpacity(0)
		self.blackMaskLayer:setVisible(false)
	end
end
