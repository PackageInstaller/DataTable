-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\AvgRoleImage.lua

local RoleImage = require("UI/Control/Com/RoleImage")
local AvgRoleFrame = require("UI/Control/Com/AvgRoleFrame")
local strClassName = "AvgRoleImage"
local AvgRoleImage = Class(strClassName, RoleImage)

function AvgRoleImage:initUI()
	self.image = UIControls.Image(self, "GridHeroPortrait")
	self.imgEmoji = UIControls.Image(self, "GridHeroPortrait/Emoji")
	self.animEmojiPanel = UIControls.LazyEffectPlayer(self, "EfxEmoji")
	self.emojiAni = UIControls.UIAni(self, "GridHeroPortrait")
	self.mainAni = UIControls.UIAni(self, "")

	self.mainAni:addEventFinish(self._onMainAnimEnd)

	self.live2D = UIControls.LazyLivePlayer(self, "live2D")
end

function AvgRoleImage:setAnimEmojiPos(pos)
	self.animEmojiPanel:setPosition(pos[1], pos[2])
end

function AvgRoleImage:playAnimEmoji(path)
	self.animEmojiPanel:setVisible(true)
	self.animEmojiPanel:playEffectByPath(path)
end

function AvgRoleImage:stopAnimEmoji()
	self.animEmojiPanel:setVisible(false)
end

function AvgRoleImage:playRoleAnim(aniName)
	self:_clearAllAnim()
	self.emojiAni:startAni(aniName, true)

	self.inRoleAnimation = aniName
end

function AvgRoleImage:showAvgRole(npcData)
	local isDynamicHero = npcData.dynamic_hero_id ~= nil
	local isLive2D = npcData.live2D_path ~= nil
	local scale = npcData.scale

	if isLive2D then
		self.image:setVisible(false)
		self.live2D:setVisible(true)
		self:showLive2D(npcData)

		self.isLive2D = true
	elseif isDynamicHero then
		self.live2D:setVisible(false)
		self.image:setVisible(false)

		local heroId = npcData.dynamic_hero_id

		self:showDynamicHero(heroId)

		self._roleID = npcData.hero_id

		if scale and self.dynamicHeroGrid then
			self.dynamicHeroGrid:setScale(scale)
		end
	else
		self.live2D:setVisible(false)
		self.image:setVisible(true)
		self:clearDynamicHero()

		local heroId = npcData.hero_id

		self:showRole(heroId)

		if scale then
			self:setScaleAndFlip(scale)
		end
	end

	self._basePos = {
		0,
		0
	}
end

function AvgRoleImage:setScaleAndFlip(scale)
	local absScale = math.abs(scale)

	self._baseScale = absScale

	self.image:setScaleXYZ(scale, absScale, absScale)
end

function AvgRoleImage:playMainAnim(animName, callback)
	self:_clearAllAnim()
	self.mainAni:startAni(animName, true)

	self.inMainAnimation = animName

	if callback then
		self:addMainAnimEndCallback(callback)
	end
end

function AvgRoleImage:addMainAnimEndCallback(callback)
	if not self.mainAniEndCallback then
		self.mainAniEndCallback = {}
	end

	table.insert(self.mainAniEndCallback, callback)
end

function AvgRoleImage:_onMainAnimEnd(animCon, animName)
	if animName == "ShowAVGTalkRole" then
		-- block empty
	elseif animName == "CloseAVGTalkRole" then
		self:setVisible(false)
	end

	self.inMainAnimation = nil

	if self.mainAniEndCallback and #self.mainAniEndCallback > 0 then
		for _, cb in ipairs(self.mainAniEndCallback) do
			cb()
		end

		self.mainAniEndCallback = nil
	end
end

function AvgRoleImage:_clearAllAnim(...)
	if self.inMainAnimation then
		self.mainAni:stopAni(self.inMainAnimation)

		self.inMainAnimation = nil
	end

	if self.inRoleAnimation then
		self.emojiAni:stopAni(self.inRoleAnimation)

		self.inRoleAnimation = nil
	end

	self.mainAniEndCallback = nil
end

function AvgRoleImage:showDynamicHero(heroId)
	if not self.dynamicHeroGrid then
		self.dynamicHeroGrid = AvgRoleFrame(self, "", "System/Common/Grid/GridHeroQFrame", 0, 0, true)
	end

	self.dynamicHeroGrid:showHeroByAnimator(heroId)
end

function AvgRoleImage:clearDynamicHero()
	if self.dynamicHeroGrid then
		self.dynamicHeroGrid:destroy()

		self.dynamicHeroGrid = nil
	end
end

function AvgRoleImage:showLive2D(npcData)
	local live2DPath = npcData.live2D_path
	local scale = npcData.scale

	self.live2D:playLive2DByPath(live2DPath, scale)
end

return AvgRoleImage
